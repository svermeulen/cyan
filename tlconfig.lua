return {
   build_dir = "build",
   source_dir = "src",
   include_dir = { "src" },

   warning_error = { "unused", "redeclaration" },

   global_env_def = "globals",
   gen_compat = "required",

   scripts = {
      ["scripts/gen_rockspec.tl"] = { "build:post" },
      ["scripts/docgen.tl"] = { "build:post" },
   },
}
