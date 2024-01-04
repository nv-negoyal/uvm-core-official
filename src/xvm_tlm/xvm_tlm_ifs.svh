//
//-----------------------------------------------------------------------------
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2007-2011 Mentor Graphics Corporation
// Copyright 2015-2024 NVIDIA Corporation
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
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//
// CLASS -- xvm_tlm_if_base #(T1,T2)
//
// These interface classes declares all the methods that should be defined
// for that type of  XVM TLM port/export/imp
//
// Only the relevant methods are declared in the respective class.
// Any class implementing this interface MUST define all the mehtods
// listed in this interface class. Hence, all the methods are pure virtual.
//
// Components that require a particular interface
// use ports to convey that requirement. Components that provide a particular
// interface use exports to convey its availability.
//
// Communication between components is established by connecting ports to
// compatible exports, much like connecting module signal-level output ports to
// compatible input ports. The difference is that XVM ports and exports bind
// interfaces (groups of methods), not signals and wires. The methods of the
// interfaces so bound pass data as whole transactions (e.g. objects).
// 
//-----------------------------------------------------------------------------

//----------------------------------------------------------------------
//PUT INTERFACES
//----------------------------------------------------------------------
interface class xvm_tlm_blocking_put_if #(type T1=int, type T2=int);
  pure virtual task put(input T1 t );
endclass
interface class xvm_tlm_nonblocking_put_if #(type T1=int, type T2=int);
  pure virtual function bit try_put( input T1 t );
  pure virtual function bit can_put( );
endclass
interface class xvm_tlm_put_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_put_if #(T1,T2), 
          xvm_tlm_nonblocking_put_if #(T1,T2);
endclass

//----------------------------------------------------------------------
//GET INTERFACES
//----------------------------------------------------------------------
interface class xvm_tlm_blocking_get_if #(type T1=int, type T2=int);
  pure virtual task get( output T2 t );
endclass
interface class xvm_tlm_nonblocking_get_if #(type T1=int, type T2=int);
  pure virtual function bit try_get( output T2 t );
  pure virtual function bit can_get( );
endclass
interface class xvm_tlm_get_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_get_if #(T1,T2), 
          xvm_tlm_nonblocking_get_if #(T1,T2);
endclass

//----------------------------------------------------------------------
//PEEK INTERFACES
//----------------------------------------------------------------------
interface class xvm_tlm_blocking_peek_if #(type T1=int, type T2=int);
  pure virtual task peek( output T2 t );
endclass
interface class xvm_tlm_nonblocking_peek_if #(type T1=int, type T2=int);
  pure virtual function bit try_peek( output T2 t );
  pure virtual function bit can_peek( );
endclass
interface class xvm_tlm_peek_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_peek_if #(T1,T2),
          xvm_tlm_nonblocking_peek_if #(T1,T2);
endclass

//----------------------------------------------------------------------
//GET_PEEK INTERFACES
//----------------------------------------------------------------------
interface class xvm_tlm_blocking_get_peek_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_get_if #(T1,T2),
          xvm_tlm_blocking_peek_if #(T1,T2);
endclass
interface class xvm_tlm_nonblocking_get_peek_if #(type T1=int, type T2=int)
  extends xvm_tlm_nonblocking_get_if #(T1,T2),
          xvm_tlm_nonblocking_peek_if #(T1,T2);
endclass
interface class xvm_tlm_get_peek_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_get_peek_if #(T1,T2),
           xvm_tlm_nonblocking_get_peek_if #(T1,T2),
           xvm_tlm_get_if #(T1,T2),
           xvm_tlm_peek_if #(T1,T2);
endclass

//----------------------------------------------------------------------
//MASTER INTERFACES
//----------------------------------------------------------------------
interface class xvm_tlm_blocking_master_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_put_if #(T1,T2),
          xvm_tlm_blocking_get_peek_if #(T1,T2);
endclass
interface class xvm_tlm_nonblocking_master_if #(type T1=int, type T2=int)
  extends xvm_tlm_nonblocking_put_if #(T1,T2),
          xvm_tlm_nonblocking_get_peek_if #(T1,T2);
endclass
interface class xvm_tlm_master_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_master_if #(T1,T2),
          xvm_tlm_nonblocking_master_if #(T1,T2),
          xvm_tlm_put_if #(T1,T2),
          xvm_tlm_get_peek_if #(T1,T2);
endclass

//----------------------------------------------------------------------
//SLAVE INTERFACES
//----------------------------------------------------------------------
interface class xvm_tlm_blocking_slave_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_put_if #(T1,T2),
          xvm_tlm_blocking_get_peek_if #(T1,T2);
endclass
interface class xvm_tlm_nonblocking_slave_if #(type T1=int, type T2=int)
  extends xvm_tlm_nonblocking_put_if #(T1,T2),
          xvm_tlm_nonblocking_get_peek_if #(T1,T2);
endclass
interface class xvm_tlm_slave_if #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_slave_if #(T1,T2),
          xvm_tlm_nonblocking_slave_if #(T1,T2),
          xvm_tlm_put_if #(T1,T2),
          xvm_tlm_get_peek_if #(T1,T2);
endclass

//----------------------------------------------------------------------
//TRANSPORT INTERFACES
//----------------------------------------------------------------------
interface class xvm_tlm_blocking_transport_if  #(type T1=int, type T2=int);
  pure virtual task transport( input T1 req , output T2 rsp );
endclass
interface class xvm_tlm_nonblocking_transport_if  #(type T1=int, type T2=int);
  pure virtual function bit nb_transport(input T1 req, output T2 rsp);
endclass
interface class xvm_tlm_transport_if  #(type T1=int, type T2=int)
  extends xvm_tlm_blocking_transport_if  #(T1,T2),
          xvm_tlm_nonblocking_transport_if  #(T1,T2);
endclass

//ANALYSIS INTERFACES
interface class xvm_tlm_analysis_if #(type T1=int, type T2=int);
  pure virtual function void write( input T1 t );
endclass

//PORT CHECK INTERFACES
interface class xvm_port_check_if#(type T=int);
endclass // xvm_port_check_if

interface class xvm_export_check_if#(type T=int) extends xvm_port_check_if#(T);
endclass // xvm_export_check_if


