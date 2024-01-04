//
//------------------------------------------------------------------------------
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2007-2011 Mentor Graphics Corporation
// Copyright 2015-2024 NVIDIA Corporation
// Copyright 2010-2018 Synopsys, Inc.
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
//-------------.----------------------------------------------------------------

//------------------------------------------------------------------------------
// Title -- xvm_*_imp ports
//
// The following defines the XVM TLM implementation (imp) classes.
//------------------------------------------------------------------------------

// Following are the definitions of all xvm_<type>_imp classes for the user. 
// They are extended from the export mixin class and use the 
// xvm_imp as the type parameter for the mixin to be used as the base class
// The respective interface class with required methods for the type of the 
// imp class is also an input to the mixin class.

// CLASS -- xvm_*_imp #(T,IMP)
//
// Unidirectional implementation (imp) port classes--An imp port provides access
// to an implementation of the associated interface to all connected ~ports~ and
// ~exports~. Each imp port instance ~must~ be connected to the component instance
// that implements the associated interface, typically the imp port's parent.
// All other connections-- e.g. to other ports and exports-- are prohibited.
//
// The asterisk in ~xvm_*_imp~ may be any of the following
//
//|  blocking_put
//|  nonblocking_put
//|  put
//|
//|  blocking_get
//|  nonblocking_get
//|  get
//|
//|  blocking_peek
//|  nonblocking_peek
//|  peek
//|
//|  blocking_get_peek
//|  nonblocking_get_peek
//|  get_peek
//
// Type parameters
//
// T   - The type of transaction to be communicated by the imp
//
// IMP - The type of the component implementing the interface. That is, the class
//       to which this imp will delegate.
//
// The interface methods are implemented in a component of type ~IMP~, a handle
// to which is passed in a constructor argument.  The imp port delegates all
// interface calls to this component.
//
//------------------------------------------------------------------------------

//----------------------------------------------------------------------
//PUT IMPS
//----------------------------------------------------------------------
class xvm_blocking_put_imp #(type T=int, type IMP=int) 
 extends xvm_blocking_put_export_pure_mixin #(T, xvm_imp #(xvm_tlm_blocking_put_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_blocking_put_imp",IMP)
  `XVM_BLOCKING_PUT_IMP (m_imp, T, t)
endclass 
class xvm_nonblocking_put_imp #(type T=int, type IMP=int) 
 extends xvm_nonblocking_put_export_pure_mixin#(T, xvm_imp #(xvm_tlm_nonblocking_put_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_nonblocking_put_imp",IMP)
  `XVM_NONBLOCKING_PUT_IMP (m_imp, T, t)
endclass 
class xvm_put_imp #(type T=int, type IMP=int) 
 extends xvm_put_export_pure_mixin#(T, xvm_imp #(xvm_tlm_put_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_put_imp",IMP)
  `XVM_PUT_IMP (m_imp, T, t)
endclass 

//----------------------------------------------------------------------
//GET IMPS
//----------------------------------------------------------------------
class xvm_blocking_get_imp #(type T=int, type IMP=int) 
 extends xvm_blocking_get_export_pure_mixin #(T, xvm_imp #(xvm_tlm_blocking_get_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_blocking_get_imp",IMP)
  `XVM_BLOCKING_GET_IMP (m_imp, T, t)
endclass 
class xvm_nonblocking_get_imp #(type T=int, type IMP=int) 
 extends xvm_nonblocking_get_export_pure_mixin#(T, xvm_imp #(xvm_tlm_nonblocking_get_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_nonblocking_get_imp",IMP)
  `XVM_NONBLOCKING_GET_IMP (m_imp, T, t)
endclass 
class xvm_get_imp #(type T=int, type IMP=int) 
 extends xvm_get_export_pure_mixin#(T, xvm_imp #(xvm_tlm_get_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_get_imp",IMP)
  `XVM_GET_IMP (m_imp, T, t)
endclass 

//----------------------------------------------------------------------
//PEEK IMPS
//----------------------------------------------------------------------
class xvm_blocking_peek_imp #(type T=int, type IMP=int) 
 extends xvm_blocking_peek_export_pure_mixin #(T, xvm_imp #(xvm_tlm_blocking_peek_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_blocking_peek_imp",IMP)
  `XVM_BLOCKING_PEEK_IMP (m_imp, T, t)
endclass 
class xvm_nonblocking_peek_imp #(type T=int, type IMP=int) 
 extends xvm_nonblocking_peek_export_pure_mixin#(T, xvm_imp #(xvm_tlm_nonblocking_peek_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_nonblocking_peek_imp",IMP)
  `XVM_NONBLOCKING_PEEK_IMP (m_imp, T, t)
endclass 
class xvm_peek_imp #(type T=int, type IMP=int) 
 extends xvm_peek_export_pure_mixin#(T, xvm_imp #(xvm_tlm_peek_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_peek_imp",IMP)
  `XVM_PEEK_IMP (m_imp, T, t)
endclass 

//----------------------------------------------------------------------
//GET-PEEK IMPS
//----------------------------------------------------------------------
class xvm_blocking_get_peek_imp #(type T=int, type IMP=int) 
 extends xvm_blocking_get_peek_export_pure_mixin #(T, xvm_imp #(xvm_tlm_blocking_get_peek_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_blocking_get_peek_imp", IMP)
  `XVM_BLOCKING_GET_PEEK_IMP (m_imp, T, t)
endclass 
class xvm_nonblocking_get_peek_imp #(type T=int, type IMP=int) 
 extends xvm_nonblocking_get_peek_export_pure_mixin #(T, xvm_imp #(xvm_tlm_nonblocking_get_peek_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_nonblocking_get_peek_imp", IMP)
  `XVM_NONBLOCKING_GET_PEEK_IMP (m_imp, T, t)
endclass
class xvm_get_peek_imp #(type T=int, type IMP=int) 
 extends xvm_get_peek_export_pure_mixin #(T, xvm_imp #(xvm_tlm_get_peek_if #(T,T))); 
  `XVM_IMP_COMMON("xvm_get_peek_imp", IMP)
  `XVM_GET_PEEK_IMP (m_imp, T, t)
endclass 

//----------------------------------------------------------------------
//MASTER IMPS
//----------------------------------------------------------------------
class xvm_blocking_nmaster_imp #(type REQ=int, type RSP=REQ, type IMP=int, 
                                type REQ_IMP=IMP, type RSP_IMP=IMP) 
 extends xvm_blocking_master_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_blocking_master_if #(REQ,RSP))); 
  typedef IMP     this_imp_type;
  typedef REQ_IMP this_req_type;
  typedef RSP_IMP this_rsp_type;
  `XVM_MS_IMP_COMMON("xvm_blocking_master_imp")
  `XVM_BLOCKING_PUT_IMP (m_req_imp, REQ, t)
  `XVM_BLOCKING_GET_PEEK_IMP (m_rsp_imp, RSP, t)
endclass 

class xvm_nonblocking_master_imp #(type REQ=int, type RSP=REQ, type IMP=int,
                                type REQ_IMP=IMP, type RSP_IMP=IMP)
 extends xvm_nonblocking_master_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_nonblocking_master_if #(REQ,RSP))); 
  typedef IMP     this_imp_type;
  typedef REQ_IMP this_req_type;
  typedef RSP_IMP this_rsp_type;
  `XVM_MS_IMP_COMMON("xvm_nonblocking_master_imp")
  `XVM_NONBLOCKING_PUT_IMP (m_req_imp, REQ, t)
  `XVM_NONBLOCKING_GET_PEEK_IMP (m_rsp_imp, RSP, t)
endclass

class xvm_master_imp #(type REQ=int, type RSP=REQ, type IMP=int,
                                type REQ_IMP=IMP, type RSP_IMP=IMP)
 extends xvm_master_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_master_if #(REQ,RSP))); 
  typedef IMP     this_imp_type;
  typedef REQ_IMP this_req_type;
  typedef RSP_IMP this_rsp_type;
  `XVM_MS_IMP_COMMON("xvm_master_imp")
  `XVM_PUT_IMP (m_req_imp, REQ, t)
  `XVM_GET_PEEK_IMP (m_rsp_imp, RSP, t)
endclass 

//----------------------------------------------------------------------
//SLAVE IMPS
//----------------------------------------------------------------------
class xvm_blocking_slave_imp #(type REQ=int, type RSP=REQ, type IMP=int, 
                                type REQ_IMP=IMP, type RSP_IMP=IMP) 
 extends xvm_blocking_slave_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_blocking_slave_if #(RSP,REQ))); 
  typedef IMP     this_imp_type;
  typedef REQ_IMP this_req_type;
  typedef RSP_IMP this_rsp_type;
  `XVM_MS_IMP_COMMON("xvm_blocking_slave_imp")
  `XVM_BLOCKING_PUT_IMP (m_rsp_imp, RSP, t)
  `XVM_BLOCKING_GET_PEEK_IMP (m_req_imp, REQ, t)
endclass 
class xvm_nonblocking_slave_imp #(type REQ=int, type RSP=REQ, type IMP=int, 
                                type REQ_IMP=IMP, type RSP_IMP=IMP) 
 extends xvm_nonblocking_slave_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_nonblocking_slave_if #(RSP,REQ))); 
  typedef IMP     this_imp_type;
  typedef REQ_IMP this_req_type;
  typedef RSP_IMP this_rsp_type;
  `XVM_MS_IMP_COMMON("xvm_nonblocking_slave_imp")
  `XVM_NONBLOCKING_PUT_IMP (m_rsp_imp, RSP, t)
  `XVM_NONBLOCKING_GET_PEEK_IMP (m_req_imp, REQ, t)
endclass
class xvm_slave_imp #(type REQ=int, type RSP=REQ, type IMP=int, 
                                type REQ_IMP=IMP, type RSP_IMP=IMP) 
 extends xvm_slave_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_slave_if #(RSP,REQ))); 
  typedef IMP     this_imp_type;
  typedef REQ_IMP this_req_type;
  typedef RSP_IMP this_rsp_type;
  `XVM_MS_IMP_COMMON("xvm_slave_imp")
  `XVM_PUT_IMP (m_rsp_imp, RSP, t)
  `XVM_GET_PEEK_IMP (m_req_imp, REQ, t)
endclass 

//----------------------------------------------------------------------
//TRANSPORT IMPS
//----------------------------------------------------------------------
class xvm_blocking_transport_imp #(type REQ=int, type RSP=REQ, type IMP=int) 
 extends xvm_blocking_transport_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_blocking_transport_if #(REQ,RSP))); 
  `XVM_IMP_COMMON("xvm_blocking_transport_imp",IMP)
  `XVM_BLOCKING_TRANSPORT_IMP (m_imp, REQ, RSP, req, rsp)
endclass 

class xvm_nonblocking_transport_imp #(type REQ=int, type RSP=REQ, type IMP=int) 
 extends xvm_nonblocking_transport_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_nonblocking_transport_if #(REQ,RSP))); 
  `XVM_IMP_COMMON("xvm_nonblocking_transport_imp",IMP)
  `XVM_NONBLOCKING_TRANSPORT_IMP (m_imp, REQ, RSP, req, rsp)
endclass

class xvm_transport_imp #(type REQ=int, type RSP=REQ, type IMP=int) 
 extends xvm_transport_export_pure_mixin #(REQ, RSP, xvm_imp #(xvm_tlm_transport_if #(REQ,RSP))); 
  `XVM_IMP_COMMON("xvm_transport_imp",IMP)
  `XVM_BLOCKING_TRANSPORT_IMP (m_imp, REQ, RSP, req, rsp)
  `XVM_NONBLOCKING_TRANSPORT_IMP (m_imp, REQ, RSP, req, rsp)
endclass 

