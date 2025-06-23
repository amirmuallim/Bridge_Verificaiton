class ahb_agt_top extends uvm_env;

	// FACTORY REGISTRATION //
	 
	`uvm_component_utils(ahb_agt_top)

	// ENV CFG, AGT[] DECLARATAION //
	
	env_cfg cfg;

	ahb_agt agt[];

	// CONSTRUCTOR //
	
	function new(string n = "ahb_agt_top", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(env_cfg)::get(this, "", "env_cfg", cfg))
			`uvm_fatal("AHB_AGT_TOP", "Can't get ENV CFG IN ahb_agt_toPp")

		agt = new[cfg.no_of_ahb_agt];

		foreach(agt[i])
		begin
			agt[i] = ahb_agt::type_id::create($sformatf("agt[%0d]", i),this);

			uvm_config_db #(ahb_agt_cfg)::set(this,$sformatf("agt[%0d]", i), "ahb_agt_cfg", cfg.ahb_cfg[i]);

		end
	endfunction

endclass	

