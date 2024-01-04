//
//----------------------------------------------------------------------
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
//----------------------------------------------------------------------

//------------------------------------------------------------------------------
// Title -- XVM TLM Port Classes
//------------------------------------------------------------------------------
// The following classes define the XVM TLM port classes.
//------------------------------------------------------------------------------

// Following are the definitions of all xvm_<type>_port classes for the user. 
// They are extended from the mixin class and use the 
// xvm_port as the type parameter for the mixin to be used as the base class
// The respective interface class with required methods for the type of the 
// port class is also an inpur to the mixin class.
//------------------------------------------------------------------------------
//
// Class -- xvm_*_port #(T)
//
// These unidirectional ports are instantiated by components that ~require~,
// or ~use~, the associated interface to convey transactions. A port can
// be connected to any compatible port, export, or imp port. Unless its
// ~min_size~ is 0, a port ~must~ be connected to at least one implementation
// of its associated interface.
//
// The asterisk in ~xvm_*_port~ is any of the following
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
// T - The type of transaction to be communicated by the export. The type T is not restricted
// to class handles and may be a value type such as int,enum,struct or similar.
//
// Ports are connected to interface implementations directly via 
// <xvm_*_imp #(T,IMP)> ports or indirectly via hierarchical connections
// to <xvm_*_port #(T)> and <xvm_*_export #(T)> ports.
//
//------------------------------------------------------------------------------



//----------------------------------------------------------------------
//PUT PORTS
//----------------------------------------------------------------------
class xvm_blocking_put_port #(type T=int) 
 extends xvm_blocking_put_port_pure_mixin#(T, xvm_port #(xvm_tlm_blocking_put_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_blocking_put_port")
  `XVM_BLOCKING_PUT_IMP (this.m_if, T, t)
endclass 
class xvm_nonblocking_put_port #(type T=int) 
 extends xvm_nonblocking_put_port_pure_mixin#(T, xvm_port #(xvm_tlm_nonblocking_put_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_nonblocking_put_port")
  `XVM_NONBLOCKING_PUT_IMP (this.m_if, T, t)
endclass 
class xvm_put_port #(type T=int) 
 extends xvm_put_port_pure_mixin#(T, xvm_port #(xvm_tlm_put_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_put_port")
  `XVM_PUT_IMP (this.m_if, T, t)
endclass 


//----------------------------------------------------------------------
//GET PORTS
//----------------------------------------------------------------------
class xvm_blocking_get_port #(type T=int) 
 extends xvm_blocking_get_port_pure_mixin#(T, xvm_port #(xvm_tlm_blocking_get_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_blocking_get_port")
  `XVM_BLOCKING_GET_IMP (this.m_if, T, t)
endclass 
class xvm_nonblocking_get_port #(type T=int) 
 extends xvm_nonblocking_get_port_pure_mixin#(T, xvm_port #(xvm_tlm_nonblocking_get_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_nonblocking_get_port")
  `XVM_NONBLOCKING_GET_IMP (this.m_if, T, t)
endclass 
class xvm_get_port #(type T=int) 
 extends xvm_get_port_pure_mixin#(T, xvm_port #(xvm_tlm_get_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_get_port")
  `XVM_GET_IMP (this.m_if, T, t)
endclass 


//----------------------------------------------------------------------
//PEEK PORTS
//----------------------------------------------------------------------
class xvm_blocking_peek_port #(type T=int) 
 extends xvm_blocking_peek_port_pure_mixin#(T, xvm_port #(xvm_tlm_blocking_peek_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_blocking_peek_port")
  `XVM_BLOCKING_PEEK_IMP (this.m_if, T, t)
endclass 
class xvm_nonblocking_peek_port #(type T=int) 
 extends xvm_nonblocking_peek_port_pure_mixin#(T, xvm_port #(xvm_tlm_nonblocking_peek_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_nonblocking_peek_port")
  `XVM_NONBLOCKING_PEEK_IMP (this.m_if, T, t)
endclass 
class xvm_peek_port #(type T=int) 
 extends xvm_peek_port_pure_mixin#(T, xvm_port #(xvm_tlm_peek_if #(T,T))); 
  `XVM_PORT_COMMON("xvm_peek_port")
  `XVM_PEEK_IMP (this.m_if, T, t)
endclass 


//----------------------------------------------------------------------
//GET-PEEK PORTS
//----------------------------------------------------------------------
class xvm_blocking_get_peek_port #(type T=int) 
 extends xvm_blocking_get_peek_port_pure_mixin#(T, xvm_port #(xvm_tlm_blocking_get_peek_if #(T,T))); 
   `XVM_PORT_COMMON("xvm_blocking_get_peek_port")
  `XVM_BLOCKING_GET_PEEK_IMP (this.m_if, T, t)
endclass 
class xvm_nonblocking_get_peek_port #(type T=int) 
 extends xvm_nonblocking_get_peek_port_pure_mixin#(T, xvm_port #(xvm_tlm_nonblocking_get_peek_if #(T,T))); 
   `XVM_PORT_COMMON("xvm_nonblocking_get_peek_port")
  `XVM_NONBLOCKING_GET_PEEK_IMP (this.m_if, T, t)
endclass
class xvm_get_peek_port #(type T=int) 
 extends xvm_get_peek_port_pure_mixin#(T, xvm_port #(xvm_tlm_get_peek_if #(T,T))); 
   `XVM_PORT_COMMON("xvm_get_peek_port")
  `XVM_GET_PEEK_IMP (this.m_if, T, t)
endclass 

//----------------------------------------------------------------------
//MASTER PORTS
//----------------------------------------------------------------------
class xvm_blocking_master_port #(type REQ=int, type RSP=REQ)
 extends xvm_blocking_master_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_blocking_master_if #(REQ,RSP))); 
  `XVM_PORT_COMMON("xvm_blocking_master_port")
  `XVM_BLOCKING_PUT_IMP (this.m_if, REQ, t)
  `XVM_BLOCKING_GET_PEEK_IMP (this.m_if, RSP, t)
endclass 
class xvm_nonblocking_master_port #(type REQ=int, type RSP=REQ) 
 extends xvm_nonblocking_master_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_nonblocking_master_if #(REQ,RSP))); 
  `XVM_PORT_COMMON("xvm_nonblocking_master_port")
  `XVM_NONBLOCKING_PUT_IMP (this.m_if, REQ, t)
  `XVM_NONBLOCKING_GET_PEEK_IMP (this.m_if, RSP, t)
endclass
class xvm_master_port #(type REQ=int, type RSP=REQ)
 extends xvm_master_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_master_if #(REQ,RSP))); 
  `XVM_PORT_COMMON("xvm_master_port")
  `XVM_PUT_IMP (this.m_if, REQ, t)
  `XVM_GET_PEEK_IMP (this.m_if, RSP, t)
endclass 

//----------------------------------------------------------------------
//SLAVE PORTS
//----------------------------------------------------------------------
class xvm_blocking_slave_port #(type REQ=int, type RSP=REQ)
 extends xvm_blocking_slave_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_blocking_slave_if #(RSP,REQ))); 
  `XVM_PORT_COMMON("xvm_blocking_slave_port")
  `XVM_BLOCKING_PUT_IMP (this.m_if, RSP, t)
  `XVM_BLOCKING_GET_PEEK_IMP (this.m_if, REQ, t)
endclass 
class xvm_nonblocking_slave_port #(type REQ=int, type RSP=REQ) 
 extends xvm_nonblocking_slave_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_nonblocking_slave_if #(RSP,REQ))); 
  `XVM_PORT_COMMON("xvm_nonblocking_slave_port")
  `XVM_NONBLOCKING_PUT_IMP (this.m_if, RSP, t)
  `XVM_NONBLOCKING_GET_PEEK_IMP (this.m_if, REQ, t)
endclass
class xvm_slave_port #(type REQ=int, type RSP=REQ)
 extends xvm_slave_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_slave_if #(RSP,REQ))); 
  `XVM_PORT_COMMON("xvm_slave_port")
  `XVM_PUT_IMP (this.m_if, RSP, t)
  `XVM_GET_PEEK_IMP (this.m_if, REQ, t)
endclass 

//----------------------------------------------------------------------
//TRANSPORT PORTS
//----------------------------------------------------------------------
class xvm_blocking_transport_port #(type REQ=int, type RSP=REQ) 
 extends xvm_blocking_transport_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_blocking_transport_if #(REQ,RSP))); 
  `XVM_PORT_COMMON("xvm_blocking_transport_port")
  `XVM_BLOCKING_TRANSPORT_IMP (this.m_if, REQ, RSP, req, rsp)
endclass 

class xvm_nonblocking_transport_port #(type REQ=int, type RSP=REQ) 
 extends xvm_nonblocking_transport_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_nonblocking_transport_if #(REQ,RSP))); 
  `XVM_PORT_COMMON("xvm_nonblocking_transport_port")
  `XVM_NONBLOCKING_TRANSPORT_IMP (this.m_if, REQ, RSP, req, rsp)
endclass

class xvm_transport_port #(type REQ=int, type RSP=REQ) 
 extends xvm_transport_port_pure_mixin #(REQ, RSP, xvm_port #(xvm_tlm_transport_if #(REQ,RSP))); 
  `XVM_PORT_COMMON("xvm_transport_port")
  `XVM_TRANSPORT_IMP (this.m_if, REQ, RSP, req, rsp)
endclass 

