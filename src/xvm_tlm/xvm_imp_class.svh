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
// Base Class for all imps, derived from xvm_port_base.
// Implements all the base class functions required for imp classes
//----------------------------------------------------------------------

virtual class xvm_imp #(type IF=uvm_void) extends xvm_port_base implements xvm_export_check_if#(IF);
  
  IF     m_if;    

  function new (string name,
                uvm_component parent,
                int min_size=0,
                int max_size=1);
    super.new(name, parent, min_size,max_size);
  endfunction

  virtual function string get_type_name();
    return "implementation";
  endfunction

 virtual function int size ();
    return 1;
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

  function void get_provided_to (ref xvm_port_base list[string]);
    xvm_port_base port;
    list.delete();
    foreach (m_provided_to[name]) begin
      port = m_provided_to[name];
      list[name] = port;
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
     s = $sformatf("imp:Resolve binding for: %s", this.get_full_name());
     m_comp.uvm_report_info("imp:resolve_bindings", s, UVM_NONE);

    if (m_resolved) begin// don't repeat ourselves
     m_comp.uvm_report_info("imp:resolve_bindings", "Already resolved", UVM_NONE);
     return;
    end

    void'($cast(m_if,this));
    m_resolved = 1;
    m_comp.uvm_report_info("imp:resolve_bindings", "successfully cast", UVM_NONE);
  
    if (m_if == null) begin
     m_comp.uvm_report_info("imp:resolve_bindings", "m_if is null", UVM_NONE);
     return;
    end
    
    if ( size() < min_size() ) begin
      m_comp.uvm_report_error(s_connection_error_id, 
        $sformatf("imp:connection count of %0d does not meet required minimum of %0d",
        size(), min_size()), UVM_NONE);
    end
  
    if (max_size() != XVM_UNBOUNDED_CONNECTIONS &&  size() > max_size() ) begin
      m_comp.uvm_report_error(s_connection_error_id, 
        $sformatf("imp:connection count of %0d exceeds maximum of %0d",
        size(), max_size()), UVM_NONE);
    end

  endfunction
   
  // Returns the implementation (imp) port at the given index from the array of
  // imps this port is connected to. Use <size> to get the valid range for index.
  // This method can only be called at the end_of_elaboration phase or after, as
  // port connections are not resolved before then.

   function IF get_if(int index=0);
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
    void'($cast(l_if, this));
    return l_if;
  endfunction

  
endclass
