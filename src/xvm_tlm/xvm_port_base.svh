//
//------------------------------------------------------------------------------
// Copyright 2010 AMD
// Copyright 2015 Analog Devices, Inc.
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2012-2017 Cisco Systems, Inc.
// Copyright 2014 Intel Corporation
// Copyright 2021-2022 Marvell International Ltd.
// Copyright 2007-2021 Mentor Graphics Corporation
// Copyright 2014-2024 NVIDIA Corporation
// Copyright 2014 Semifore
// Copyright 2010-2018 Synopsys, Inc.
// Copyright 2017 Verific
//   All Rights Reserved Worldwide
//
//   Licensed under the Apache License, Version 2.0 (the "License"); you may not
//   use this file except in compliance with the License.  You may obtain a copy
//   of the License at
//
//       http://www.apache.org/licenses/LICENSE-2.0
//
//   Unless required by applicable law or agreed to in writing, software
//   distributed under the License is distributed on an "AS IS" BASIS, WITHOUT
//   WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.  See the
//   License for the specific language governing permissions and limitations
//   under the License.
//------------------------------------------------------------------------------

typedef class xvm_port_base;
typedef class xvm_port_component;
// CLASS: uvm_port_list
// Associative array of xvm_port_component class handles, indexed by string
typedef xvm_port_component xvm_port_list[string];


//------------------------------------------------------------------------------
//
// CLASS: xvm_port_component
//
//------------------------------------------------------------------------------
// This class defines a base class for obtaining a port's connectivity lists
// after or during the end_of_elaboration phase.  The sub-class,
// <xvm_port_base> has a member of this type.
//
// Each port's full name and type name can be retrieved using ~get_full_name~ 
// and ~get_type_name~ methods inherited from <uvm_component>.
//
//------------------------------------------------------------------------------
class xvm_port_component extends uvm_component;

 xvm_port_base m_port;

  function new (string name, uvm_component parent, xvm_port_base port);
    super.new(name,parent);
    if (port == null)
      uvm_report_fatal("Bad usage", "Null handle to port", UVM_NONE);
    m_port = port;
  endfunction

  virtual function void resolve_bindings();
    uvm_report_info("Resolve bindings", "base component", UVM_NONE);
    m_port.resolve_bindings();
    uvm_report_info("Resolve bindings", "base component done", UVM_NONE);
  endfunction : resolve_bindings

  function xvm_port_base get_port();
    return m_port;
  endfunction

  // Function: get_connected_to
  //
  // For a port or export type, this function fills ~list~ with all
  // of the ports, exports and implementations that this port is
  // connected to.
   virtual function void get_connected_to(ref xvm_port_list list);
    xvm_port_base list1[string];
    m_port.get_connected_to(list1);
    list.delete();
    foreach(list1[name]) begin
      list[name] = list1[name].get_comp();
    end
  endfunction
  
  // Function: get_provided_to
  //
  // For an implementation or export type, this function fills ~list~ with all
  // of the ports, exports and implementations that this port is
  // provides its implementation to.
   virtual function void get_provided_to(ref xvm_port_list list);
    xvm_port_base list1[string];
    m_port.get_provided_to(list1);
    list.delete();
    foreach(list1[name]) begin
      list[name] = list1[name].get_comp();
    end
  endfunction  
endclass


//------------------------------------------------------------------------------
//
// CLASS --  xvm_port_base
//
//------------------------------------------------------------------------------
//
// Transaction-level communication between components is handled via its ports,
// exports, and imps. This class is the base class for all the classes implementing 
// ports, exports and imps.
//
//
// Just before <xvm_component::end_of_elaboration_phase>, an internal
// <xvm_component::resolve_bindings> process occurs, after which each port and
// export holds a list of all imps connected to it via hierarchical connections
// to other ports and exports. In effect, we are collapsing the port's fanout,
// which can span several levels up and down the component hierarchy, into a
// single array held local to the port. Once the list is determined, the port's
// min and max connection settings can be checked and enforced.
//
// xvm_port_base possesses the properties of components in that they have a
// hierarchical instance path and parent. xvm_port_base contains a local instance
// of uvm_component through xvm_port_component, to which it delegates such commands
// as get_name, get_full_name, and get_parent.
// The connectivity lists are returned in the form of handles to objects of this
// type. This allowing traversal of any port's fan-out and fan-in network
// through recursive calls to <get_connected_to> and <get_provided_to>. 
//
//------------------------------------------------------------------------------

virtual class xvm_port_base;

  typedef xvm_port_base this_type;

  int unsigned  m_if_mask;
  int unsigned  m_def_index;
  xvm_port_component m_comp;
  int               m_min_size;
  int               m_max_size;
  // From child classes for access.
  xvm_port_base m_provided_by[string];
  xvm_port_base m_provided_to[string];
  bit               m_resolved;

 
  function new (string name,
                uvm_component parent,
                int min_size=0,
                int max_size=1);
    uvm_component comp;
    int tmp;
    m_min_size  = min_size;
    m_max_size  = max_size;
    m_comp = new(name, parent, this);

    if (!uvm_config_int::get(m_comp, "", "check_connection_relationships",tmp))
      m_comp.set_report_id_action(s_connection_warning_id, UVM_NO_ACTION);

 endfunction

  // Following functions use the properties of uvm_component
  // through the m_comp member variable of type xvm_port_component
  function string get_name();
    return m_comp.get_name();
  endfunction

  virtual function string get_full_name();
    return m_comp.get_full_name();
  endfunction

  virtual function uvm_component get_parent();
    return m_comp.get_parent();
  endfunction

  virtual function xvm_port_component get_comp();
    return m_comp;
  endfunction

  // Returns the max_size member variable 
  function int max_size ();
    return m_max_size;
  endfunction

  // Returns the min_size member variable
  function int min_size ();
    return m_min_size;
  endfunction

  function bit is_unbounded ();
    return (m_max_size ==  XVM_UNBOUNDED_CONNECTIONS);
  endfunction

  // Following functions should be implemented in the derived classes
  // for exports, ports and imps. If they are not declared and the base 
  // class method is called, they will throw an error.
  virtual function string get_type_name();
    m_comp.uvm_report_error("xvm_port_base", "Base class get_type_name function called. Not implemented in derived class", UVM_NONE);
  endfunction

  virtual function int size ();
    m_comp.uvm_report_error("xvm_port_base", "Base class size function called. Not implemented in derived class", UVM_NONE);
  endfunction

  virtual function void get_connected_to (ref xvm_port_base list[string]);
    m_comp.uvm_report_error("xvm_port_base", "Base class get_connected_to function called. Not implemented in derived class", UVM_NONE);
  endfunction
  virtual function void get_provided_to (ref xvm_port_base list[string]);
    m_comp.uvm_report_error("xvm_port_base", "Base class get_provided_to function called. Not implemented in derived class", UVM_NONE);
  endfunction
  virtual function void debug_provided_to  (int level=0, int max_level=-1);
    m_comp.uvm_report_error("xvm_port_base", "Base class debug_provided_to function called. Not implemented in derived class", UVM_NONE);
  endfunction
  virtual function void debug_connected_to (int level=0, int max_level=-1);
    m_comp.uvm_report_error("xvm_port_base", "Base class debug_connected_to function called. Not implemented in derived class", UVM_NONE);
  endfunction
  virtual function void resolve_bindings();
     m_comp.uvm_report_error("xvm_port_base", "Base class resolve_bindings function called. Not implemented in derived class", UVM_NONE);
  endfunction

endclass
