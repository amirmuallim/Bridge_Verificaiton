# Bridge Verification

This repository contains a SystemVerilog/UVM verification environment for an AHB-to-APB bridge design. The project is organized around RTL source files, testbench components, and simulation scripts to compile and run verification tests.

## Overview

The design under test is a bridge between the AHB and APB interfaces. The verification setup includes:

- RTL implementation of the bridge and related interface logic
- AHB and APB agent components
- UVM-based testbench and environment configuration
- Simulation targets for compiling and running verification tests
- Coverage and waveform generation support

## Repository structure

```text
.
├── .gitignore
├── Bridge_Verification/
│   ├── ahb_agent/
│   ├── apb_agent/
│   ├── rtl/
│   │   ├── ahb_apb_top.v
│   │   ├── ahb_slave.v
│   │   ├── apb_controller.v
│   │   ├── apb_interface.v
│   │   ├── bridge_if.sv
│   │   └── definitions.v
│   ├── sim/
│   │   └── Makefile
│   ├── tb/
│   │   ├── env.sv
│   │   ├── env_cfg.sv
│   │   ├── sb.sv
│   │   └── top.sv
│   └── test/
│       ├── bridge_test.sv
│       └── bridge_test_pkg.sv
└── README.md
```

## RTL contents

The `Bridge_Verification/rtl` folder contains the bridge implementation and related interface definitions, including:

- `ahb_apb_top.v` — top-level bridge module
- `ahb_slave.v` — AHB slave logic
- `apb_controller.v` — APB controller logic
- `apb_interface.v` — APB interface definition
- `bridge_if.sv` — interface used by the verification environment
- `definitions.v` — shared definitions and constants

## Verification environment

The verification code is organized in the following directories:

- `ahb_agent/` — AHB agent-related components
- `apb_agent/` — APB agent-related components
- `tb/` — testbench environment, scoreboard, and top module
- `test/` — UVM test classes and test package definitions

The repository uses a UVM-based methodology with tests such as:

- `single_test`
- `incr_test`
- `wrap_test`
- `bridge_test`

## Simulation

The project includes a `Makefile` under `Bridge_Verification/sim` to compile and run the verification environment.

### Quick usage

```bash
cd Bridge_Verification/sim
make help
make sv_cmp
make run_test
```

The default simulator is set to Questa, but the `Makefile` also includes VCS targets and FSDB support.

### Available targets

Examples from the included Makefile include:

- `make clean`
- `make sv_cmp`
- `make run_test`
- `make single_test`
- `make incr_test`
- `make wrap_test`
- `make regress`
- `make report`

## Prerequisites

Before running the tests, make sure one of the following simulators is installed and available in your environment:

- Mentor QuestaSim
- Synopsys VCS

You should also have a working SystemVerilog/UVM toolchain and the required simulator PATH configured.

## Notes

This project is intended for hardware verification and functional validation of an AHB-APB bridge. It is structured for simulation-based testing, waveform analysis, and coverage collection.

## License

No explicit license file is present in the repository. If you plan to share or redistribute this project, it is recommended to add an appropriate open-source license before publication.
