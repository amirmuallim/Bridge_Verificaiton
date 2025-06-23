class apb_mon extends uvm_monitor;

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(apb_mon)

	// AGT CFG, V_INTERFACE, ANALYSSIS PORT DECLARATAION //
	
	apb_agt_cfg cfg;

	virtual bridge_if.APB_MON_MP vif;

	uvm_analysis_port #(apb_xtn) mp;


	// CONSTRUCTOR //
	
	function new(string n = "apb_mon", uvm_component p);
		super.new(n, p);
		mp = new("mp", this);

	endfunction

	// BUILD PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(apb_agt_cfg)::get(this, "", "apb_agt_cfg", cfg))
			`uvm_fatal("APB_MON", "Can't get apg_agt_cfg in APB_MON")

	endfunction

	// CONNECT PHASE //
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		vif = cfg.vif;

	endfunction

	// RUN PHASE //
	
	task run_phase(uvm_phase phase);
	begin
		forever
		begin
			collect_data();
		end
	end
	endtask

	// COLLECT DATA //
	
	task collect_data();
	begin
		apb_xtn xtn;
		xtn = apb_xtn::type_id::create("xtn");

		wait(vif.apb_mon_cb.PENABLE == 1)
		xtn.PADDR = vif.apb_mon_cb.PADDR;
		xtn.PSELx = vif.apb_mon_cb.PSELx;
		xtn.PWRITE = vif.apb_mon_cb.PWRITE;
		if(xtn.PWRITE == 1)
			xtn.PWDATA = vif.apb_mon_cb.PWDATA;
		else
			xtn.PRDATA = vif.apb_mon_cb.PRDATA;
			
		repeat(2);
		@(vif.apb_mon_cb);

		`uvm_info("APB_MON",$sformatf("PRINTING XTN FROM APB MON \n %s", xtn.sprint()),UVM_MEDIUM)

		mp.write(xtn);

endclass

