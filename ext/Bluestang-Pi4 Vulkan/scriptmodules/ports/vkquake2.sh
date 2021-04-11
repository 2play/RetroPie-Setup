#!/usr/bin/env bash

rp_module_id="vkquake2"
rp_module_desc="vkQuake 2"
rp_module_help="Copy .pak files to ~/RetroPie/roms/ports/quake2/baseq2 folder"
rp_module_licence="GPL2 https://github.com/kondrak/vkQuake2/blob/master/LICENSE"
rp_module_repo="git https://github.com/yquake2/yquake2.git master"
rp_module_section="exp"
rp_module_flags="!all vk"

function get_arch_vkquake2() {
    echo "$(uname -m)"
}

function depends_vkquake2() {
    getDepends libglu1-mesa-dev libogg-dev libopenal-dev libsdl2-dev libvorbis-dev zlib1g-dev libcurl4-openssl-dev libvulkan-dev
}

function sources_vkquake2() {
    gitPullOrClone
    applyPatch "$md_data/vkQ2.diff"
}

function build_vkquake2() {
    cmake .
    make clean
    make
    md_ret_require="$md_build/release/quake2"
}

function install_vkquake2() {
    md_ret_files=(
        'release/baseq2'
        'release/q2ded'
        'release/quake2'
        'release/ref_gl1.so'
        'release/ref_gl3.so'
        'release/ref_soft.so'
        'release/ref_vk.so'
        'LICENSE'
        'README.md'
    )
}

function configure_vkquake2() {
    mkRomDir "ports/quake2"
    addPort "$md_id" "vkquake2" "vkQuake 2" "$md_inst/quake2 +set vid_renderer vk +set r_mode -1 +set r_customwidth %XRES% +set r_customheight %YRES%"
    
        [[ "$md_mode" == "remove" ]] && return

    chown -R $user:$user "$romdir/ports/quake2"
    chown -R $user:$user "$md_inst"

    moveConfigDir "$md_inst/baseq2" "$romdir/ports/quake2"
}
