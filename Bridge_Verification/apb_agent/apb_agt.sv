class apb_agt extends uvm_agent;

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(apb_agt)

	// AGT_CFG, DRV, MON, SEQR DECLARATIONS //
	
	apb_mon mon_h;
	apb_drv drv_h;
	apb_seqr seqr_h;

	apb_agt_cfg cfg;

	// CONSTRUCTOR //
	
	function new(string n = "apb_agt", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(apb_agt_cfg)::get(this, "", "apb_agt_cfg", cfg))
			`uvm_fatal("APB_AGT", "Can't get apb_agt_cfg in APB_AGT")

		uvm_config_db #(apb_agt_cfg)::set(this, "drv_h", "apb_agt_cfg", cfg);
		uvm_config_db #(apb_agt_cfg)::set(this, "mon_h", "apb_agt_cfg", cfg);
		uvm_config_db #(apb_agt_cfg)::set(this, "seqr_h", "apb_agt_cfg", cfg);
		

		mon_h = apb_mon::type_id::create("mon_h", this);

		if(cfg.is_active == UVM_ACTIVE)
		begin
			drv_h = apb_drv::type_id::create("drv_h", this);
			seqr_h = apb_seqr::type_id::create("seqr_h", this);
		end

	endfunction

	// CONNECT PHASE //
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(cfg.is_active == UVM_ACTIVE)
		begin
		//	drv_h.seq_item_port.connect(seqr_h.seq_item_export);
		end
	endfunction 

endclass
	

