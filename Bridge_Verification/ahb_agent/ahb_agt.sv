class ahb_agt extends uvm_agent;
	
	// FACTORY REGISTRAION //
	
	`uvm_component_utils(ahb_agt)

	// MON, DRV, SEQR, CFG HANDLES DECLARATION //
	
	ahb_drv drv_h;
	ahb_mon mon_h;
	ahb_sequencer seqr_h;

	ahb_agt_cfg cfg;

	// CONSTRUCTOR //
	
	function new (string n = "ahb_agt", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(ahb_agt_cfg)::get(this, "", "ahb_agt_cfg", cfg))
			`uvm_fatal("AHB_AGT", "Can't get cfg in AHB_AGT")

		uvm_config_db #(ahb_agt_cfg)::set(this, "drv_h", "ahb_agt_cfg", cfg);
		uvm_config_db #(ahb_agt_cfg)::set(this, "mon_h", "ahb_agt_cfg", cfg);
		uvm_config_db #(ahb_agt_cfg)::set(this, "seqr_h", "ahb_agt_cfg", cfg);
		

		mon_h = ahb_mon::type_id::create("mon_h", this);

		if(cfg.is_active == UVM_ACTIVE)
		begin
			drv_h = ahb_drv::type_id::create("drv_h", this);
			seqr_h = ahb_sequencer::type_id::create("seqr_h", this);
		end

	endfunction

	// CONNECT PHASE //
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(cfg.is_active == UVM_ACTIVE)
		begin
			drv_h.seq_item_port.connect(seqr_h.seq_item_export);
		end
	endfunction

endclass


