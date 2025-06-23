class ahb_seq extends uvm_sequence #(ahb_xtn);

	// FACTORY REGISTRATION //
	
	`uvm_object_utils(ahb_seq)

	// LOCAL VARIABLE TO STORE NON SEQ TRANSFER //
	
	bit [31:0] haddr;
        bit hwrite;
      	bit [2:0] hsize;
        bit [2:0] hburst;
	bit [9:0] hlength;

	bit [31:0] start_addr, boundary_addr;

	// CONSTRUCTOR //
	
	function new(string n = "ahb_seq");
		super.new(n);
	endfunction

endclass

// SINGLE SEQ //

class single_seq extends ahb_seq;

	// FACTORY AND CONSTRUCTOR //
	
	`uvm_object_utils(single_seq)

	function new(string n = "single_seq");
		super.new(n);
	endfunction

	task body();
	begin
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with { HTRANS == 2'b10; 
						HWRITE == 1'b1;});
		`uvm_info("AHB_SEQ",$sformatf("printing from sequence single_seq \n %s",req.sprint()),UVM_MEDIUM)
		
		finish_item(req);
	end
	endtask

endclass

// INCREMENT SEQ //

class incr_seq extends ahb_seq;

	// FACTORY AND CONSTRUCTOR //
	
	`uvm_object_utils(incr_seq)

	function new(string n = "incr_seq");
		super.new(n);
	endfunction

	task body();
	begin
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with { HTRANS == 2'b10;
	       					HBURST inside {1, 3, 5, 7};	
					/*	HWRITE == 1'b1;*/})
		else `uvm_error("AHB_SEQ", "INCR SEQRandomization failed");
		`uvm_info("AHB_SEQ",$sformatf("printing from incr nonseq(first) transaction sequence \n %s",req.sprint()),UVM_MEDIUM)
		
		finish_item(req);

		haddr = req.HADDR;
		hburst = req.HBURST;
		hsize = req.HSIZE;
		hwrite = req.HWRITE;
		hlength = req.hlength;

		for(int i = 1; i<hlength; i++)
		begin
			start_item(req);
			assert(req.randomize() with { HTRANS == 2'b11;
	       					HBURST == hburst;	
						HWRITE == hwrite;
						HSIZE == hsize;
						HADDR == (haddr+(2**hsize));})
			else `uvm_error("AHB_SEQ", "INC SEQ Randomization failed");
			`uvm_info("AHB_SEQ",$sformatf("printing incr seq from sequence \n %s",req.sprint()),UVM_MEDIUM)
		
			finish_item(req);
			haddr = req.HADDR;
		end

	end
	endtask

endclass

// WRAP SEQ //

class wrap_seq extends ahb_seq;

	// FACTORY AND CONSTRUCTOR //
	
	`uvm_object_utils(wrap_seq)

	function new(string n = "wrap_seq");
		super.new(n);
	endfunction

	task body();
	begin
		req = ahb_xtn::type_id::create("req");
		start_item(req);
		assert(req.randomize() with { HTRANS == 2'b10;
	       					HBURST inside {2, 4, 6};	
					/*	HWRITE == 1'b1;*/})
		else `uvm_error("AHB_SEQ", "WRAP SEQ Randomization failed");
		`uvm_info("AHB_SEQ",$sformatf("printing from wrap nonseq(first) transaction sequence \n %s",req.sprint()),UVM_MEDIUM)
		
		finish_item(req);

		haddr = req.HADDR;
		hburst = req.HBURST;
		hsize = req.HSIZE;
		hwrite = req.HWRITE;
		hlength = req.hlength;

		//start_addr = int'((haddr)/((2**hsize)*(hlength)))*((2**hsize)*hlength);
		start_addr = int'((haddr / ((2**hsize) * hlength))) * ((2**hsize) * hlength);

		boundary_addr = start_addr + ((2**hsize)*hlength);

		haddr = req.HADDR+(2**hsize);


		for(int i = 1; i<hlength; i++)
		begin
			if(boundary_addr == haddr)
			begin
				haddr = start_addr;
			end

			start_item(req);
			assert(req.randomize() with { HTRANS == 2'b11;
	       					HBURST == hburst;	
						HWRITE == hwrite;
						HSIZE == hsize;
						HADDR == haddr;})
			else `uvm_error("AHB_SEQ", "WRAP SEQ Randomization failed");
			`uvm_info("AHB_SEQ",$sformatf("printing wrap seq from sequence \n %s",req.sprint()),UVM_MEDIUM)
		
			finish_item(req);
			haddr = req.HADDR+(2**hsize);
		end

	end
	endtask
endclass

