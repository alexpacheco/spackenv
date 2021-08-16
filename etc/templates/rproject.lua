{% extends "modules/modulefile.lua" %}
{% block footer %}
-- Add local and cephfs scratch for all installed packages
local cephscratch=pathJoin("/share/ceph/scratch/",os.getenv('USER'),"/",os.getenv('SLURM_JOB_ID')) or pathJoin(os.getenv('HOME'),"/JOB_TMPDIR")
local tmpscratch=pathJoin("/scratch/",os.getenv('USER'),"/",os.getenv('SLURM_JOB_ID')) or pathJoin(os.getenv('HOME'),"/JOB_TMPDIR")
local rlibsuser=pathJoin(os.getenv('HOME'),"R/x86_64-pc-linux-gnu-library/4.0")

-- Loading this module unlocks the path below unconditionally
if os.getenv("march") == "ivybridge" then
  append_path("R_LIBS_SITE","/share/Apps/r_spack/4.0.3/avx/rlib/R/library")  
--  append_path("MODULEPATH","/share/Apps/share/Modules/lmod/linux-centos8-x86_64/py_venv/pythonapps/avx")
elseif os.getenv("march") == "haswell" then
  append_path("R_LIBS_SITE","/share/Apps/r_spack/4.0.3/avx2/rlib/R/library")  
elseif os.getenv("march") == "skylake" then 
  append_path("R_LIBS_SITE","/share/Apps/r_spack/4.0.3/avx512/rlib/R/library")  
else
  append_path("R_LIBS_SITE","/share/Apps/r_spack/4.0.3/avx/rlib/R/library")  
end

--- Setup R_LIBS_USER for user installed packages
setenv("R_LIBS_USER",rlibsuser)

--- Setup CEPH SCRATCH and LOCAL SCRATCH
setenv("LOCAL_SCRATCH",tmpscratch)
setenv("CEPHFS_SCRATCH",cephscratch)
if os.getenv('SLURM_JOB_ID') == nil then
  setenv("TMPDIR",pathJoin(os.getenv('HOME'),"/JOB_TMPDIR"))
else
  setenv("TMPDIR",cephscratch)
end
{% endblock %}

