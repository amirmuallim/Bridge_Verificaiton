`timescale 1ns/1ps

module top;

	// Package imports //
	import uvm_pkg::*;
	import bridge_test_pkg::*;
	`include "uvm_macros.svh"

	// CLOCK GENERATION //
	
	bit clk = 1'b0;
	always #5 clk = ~clk; // 100 MHz 

	// INTERFACE DECLARATION //
	
	bridge_if ahb_if(clk);
	bridge_if apb_if(clk);

	// DUT INSTANTIATION //
	
	rtl_top DUT(.Hclk(clk),
		.Hresetn(ahb_if.HRESETn),
		.Htrans(ahb_if.HTRANS),
		.Hsize(ahb_if.HSIZE),
		.Hreadyin(ahb_if.HREADYin),
		.Hwdata(ahb_if.HWDATA),
		.Haddr(ahb_if.HADDR),
		.Hwrite(ahb_if.HWRITE),
		.Prdata(apb_if.PRDATA),
		.Hrdata(ahb_if.HRDATA),
		.Hresp(ahb_if.HRESP),
		.Hreadyout(ahb_if.HREADYout),
		.Pselx(apb_if.PSELx),
		.Pwrite(apb_if.PWRITE),
		.Penable(apb_if.PENABLE),
		.Paddr(apb_if.PADDR),
		.Pwdata(apb_if.PWDATA)
		);

	initial begin

		// SETTING INTERFACES IN CONFIG DB AS VIRTUAL //

		uvm_config_db #(virtual bridge_if)::set(null, "*", "vif_ahb", ahb_if);
		uvm_config_db #(virtual bridge_if)::set(null, "*", "vif_apb", apb_if);

		// RUN_TEST //

		run_test();

	end

endmodule


