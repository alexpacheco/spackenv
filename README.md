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

The directory `etc/lmod` contains the LMOD configuration to switch between avx, avx2 and avx512 enabled `MODULEPATHS`

### LU Software

This spack installation provides the deployed site-software on Sol and Hawk.

To reproduce this installation, you need to first copy the site configuration files from `lusoft/etc/spack` to your spack install tree. This assumes that SLURM and the compiler environment above is already installed. Edit the `packages.yaml` file to point to the location of slurm (/usr/local), rmda-core (/usr), gcc, intel, cuda, and nvhpc. The file `repo.yaml` is hardwired with  location of the lubio repository and should be changed to your location.

On Sol, these files are available at `/share/Apps/lusoft/etc/spack`.


#### Available Environments
##### solhawk

This environment builds the entire software except the various python and r packages for ivybridge, haswell and skylake_avx512 architectures. This environment also builds the tcl environment modules that is not currently used. This should be build first and any new packages should be added to this environment.

```
cd spackenv/cent8/envs/solhawk
spack env activate -d .
spack concretize -f # optional
spack install
```

#### avx/avx2/avx512

These environment builds the software stack except the various python and r packages for ivybridge/haswell/skylake_avx512 architectures. If software in the `solhawk` environment is already built, then these environments are only setting up the installation root for the LMOD module files `/share/Apps/lusoft/share/modules/lmod/{avx,avx2,avx512}`. The only reason these environments exist is due to SPACK's inability to built a architecture based LMOD module tree similar to the TCL module tree. 
*Note*: If you change the path of the installation root, make sure that you change the corresponding path in `compilers/etc/SitePackage.lua`.

```
cd spackenv/cent8/envs/avx2/lusoft
spack env activate -d .
spack concretize -f # optional
spack install
```

#### Python and R packages

Rather than building module files for various python and r packages, a single module is created for a filesystem view of all python and r packages respectively. The path to the r filesystem is setup as `R_LIBS_SITE` so that any application such as `trinity` that requires many R packages only need to load the r module. If new packages added to the above environments require a dependent R package, then that dependency should be added to the rpoject environment and concretized. The python environment uses a `concretization: together` and may not provide the same python package as the above software environments. The filesystem views are hardwired as `/share/Apps/py_spack/3.8.6/{avx,avx2,avx512}` and `/share/Apps/r_spack/4.0.3/{avx,avx2,avx512}`.

```
cd spackenv/cent8/envs/avx/python
spack env activate -d .
spack concretize -f # optional
spack install
```

```
cd spackenv/cent8/envs/avx512/rproject
spack env activate -d .
spack concretize -f # optional
spack install
```
 

## CentOS 7.x software

This just collects the various environments for building software before the CentOS 8.x upgrade. 




 
