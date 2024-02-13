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
//------------------------------------------------------------------------------

//------------------------------------------------------------------------------
// Title -- XVM TLM Export Classes
//------------------------------------------------------------------------------
// The following classes define the XVM TLM export classes.
//------------------------------------------------------------------------------
// Following are the definitions of all xvm_<type>_export classes for the user. 
// They are extended from the mixin class and use the 
// xvm_export as the type parameter for the mixin to be used as the base class
// The respective interface class with required methods for the type of the 
// export class is also an input to the mixin class.
//
// The unidirectional xvm_*_export is a port that ~forwards~ or ~promotes~
// an interface implementation from a child component to its parent.
// An export can be connected to any compatible child export or imp port.
// It must ultimately be connected to at least one implementation
// of its associated interface.
//
// The interface type represented by the asterisk is any of the following
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
// T - The type of transaction to be communicated by the export
// 
// Exports are connected to interface implementations directly via 
// <xvm_*_imp #(T,IMP)> ports or indirectly via other <xvm_*_export #(T)> exports.
//
//------------------------------------------------------------------------------

//----------------------------------------------------------------------
//PUT EXPORTS
//----------------------------------------------------------------------
class xvm_blocking_put_export #(type T=int) 
 extends xvm_blocking_put_export_pure_mixin#(T, xvm_export #(xvm_tlm_blocking_put_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_blocking_put_export")
  `XVM_BLOCKING_PUT_IMP (this.m_if, T, t)
endclass 
class xvm_nonblocking_put_export #(type T=int) 
 extends xvm_nonblocking_put_export_pure_mixin#(T, xvm_export #(xvm_tlm_nonblocking_put_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_nonblocking_put_export")
  `XVM_NONBLOCKING_PUT_IMP (this.m_if, T, t)
endclass 
class xvm_put_export #(type T=int) 
 extends xvm_put_export_pure_mixin#(T, xvm_export #(xvm_tlm_put_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_put_export")
  `XVM_PUT_IMP (this.m_if, T, t)
endclass 

//----------------------------------------------------------------------
//GET EXPORTS
//----------------------------------------------------------------------
class xvm_blocking_get_export #(type T=int) 
 extends xvm_blocking_get_export_pure_mixin#(T, xvm_export #(xvm_tlm_blocking_get_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_blocking_get_export")
  `XVM_BLOCKING_GET_IMP (this.m_if, T, t)
endclass 
class xvm_nonblocking_get_export #(type T=int) 
 extends xvm_nonblocking_get_export_pure_mixin#(T, xvm_export #(xvm_tlm_nonblocking_get_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_nonblocking_get_export")
  `XVM_NONBLOCKING_GET_IMP (this.m_if, T, t)
endclass 
class xvm_get_export #(type T=int) 
 extends xvm_get_export_pure_mixin#(T, xvm_export #(xvm_tlm_get_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_get_export")
  `XVM_GET_IMP (this.m_if, T, t)
endclass 

//----------------------------------------------------------------------
//PEEK EXPORTS
//----------------------------------------------------------------------
class xvm_blocking_peek_export #(type T=int) 
 extends xvm_blocking_peek_export_pure_mixin#(T, xvm_export #(xvm_tlm_blocking_peek_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_blocking_peek_export")
  `XVM_BLOCKING_PEEK_IMP (this.m_if, T, t)
endclass 
class xvm_nonblocking_peek_export #(type T=int) 
 extends xvm_nonblocking_peek_export_pure_mixin#(T, xvm_export #(xvm_tlm_nonblocking_peek_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_nonblocking_peek_export")
  `XVM_NONBLOCKING_PEEK_IMP (this.m_if, T, t)
endclass 
class xvm_peek_export #(type T=int) 
 extends xvm_peek_export_pure_mixin#(T, xvm_export #(xvm_tlm_peek_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_peek_export")
  `XVM_PEEK_IMP (this.m_if, T, t)
endclass 

//----------------------------------------------------------------------
//GET-PEEK EXPORTS
//----------------------------------------------------------------------
class xvm_blocking_get_peek_export #(type T=int) 
 extends xvm_blocking_get_peek_export_pure_mixin#(T, xvm_export #(xvm_tlm_blocking_get_peek_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_blocking_get_peek_export")
  `XVM_BLOCKING_GET_PEEK_IMP (this.m_if, T, t)
endclass 

class xvm_nonblocking_get_peek_export #(type T=int) 
 extends xvm_nonblocking_get_peek_export_pure_mixin#(T, xvm_export #(xvm_tlm_nonblocking_get_peek_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_nonblocking_get_peek_export")
  `XVM_NONBLOCKING_GET_PEEK_IMP (this.m_if, T, t)
endclass

class xvm_get_peek_export #(type T=int) 
 extends xvm_get_peek_export_pure_mixin#(T, xvm_export #(xvm_tlm_get_peek_if #(T))); 
  `XVM_EXPORT_COMMON("xvm_get_peek_export")
  `XVM_GET_PEEK_IMP (this.m_if, T, t)
endclass 

//----------------------------------------------------------------------
//MASTER EXPORTS
//----------------------------------------------------------------------
class xvm_blocking_master_export #(type REQ=int, type RSP=REQ) 
 extends xvm_blocking_master_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_blocking_master_if #(REQ,RSP)));
  `XVM_EXPORT_COMMON("xvm_blocking_master_export")
  `XVM_BLOCKING_PUT_IMP (this.m_if, REQ, t)
  `XVM_BLOCKING_GET_PEEK_IMP (this.m_if, RSP, t)
endclass 

class xvm_nonblocking_master_export #(type REQ=int, type RSP=REQ) 
 extends xvm_nonblocking_master_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_nonblocking_master_if #(REQ,RSP)));
  `XVM_EXPORT_COMMON("xvm_nonblocking_master_export")
  `XVM_NONBLOCKING_PUT_IMP (this.m_if, REQ, t)
  `XVM_NONBLOCKING_GET_PEEK_IMP (this.m_if, RSP, t)
endclass

class xvm_master_export #(type REQ=int, type RSP=REQ) 
 extends xvm_master_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_master_if #(REQ,RSP)));
  `XVM_EXPORT_COMMON("xvm_master_export")
  `XVM_PUT_IMP (this.m_if, REQ, t)
  `XVM_GET_PEEK_IMP (this.m_if, RSP, t)
endclass 

//----------------------------------------------------------------------
//SLAVE EXPORTS
//----------------------------------------------------------------------
class xvm_blocking_slave_export #(type REQ=int, type RSP=REQ) 
 extends xvm_blocking_slave_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_blocking_slave_if #(RSP,REQ)));
  `XVM_EXPORT_COMMON("xvm_blocking_slave_export")
  `XVM_BLOCKING_PUT_IMP (this.m_if, RSP, t)
  `XVM_BLOCKING_GET_PEEK_IMP (this.m_if, REQ, t)
endclass 

class xvm_nonblocking_slave_export #(type REQ=int, type RSP=REQ) 
 extends xvm_nonblocking_slave_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_nonblocking_slave_if #(RSP,REQ)));
  `XVM_EXPORT_COMMON("xvm_nonblocking_slave_export")
  `XVM_NONBLOCKING_PUT_IMP (this.m_if, RSP, t)
  `XVM_NONBLOCKING_GET_PEEK_IMP (this.m_if, REQ, t)
endclass

class xvm_slave_export #(type REQ=int, type RSP=REQ) 
 extends xvm_slave_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_slave_if #(RSP,REQ)));
  `XVM_EXPORT_COMMON("xvm_slave_export")
  `XVM_PUT_IMP (this.m_if, RSP, t)
  `XVM_GET_PEEK_IMP (this.m_if, REQ, t)
endclass 

//----------------------------------------------------------------------
//TRANSPORT EXPORTS
//----------------------------------------------------------------------
class xvm_blocking_transport_export #(type REQ=int, type RSP=REQ) 
 extends xvm_blocking_transport_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_blocking_transport_if #(REQ,RSP)));
  `XVM_EXPORT_COMMON("xvm_blocking_transport_export")
  `XVM_BLOCKING_TRANSPORT_IMP (this.m_if, REQ, RSP, req, rsp)
endclass 

class xvm_nonblocking_transport_export #(type REQ=int, type RSP=REQ) 
 extends xvm_nonblocking_transport_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_nonblocking_transport_if #(REQ,RSP)));
  `XVM_EXPORT_COMMON("xvm_nonblocking_transport_export")
  `XVM_NONBLOCKING_TRANSPORT_IMP (this.m_if, REQ, RSP, req, rsp)
endclass

class xvm_transport_export #(type REQ=int, type RSP=REQ) 
 extends xvm_transport_export_pure_mixin #(REQ, RSP, xvm_export #(xvm_tlm_transport_if #(REQ,RSP)));
  `XVM_EXPORT_COMMON("xvm_transport_export")
  `XVM_TRANSPORT_IMP (this.m_if, REQ, RSP, req, rsp)
endclass 

