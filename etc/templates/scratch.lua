{% extends "modules/modulefile.lua" %}
{% block footer %}
-- Add local and cephfs scratch for all installed packages
local cephscratch=pathJoin("/share/ceph/scratch/",os.getenv('USER'),"/",os.getenv('SLURM_JOB_ID')) or "/tmp"
local tmpscratch=pathJoin("/scratch/",os.getenv('USER'),"/",os.getenv('SLURM_JOB_ID')) or "/tmp"

--- Setup CEPH SCRATCH and LOCAL SCRATCH
setenv("LOCAL_SCRATCH",tmpscratch)
setenv("CEPHFS_SCRATCH",cephscratch)
{% endblock %}
