//
//------------------------------------------------------------------------------
// Copyright 2011 AMD
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2014 Cisco Systems, Inc.
// Copyright 2007-2014 Mentor Graphics Corporation
// Copyright 2013-2024 NVIDIA Corporation
// Copyright 2014 Semifore
// Copyright 2010-2013 Synopsys, Inc.
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
//
// CLASS -- xvm_sqr_if_base #(REQ,RSP)
//----------------------------------------------------------------------


`define XVM_SEQ_ITEM_TASK_ERROR "Sequencer interface task not implemented"
`define XVM_SEQ_ITEM_FUNCTION_ERROR "Sequencer interface function not implemented"

//------------------------------------------------------------------------------
// This class defines an interface for sequence drivers to communicate with
// sequencers. The driver requires the interface via a port, and the sequencer
// implements it and provides it via an export.
//------------------------------------------------------------------------------

interface class xvm_sqr_if #(type T1=uvm_object, T2=T1);
  pure virtual task get_next_item(output T1 t);
  pure virtual task try_next_item(output T1 t);
  pure virtual function void item_done(input T2 t = null);
  pure virtual task wait_for_sequences();
  pure virtual function bit has_do_available();
  pure virtual task get(output T1 t);
  pure virtual task peek(output T1 t);
  pure virtual task put(input T2 t);
  pure virtual function void put_response(input T2 t);
  pure virtual function void disable_auto_item_recording();
  pure virtual function bit is_auto_item_recording_enabled();
endclass
