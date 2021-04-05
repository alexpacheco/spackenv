{% extends "modules/modulefile.lua" %}
{% block footer %}
family("python")
-- https://github.com/CHPC-UofU/Lmod-setup/blob/master/2019.03.lua
--
local base = "{{spec.prefix}}"

-- starting with conda 4.6 (June 2019), more needs to be sourced so that virtual environments work
-- we source the conda.[sh,csh] at module load, and unset all the stuff that this sets manually at unload
-- this happens at load
execute{cmd="source " .. base .. "/etc/profile.d/conda."..myShellType(),modeA={"load"}}
execute{cmd="conda config --set env_prompt '({name})'",modeA={"load"}}

-- this happens at unload
-- could also do "conda deactivate; " but that should be part of independent VE module
if (myShellType() == "csh") then
  -- csh sets these environment variables and an alias for conda
  cmd = "unsetenv CONDA_EXE; unsetenv _CONDA_ROOT; unsetenv _CONDA_EXE; " ..
        "unsetenv CONDA_SHLVL; unalias conda"
  execute{cmd=cmd, modeA={"unload"}}
end
if (myShellType() == "sh") then
  -- bash sets environment variables, shell functions and path to condabin
  if (mode() == "unload") then
    remove_path("PATH", pathJoin(base,"condabin"))
  end
  cmd = "unset CONDA_EXE; unset _CE_CONDA; unset _CE_M; " ..
        "unset -f __conda_activate; unset -f __conda_reactivate; " .. 
        "unset -f __conda_hashr; unset CONDA_SHLVL; unset _CONDA_EXE; " .. 
        "unset _CONDA_ROOT; unset -f conda"
  execute{cmd=cmd, modeA={"unload"}}
end
-- Add modulepath for locally installed packages
append_path("MODULEPATH","/share/Apps/share/Modules/lmod/linux-centos8-x86_64/py_venv/{{spec.version}}")
{% endblock %}

