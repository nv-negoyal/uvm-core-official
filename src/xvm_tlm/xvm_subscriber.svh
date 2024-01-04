//
//------------------------------------------------------------------------------
// Copyright 2007-2018 Cadence Design Systems, Inc.
// Copyright 2007-2011 Mentor Graphics Corporation
// Copyright 2015-2024 NVIDIA Corporation
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
// CLASS -- xvm_subscriber
//
// This class provides an analysis export for receiving transactions from a
// connected analysis export. Making such a connection "subscribes" this
// component to any transactions emitted by the connected analysis port.
//
// Subtypes of this class must define the write method to process the incoming
// transactions. This class is particularly useful when designing a coverage
// collector that attaches to a monitor. 
//------------------------------------------------------------------------------

virtual class xvm_subscriber #(type T=int) extends uvm_component;

  typedef xvm_subscriber #(T) this_type;

  // Port -- analysis_export
  //
  // This export provides access to the write method, which derived subscribers
  // must implement.

  xvm_analysis_imp #(T, this_type) analysis_export;
  
  function new (string name, uvm_component parent);
    super.new(name, parent);
    analysis_export = new("analysis_imp", this);
  endfunction
  
  pure virtual function void write(T t);
    
endclass
