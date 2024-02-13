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

//
// The mixin pattern uses a combination of Interface classes and CRTP
// to provide multiple inheritance in System Verilog. It provides a default 
// implementation of an interface and extends from a class that is a type 
// parameter for the mixin class. The name mixin comes from how the class 
// mixes the interface into the base class. In this way, two classes 
// derived from the mixin class implement the same interface but may be
// derived from different base classes. 

// Following at the definition of port mixins. The ports are declared using
// the port mixins

//----------------------------------------------------------------------
//PUT MIXIN
//----------------------------------------------------------------------
virtual class xvm_blocking_put_port_pure_mixin #(type T=int, type BASE=int)
   extends BASE
   implements xvm_tlm_blocking_put_if #(T),
              xvm_port_check_if #(xvm_tlm_blocking_put_if #(T));
   `XVM_NEW_COMMON
   pure virtual task put(T t);
endclass // xvm_blocking_put_port_pure_mixin
virtual class xvm_nonblocking_put_port_pure_mixin #(type T=int, type BASE=int)
   extends BASE
   implements xvm_tlm_nonblocking_put_if #(T),
              xvm_port_check_if #(xvm_tlm_nonblocking_put_if #(T));
   `XVM_NEW_COMMON
   pure virtual function bit try_put (T t); 
   pure virtual function bit can_put(); 
endclass // xvm_nonblocking_put_port_pure_mixin
virtual class xvm_put_port_pure_mixin #(type T=int, type BASE=int)
   extends xvm_blocking_put_port_pure_mixin #(T,
	         xvm_nonblocking_put_port_pure_mixin #(T, BASE))
   implements xvm_tlm_put_if #(T),
              xvm_port_check_if #(xvm_tlm_put_if #(T));
   `XVM_NEW_COMMON
   pure virtual task put(T t);
   pure virtual function bit try_put (T t); 
   pure virtual function bit can_put(); 
endclass // xvm_put_port_pure_mixin

//----------------------------------------------------------------------
//GET MIXIN
//----------------------------------------------------------------------
virtual class xvm_blocking_get_port_pure_mixin #(type T=int, type BASE=int)
   extends BASE
   implements xvm_tlm_blocking_get_if #(T),
              xvm_port_check_if #(xvm_tlm_blocking_get_if #(T));
   `XVM_NEW_COMMON
   pure virtual task get(output T t);
endclass // xvm_blocking_get_port_pure_mixin
virtual class xvm_nonblocking_get_port_pure_mixin #(type T=int, type BASE=int)
   extends BASE
   implements xvm_tlm_nonblocking_get_if #(T),
              xvm_port_check_if #(xvm_tlm_nonblocking_get_if #(T));
   `XVM_NEW_COMMON
   pure virtual function bit try_get (output T t); 
   pure virtual function bit can_get(); 
endclass // xvm_nonblocking_get_port_pure_mixin
virtual class xvm_get_port_pure_mixin #(type T=int, type BASE=int)
   extends xvm_blocking_get_port_pure_mixin #(T,
	         xvm_nonblocking_get_port_pure_mixin #(T, BASE))
   implements xvm_tlm_get_if #(T),
              xvm_port_check_if #(xvm_tlm_get_if #(T));
   `XVM_NEW_COMMON
   pure virtual task get(output T t);
   pure virtual function bit try_get (output T t); 
   pure virtual function bit can_get(); 
endclass // xvm_get_port_pure_mixin

//----------------------------------------------------------------------
//PEEK MIXIN
//----------------------------------------------------------------------
virtual class xvm_blocking_peek_port_pure_mixin #(type T=int, type BASE=int)
   extends BASE
   implements xvm_tlm_blocking_peek_if #(T),
              xvm_port_check_if #(xvm_tlm_blocking_peek_if #(T));
   `XVM_NEW_COMMON
   pure virtual task peek(output T t);
endclass // xvm_blocking_peek_port_pure_mixin
virtual class xvm_nonblocking_peek_port_pure_mixin #(type T=int, type BASE=int)
   extends BASE
   implements xvm_tlm_nonblocking_peek_if #(T),
              xvm_port_check_if #(xvm_tlm_nonblocking_peek_if #(T));
   `XVM_NEW_COMMON
   pure virtual function bit try_peek (output T t); 
   pure virtual function bit can_peek(); 
endclass // xvm_nonblocking_peek_port_pure_mixin
virtual class xvm_peek_port_pure_mixin #(type T=int, type BASE=int)
   extends xvm_blocking_peek_port_pure_mixin #(T,
	         xvm_nonblocking_peek_port_pure_mixin #(T, BASE))
   implements xvm_tlm_peek_if #(T),
              xvm_port_check_if #(xvm_tlm_peek_if #(T));
   `XVM_NEW_COMMON
   pure virtual task peek(output T t);
   pure virtual function bit try_peek (output T t); 
   pure virtual function bit can_peek(); 
endclass // xvm_peek_port_pure_mixin

//----------------------------------------------------------------------
// GET_PEEK MIXIN
//----------------------------------------------------------------------
virtual class xvm_blocking_get_peek_port_pure_mixin #(type T=int, type BASE=int)
   extends xvm_blocking_peek_port_pure_mixin #(T,
	         xvm_blocking_get_port_pure_mixin #(T, BASE))
   implements xvm_tlm_blocking_get_peek_if #(T),
              xvm_port_check_if #(xvm_tlm_blocking_peek_if #(T)),
              xvm_port_check_if #(xvm_tlm_blocking_get_if #(T)),
              xvm_port_check_if #(xvm_tlm_blocking_get_peek_if #(T));
   `XVM_NEW_COMMON
   pure virtual task get(output T t);
   pure virtual task peek(output T t);
endclass // xvm_blocking_get_peek_port_pure_mixin
virtual class xvm_nonblocking_get_peek_port_pure_mixin #(type T=int, type BASE=int)
   extends xvm_nonblocking_peek_port_pure_mixin #(T,
	         xvm_nonblocking_get_port_pure_mixin #(T, BASE))
   implements xvm_tlm_nonblocking_get_peek_if #(T),
              xvm_port_check_if #(xvm_tlm_nonblocking_peek_if #(T)),
              xvm_port_check_if #(xvm_tlm_nonblocking_get_if #(T)),
              xvm_port_check_if #(xvm_tlm_nonblocking_get_peek_if #(T));
   `XVM_NEW_COMMON
   pure virtual function bit try_get (output T t); 
   pure virtual function bit can_get(); 
   pure virtual function bit try_peek (output T t); 
   pure virtual function bit can_peek(); 
endclass // xvm_nonblocking_get_peek_port_pure_mixin
virtual class xvm_get_peek_port_pure_mixin #(type T=int, type BASE=int)
   extends xvm_peek_port_pure_mixin #(T,
	         xvm_get_port_pure_mixin #(T, BASE))
   implements xvm_tlm_get_peek_if #(T),
              xvm_port_check_if #(xvm_tlm_get_if #(T)),
              xvm_port_check_if #(xvm_tlm_peek_if #(T)),
              xvm_port_check_if #(xvm_tlm_get_peek_if #(T));
   `XVM_NEW_COMMON
   pure virtual task get(output T t);
   pure virtual task peek(output T t);
   pure virtual function bit try_get (output T t); 
   pure virtual function bit can_get(); 
   pure virtual function bit try_peek (output T t); 
   pure virtual function bit can_peek(); 
endclass // xvm_get_peek_port_pure_mixin

//----------------------------------------------------------------------
//MASTER MIXIN
//----------------------------------------------------------------------
virtual class xvm_blocking_master_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends xvm_blocking_peek_port_pure_mixin #(RSP,
	         xvm_blocking_get_port_pure_mixin #(RSP, 
	         xvm_blocking_put_port_pure_mixin #(REQ, BASE)))
   implements xvm_tlm_blocking_master_if #(REQ,RSP),
            xvm_port_check_if #(xvm_tlm_blocking_put_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_blocking_get_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_blocking_peek_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_blocking_get_peek_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_blocking_master_if #(REQ,RSP));
   `XVM_NEW_COMMON
   pure virtual task put(REQ t);
   pure virtual task get(output RSP t);
   pure virtual task peek(output RSP t);
endclass // xvm_blocking_master_port_pure_mixin
virtual class xvm_nonblocking_master_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends xvm_nonblocking_peek_port_pure_mixin #(RSP,
	         xvm_nonblocking_get_port_pure_mixin #(RSP, 
	         xvm_nonblocking_put_port_pure_mixin #(REQ, BASE)))
   implements xvm_tlm_nonblocking_master_if #(REQ,RSP),
            xvm_port_check_if #(xvm_tlm_nonblocking_put_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_nonblocking_get_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_nonblocking_peek_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_nonblocking_get_peek_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_nonblocking_master_if #(REQ,RSP));
   `XVM_NEW_COMMON
   pure virtual function bit try_put(REQ t);
   pure virtual function bit try_get(output RSP t);
   pure virtual function bit try_peek(output RSP t);
   pure virtual function bit can_get(); 
   pure virtual function bit can_peek(); 
   pure virtual function bit can_put(); 
endclass // xvm_blocking_master_port_pure_mixin
virtual class xvm_master_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends xvm_peek_port_pure_mixin #(RSP,
	         xvm_get_port_pure_mixin #(RSP, 
	         xvm_put_port_pure_mixin #(REQ, 
	         xvm_blocking_master_port_pure_mixin #(REQ, RSP,
	         xvm_nonblocking_master_port_pure_mixin #(REQ, RSP, BASE))))) 
   implements xvm_tlm_master_if #(REQ,RSP),
            xvm_port_check_if #(xvm_tlm_put_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_get_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_peek_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_get_peek_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_master_if #(REQ,RSP));
   `XVM_NEW_COMMON
   pure virtual task put(REQ t);
   pure virtual task get(output RSP t);
   pure virtual task peek(output RSP t);
   pure virtual function bit try_put(REQ t);
   pure virtual function bit try_get(output RSP t);
   pure virtual function bit try_peek(output RSP t);
   pure virtual function bit can_get(); 
   pure virtual function bit can_peek(); 
   pure virtual function bit can_put(); 
endclass // xvm_master_port_pure_mixin

//----------------------------------------------------------------------
//SLAVE MIXIN
//----------------------------------------------------------------------
virtual class xvm_blocking_slave_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends xvm_blocking_peek_port_pure_mixin #(REQ,
	         xvm_blocking_get_port_pure_mixin #(REQ, 
	         xvm_blocking_put_port_pure_mixin #(RSP, BASE)))
   implements xvm_tlm_blocking_slave_if #(RSP,REQ),
            xvm_port_check_if #(xvm_tlm_blocking_put_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_blocking_get_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_blocking_peek_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_blocking_get_peek_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_blocking_slave_if #(RSP,REQ));
   `XVM_NEW_COMMON
   pure virtual task put(RSP t);
   pure virtual task get(output REQ t);
   pure virtual task peek(output REQ t);
endclass // xvm_blocking_slave_port_pure_mixin
virtual class xvm_nonblocking_slave_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends xvm_nonblocking_peek_port_pure_mixin #(REQ,
	         xvm_nonblocking_get_port_pure_mixin #(REQ, 
	         xvm_nonblocking_put_port_pure_mixin #(RSP, BASE)))
   implements xvm_tlm_nonblocking_slave_if #(RSP,REQ),
            xvm_port_check_if #(xvm_tlm_nonblocking_put_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_nonblocking_get_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_nonblocking_peek_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_nonblocking_get_peek_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_nonblocking_slave_if #(RSP,REQ));
   `XVM_NEW_COMMON
   pure virtual function bit try_put(RSP t);
   pure virtual function bit try_get(output REQ t);
   pure virtual function bit try_peek(output REQ t);
   pure virtual function bit can_get(); 
   pure virtual function bit can_peek(); 
   pure virtual function bit can_put(); 
endclass // xvm_nonblocking_slave_port_pure_mixin
virtual class xvm_slave_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends xvm_peek_port_pure_mixin #(REQ,
	         xvm_get_port_pure_mixin #(REQ, 
	         xvm_put_port_pure_mixin #(RSP, 
	         xvm_blocking_slave_port_pure_mixin #(REQ, RSP,
	         xvm_nonblocking_slave_port_pure_mixin #(REQ, RSP, BASE))))) 
   implements xvm_tlm_slave_if #(RSP,REQ),
            xvm_port_check_if #(xvm_tlm_put_if #(RSP)),
            xvm_port_check_if #(xvm_tlm_get_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_peek_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_get_peek_if #(REQ)),
            xvm_port_check_if #(xvm_tlm_slave_if #(RSP,REQ));
   `XVM_NEW_COMMON
   pure virtual task put(input RSP t);
   pure virtual task get(output REQ t);
   pure virtual task peek(output REQ t);
   pure virtual function bit try_put(RSP t);
   pure virtual function bit try_get(output REQ t);
   pure virtual function bit try_peek(output REQ t);
   pure virtual function bit can_get(); 
   pure virtual function bit can_peek(); 
   pure virtual function bit can_put(); 
endclass // xvm_slave_port_pure_mixin

//----------------------------------------------------------------------
//TRANSPORT MIXIN
//----------------------------------------------------------------------
virtual class xvm_blocking_transport_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends BASE
   implements xvm_tlm_blocking_transport_if #(REQ,RSP),
              xvm_port_check_if #(xvm_tlm_blocking_transport_if #(REQ,RSP));
   `XVM_NEW_COMMON
   pure virtual task transport (REQ req_arg, output RSP rsp_arg); 
endclass // xvm_blocking_transport_port_pure_mixin
virtual class xvm_nonblocking_transport_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends BASE
   implements xvm_tlm_nonblocking_transport_if #(REQ,RSP),
              xvm_port_check_if #(xvm_tlm_nonblocking_transport_if #(REQ,RSP));
   `XVM_NEW_COMMON
   pure virtual function bit nb_transport (REQ req_arg, output RSP rsp_arg); 
endclass // xvm_nonblocking_transport_port_pure_mixin
virtual class xvm_transport_port_pure_mixin #(type REQ=int, type RSP=REQ, type BASE=int)
   extends xvm_blocking_transport_port_pure_mixin #(REQ, RSP,
	         xvm_nonblocking_transport_port_pure_mixin #(REQ, RSP, BASE))
   implements xvm_tlm_transport_if #(REQ,RSP),
              xvm_port_check_if #(xvm_tlm_blocking_transport_if #(REQ,RSP)),
              xvm_port_check_if #(xvm_tlm_nonblocking_transport_if #(REQ,RSP)),
              xvm_port_check_if #(xvm_tlm_transport_if #(REQ,RSP));
   `XVM_NEW_COMMON
   pure virtual task transport (REQ req_arg, output RSP rsp_arg); 
   pure virtual function bit nb_transport (REQ req_arg, output RSP rsp_arg); 
endclass // xvm_transport_port_pure_mixin



