# OneModel Dycops

[![License](https://img.shields.io/badge/License-Apache_2.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

In this repository you will find the examples of the following publication:

- Santos-Navarro, F. N., Navarro, J. L., Boada, Y., Vignoni, A., & Picó, J. (2022). "OneModel: an open-source SBML modeling tool focused on accessibility, simplicity, and modularity." *DYCOPS*.

## Installation

You will need Matlab R2020b, Python v3.8.0 and OneModel v0.0.10, for running the examples in this repository.

You can use pip to install OneModel:

```
pip install onemodel==0.1.0
```

*The examples might not work, if a different version of Python or OneModel is used.*

## Information of the folder and files

**Folders:**

- `01_antithetic_controller/` 
 
contains the OneModel files for implmenting the antithetic controller.

- `02_host_aware_antithetic_controller/` 

contains the OneModel files for implmenting the host aware antithetic controller.

- `02_host_aware_antithetic_controller/host_aware_model/` 
 
contains the host aware model for *E. coli*.

- `build/` 
 
the generated SBML and Matlab files are saved here

- `data/` 

some experimental values we need to run the Matlab simulations

- `utils/` 
 
some custom code we need to run the Matlab simulations

**Files:**

- `build_examples.sh` 

is a shell script that calls OneModel to generate Matlab code from the examples.

- `example_01.m` 

Matlab script that runs the simulation of the antithetic controller

- `example_02.m` 
 
Matlab script that runs the simulation of the host aware antithetic controller

- `initialize.m` 

you need to execute this script in Matlab before executing other Matlab scripts

- `LICENSE` 

license file

- `README.md` 

is the text file you are reading right now :-)

- `simulateMassDistribution.m` 

Matlab script that run multiple simulations of the host aware model to check it is well implemented

## Citing

If you use OneModel or SBML2dae in your research, please use the following citations in your published works:

- Santos-Navarro, F. N., Navarro, J. L., Boada, Y., Vignoni, A., & Picó, J. (2022). "OneModel: an open-source SBML modeling tool focused on accessibility, simplicity, and modularity." *DYCOPS*.

## License

Copyright 2022 Fernando N. Santos-Navarro, Jose Luis Herrero, Yadira Boada, Alejandro Vignoni, and Jesús Picó

Licensed under the Apache License, Version 2.0 (the "License"); you may not use this software except in compliance with the License. You may obtain a copy of the License at http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software distributed under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied. See the License for the specific language governing permissions and limitations under the License.
