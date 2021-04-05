#!/bin/bash


getarch() {
  avx=$(cat /proc/cpuinfo | egrep avx)
  avx2=$(cat /proc/cpuinfo | egrep avx2)
  avx512=$(cat /proc/cpuinfo | egrep avx512)

  if [[ ! -z "$avx512" ]]; then
    arch=avx512
    march=skylake
  elif [[ ! -z "$avx2" ]]; then
    arch=avx2
    march=haswell
  else
    arch=avx
    march=ivybridge
  fi

  export arch
  export march
  export MODULEPATH=/share/Apps/lusoft/share/spack/lmod/default/linux-centos8-x86_64/Core
  export MODULEPATH=/share/Apps/lusoft/share/spack/lmod/${arch}/linux-centos8-x86_64/Core:${MODULEPATH}
  echo "System Architecture:" ${arch}
  echo "Processor Family:" ${march}
}

#arch=$1
version=$(cat /etc/os-release | egrep -i version_id | awk -F= '{print $NF}' | sed -e 's/"//g')
hostname=$(/usr/bin/hostname)
#
if [[ $version -eq 7 ]]; then
#  echo "CentOS7:" $version
  #source /share/Apps/compilers/opt/spack/linux-centos7-x86_64/gcc-4.8.5/lmod/8.3-x6urxhe/lmod/lmod/init/bash
  source /share/Apps/compilers/opt/spack/linux-centos7-x86_64/gcc-4.8.5/lmod/8.4.7-hv52cm3/lmod/lmod/init/bash
  unset MODULEPATH
#  export MODULEPATH=/share/Apps/share/Modules/modulefiles/applications
#  export MODULEPATH=${MODULEPATH}:/share/Apps/share/Modules/modulefiles/library
#  export MODULEPATH=${MODULEPATH}:/share/Apps/share/Modules/modulefiles/toolchain
#  export MODULEPATH=${MODULEPATH}:/share/Apps/share/Modules/modulefiles/admin
else
#  echo "CentOS8:" $version
  source /share/Apps/compilers/opt/spack/linux-centos8-x86_64/gcc-8.3.1/lmod/8.4.7-qlx5gqy/lmod/lmod/init/bash
  #source /share/Apps/compilers/opt/spack/linux-centos8-x86_64/gcc-8.3.1/lmod/8.4.13-azbergb/lmod/lmod/init/bash
fi
  getarch
  export LMOD_PACKAGE_PATH=/share/Apps/compilers/etc/lmod
  if [ -z "$__Init_Default_Modules" ]; then
     export __Init_Default_Modules=1;
     ## abilty to predefine elsewhere the default list
     if [[ $hostname =~ "sol" ]]; then
       ## check if gpus exist
       if [[ ! -z "${CUDA_VISIBLE_DEVICES// }" ]]; then
         LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"solgpu"}
       else
         LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"sol"}
       fi
     elif [[ $hostname =~ "hawk" ]]; then
       if [[ ! -z "${CUDA_VISIBLE_DEVICES// }" ]]; then
         LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"hawkgpu"}
       else
         LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"hawk"}
       fi
     else
       if [[ ! -z "${CUDA_VISIBLE_DEVICES// }" ]]; then
         LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"solgpu"}
       else
         LMOD_SYSTEM_DEFAULT_MODULES=${LMOD_SYSTEM_DEFAULT_MODULES:-"sol"}
       fi
     fi
     export LMOD_SYSTEM_DEFAULT_MODULES
     module --initial_load --no_redirect restore
  else
     module refresh
  fi
#fi


