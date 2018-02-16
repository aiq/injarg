package = "injarg"
version = "scm-0"

description = {
   summary = "inject == inj[ect]arg[s]",
   detailed = "Command-line tool that allows to call an app with arguments from an args file.",
   license = "MIT",
   homepage = "https://github.com/aiq/injarg"
}

source = {
   url = "..."
}

dependencies = {
   "lua >= 5.1",
   "luafilesystem",
}

build = {
   type = "builtin",
   modules = {},
   install = {
      bin = {
         [ "injarg" ] = "bin/injarg"
      }
   }
}
