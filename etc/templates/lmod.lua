-- -*- lua -*-
-- Module file created by 
-- Module file created by {{Your Name}} on {{Creation Date}}
--
--
-- {{spec.name}}@{{spec.version}}%{{compiler.name}}@{{compiler.version}} arch={x86_64/ivybridge/haswell/skylake_avx512/multiarch/binary}
--

local version = "{{spec.version}}"
local toolchain = "{{compiler.name}}-{{compiler.version}}-{{mpi.name}}-{{mpi.version}}"

whatis([[Name : ]])
whatis([[Version : ]])
whatis([[Target : ]])
whatis([[Short description : .]])

help([[
.]])

-- Load dependent modules
--if not isloaded("{{name}}/{{version}}") then 
--    load("{{name}}/{{version}}")
--end

local base = pathJoin("/share/Apps/", myModuleName(), version, toolchain)
local cephscratch=pathJoin("/share/ceph/scratch/",os.getenv('USER'),"/",os.getenv('SLURM_JOB_ID')) or "/tmp"
local tmpscratch=pathJoin("/scratch/",os.getenv('USER'),"/",os.getenv('SLURM_JOB_ID')) or "/tmp"

prepend_path("PATH",pathJoin(base,"bin"))
prepend_path("LD_LIBRARY_PATH",pathJoin(base,"lib"))
prepend_path("LD_LIBRARY_PATH",pathJoin(base,"lib64"))
prepend_path("LD_INCLUDE_PATH",pathJoin(base,"include"))
prepend_path("MANPATH",pathJoin(base,"share/man"))

--- Setup CEPH SCRATCH and LOCAL SCRATCH
-- setenv("SCRATCH",tmpscratch)
setenv("SCRATCH",cephscratch)

--- For Conda Environments
execute{cmd="conda activate {{env.name}}",modeA={"load"}}
execute{cmd="conda deactivate",modeA={"unload"}}

-- For License Information
local err_message="To use this module you must be in a particular group\n" ..
                  "Please open a Jira ticket at https://lts.lehigh.edu/help\n"

local found = userInGroups("HPCSOFT", "HPCSUDO")

if (not found ) then
   LmodError(err_message)
end


