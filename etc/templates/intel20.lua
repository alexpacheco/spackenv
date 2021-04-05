{% extends "modules/modulefile.lua" %}
{% block footer %}
-- Add modulepath for locally installed packages
append_path("LD_LIBRARY_PATH","/share/Apps/intel/2020/compilers_and_libraries_2020.3.275/linux/lib")
prepend_path("MODULEPATH","/share/Apps/share/Modules/lmod/linux-centos8-x86_64/{{spec.name}}/{{spec.version}}/intel/20.0.3")
{% endblock %}
