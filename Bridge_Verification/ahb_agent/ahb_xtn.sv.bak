class ahb_xtn extends uvm_sequence_item;
	
	// FACTORY REGISTRATION AND CONSTRUCTOR //
	
	`uvm_object_utils(ahb_xtn)
	
	function new(string n = "ahb_xtn");
		super.new(n);
	endfunction

	// SIGNALS //
	
	bit HRESETn;
	rand bit [31:0] HADDR;
	rand bit [1:0] HTRANS;
	rand bit HWRITE;
	rand bit [2:0] HSIZE;
	rand bit [2:0] HBURST;
	rand bit [31:0] HWDATA;
	bit [31:0] HRDATA;
	bit HREADYin, HREADYout;
	bit [2:0] HRESP;
	
	// CONSTRAINTS //
	
	rand bit [9:0] hlength;

	constraint valid_hsize { HSIZE inside {[0:2]};} // slave data width is 32 bits or 4 bytes

	constraint valid_haddr { HADDR inside {[32'h8000_0000:32'h8000_03ff],
					       [32'h8400_0000:32'h8400_03ff],
					       [32'h8800_0000:32'h8800_03ff],
					       [32'h8c00_0000:32'h8c00_03ff]};} // According to specification 

	constraint valid_incr { (HSIZE == 1) -> HADDR%2 == 0;
				(HSIZE == 2) -> HADDR%4 == 0;}

	constraint valid_burst { (HBURST == 0 ) -> hlength == 1;
				(HBURST == 2) -> hlength == 4;
				(HBURST == 3) -> hlength == 4;
				(HBURST == 4) -> hlength == 8;
				(HBURST == 5) -> hlength == 8;
				(HBURST == 6) -> hlength == 16;
				(HBURST == 7) -> hlength == 16;} // sets the hlength

	constraint valid_length { HADDR%1024 + (hlength*(2**HSIZE)) <= 1023;} // Ensures the no.of trans doesn't exceed the boundary address.

	// DO PRINT METHOD //
	
	function void do_print(uvm_printer printer);
		super.do_print(printer);
	
		printer.print_field("HRESETn", this.HRESETn, 1, UVM_BIN);
		printer.print_field("HADDR", this.HADDR, 32, UVM_HEX);
		printer.print_field("HTRANS", this.HTRANS, 2, UVM_BIN);
		printer.print_field("HWRITE", this.HWRITE, 1, UVM_BIN);
		printer.print_field("HSIZE", this.HSIZE, 3, UVM_DEC);
		printer.print_field("HBURST", this.HBURST, 3, UVM_DEC);
		printer.print_field("HWDATA", this.HWDATA, 32, UVM_HEX);
		printer.print_field("HRDATA", this.HRDATA, 32, UVM_HEX);
		printer.print_field("HREADYin", this.HREADYin, 1, UVM_BIN);
		printer.print_field("HREADYout", this.HREADYout, 1, UVM_BIN);
		printer.print_field("HRESP", this.HRESP, 3, UVM_BIN);
		printer.print_field("hlength", this.hlength, 10, UVM_DEC);
	endfunction
	
endclass 


