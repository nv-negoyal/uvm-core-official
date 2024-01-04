//----------------------------------------------------------------------
// Copyright 2011 AMD
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2014 Intel Corporation
// Copyright 2007-2014 Mentor Graphics Corporation
// Copyright 2015-2024 NVIDIA Corporation
// Copyright 2013-2018 Synopsys, Inc.
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

//-----------------------------------------------------------------------------
//
// The XVM TLM implementation declaration macros provide a way for components
// to provide multiple implementation ports of the same implementation 
// interface. When an implementation port is defined using the built-in
// set of imps, there must be exactly one implementation of the interface.
//
// For example, if a component needs to provide a put implementation then
// it would have an implementation port defined like:
//
//| class mycomp extends uvm_component;
//|   xvm_put_imp#(data_type, mycomp) put_imp;
//|   ...
//|   virtual task put (data_type t);
//|     ...
//|   endtask
//| endclass
//
// There are times, however, when you need more than one implementation 
// for an interface. This set of declarations allow you to easily create
// a new implementation class to allow for multiple implementations. Although
// the new implementation class is a different class, it can be bound to
// the same types of exports and ports as the original class. Extending
// the put example above, let's say that mycomp needs to provide two put
// implementation ports. In that case, you would do something like:
//
//| //Define two new put interfaces which are compatible with xvm_put_ports
//| //and xvm_put_exports.
//|
//| `xvm_put_imp_decl(_1)
//| `xvm_put_imp_decl(_2)
//|
//| class my_put_imp#(type T=int) extends uvm_component;
//|    xvm_put_imp_1#(T,my_put_imp#(T)) put_imp1;
//|    xvm_put_imp_2#(T,my_put_imp#(T)) put_imp2;
//|    ...
//|    function void put_1 (input T t);
//|      //puts coming into put_imp1
//|      ...
//|    endfunction
//|    function void put_2(input T t);
//|      //puts coming into put_imp2
//|      ...
//|    endfunction
//| endclass
//
// The important thing to note is that each `xvm_<interface>_imp_decl creates a 
// new class of type xvm_<interface>_imp<suffix>, where suffix is the input 
// argument to the macro. For this reason, you will typically want to put
// these macros in a separate package to avoid collisions and to allow 
// sharing of the definitions.
//-----------------------------------------------------------------------------


// Define the class xvm_<type>_impSFX for providing blocking put
// implementations.  ~SFX~ is the suffix for the new class type.

`define xvm_blocking_put_imp_decl(SFX) \
class xvm_blocking_put_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_blocking_put_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_put_if #(T,T)), \
  `XVM_IMP_COMMON(`"xvm_blocking_put_imp``SFX`",IMP) \
  `XVM_BLOCKING_PUT_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_nonblocking_put_imp_decl(SFX) \
class xvm_nonblocking_put_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_nonblocking_put_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_nonblocking_put_if #(T,T)), \
            xvm_tlm_nonblocking_put_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_nonblocking_put_imp``SFX`",IMP) \
  `XVM_NONBLOCKING_PUT_IMP_SFX( SFX, m_imp, T, t) \
endclass

`define xvm_put_imp_decl(SFX) \
class xvm_put_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_put_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_put_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_put_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_put_if #(T,T)), \
            xvm_tlm_put_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_put_imp``SFX`",IMP) \
  `XVM_BLOCKING_PUT_IMP_SFX(SFX, m_imp, T, t) \
  `XVM_NONBLOCKING_PUT_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_blocking_get_imp_decl(SFX) \
class xvm_blocking_get_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_blocking_get_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_get_if #(T,T)), \
            xvm_tlm_blocking_get_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_blocking_get_imp``SFX`",IMP) \
  `XVM_BLOCKING_GET_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_nonblocking_get_imp_decl(SFX) \
class xvm_nonblocking_get_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_nonblocking_get_if #(T,T)) \
 implements xvm_export_check_if #(xvm_tlm_nonblocking_get_if #(T,T)), \
            xvm_tlm_nonblocking_get_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_nonblocking_get_imp``SFX`",IMP) \
  `XVM_NONBLOCKING_GET_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_get_imp_decl(SFX) \
class xvm_get_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_get_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_get_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_get_if #(T,T)), \
            xvm_tlm_get_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_get_imp``SFX`",IMP) \
  `XVM_BLOCKING_GET_IMP_SFX(SFX, m_imp, T, t) \
  `XVM_NONBLOCKING_GET_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_blocking_peek_imp_decl(SFX) \
class xvm_blocking_peek_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_blocking_peek_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_peek_if #(T,T)), \
            xvm_tlm_blocking_peek_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_blocking_peek_imp``SFX`",IMP) \
  `XVM_BLOCKING_PEEK_IMP_SFX(SFX, m_imp, T, t) \
endclass 

`define xvm_nonblocking_peek_imp_decl(SFX) \
class xvm_nonblocking_peek_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_nonblocking_peek_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_nonblocking_peek_if #(T,T)), \
            xvm_tlm_nonblocking_peek_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_nonblocking_peek_imp``SFX`",IMP) \
  `XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_peek_imp_decl(SFX) \
class xvm_peek_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_peek_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_peek_if #(T,T)), \
            xvm_tlm_peek_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_peek_imp``SFX`",IMP) \
  `XVM_BLOCKING_PEEK_IMP_SFX(SFX, m_imp, T, t) \
  `XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_blocking_get_peek_imp_decl(SFX) \
class xvm_blocking_get_peek_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_blocking_get_peek_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_get_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_blocking_peek_if #(T,T)), \
            xvm_tlm_blocking_get_peek_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_blocking_get_peek_imp``SFX`",IMP) \
  `XVM_BLOCKING_GET_IMP_SFX(SFX, m_imp, T, t) \
  `XVM_BLOCKING_PEEK_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_nonblocking_get_peek_imp_decl(SFX) \
class xvm_nonblocking_get_peek_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_nonblocking_get_peek_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_nonblocking_get_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_peek_if #(T,T)), \
            xvm_tlm_nonblocking_get_peek_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_nonblocking_get_peek_imp``SFX`",IMP) \
  `XVM_NONBLOCKING_GET_IMP_SFX(SFX, m_imp, T, t) \
  `XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_get_peek_imp_decl(SFX) \
class xvm_get_peek_imp``SFX #(type T=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_get_peek_if #(T,T)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_get_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_blocking_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_get_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_peek_if #(T,T)), \
            xvm_export_check_if #(xvm_tlm_get_peek_if #(T,T)), \
            xvm_tlm_get_peek_if #(T,T); \
  `XVM_IMP_COMMON(`"xvm_get_peek_imp``SFX`",IMP) \
  `XVM_BLOCKING_GET_IMP_SFX(SFX, m_imp, T, t) \
  `XVM_NONBLOCKING_GET_IMP_SFX(SFX, m_imp, T, t) \
  `XVM_BLOCKING_PEEK_IMP_SFX(SFX, m_imp, T, t) \
  `XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, m_imp, T, t) \
endclass

`define xvm_blocking_master_imp_decl(SFX) \
class xvm_blocking_master_imp``SFX #(type REQ=int, type RSP=int, type IMP=int, \
                                     type REQ_IMP=IMP, type RSP_IMP=IMP) \
 extends xvm_imp #(xvm_tlm_blocking_master_if #(REQ,RSP)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_master_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_blocking_put_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_blocking_peek_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_peek_if #(REQ,RSP)), \
            xvm_tlm_blocking_master_if #(REQ,RSP); \
  typedef IMP     this_imp_type; \
  typedef REQ_IMP this_req_type; \
  typedef RSP_IMP this_rsp_type; \
  `XVM_MS_IMP_COMMON(`"xvm_blocking_master_imp``SFX`") \
  \
  `XVM_BLOCKING_PUT_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  \
  `XVM_BLOCKING_GET_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  `XVM_BLOCKING_PEEK_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  \
endclass

`define xvm_nonblocking_master_imp_decl(SFX) \
class xvm_nonblocking_master_imp``SFX #(type REQ=int, type RSP=int, type IMP=int, \
                                   type REQ_IMP=IMP, type RSP_IMP=IMP) \
 extends xvm_imp #(xvm_tlm_nonblocking_master_if #(REQ,RSP)) \ 
 implements xvm_export_check_if #(xvm_tlm_nonblocking_master_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_put_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_peek_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_peek_if #(REQ,RSP)), \
            xvm_tlm_nonblocking_master_if #(REQ,RSP); \
  typedef IMP     this_imp_type; \
  typedef REQ_IMP this_req_type; \
  typedef RSP_IMP this_rsp_type; \
  `XVM_MS_IMP_COMMON(`"xvm_nonblocking_master_imp``SFX`") \
  \
  `XVM_NONBLOCKING_PUT_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  \
  `XVM_NONBLOCKING_GET_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  `XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  \
endclass

`define xvm_master_imp_decl(SFX) \
class xvm_master_imp``SFX #(type REQ=int, type RSP=int, type IMP=int, \
                            type REQ_IMP=IMP, type RSP_IMP=IMP) \
 extends xvm_imp #(xvm_tlm_master_if #(REQ,RSP)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_master_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_blocking_put_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_blocking_peek_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_peek_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_master_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_put_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_peek_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_peek_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_put_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_get_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_peek_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_get_peek_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_master_if #(REQ,RSP)), \
            xvm_tlm_master_if #(REQ,RSP); \
  typedef IMP     this_imp_type; \
  typedef REQ_IMP this_req_type; \
  typedef RSP_IMP this_rsp_type; \
  `XVM_MS_IMP_COMMON(`"xvm_master_imp``SFX`") \
  \
  `XVM_BLOCKING_PUT_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  `XVM_NONBLOCKING_PUT_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  \
  `XVM_BLOCKING_GET_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  `XVM_BLOCKING_PEEK_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  `XVM_NONBLOCKING_GET_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  `XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  \
endclass

`define xvm_blocking_slave_imp_decl(SFX) \
class xvm_blocking_slave_imp``SFX #(type REQ=int, type RSP=int, type IMP=int, \
                                    type REQ_IMP=IMP, type RSP_IMP=IMP) \
 extends xvm_imp #(xvm_tlm_blocking_slave_if #(RSP,REQ)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_slave_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_blocking_put_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_blocking_peek_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_peek_if #(RSP,REQ)), \
            xvm_tlm_blocking_slave_if #(RSP,REQ); \
  typedef IMP     this_imp_type; \
  typedef REQ_IMP this_req_type; \
  typedef RSP_IMP this_rsp_type; \
  `XVM_MS_IMP_COMMON(`"xvm_blocking_slave_imp``SFX`") \
  \
  `XVM_BLOCKING_PUT_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  \
  `XVM_BLOCKING_GET_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  `XVM_BLOCKING_PEEK_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  \
endclass

`define xvm_nonblocking_slave_imp_decl(SFX) \
class xvm_nonblocking_slave_imp``SFX #(type REQ=int, type RSP=int, type IMP=int, \
                                       type REQ_IMP=IMP, type RSP_IMP=IMP) \
 extends xvm_imp #(xvm_tlm_nonblocking_slave_if #(RSP,REQ)) \ 
 implements xvm_export_check_if #(xvm_tlm_nonblocking_slave_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_put_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_peek_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_peek_if #(RSP,REQ)), \
            xvm_tlm_nonblocking_slave_if #(RSP,REQ); \
  typedef IMP     this_imp_type; \
  typedef REQ_IMP this_req_type; \
  typedef RSP_IMP this_rsp_type; \
  `XVM_MS_IMP_COMMON(`"xvm_nonblocking_slave_imp``SFX`") \
  \
  `XVM_NONBLOCKING_PUT_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  \
  `XVM_NONBLOCKING_GET_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  `XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  \
endclass

`define xvm_slave_imp_decl(SFX) \
class xvm_slave_imp``SFX #(type REQ=int, type RSP=int, type IMP=int, \
                           type REQ_IMP=IMP, type RSP_IMP=IMP) \
 extends xvm_imp #(xvm_tlm_slave_if #(RSP,REQ)) \ 
 implements xvm_export_check_if #(xvm_tlm_blocking_slave_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_blocking_put_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_blocking_peek_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_blocking_get_peek_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_slave_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_put_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_peek_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_get_peek_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_put_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_get_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_peek_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_get_peek_if #(RSP,REQ)), \
            xvm_export_check_if #(xvm_tlm_slave_if #(RSP,REQ)), \
            xvm_tlm_slave_if #(RSP,REQ); \
  typedef IMP     this_imp_type; \
  typedef REQ_IMP this_req_type; \
  typedef RSP_IMP this_rsp_type; \
  `XVM_MS_IMP_COMMON(`"xvm_slave_imp``SFX`") \
  \
  `XVM_BLOCKING_PUT_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  `XVM_NONBLOCKING_PUT_IMP_SFX(SFX, m_rsp_imp, RSP, t) // rsp \
  \
  `XVM_BLOCKING_GET_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  `XVM_BLOCKING_PEEK_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  `XVM_NONBLOCKING_GET_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  `XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, m_req_imp, REQ, t) // req \
  \
endclass

`define xvm_blocking_transport_imp_decl(SFX) \
class xvm_blocking_transport_imp``SFX #(type REQ=int, type RSP=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_blocking_transport_if #(REQ,RSP)) \
 implements xvm_export_check_if #(xvm_tlm_blocking_transport_if #(REQ,RSP)), \
            xvm_tlm_blocking_transport_if #(REQ,RSP); \
  `XVM_IMP_COMMON(`"xvm_blocking_transport_imp``SFX`",IMP) \
  `XVM_BLOCKING_TRANSPORT_IMP_SFX(SFX, m_imp, REQ, RSP, req, rsp) \
endclass

`define xvm_nonblocking_transport_imp_decl(SFX) \
class xvm_nonblocking_transport_imp``SFX #(type REQ=int, type RSP=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_nonblocking_transport_if #(REQ,RSP)) \
 implements xvm_export_check_if #(xvm_tlm_nonblocking_transport_if #(REQ,RSP)), \
            xvm_tlm_nonblocking_transport_if #(REQ,RSP); \
  `XVM_IMP_COMMON(`"xvm_nonblocking_transport_imp``SFX`",IMP) \
  `XVM_NONBLOCKING_TRANSPORT_IMP_SFX(SFX, m_imp, REQ, RSP, req, rsp) \
endclass

`define xvm_non_blocking_transport_imp_decl(SFX) \
  `xvm_nonblocking_transport_imp_decl(SFX)

`define xvm_transport_imp_decl(SFX) \
class xvm_transport_imp``SFX #(type REQ=int, type RSP=int, type IMP=int) \
 extends xvm_imp #(xvm_tlm_transport_if #(REQ,RSP)) \
 implements xvm_export_check_if #(xvm_tlm_blocking_transport_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_nonblocking_transport_if #(REQ,RSP)), \
            xvm_export_check_if #(xvm_tlm_transport_if #(REQ,RSP)), \
            xvm_tlm_transport_if #(REQ,RSP); \
  `XVM_IMP_COMMON(`XVM_TLM_TRANSPORT_MASK,`"xvm_transport_imp``SFX`",IMP) \
  `XVM_BLOCKING_TRANSPORT_IMP_SFX(SFX, m_imp, REQ, RSP, req, rsp) \
  `XVM_NONBLOCKING_TRANSPORT_IMP_SFX(SFX, m_imp, REQ, RSP, req, rsp) \
endclass

// MACRO -- NODOCS -- `xvm_analysis_imp_decl
//
//| `xvm_analysis_imp_decl(SFX)
//
// Define the class xvm_analysis_impSFX for providing an analysis
// implementation. ~SFX~ is the suffix for the new class type. The analysis 
// implementation is the write function. The `xvm_analysis_imp_decl allows 
// for a scoreboard (or other analysis component) to support input from many 
// places. For example:
//
//| `xvm_analysis_imp_decl(_ingress)
//| `xvm_analysis_imp_decl(_egress)
//|
//| class myscoreboard extends xvm_component;
//|   xvm_analysis_imp_ingress#(mydata, myscoreboard) ingress;
//|   xvm_analysis_imp_egress#(mydata, myscoreboard) egress;
//|   mydata ingress_list[$];
//|   ...
//|
//|   function new(string name, xvm_component parent);
//|     super.new(name,parent);
//|     ingress = new("ingress", this);
//|     egress = new("egress", this);
//|   endfunction
//|
//|   function void write_ingress(mydata t);
//|     ingress_list.push_back(t);
//|   endfunction
//|
//|   function void write_egress(mydata t);
//|     find_match_in_ingress_list(t);
//|   endfunction
//|
//|   function void find_match_in_ingress_list(mydata t);
//|     //implement scoreboarding for this particular dut
//|     ...
//|   endfunction
//| endclass

`define xvm_analysis_imp_decl(SFX) \
class xvm_analysis_imp``SFX #(type T=int, type IMP=int) \
  extends xvm_imp #(xvm_tlm_analysis_if #(T,T)) \
  implements xvm_tlm_analysis_if #(T,T), \
             xvm_export_check_if #(xvm_tlm_analysis_if #(T,T)); \
  `XVM_IMP_COMMON(`"xvm_analysis_imp``SFX`",IMP) \
  function void write( input T t); \
    m_imp.write``SFX( t); \
  endfunction \
  \
endclass


// These imps are used in xvm_*_port, xvm_*_export and xvm_*_imp, using suffixes
//

`define XVM_BLOCKING_PUT_IMP_SFX(SFX, imp, TYPE, arg) \
  task put( input TYPE arg); imp.put``SFX( arg); endtask

`define XVM_BLOCKING_GET_IMP_SFX(SFX, imp, TYPE, arg) \
  task get( output TYPE arg); imp.get``SFX( arg); endtask

`define XVM_BLOCKING_PEEK_IMP_SFX(SFX, imp, TYPE, arg) \
  task peek( output TYPE arg);imp.peek``SFX( arg); endtask

`define XVM_NONBLOCKING_PUT_IMP_SFX(SFX, imp, TYPE, arg) \
  function bit try_put( input TYPE arg); \
    if( !imp.try_put``SFX( arg)) return 0; \
    return 1; \
  endfunction \
  function bit can_put(); return imp.can_put``SFX(); endfunction

`define XVM_NONBLOCKING_GET_IMP_SFX(SFX, imp, TYPE, arg) \
  function bit try_get( output TYPE arg); \
    if( !imp.try_get``SFX( arg)) return 0; \
    return 1; \
  endfunction \
  function bit can_get(); return imp.can_get``SFX(); endfunction

`define XVM_NONBLOCKING_PEEK_IMP_SFX(SFX, imp, TYPE, arg) \
  function bit try_peek( output TYPE arg); \
    if( !imp.try_peek``SFX( arg)) return 0; \
    return 1; \
  endfunction \
  function bit can_peek(); return imp.can_peek``SFX(); endfunction

`define XVM_BLOCKING_TRANSPORT_IMP_SFX(SFX, imp, REQ, RSP, req_arg, rsp_arg) \
  task transport( input REQ req_arg, output RSP rsp_arg); \
    imp.transport``SFX(req_arg, rsp_arg); \
  endtask

`define XVM_NONBLOCKING_TRANSPORT_IMP_SFX(SFX, imp, REQ, RSP, req_arg, rsp_arg) \
  virtual function bit nb_transport( input REQ req_arg, output RSP rsp_arg); \
    if(imp) return imp.nb_transport``SFX(req_arg, rsp_arg); \
  endfunction


//----------------------------------------------------------------------
// imp definitions
//----------------------------------------------------------------------
`define XVM_SEQ_ITEM_PULL_IMP(imp, REQ, RSP, req_arg, rsp_arg) \
  function void disable_auto_item_recording(); imp.disable_auto_item_recording(); endfunction \
  function bit is_auto_item_recording_enabled(); return imp.is_auto_item_recording_enabled(); endfunction \
  task get_next_item(output REQ req_arg); imp.get_next_item(req_arg); endtask \
  task try_next_item(output REQ req_arg); imp.try_next_item(req_arg); endtask \
  function void item_done(input RSP rsp_arg = null); imp.item_done(rsp_arg); endfunction \
  task wait_for_sequences(); imp.wait_for_sequences(); endtask \
  function bit has_do_available(); return imp.has_do_available(); endfunction \
  function void put_response(input RSP rsp_arg); imp.put_response(rsp_arg); endfunction \
  task get(output REQ req_arg); imp.get(req_arg); endtask \
  task peek(output REQ req_arg); imp.peek(req_arg); endtask \
  task put(input RSP rsp_arg); imp.put(rsp_arg); endtask

