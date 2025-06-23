class ahb_sequencer extends uvm_sequencer #(ahb_xtn);

	// FACTORY REGISTRATION AND CONSTRUCTOR //
	
	`uvm_component_utils(ahb_sequencer)

	function new(string n = "ahb_sequencer", uvm_component p);
		super.new(n, p);
	endfunction

endclass

