//
//----------------------------------------------------------------------
// Copyright 2024 NVIDIA Corporation
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the
//   "License"); you may not use this file except in
//   compliance with the License.  You may obtain a copy of
//   the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in
//   writing, software distributed under the License is
//   distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
//   CONDITIONS OF ANY KIND, either express or implied.  See
//   the License for the specific language governing
//   permissions and limitations under the License.
//----------------------------------------------------------------------

//----------------------------------------------------------------------
// Base Class for all exports, derived from xvm_port_base.
// Implements all the base class functions required for export classes
//----------------------------------------------------------------------
virtual class xvm_export #(type IF=uvm_void) extends xvm_port_base implements xvm_export_check_if#(IF);
   
  xvm_port_base     m_imp_list[string];
  IF     m_if;    
  
  function new (string name,
                uvm_component parent,
                int min_size=0,
                int max_size=1);
    super.new(name, parent, min_size,max_size);
  endfunction

  virtual function string get_type_name();
      return "export";
  endfunction

  // Gets the number of implementation ports connected to this port. The value
  // is not valid before the end_of_elaboration phase, as port connections have
  // not yet been resolved.
  virtual function int size ();
    return m_imp_list.num();
  endfunction

  function void set_if (int index=0);
    m_if = get_if(index);
    if (m_if != null) begin
      m_def_index = index;
    end else begin
      m_comp.uvm_report_warning("export: set_if",
        "m_if is set to null", UVM_NONE);
    end
 endfunction

  // Sets the default implementation port to use when calling an interface
  // method. This method should only be called on XVM_EXPORT types. The value
  // must not be set before the end_of_elaboration phase, when port connections
  // have not yet been resolved.
  function void set_default_index (int index);
    m_def_index = index;
  endfunction

  // Connects this port to the given ~provider~ port. The ports must be 
  // compatible.
  // Errors our if the the argument is of port type 
  // as the expected argument is only of type xvm_export_check_if (imp, export)
  virtual function void connect (xvm_export_check_if#(IF) provider);
     uvm_root top;
     uvm_coreservice_t cs;
     xvm_export_check_if m_export_if;
     xvm_imp #(IF) p_xvm_imp;
     xvm_export #(IF) p_xvm_export;
     xvm_port_base p_xvm_base;
     cs = uvm_coreservice_t::get();
     top = cs.get_root();

/*
    if (!$cast(m_export_if, provider)) begin // Ensuring PORTS don't connect to IF_IMPL
       m_comp.uvm_report_error(s_connection_error_id,
                       "Cannot connect to this port type", UVM_NONE);
      return;
    end
*/
    if (end_of_elaboration_ph.get_state() == UVM_PHASE_EXECUTING || // TBD tidy
        end_of_elaboration_ph.get_state() == UVM_PHASE_DONE ) begin
       m_comp.uvm_report_warning("export:Late Connection", 
         {"Attempt to connect ",this.get_full_name()," (of type ",this.get_type_name(),
          ") at or after end_of_elaboration phase.  Ignoring."});
       return;
     end

    if (provider == null) begin
      m_comp.uvm_report_error(s_connection_error_id,
                       "export:Cannot connect to null port handle", UVM_NONE);
      return;
    end
 
   if ($cast(p_xvm_base, provider)) begin
      if (p_xvm_base == this) begin
        m_comp.uvm_report_error(s_connection_error_id,
                       "export:Cannot connect a port instance to itself", UVM_NONE);
        return;
      end
      void'(m_check_relationship(p_xvm_base));
      m_provided_by[p_xvm_base.get_full_name()] = p_xvm_base;
      p_xvm_base.m_provided_to[get_full_name()] = this;
      m_comp.uvm_report_info("port:connect to port", p_xvm_base.get_full_name() , UVM_NONE);
    end else begin
      m_comp.uvm_report_error(s_connection_error_id,
                       "export:Cannot cast the provider to connect", UVM_NONE);
      return;
   end
    
  endfunction

  // Function: debug_connected_to
  //
  // The ~debug_connected_to~ method outputs a visual text display of the
  // port/export/imp network to which this port connects (i.e., the port's
  // fanout).
  //
  // This method must not be called before the end_of_elaboration phase, as port
  // connections are not resolved until then.
  function void debug_connected_to (int level=0, int max_level=-1);
    int sz, num, curr_num;
    string s_sz;
    static string indent, save;
    xvm_port_base port;
   
    if (level <  0) level = 0;
    if (level == 0) begin save = ""; indent="  "; end
  
    if (max_level != -1 && level >= max_level)
      return;
  
    num = m_provided_by.num();
  
    if (m_provided_by.num() != 0) begin
      foreach (m_provided_by[nm]) begin
        curr_num++;
        port = m_provided_by[nm];
        save = {save, indent, "  | \n"};
        save = {save, indent, "  |_",nm," (",port.get_type_name(),")\n"};
        indent = (num > 1 && curr_num != num) ?  {indent,"  | "}:{indent, "    "};
        port.debug_connected_to(level+1, max_level);
        indent = indent.substr(0,indent.len()-4-1);
      end
    end
  
    if (level == 0) begin
      if (save != "")
        save = {"This port's fanout network:\n\n  ",
               get_full_name()," (",get_type_name(),")\n",save,"\n"};
      if (m_imp_list.num() == 0) begin
	      uvm_root top;
        uvm_coreservice_t cs;
	      cs = uvm_coreservice_t::get();
	      top = cs.get_root();
        if (end_of_elaboration_ph.get_state() == UVM_PHASE_EXECUTING ||
            end_of_elaboration_ph.get_state() == UVM_PHASE_DONE )  // TBD tidy
           save = {save,"  Connected implementations: none\n"};
        else
           save = {save,
                 "  Connected implementations: not resolved until end-of-elab\n"};
      end
      else begin
        save = {save,"  Resolved implementation list:\n"};
        foreach (m_imp_list[nm]) begin
          port = m_imp_list[nm];
          s_sz.itoa(sz);
          save = {save, indent, s_sz, ": ",nm," (",port.get_type_name(),")\n"};
          sz++;
        end
      end
      m_comp.uvm_report_info("debug_connected_to", save);
    end
  endfunction
  
  // Function: debug_provided_to
  //
  // The ~debug_provided_to~ method outputs a visual display of the port/export
  // network that ultimately connect to this port (i.e., the port's fanin).
  //
  // This method must not be called before the end_of_elaboration phase, as port
  // connections are not resolved until then.
  function void debug_provided_to  (int level=0, int max_level=-1);
    string nm;
    int num,curr_num;
    xvm_port_base port;
    static string indent, save;
  
    if (level <  0) level = 0; 
    if (level == 0) begin save = ""; indent = "  "; end

    if (max_level != -1 && level > max_level)
      return;
  
    num = m_provided_to.num();
  
    if (num != 0) begin
      foreach (m_provided_to[nm]) begin
        curr_num++;
        port = m_provided_to[nm];
        save = {save, indent, "  | \n"};
        save = {save, indent, "  |_",nm," (",port.get_type_name(),")\n"};
        indent = (num > 1 && curr_num != num) ?  {indent,"  | "}:{indent, "    "};
        port.debug_provided_to(level+1, max_level);
        indent = indent.substr(0,indent.len()-4-1);
      end
    end

    if (level == 0) begin
      if (save != "")
        save = {"This port's fanin network:\n\n  ",
               get_full_name()," (",get_type_name(),")\n",save,"\n"};
      if (m_provided_to.num() == 0)
        save = {save,indent,"This port has not been bound\n"};
      m_comp.uvm_report_info("debug_provided_to", save);
    end
  
  endfunction


  // get_connected_to
  // ----------------

  function void get_connected_to (ref xvm_port_base list[string]);
    xvm_port_base port;
    list.delete();
    foreach (m_provided_by[name]) begin
      port = m_provided_by[name];
      list[name] = port;
    end
  endfunction


  // get_provided_to
  // ---------------

  function void get_provided_to (ref xvm_port_base  list[string]);
    xvm_port_base port;
    list.delete();
    foreach (m_provided_to[name]) begin
      port = m_provided_to[name];
      list[name] = port;
    end
  endfunction

  // m_check_relationship
  // --------------------
  // Relationships, when enabled, are checked are as follows:
  //
  // - If this port is an XVM_PORT type, the ~provider~ can be a parent port,
  //   or a sibling export or implementation port.
  //
  // - If this port is a <XVM_EXPORT> type, the provider can be a child
  //   export or implementation port.
  //
  // If any relationship check is violated, a warning is issued.

  local function bit  m_check_relationship (xvm_port_base provider);  
    string s;
    xvm_port_base from;
    uvm_component from_parent;
    uvm_component to_parent;
    uvm_component from_gparent;
    uvm_component to_gparent;
    xvm_export_check_if m_export_if;
   
    // Checks that the connection is between ports that are hierarchically
    // adjacent (up or down one level max, or are siblings),
    // and check for legal direction, requirer.connect(provider).

    // if we're an analysis port, allow connection to anywhere
    if (get_type_name() == "xvm_analysis_port")
      return 1;
    
    from         = this;
    from_parent  = get_parent();
    to_parent    = provider.get_parent();
  
    // skip check if we have a parentless port
    if (from_parent == null || to_parent == null)
      return 1;
  
    from_gparent = from_parent.get_parent();
    to_gparent   = to_parent.get_parent();
  
    
    // Connecting export-to-export: PARENT.export.connect(CHILD.export)
    // Connecting export-to-imp:    PARENT.export.connect(CHILD.imp)
    //
    if ( ($cast(m_export_if, provider)) &&
             from_parent != to_gparent) begin
      s = {provider.get_full_name(),
           " (of type ",provider.get_type_name(),
           ") is not down one level of hierarchy from this export. ",
           "An export-to-export or export-to-imp connection takes the form ",
           "parent_export.connect(child_component.child_export)"};
      m_comp.uvm_report_warning(s_connection_warning_id, s, UVM_NONE);
      return 0;
    end

    return 1;
  endfunction


  // m_add_list
  //
  // Internal method.

  local function void m_add_list (xvm_port_base provider);
     string sz;

   for (int i = 0; i < provider.size(); i++) begin
      //imp = provider.get_if(i);
      // Need to add to the imp_list too.
      if (!m_imp_list.exists(provider.get_full_name())) begin
        m_imp_list[provider.get_full_name()] = provider; 
      end
    end
  endfunction

  // This callback is called just before entering the end_of_elaboration phase.
  // It recurses through each port's fanout to determine all the imp 
  // destinations. It then checks against the required min and max connections.
  // After resolution, <size> returns a valid value and <get_if>
  // can be used to access a particular imp.
  //
  // This method is automatically called just before the start of the
  // end_of_elaboration phase. Users should not need to call it directly.

  virtual function void resolve_bindings();
     string s;
     s = $sformatf("export:Resolve binding for: %s", this.get_full_name());
     m_comp.uvm_report_info("export:resolve_bindings", s, UVM_NONE);

    if (m_resolved) // don't repeat ourselves
     return;

    begin
      foreach (m_provided_by[nm]) begin
        xvm_port_base port;
        port = m_provided_by[nm];
        port.resolve_bindings();
        m_add_list(port);
      end
    end
  
    m_resolved = 1;
  
    if (size() < min_size() ) begin
      m_comp.uvm_report_error(s_connection_error_id, 
        $sformatf("export:connection count of %0d does not meet required minimum of %0d",
        size(), min_size()), UVM_NONE);
    end
  
    if (max_size() != XVM_UNBOUNDED_CONNECTIONS && size() > max_size() ) begin
      m_comp.uvm_report_error(s_connection_error_id, 
        $sformatf("export:connection count of %0d exceeds maximum of %0d",
        size(), max_size()), UVM_NONE);
    end

    if (size())
      set_if(0);
  
  endfunction
  
  // Returns the implementation (imp) port at the given index from the array of
  // imps this port is connected to. Use <size> to get the valid range for index.
  // This method can only be called at the end_of_elaboration phase or after, as
  // port connections are not resolved before then.

  function  IF get_if(int index=0);
    string s;
    IF l_if;
    if (size()==0) begin
      m_comp.uvm_report_warning("get_if",
        "Port size is zero; cannot get interface at any index", UVM_NONE);
      return null;
    end
    if (index < 0 || index >= size()) begin
      $sformat(s, "Index %0d out of range [0,%0d]", index, size()-1);
      m_comp.uvm_report_warning(s_connection_error_id, s, UVM_NONE);
      return null;
    end
    foreach (m_imp_list[nm]) begin
      if (index == 0) begin
 //       return m_imp_list[nm];
        void'($cast(l_if, m_imp_list[nm]));
        if (l_if == null) begin
          m_comp.uvm_report_warning("export: get_if", "l_if is null", UVM_NONE);
          $sformat(s, "name of imp port is %s of type %s",  m_imp_list[nm].get_full_name(), m_imp_list[nm].get_type_name() );
          m_comp.uvm_report_warning("export: get_if", s, UVM_NONE);
        end
        return l_if;
      end
      index--;
    end
  endfunction


endclass
