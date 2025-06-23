class apb_agt_cfg extends uvm_object;

	// FACTORY REGISTRATION //
	
	`uvm_object_utils(apb_agt_cfg)

	// V_INTERFACE, ENUM DECLARATION //
	
	virtual bridge_if vif;

	uvm_active_passive_enum is_active = UVM_ACTIVE;
	
	// STATIC VARIABLES //
	

	// CONSTRUCTOR //
	
	function new(string n = "apb_agt_cfg");
		super.new(n);
	endfunction

endclass

