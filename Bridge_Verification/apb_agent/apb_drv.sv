class apb_drv extends uvm_driver #(apb_xtn);

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(apb_drv)

	// V_INTERFACE, XTN, AGT_CFG DECLARATION //
	
	virtual bridge_if.APB_DRV_MP vif;

	apb_xtn xtn;

	apb_agt_cfg cfg;

	// CONSTRUCTOR //
	
	function new(string n = "apb_drv", uvm_component p);
		super.new(n, p);
	endfunction

	// BUILD PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(apb_agt_cfg)::get(this, "", "apb_agt_cfg", cfg))
			`uvm_fatal("APB_DRV", "Can't get apb_agt_cfg in APB DRV")

	endfunction

	// CONNECT PHASE //
	
	function void connect_phase(uvm_phase phase);
		super.connect_phase(phase);

		vif = cfg.vif;

	endfunction

	// RUN PHASE //
	
	task run_phase(uvm_phase phase);

		forever
		begin
		send_to_dut();
		end
	endtask

	// SEND_TO_DUT //
	
	task send_to_dut();
	begin
		wait(vif.apb_drv_cb.PSELx)
			if(vif.apb_drv_cb.PWRITE == 0)
			vif.apb_drv_cb.PRDATA <= $random;
		repeat(2)
		@(vif.apb_drv_cb);
		`uvm_info("APB_DRV", $sformatf("Printing XTN from APB_DRV /n %s", xtn.sprint()), UVM_MEDIUM)
	end
	endtask	

	
endclass

