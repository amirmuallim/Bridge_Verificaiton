class env_cfg extends uvm_object;

	// FACTORY REGISTRATION //
	
	`uvm_object_utils(env_cfg)

	bit has_ahb_agt = 1;
	bit has_apb_agt = 1;

	int no_of_ahb_agt = 1;
	int no_of_apb_agt = 1;

	bit has_sb = 1;

	ahb_agt_cfg ahb_cfg[];
	apb_agt_cfg apb_cfg[];

	// CONSTRUCTOR //
	
	function new(string n = "env_cfg");
		super.new(n);
	endfunction

endclass


