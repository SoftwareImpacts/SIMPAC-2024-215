
# FEGC 1.0: Flow Energy Gradient Calculator

**Version**: 1.0  
**Authors**: Iman Farahbakhsh 
**Repository**: [FEGC GitHub](https://github.com/imanfarahbakhsh/FEGC1.0)  
**License**: MIT License  

## Overview

**FEGC 1.0** is a Fortran-based toolbox for analyzing fluid flow instabilities by calculating the energy gradient ratio. This tool provides valuable insights into flow stability and is designed to predict the initiation locus for fluid instability and chaos. It primarily applies to two-dimensional fluid fields and can process flow data such as mesh, velocity, and vorticity fields.

Key features include:
- Calculation of the energy gradient ratio, a critical metric in fluid stability analysis.
- Identification of high-potential points for fluid instability and chaos initiation.
- Modular architecture to facilitate ease of use and potential future expansion.

## Software Architecture

FEGC is structured into the following main components:

1. **Module Parameters**: Handles the geometrical and flow parameters of the field, initialized at the start of the main program.
2. **Subroutine File Reading**: Extracts mesh data, velocity, and vorticity fields from input files.
3. **Subroutine Energy Gradient**: Computes the energy gradient ratio, which includes:
   - The gradient of energy exchange across streamlines (numerator).
   - The energy dissipation gradient along streamlines (denominator).
4. **Subroutine Write Solution**: Saves the calculated energy gradient ratio to an output file for further analysis.
5. **Post-Processing Stage** (optional): Identifies and extracts regions of high potential for fluid instability and chaos.

## Usage Instructions

### Requirements

- **Fortran Compiler**: Ensure a working Fortran compiler is installed.
- **Development Environments**: The code can be compiled and run in environments like Code::Blocks or Visual Studio Code.

### Installation

1. Clone the repository:

   ```bash
   git clone https://github.com/imanfarahbakhsh/FEGC1.0.git
   cd FEGC1.0
   ```

2. Compile the code using a Fortran compiler:

   ```bash
   gfortran -o FEGC main_program.f90
   ```

### Running the Code

1. Prepare input files containing mesh, velocity, and vorticity fields of the fluid flow. Ensure the files are in the required format as specified in the code documentation.
2. Execute the compiled program:

   ```bash
   ./FEGC input_file.dat
   ```

3. The output will include the energy gradient ratio, appended to the input file or saved in a designated output file.

### Post-Processing

After computation, a post-processing step can be performed to analyze and identify points with the highest potential for initiating instability or chaos.

## Future Improvements

Future versions of FEGC will aim to include:
- Scalability for larger datasets.
- A graphical user interface (GUI) for easier user interaction.
- Support for three-dimensional fluid fields.
- Integration with other fluid simulation tools.

## References

1. I. Farahbakhsh, H.S. Dou, *Derivation of energy gradient function for Rayleigh–Taylor instability*, [DOI](https://doi.org/10.1088/1873-7005/aac558).
2. I. Farahbakhsh, S.S. Nourazar, et al., *On the instability of plane poiseuille flow of two immiscible fluids*, [DOI](https://doi.org/10.1017/jmech.2014.16).

For questions or support, contact **i.farahbakhsh@aut.ac.ir**.
