package bridge_test_pkg;

  import uvm_pkg::*;
  `include "uvm_macros.svh"

  // Configurations
  `include "apb_agt_cfg.sv"
  `include "ahb_agt_cfg.sv"
  `include "env_cfg.sv"

  // Transactions
  `include "apb_xtn.sv"
  `include "ahb_xtn.sv"

  // Driver, Monitor, Sequencer (APB Agent - Slave)
  `include "apb_drv.sv"
  `include "apb_mon.sv"
  `include "apb_seqr.sv"  
  `include "apb_agt.sv"
  `include "apb_agt_top.sv"

  // Driver, Monitor, Sequencer (AHB Agent - Master)
  `include "ahb_drv.sv"
  `include "ahb_mon.sv"
  `include "ahb_sequencer.sv"
  `include "ahb_seq.sv"
  `include "ahb_agt.sv"
  `include "ahb_agt_top.sv"

  // Scoreboard
  `include "sb.sv"

  // Testbench top
  `include "env.sv"

  // Test
  `include "bridge_test.sv"

endpackage


