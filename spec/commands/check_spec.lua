
local util = require("spec.util")

describe("check command", function()
   it("should do basic type checking of a single file", function()
      util.run_mock_project(finally, {
         cmd = "check",
         args = { "foo.tl" },
         dir_structure = {
            ["foo.tl"] = [[local x: number = "hello"]]
         },
         cmd_output_match = "Error",
         exit_code = 1,
      })
   end)

   it("should do basic type checking of many files", function()
      util.run_mock_project(finally, {
         cmd = "check",
         args = { "foo.tl", "bar.tl" },
         dir_structure = {
            ["foo.tl"] = [[local _x: number = "hello"]],
            ["bar.tl"] = [[local _x: string = "hello"]],
         },
         cmd_output_match_lines = {
            [1] = "%d.*Error.*foo%.tl",
            [3] = "Type checked.*bar%.tl",
         },
         exit_code = 1,
      })
   end)

   it("should handle being told to type check a non-file", function()
      util.run_mock_project(finally, {
         cmd = "check",
         args = { "foo" },
         dir_structure = {
            foo = {},
         },
         cmd_output_match = "is not a file",
         exit_code = 1,
      })
   end)
end)
