class ahb_mon extends uvm_monitor;

	// FACTORY REGISTRATION //
	
	`uvm_component_utils(ahb_mon)

	// V_INTERFACE, XTN, CFG, ANALYSIS PORT DECLARATION //
	
	virtual bridge_if.AHB_MON_MP vif;

	ahb_agt_cfg cfg;

	uvm_analysis_port #(ahb_xtn) mp;

	// CONSTRUCTOR // 
	
	function new(string n = "ahb_mon", uvm_component p);
		super.new(n, p);
		mp = new("mp", this);

	endfunction

	// BUILD PHASE //
	
	function void build_phase(uvm_phase phase);
		super.build_phase(phase);

		if(!uvm_config_db #(ahb_agt_cfg)::get(this, "", "ahb_agt_cfg", cfg))
			`uvm_fatal("AHB_MON", "Can't get config in ahb_mon")

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
			collect_data();
		end
	endtask

	// COLLECT DATA //

	task collect_data();
		ahb_xtn xtn;
		xtn = ahb_xtn::type_id::create("xtn");
		
		// ahb_mon_cb ahb_mon_cb
		wait(vif.ahb_mon_cb.HREADYout == 1 &&(vif.ahb_mon_cb.HTRANS == 2 || vif.ahb_mon_cb.HTRANS == 3 ))//|| vif.ahb_mon_cb.HTRANS == 0)) // ; ADD IF ERROR
			begin
				xtn.HADDR = vif.ahb_mon_cb.HADDR;
				xtn.HTRANS = vif.ahb_mon_cb.HTRANS;
				xtn.HBURST = vif.ahb_mon_cb.HBURST;
				xtn.HSIZE = vif.ahb_mon_cb.HSIZE;
				xtn.HWRITE = vif.ahb_mon_cb.HWRITE;
				xtn.HREADYin = vif.ahb_mon_cb.HREADYin;

				@(vif.ahb_mon_cb);

				wait(vif.ahb_mon_cb.HREADYout == 1)
				if(xtn.HWRITE)
					xtn.HWDATA = vif.ahb_mon_cb.HWDATA;
				else
					xtn.HRDATA = vif.ahb_mon_cb.HRDATA;

				`uvm_info("AHB_MON",$sformatf("PRINTING XTN FROM AHB MON \n %s", xtn.sprint()),UVM_MEDIUM)

				mp.write(xtn);
			end
	endtask
endclass


