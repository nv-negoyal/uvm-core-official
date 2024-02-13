//
//----------------------------------------------------------------------
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2007-2011 Mentor Graphics Corporation
// Copyright 2015-2024 NVIDIA Corporation
// Copyright 2010 Synopsys, Inc.
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

//------------------------------------------------------------------------------
// Title -- Analysis Ports
//------------------------------------------------------------------------------
// This section defines the port, export, and imp classes used for transaction
// analysis.
//------------------------------------------------------------------------------
const int XVM_UNBOUNDED_CONNECTIONS = -1;

//------------------------------------------------------------------------------
// Broadcasts a value to all subscribers implementing a <xvm_analysis_imp>.
// 
//| class mon extends uvm_component;
//|   xvm_analysis_port#(trans) ap;
//|
//|   function new(string name = "sb", uvm_component parent = null);
//|      super.new(name, parent);
//|      ap = new("ap", this);
//|   endfunction
//|
//|   task run_phase(uvm_phase phase);
//|       trans t;
//|       ...
//|       ap.write(t);
//|       ...
//|   endfunction
//| endclass
//------------------------------------------------------------------------------

class xvm_analysis_port #(type T=int)
  extends xvm_port #(xvm_tlm_analysis_if #(T)) 
  implements xvm_tlm_analysis_if #(T),
             xvm_port_check_if #(xvm_tlm_analysis_if #(T));

  function new (string name, uvm_component parent);
    super.new (name, parent, 0, XVM_UNBOUNDED_CONNECTIONS);
  endfunction

  virtual function string get_type_name();
    return "xvm_analysis_port";
  endfunction

  virtual function void write (input T t);
    xvm_tlm_analysis_if # (T, T) tif;
    for (int i = 0; i < this.size(); i++) begin
      tif = this.get_if (i);
      if ( tif == null )
        uvm_report_fatal ("NTCONN", {"No xvm_tlm interface is connected to ", get_full_name(), " for executing write()"}, UVM_NONE);
      tif.write (t);
    end 
  endfunction
endclass 


//------------------------------------------------------------------------------
// Receives all transactions broadcasted by a <xvm_analysis_port>. It serves as
// the termination point of an analysis port/export/imp connection. The component
// attached to the ~imp~ class--called a ~subscriber~-- implements the analysis
// interface.
//
// Will invoke the ~write(T)~ method in the parent component.
// The implementation of the ~write(T)~ method must not modify
// the value passed to it.
//
//| class sb extends uvm_component;
//|   xvm_analysis_imp#(trans, sb) ap;
//|
//|   function new(string name = "sb", uvm_component parent = null);
//|      super.new(name, parent);
//|      ap = new("ap", this);
//|   endfunction
//|
//|   function void write(trans t);
//|       ...
//|   endfunction
//| endclass
//------------------------------------------------------------------------------

class xvm_analysis_imp #(type T=int, type IMP=int)
  extends xvm_imp #(xvm_tlm_analysis_if #(T))
  implements xvm_tlm_analysis_if #(T),
             xvm_export_check_if #(xvm_tlm_analysis_if #(T));

  `XVM_IMP_COMMON("xvm_analysis_imp",IMP)
  virtual function void write (input T t);
    m_imp.write (t);
  endfunction
endclass


//------------------------------------------------------------------------------
// Exports a lower-level <xvm_analysis_imp> to its parent.
//------------------------------------------------------------------------------


class xvm_analysis_export #(type T=int)
  extends xvm_export #(xvm_tlm_analysis_if #(T)) 
  implements xvm_tlm_analysis_if #(T),
             xvm_export_check_if #(xvm_tlm_analysis_if #(T));

  function new (string name, uvm_component parent = null);
    super.new (name, parent, 1, XVM_UNBOUNDED_CONNECTIONS);
  endfunction

  virtual function string get_type_name();
    return "xvm_analysis_export";
  endfunction
  
  // analysis port differs from other ports in that it broadcasts
  // to all connected interfaces. Ports only send to the interface
  // at the index specified in a call to set_if (0 by default).
  virtual function void write (input T t);
    xvm_tlm_analysis_if #(T, T) tif;
    for (int i = 0; i < this.size(); i++) begin
      tif = this.get_if (i);
      if (tif == null)
         uvm_report_fatal ("NTCONN", {"No xvm_tlm interface is connected to ", get_full_name(), " for executing write()"}, UVM_NONE);
      tif.write (t);
    end 
  endfunction

endclass



