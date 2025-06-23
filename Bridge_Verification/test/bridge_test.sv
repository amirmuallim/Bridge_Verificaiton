class bridge_test extends uvm_test;

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(bridge_test)
	
	// ENV, ENV_CFG, AGT_CFG'S HANDLES //
	
	env_cfg e_cfg;
	env env_h;

	ahb_agt_cfg m_cfg[];
	apb_agt_cfg s_cfg[];

	// PARAMETER FOR ENV CFG //
	
	int no_of_ahb_agt = 1;
	int no_of_apb_agt = 1;
	bit has_sb = 1;
	
	// CONSTRUCTOR //
	
	function new(string n = "bridge_test", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		e_cfg = env_cfg::type_id::create("e_cfg", this);

		if(e_cfg.has_ahb_agt)
		begin
			e_cfg.ahb_cfg= new[no_of_ahb_agt];
		end

		if(e_cfg.has_apb_agt)
		begin
			e_cfg.apb_cfg= new[no_of_apb_agt];
		end

		m_cfg = new[no_of_ahb_agt];
		s_cfg = new[no_of_apb_agt];

		foreach(m_cfg[i])
		begin
			m_cfg[i] = ahb_agt_cfg::type_id::create($sformatf("ahb_cfg[%0d]", i));
			if(!uvm_config_db #(virtual bridge_if)::get(this, "", "vif_ahb", m_cfg[i].vif))
				`uvm_fatal("TEST", "Cant get if for ahb_cfg")

			m_cfg[i].is_active = UVM_ACTIVE;
			
			e_cfg.ahb_cfg[i] = m_cfg[i];
		end

		foreach(s_cfg[i])
		begin
			s_cfg[i] = apb_agt_cfg::type_id::create($sformatf("apb_cfg[%0d]", i));
			if(!uvm_config_db #(virtual bridge_if)::get(this, "", "vif_apb", s_cfg[i].vif))
				`uvm_fatal("TEST", "Cant get if for apb_cfg")

			s_cfg[i].is_active = UVM_ACTIVE;
			
			e_cfg.apb_cfg[i] = s_cfg[i];
		end


		e_cfg.no_of_ahb_agt = no_of_ahb_agt;
		e_cfg.no_of_apb_agt = no_of_apb_agt;
		e_cfg.has_sb = has_sb;
	

		uvm_config_db #(env_cfg)::set(this, "*", "env_cfg", e_cfg);

		env_h = env::type_id::create("env_h", this);
		
	endfunction

	// RUN PHASE //

	task run_phase(uvm_phase phase);
	
		uvm_top.print_topology();
	endtask	

endclass

// SINGLE TRANSFER TEST //

class single_test extends bridge_test;

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(single_test)

	// SEQ HANDLE //
	
	single_seq seq_h;

	// CONSTRUCTOR //
	
	function new(string n = "single_test", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD_PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	// RUN_PHASE //
	
	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
	
		seq_h = single_seq::type_id::create("seq_h");
		seq_h.start(env_h.ahb_top.agt[0].seqr_h);
	
		phase.drop_objection(this);

	endtask

endclass

// INCR TEST //

class incr_test extends bridge_test;

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(incr_test)

	// SEQ HANDLE //
	
	incr_seq seq_h;

	// CONSTRUCTOR //
	
	function new(string n = "incr_test", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD_PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	// RUN_PHASE //
	
	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
	
		seq_h = incr_seq::type_id::create("seq_h");
		seq_h.start(env_h.ahb_top.agt[0].seqr_h);
	
		phase.drop_objection(this);

	endtask

endclass 

// WRAP SEQ //

class wrap_test extends bridge_test;

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(wrap_test)

	// SEQ HANDLE //
	
	wrap_seq seq_h;

	// CONSTRUCTOR //
	
	function new(string n = "wrap_test", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD_PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction

	// RUN_PHASE //
	
	task run_phase(uvm_phase phase);

		phase.raise_objection(this);
	
		seq_h = wrap_seq::type_id::create("seq_h");
		seq_h.start(env_h.ahb_top.agt[0].seqr_h);
	
		phase.drop_objection(this);

	endtask

endclass
