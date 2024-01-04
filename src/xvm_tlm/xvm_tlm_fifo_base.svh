//
//------------------------------------------------------------------------------
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2007-2011 Mentor Graphics Corporation
// Copyright 2014-2024 NVIDIA Corporation
// Copyright 2014 Semifore
// Copyright 2014-2018 Synopsys, Inc.
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
//------------------------------------------------------------------------------


`define XVM_TLM_FIFO_TASK_ERROR "fifo channel task not implemented"
`define XVM_TLM_FIFO_FUNCTION_ERROR "fifo channel function not implemented"

class xvm_tlm_event;
  event trigger;
endclass

//------------------------------------------------------------------------------
//
// CLASS -- xvm_tlm_fifo_base #(T)
//
// This class is the base for <xvm_tlm_fifo#(T)>. It defines the XVM TLM exports 
// through which all transaction-based FIFO operations occur. It also defines
// default implementations for each interface method provided by these exports.
//
// The interface methods provided by the <put_export> and the <get_peek_export>
// are defined and described by <xvm_tlm_if_base #(T1,T2)>.  
//
// Parameter type
//
// T - The type of transactions to be stored by this FIFO.
//
//------------------------------------------------------------------------------

virtual class xvm_tlm_fifo_base #(type T=int) extends uvm_component;

  `uvm_component_abstract_param_utils(xvm_tlm_fifo_base #(T))
  
  typedef xvm_tlm_fifo_base #(T) this_type;
  
  xvm_put_imp #(T, this_type) put_export;
  
  xvm_get_peek_imp #(T, this_type) get_peek_export;  

  xvm_analysis_port #(T) put_ap;

  xvm_analysis_port #(T) get_ap;


  // The following are aliases to the above put_export.

  xvm_put_imp      #(T, this_type) blocking_put_export;
  xvm_put_imp      #(T, this_type) nonblocking_put_export;

  // The following are all aliased to the above get_peek_export, which provides
  // the superset of these interfaces.

  xvm_get_peek_imp #(T, this_type) blocking_get_export;
  xvm_get_peek_imp #(T, this_type) nonblocking_get_export;
  xvm_get_peek_imp #(T, this_type) get_export;
  
  xvm_get_peek_imp #(T, this_type) blocking_peek_export;
  xvm_get_peek_imp #(T, this_type) nonblocking_peek_export;
  xvm_get_peek_imp #(T, this_type) peek_export;
  
  xvm_get_peek_imp #(T, this_type) blocking_get_peek_export;
  xvm_get_peek_imp #(T, this_type) nonblocking_get_peek_export;

  // Function -- new
  //
  // The ~name~ and ~parent~ are the normal uvm_component constructor arguments. 
  // The ~parent~ should be ~null~ if the xvm_tlm_fifo is going to be used in a
  // statically elaborated construct (e.g., a module). The ~size~ indicates the
  // maximum size of the FIFO. A value of zero indicates no upper bound.

  function new(string name, uvm_component parent = null);
    super.new(name, parent);

    put_export = new("put_export", this);
    blocking_put_export     = put_export;
    nonblocking_put_export  = put_export;

    get_peek_export = new("get_peek_export", this);
    blocking_get_peek_export    = get_peek_export;
    nonblocking_get_peek_export = get_peek_export;
    blocking_get_export         = get_peek_export;
    nonblocking_get_export      = get_peek_export;
    get_export                  = get_peek_export;
    blocking_peek_export        = get_peek_export;
    nonblocking_peek_export     = get_peek_export;
    peek_export                 = get_peek_export;

    put_ap = new("put_ap", this);
    get_ap = new("get_ap", this);
    
  endfunction

  //turn off auto config
  virtual function bit use_automatic_config();
    return 0;
  endfunction : use_automatic_config
   
  virtual function void flush();
    uvm_report_error("flush", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
  endfunction
  
  virtual function int size();
    uvm_report_error("size", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual task put(T t);
    uvm_report_error("put", `XVM_TLM_FIFO_TASK_ERROR, UVM_NONE);
  endtask

  virtual task get(output T t);
    uvm_report_error("get", `XVM_TLM_FIFO_TASK_ERROR, UVM_NONE);
  endtask

  virtual task peek(output T t);
    uvm_report_error("peek", `XVM_TLM_FIFO_TASK_ERROR, UVM_NONE);
  endtask
  
  virtual function bit try_put(T t);
    uvm_report_error("try_put", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function bit try_get(output T t);
    uvm_report_error("try_get", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function bit try_peek(output T t);
    uvm_report_error("try_peek", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction
  
  virtual function bit can_put();
    uvm_report_error("can_put", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function bit can_get();
    uvm_report_error("can_get", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function bit can_peek();
    uvm_report_error("can_peek", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function xvm_tlm_event ok_to_put();
    uvm_report_error("ok_to_put", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return null;
  endfunction

  virtual function xvm_tlm_event ok_to_get();
    uvm_report_error("ok_to_get", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return null;
  endfunction

  virtual function xvm_tlm_event ok_to_peek();
    uvm_report_error("ok_to_peek", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return null;
  endfunction

  virtual function bit is_empty();
    uvm_report_error("is_empty", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

  virtual function bit is_full();
    uvm_report_error("is_full", `XVM_TLM_FIFO_FUNCTION_ERROR);
    return 0;
  endfunction

  virtual function int used();
    uvm_report_error("used", `XVM_TLM_FIFO_FUNCTION_ERROR, UVM_NONE);
    return 0;
  endfunction

endclass
