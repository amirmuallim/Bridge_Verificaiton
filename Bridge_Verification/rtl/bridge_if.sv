`timescale 1ns/1ps

interface bridge_if(input bit clk);

	// AHB SIGNALS //
	
	logic HRESETn;

	logic [31:0] HADDR;
	logic [1:0] HTRANS;
	logic HWRITE;
	logic [2:0] HSIZE;
	logic [2:0] HBURST;
	logic [31:0] HWDATA;
	logic [31:0] HRDATA;
	logic HREADYin, HREADYout;
	logic [1:0] HRESP;

	// APB SIGNALS //	
	
	logic [31:0] PRDATA;
	logic PWRITE;
	logic PENABLE;
	logic [31:0] PADDR;
	logic [31:0] PWDATA;	
	logic [3:0] PSELx;

	// CLOCKING BLOCKS FOR AHB //
	
	clocking ahb_drv_cb@(posedge clk);
		default input #1 output #1;
		
		output HRESETn;
		output HADDR;
		output HTRANS;
		output HWRITE;
		output HSIZE;
		output HBURST;
		output HWDATA;
		input HRDATA;
		output HREADYin;
		input HREADYout;
		input HRESP;
	
	endclocking

	clocking ahb_mon_cb @(posedge clk);
		default input #1 output #1;

		input HRESETn;
		input HADDR;
		input HWRITE;
		input HSIZE;
		input HTRANS;
		input HBURST;
		input HWDATA;
		input HRDATA;
		input HREADYin;
		input HREADYout;
		input HRESP; 

	endclocking

	// CLOCKING BLOCKS FOR APB //
	
	clocking apb_drv_cb @(posedge clk);
		default input #1 output #1; 
		
		output PRDATA;
		input PWRITE;
		input PENABLE;
		input PSELx;
	
	endclocking

	clocking apb_mon_cb @(posedge clk);
		default input #1 output #1;

		input PRDATA;
		input PWRITE;
		input PENABLE;
		input PADDR;
		input PWDATA;	
		input PSELx;

	endclocking


	// MODPORT DECLARATIONS //
		
	modport AHB_DRV_MP (clocking ahb_drv_cb);
	modport AHB_MON_MP (clocking ahb_mon_cb);
	modport APB_DRV_MP (clocking apb_drv_cb);
	modport APB_MON_MP (clocking apb_mon_cb);


endinterface		

