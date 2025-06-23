class ahb_drv extends uvm_driver #(ahb_xtn);

	// FACTORY REGISTRAITON AND CONSTRUCTOR //
	
	`uvm_component_utils(ahb_drv)

	function new(string n = "ahb_drv", uvm_component p);
		super.new(n, p);
	endfunction

	// V_INTERFACE, XTN, AGT_CONFIG DECLARATION //
	
	virtual bridge_if.AHB_DRV_MP vif;

	ahb_xtn xtn;

	ahb_agt_cfg cfg;

	// BUILD PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(ahb_agt_cfg)::get(this, "", "ahb_agt_cfg", cfg))
			`uvm_fatal("AHB_DRV", "Can't get agt cfg in ahb drv")
	
	endfunction

	// CONNECT PHASE //
	
	function void connect_phase (uvm_phase phase);
		super.connect_phase(phase);

		vif = cfg.vif;

	endfunction

	// RUN PHASE //
	
	task run_phase(uvm_phase phase);
		
		// RST SEQ //

		@(vif.ahb_drv_cb)
		vif.ahb_drv_cb.HRESETn <= 1'b0;
		@(vif.ahb_drv_cb)
		vif.ahb_drv_cb.HRESETn <= 1'b1;

		// DRV LOGIC //

		forever
		begin
			seq_item_port.get_next_item(req);
			send_to_dut(req);
			seq_item_port.item_done();
		end

	endtask

	task send_to_dut(ahb_xtn xtn);

		`uvm_info("AHB_DRV", $sformatf("Printing XTN from AHB_DRV /n %s", xtn.sprint()), UVM_MEDIUM)

		wait(vif.ahb_drv_cb.HREADYout)
		vif.ahb_drv_cb.HTRANS <= xtn.HTRANS;
		vif.ahb_drv_cb.HWRITE <= xtn.HWRITE;
		vif.ahb_drv_cb.HADDR <= xtn.HADDR;
		vif.ahb_drv_cb.HBURST <= xtn.HBURST;
		vif.ahb_drv_cb.HREADYin <= 1'b1;

		@(vif.ahb_drv_cb);
		wait(vif.ahb_drv_cb.HREADYout) // add == 1 if any error
		if(xtn.HWRITE)
			vif.ahb_drv_cb.HWDATA <= xtn.HWDATA;
		else
			vif.ahb_drv_cb.HWDATA <= 32'b0;

	endtask

endclass



