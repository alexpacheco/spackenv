{% extends "modules/modulefile.lua" %}
{% block footer %}
-- Add modulepath for locally installed packages
prepend_path("MODULEPATH","/share/Apps/share/Modules/lmod/linux-centos8-x86_64/{{spec.name}}/{{spec.version}}/gcc/9.3.0")
{% endblock %}
