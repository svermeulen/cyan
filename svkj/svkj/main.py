
from pathlib import Path
import subprocess
import shutil

root_dir = Path(__file__).parent.parent.parent
version = "svkj-6"
rockspec_file = root_dir.joinpath(f"cyan-{version}.rockspec")

def init_lua_rocks():
    print("======= Running init_lua_rocks ===========")
    subprocess.run(["luarocks", "init"], cwd=root_dir, check=True)

def init_lua_rocks_deps():
    init_lua_rocks()
    print("======= Running init_lua_rocks_deps ===========")
    subprocess.run(["./luarocks", "install", "--only-deps", "cyan-dev-1.rockspec"], cwd=root_dir, check=True)

def build_teal():
    init_lua_rocks_deps()
    print("======= Running build_teal ===========")
    subprocess.run(["./lua_modules/bin/tl", "build"], cwd=root_dir, check=True)

def generate_rockspec():
    build_teal()
    print("======= Running generate_rockspec ===========")
    dev_file = root_dir.joinpath("cyan-dev-1.rockspec")
    rockspec_file.write_text(dev_file.read_text().replace("dev-1", version))

def lua_rocks_make():
    generate_rockspec()
    init_lua_rocks()
    print("======= Running lua_rocks_make ===========")
    subprocess.run(["./luarocks", "make", rockspec_file], cwd=root_dir, check=True)

def create_rock():
    lua_rocks_make()
    print("======= Running create_rock ===========")
    subprocess.run(["./luarocks", "pack", "cyan"], cwd=root_dir, check=True)
    rock_file = root_dir.joinpath(f"cyan-{version}.all.rock")
    assert rock_file.exists()
    print("=======================")
    print(f"SUCCESS - rock file created at {rock_file}")
    print("=======================")
