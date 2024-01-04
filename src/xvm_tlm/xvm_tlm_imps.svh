//
//----------------------------------------------------------------------
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2007-2011 Mentor Graphics Corporation
// Copyright 2018-2024 NVIDIA Corporation
// Copyright 2018 Synopsys, Inc.
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
//
// These IMP macros define implementations of the xvm_*_port, xvm_*_export,
// and xvm_*_imp ports.
//

//---------------------------------------------------------------
// Macros for implementations of XVM imps,ports and exports

//----------------------------------------------------------------------
//PUT DEFINES
//----------------------------------------------------------------------
`define XVM_BLOCKING_PUT_IMP(imp, TYPE, arg) \
  virtual task put (TYPE arg); \
    imp.put(arg); \
  endtask

`define XVM_NONBLOCKING_PUT_IMP(imp, TYPE, arg) \
  virtual function bit try_put (TYPE arg); \
    return imp.try_put(arg); \
  endfunction \
  virtual function bit can_put(); \
    return imp.can_put(); \
  endfunction

`define XVM_PUT_IMP(imp, TYPE, arg) \
  `XVM_BLOCKING_PUT_IMP(imp, TYPE, arg) \
  `XVM_NONBLOCKING_PUT_IMP(imp, TYPE, arg)

//----------------------------------------------------------------------
//GET DEFINES
//----------------------------------------------------------------------
`define XVM_BLOCKING_GET_IMP(imp, TYPE, arg) \
  virtual task get (output TYPE arg); \
    imp.get(arg); \
  endtask

`define XVM_NONBLOCKING_GET_IMP(imp, TYPE, arg) \
  virtual function bit try_get (output TYPE arg); \
    return imp.try_get(arg); \
  endfunction \
  virtual function bit can_get(); \
    return imp.can_get(); \
  endfunction

`define XVM_GET_IMP(imp, TYPE, arg) \
  `XVM_BLOCKING_GET_IMP(imp, TYPE, arg) \
  `XVM_NONBLOCKING_GET_IMP(imp, TYPE, arg)

//----------------------------------------------------------------------
// PEEK DEFINES
//----------------------------------------------------------------------
`define XVM_BLOCKING_PEEK_IMP(imp, TYPE, arg) \
  virtual task peek (output TYPE arg); \
    imp.peek(arg); \
  endtask

`define XVM_NONBLOCKING_PEEK_IMP(imp, TYPE, arg) \
  virtual function bit try_peek (output TYPE arg); \
    return imp.try_peek(arg); \
  endfunction \
  virtual function bit can_peek(); \
    return imp.can_peek(); \
  endfunction

`define XVM_PEEK_IMP(imp, TYPE, arg) \
  `XVM_BLOCKING_PEEK_IMP(imp, TYPE, arg) \
  `XVM_NONBLOCKING_PEEK_IMP(imp, TYPE, arg)

`define XVM_BLOCKING_GET_PEEK_IMP(imp, TYPE, arg) \
  `XVM_BLOCKING_GET_IMP(imp, TYPE, arg) \
  `XVM_BLOCKING_PEEK_IMP(imp, TYPE, arg)

`define XVM_NONBLOCKING_GET_PEEK_IMP(imp, TYPE, arg) \
  `XVM_NONBLOCKING_GET_IMP(imp, TYPE, arg) \
  `XVM_NONBLOCKING_PEEK_IMP(imp, TYPE, arg)

`define XVM_GET_PEEK_IMP(imp, TYPE, arg) \
  `XVM_BLOCKING_GET_PEEK_IMP(imp, TYPE, arg) \
  `XVM_NONBLOCKING_GET_PEEK_IMP(imp, TYPE, arg)

`define XVM_BLOCKING_TRANSPORT_IMP(imp, REQ, RSP, req_arg, rsp_arg) \
  virtual task transport (REQ req_arg, output RSP rsp_arg); \
    imp.transport(req_arg, rsp_arg); \
  endtask

`define XVM_NONBLOCKING_TRANSPORT_IMP(imp, REQ, RSP, req_arg, rsp_arg) \
  virtual function bit nb_transport (REQ req_arg, output RSP rsp_arg); \
    return imp.nb_transport(req_arg, rsp_arg); \
  endfunction

`define XVM_TRANSPORT_IMP(imp, REQ, RSP, req_arg, rsp_arg) \
  `XVM_BLOCKING_TRANSPORT_IMP(imp, REQ, RSP, req_arg, rsp_arg) \
  `XVM_NONBLOCKING_TRANSPORT_IMP(imp, REQ, RSP, req_arg, rsp_arg)

//----------------------------------------------------------------------
// COMMON DEFINES
//----------------------------------------------------------------------
`define XVM_TLM_GET_TYPE_NAME(NAME) \
  virtual function string get_type_name(); \
    return NAME; \
  endfunction

`define XVM_IMP_COMMON(TYPE_NAME,IMP) \
  local IMP m_imp; \
  function new (string name, IMP imp); \
    super.new (name, imp, 1, 1); \
    m_imp = imp; \
  endfunction \
  `XVM_TLM_GET_TYPE_NAME(TYPE_NAME)

`define XVM_NEW_COMMON \
  function new (string name, uvm_component parent, \
                int min_size=1, int max_size=1); \
    super.new (name, parent, min_size, max_size); \
  endfunction \

`define XVM_PORT_COMMON(TYPE_NAME) \
  function new (string name, uvm_component parent, \
                int min_size=1, int max_size=1); \
    super.new (name, parent, min_size, max_size); \
  endfunction \
  `XVM_TLM_GET_TYPE_NAME(TYPE_NAME)

`define XVM_SEQ_PORT(MASK,TYPE_NAME) \
  function new (string name, uvm_component parent, \
                int min_size=0, int max_size=1); \
    super.new (name, parent, min_size, max_size); \
  endfunction \
  `XVM_TLM_GET_TYPE_NAME(TYPE_NAME)

`define XVM_EXPORT_COMMON(TYPE_NAME) \
  function new (string name, uvm_component parent, \
                int min_size=1, int max_size=1); \
    super.new (name, parent, min_size, max_size); \
  endfunction \
  `XVM_TLM_GET_TYPE_NAME(TYPE_NAME)

`define XVM_SEQ_PORT(TYPE_NAME) \
  function new (string name, uvm_component parent, \
                int min_size=0, int max_size=1); \
    super.new (name, parent, min_size, max_size); \
  endfunction \
  `XVM_TLM_GET_TYPE_NAME(TYPE_NAME)
  
`define XVM_MS_IMP_COMMON(TYPE_NAME) \
  local this_req_type m_req_imp; \
  local this_rsp_type m_rsp_imp; \
  function new (string name, this_imp_type imp, \
                this_req_type req_imp = null, this_rsp_type rsp_imp = null); \
    super.new (name, imp, 1, 1); \
    if(req_imp==null) $cast(req_imp, imp); \
    if(rsp_imp==null) $cast(rsp_imp, imp); \
    m_req_imp = req_imp; \
    m_rsp_imp = rsp_imp; \
  endfunction  \
  `XVM_TLM_GET_TYPE_NAME(TYPE_NAME)

