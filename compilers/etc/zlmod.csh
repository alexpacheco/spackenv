#!/bin/tcsh


#arch=$1
set version = `cat /etc/os-release | egrep -i version_id | awk -F= '{print $NF}' | sed -e 's/"//g'`
set hostname = `/usr/bin/hostname`
#
if ( $version == 7 ) then
#  echo "CentOS7:" $version
  source /share/Apps/compilers/opt/spack/linux-centos7-x86_64/gcc-4.8.5/lmod/8.4.7-hv52cm3/lmod/lmod/init/csh
  unset MODULEPATH
  setenv MODULEPATH /share/Apps/share/Modules/modulefiles/applications
  setenv MODULEPATH ${MODULEPATH}:/share/Apps/share/Modules/modulefiles/library
  setenv MODULEPATH ${MODULEPATH}:/share/Apps/share/Modules/modulefiles/toolchain
  setenv MODULEPATH ${MODULEPATH}:/share/Apps/share/Modules/modulefiles/admin
else
#  echo "CentOS8:" $version
  source /share/Apps/compilers/opt/spack/linux-centos8-x86_64/gcc-8.3.1/lmod/8.4.7-qlx5gqy/lmod/lmod/init/csh
  #source /share/Apps/compilers/opt/spack/linux-centos8-x86_64/gcc-8.3.1/lmod/8.4.13-azbergb/lmod/lmod/init/csh
#  getarch
  setenv avx  `cat /proc/cpuinfo | egrep flags | tail -1 | awk '{for (i=1;i<=NF;i++){print i,$i}}' | egrep avx`
  setenv avx2 `cat /proc/cpuinfo | egrep flags | tail -1 | awk '{for (i=1;i<=NF;i++){print i,$i}}' | egrep avx2`
  setenv avx512 `cat /proc/cpuinfo | egrep flags | tail -1 | awk '{for (i=1;i<=NF;i++){print i,$i}}' | egrep avx512`

  if ( $%avx512 > 0 ) then
    setenv arch avx512
    setenv march skylake
  else if ( $%avx2 > 0 ) then
    setenv arch avx2
    setenv march haswell
  else
    setenv arch avx
    setenv march ivybridge
  endif

  setenv MODULEPATH /share/Apps/lusoft/share/spack/lmod/default/linux-centos8-x86_64/Core
  setenv MODULEPATH /share/Apps/lusoft/share/spack/lmod/${arch}/linux-centos8-x86_64/Core:${MODULEPATH}
  echo "System Architecture:" ${arch}
  echo "Processor Family:" ${march}
  setenv LMOD_PACKAGE_PATH /share/Apps/compilers/etc/lmod
  if ( ! $?__Init_Default_Modules )  then
     setenv __Init_Default_Modules 1;
     ## abilty to predefine elsewhere the default list
     if ( $hostname =~ "sol" ) then
       ## check if gpus exist
       if ( $?CUDA_VISIBLE_DEVICES ) then
         if ( ! $?LMOD_SYSTEM_DEFAULT_MODULES ) then
           setenv LMOD_SYSTEM_DEFAULT_MODULES "solgpu"
         endif
       else
         if ( ! $?LMOD_SYSTEM_DEFAULT_MODULES ) then
           setenv LMOD_SYSTEM_DEFAULT_MODULES "sol"
         endif
       endif
     else if ( $hostname =~ "hawk" ) then
       if ( $?CUDA_VISIBLE_DEVICES ) then
         if ( ! $?LMOD_SYSTEM_DEFAULT_MODULES ) then
           setenv LMOD_SYSTEM_DEFAULT_MODULES "hawkgpu"
         endif
       else
         if ( ! $?LMOD_SYSTEM_DEFAULT_MODULES ) then
           setenv LMOD_SYSTEM_DEFAULT_MODULES "hawk"
         endif
       endif
     else
       if ( $?CUDA_VISIBLE_DEVICES ) then
         if ( ! $?LMOD_SYSTEM_DEFAULT_MODULES ) then
           setenv LMOD_SYSTEM_DEFAULT_MODULES "solgpu"
         endif
       else
         if ( ! $?LMOD_SYSTEM_DEFAULT_MODULES ) then
           setenv LMOD_SYSTEM_DEFAULT_MODULES "sol"
         endif
       endif
     endif
     #export LMOD_SYSTEM_DEFAULT_MODULES
     module --initial_load --no_redirect restore
  else
     module refresh
  endif
endif



