//
//-----------------------------------------------------------------------------
// Copyright 2011 AMD
// Copyright 2012 Accellera Systems Initiative
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2007-2011 Mentor Graphics Corporation
// Copyright 2015-2024 NVIDIA Corporation
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
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
// Title  -- Sequence Item Pull Ports
//
// This section defines the port, export, and imp port classes for
// communicating sequence items between <uvm_sequencer #(REQ,RSP)> and
// <uvm_driver #(REQ,RSP)>.
//-----------------------------------------------------------------------------

//-----------------------------------------------------------------------------
//
// Class --  xvm_seq_item_pull_port #(REQ,RSP)
//
// XVM provides a port, export, and imp connector for use in sequencer-driver
// communication. All have standard port connector constructors, except that
// xvm_seq_item_pull_port's default min_size argument is 0; it can be left
// unconnected.
//
//-----------------------------------------------------------------------------


class xvm_seq_item_pull_port #(type REQ=int, type RSP=REQ)
  extends xvm_port #(xvm_sqr_if #(REQ, RSP)) 
  implements xvm_sqr_if #(REQ, RSP),
             xvm_port_check_if #(xvm_sqr_if #(REQ, RSP));
  `XVM_SEQ_PORT("xvm_seq_item_pull_port")
  `XVM_SEQ_ITEM_PULL_IMP(this.m_if, REQ, RSP, t, t)

  bit print_enabled;
    
endclass

//-----------------------------------------------------------------------------
//
// Class -- xvm_seq_item_pull_export #(REQ,RSP)
//
// This export type is used in sequencer-driver communication. It has the
// standard constructor for exports.
//
//-----------------------------------------------------------------------------


class xvm_seq_item_pull_export #(type REQ=int, type RSP=REQ)
  extends xvm_export #(xvm_sqr_if #(REQ, RSP))
  implements xvm_sqr_if #(REQ, RSP),
             xvm_export_check_if #(xvm_sqr_if #(REQ, RSP));
  `XVM_EXPORT_COMMON("xvm_seq_item_pull_export")
  `XVM_SEQ_ITEM_PULL_IMP(this.m_if, REQ, RSP, t, t)
endclass

//-----------------------------------------------------------------------------
//
// Class -- xvm_seq_item_pull_imp #(REQ,RSP,IMP)
//
// This imp type is used in sequencer-driver communication. It has the
// standard constructor for imp-type ports.
//
//-----------------------------------------------------------------------------

class xvm_seq_item_pull_imp #(type REQ=int, type RSP=REQ, type IMP=int)
  extends xvm_imp #(xvm_sqr_if #(REQ, RSP)) 
  implements xvm_sqr_if #(REQ, RSP),
             xvm_export_check_if #(xvm_sqr_if #(REQ, RSP));
  `XVM_IMP_COMMON("xvm_seq_item_pull_imp",IMP)
  `XVM_SEQ_ITEM_PULL_IMP(m_imp, REQ, RSP, t, t)

endclass
