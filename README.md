# SPACK Environments

This repo contains the environment definitions to deploy site-software on Lehigh University's Research Computing resources via SPACK environments.

## Software deployment for CentOS 8.x

Software is deployed using two Spack installations. 

1. For compilers and module environments
2. Site software for general use

### Compilers

This spack installation provides the gcc, nvhpc and cuda compilers, and lmod software for module management. In the future, this installation will also provide intel-oneapi compilers. For legacy reasons, intel@19.0.3 and intel@20.0.3 were installed in /share/Apps/intel with older intel compilers. This installation should not be used for deploying site software nor should the software provided be made available using the module environment.

To reproduce installation
```
git clone https://github.com/alexpacheco/spackenv.git
cd spackenv/compilers/envs/compilers
spack env activate -d .
spack concretize -f # optional
spack install
```

The directory `etc/lmod` contains the lmod configuration to switch between avx, avx2 and avx512 enabled `MODULEPATHS`




## CentOS 7.x software

This just collects the various environments for building software before the CentOS 8.x upgrade. 




 
