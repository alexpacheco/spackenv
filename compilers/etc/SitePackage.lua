local arch=os.getenv("arch") or "avx"
if (mode() == "load") then
   local required = false
   local activeA = loaded_modules()

   for i = 1,#activeA do
--      io.stderr:write("Unloading: ",activeA[i].userName,"\n")
      unload(activeA[i].userName)
   end
   setenv("LMOD_ADMIN_FILE","/share/Apps/compilers/etc/lmod/admin.list")
--   setenv("MODULEPATH","/share/Apps/lusoft/share/spack/lmod/",os.getenv('arch'),"/linux-centos8-x86_64/Core")
   setenv("MODULEPATH","/share/Apps/lusoft/share/spack/lmod/",arch,"/linux-centos8-x86_64/Core")
   append_path("MODULEPATH","/share/Apps/lusoft/share/spack/lmod/default/linux-centos8-x86_64/Core")
   append_path("MODULEPATH","/share/Apps/share/Modules/lmod/applications/licensed")
   append_path("MODULEPATH","/share/Apps/share/Modules/lmod/default")
   for i = 1,#activeA do
--      io.stderr:write("loading: ",activeA[i].userName,"\n")
      mgrload(required, activeA[i])
   end
end
