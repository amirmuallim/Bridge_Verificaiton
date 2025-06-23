class env extends uvm_env;

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(env)

	// AGT TOP, SB, E_CFG DECLARATIONS //
	
	ahb_agt_top ahb_top;
	apb_agt_top apb_top;

	sb sb_h;

	env_cfg cfg;

	// CONSTRUCTOR //
	
	function new(string n = "env", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD_PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(env_cfg)::get(this, "", "env_cfg", cfg))
			`uvm_fatal("ENV", "Can't get ENV CFG IN ENV")

		if(cfg.has_ahb_agt)
		begin
			ahb_top = ahb_agt_top::type_id::create("ahb_top", this);
		end

		if(cfg.has_apb_agt)
		begin
			apb_top = apb_agt_top::type_id::create("apb_top", this);
		end

		if(cfg.has_sb)
		begin
			sb_h = sb::type_id::create("sb_h", this);
		end

	endfunction

	// CONNECT PHASE //
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		if(cfg.has_sb)
		begin
			if(cfg.has_ahb_agt)
			begin
				foreach(cfg.ahb_cfg[i])
				begin
					ahb_top.agt[i].mon_h.mp.connect(sb_h.fifo_ahb[i].analysis_export);
				end
			end
			
			if(cfg.has_apb_agt)
			begin
				foreach(cfg.apb_cfg[i])
				begin
					apb_top.agt[i].mon_h.mp.connect(sb_h.fifo_apb[i].analysis_export);
				end
			end
		end
	endfunction

endclass




