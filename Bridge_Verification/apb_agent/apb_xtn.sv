class apb_xtn extends uvm_sequence_item;

	// FACTORY REGISTRATION //
	
	`uvm_object_utils(apb_xtn)

	// SIGNALS //
	
	bit PENABLE;
	bit PWRITE;	
	bit [31:0] PWDATA;
	rand bit [31:0] PRDATA;
	bit [31:0] PADDR;
	bit [3:0] PSELx;
	
	// CONSTRUCTOR //
	
	function new(string n = "apb_xtn");
		super.new(n);
	endfunction

	// DO_PRINT METHOD //
	function void do_print(uvm_printer printer);
		super.do_print(printer);

		printer.print_field("PENABLE", this.PENABLE, 1, UVM_BIN);
		printer.print_field("PWRITE", this.PWRITE, 1, UVM_BIN);
		printer.print_field("PWDATA", this.PWDATA, 32, UVM_HEX);
		printer.print_field("PRDATA", this.PRDATA, 32, UVM_HEX);
		printer.print_field("PADDR", this.PADDR, 32, UVM_HEX);
		printer.print_field("PSELx", this.PSELx, 4, UVM_HEX);
	endfunction
	

endclass

