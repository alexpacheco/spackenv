{% extends "modules/modulefile.lua" %}
{% block footer %}
-- Add variables specific to openmolcas
local scratch=pathJoin("/share/ceph/scratch/",os.getenv('USER'),"/",os.getenv('SLURM_JOB_ID'))
local nprocs=os.getenv('SLURM_NTASKS') or "1"
setenv("MOLCAS_WORKDIR",scratch)
setenv("MOLCAS_NPROCS",nprocs)
-- setenv("MOLCAS_NPROCS",os.getenv('SLURM_NTASKS'))
setenv("MOLCAS_SAVE","INCR")
setenv("MOLCAS_PRINT","NORMAL")
setenv("MOLCAS_MEM","5000")
{% endblock %}
