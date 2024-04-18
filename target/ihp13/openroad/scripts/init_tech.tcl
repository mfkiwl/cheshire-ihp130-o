# Copyright 2023 ETH Zurich and University of Bologna.
# Solderpad Hardware License, Version 0.51, see LICENSE for details.
# SPDX-License-Identifier: SHL-0.51

# Authors:
# - Tobias Senti <tsenti@ethz.ch>
# - Jannis Schönleber <janniss@iis.ee.ethz.ch>
# - Philippe Sauter   <phsauter@ethz.ch>

# Initialize the PDK

utl::report "Init tech from Github PDK"

set dlyline_dir   ${pdk_dir}/../src/mc_delay
set pdk_cells_lib ${pdk_dir}/ihp-sg13g2/ihp-sg13g2/libs.ref/sg13g2_stdcell/lib
set pdk_cells_lef ${pdk_dir}/ihp-sg13g2/ihp-sg13g2/libs.ref/sg13g2_stdcell/lef
set pdk_sram_lib  ${pdk_dir}/ihp-sg13g2/ihp-sg13g2/libs.ref/sg13g2_sram/lib
set pdk_sram_lef  ${pdk_dir}/ihp-sg13g2/ihp-sg13g2/libs.ref/sg13g2_sram/lef
set pdk_io_lib    ${pdk_dir}/future/sg13g2_iocell/
set pdk_io_lef    ${pdk_dir}/future/sg13g2_iocell/

# LIB
define_corners tt ff

puts "Init standard cells"
read_liberty -corner tt ${pdk_cells_lib}/sg13g2_stdcell_typ_1p20V_25C.lib
read_liberty -corner ff ${pdk_cells_lib}/sg13g2_stdcell_fast_1p32V_m40C.lib

puts "Init IO cells"
read_liberty -corner tt ${pdk_io_lib}/sg13g2_iocell_typ_1p2V_3p3V_25C.lib
read_liberty -corner ff ${pdk_io_lib}/sg13g2_iocell_fast_1p32V_3p3V_m40C.lib

puts "Init SRAM macros"
# Read Patched SRAMs TODO: add proper corners when released!
read_liberty -corner tt ${pdk_sram_lib}/RM_IHPSG13_1P_64x64_c2_bm_bist_typ_1p20V_25C.lib
read_liberty -corner ff ${pdk_sram_lib}/RM_IHPSG13_1P_64x64_c2_bm_bist_fast_1p32V_m55C.lib

read_liberty -corner tt ${pdk_sram_lib}/RM_IHPSG13_1P_256x48_c2_bm_bist_typ_1p20V_25C.lib
read_liberty -corner ff ${pdk_sram_lib}/RM_IHPSG13_1P_256x48_c2_bm_bist_fast_1p32V_m55C.lib

read_liberty -corner tt ${pdk_sram_lib}/RM_IHPSG13_1P_256x64_c2_bm_bist_typ_1p20V_25C.lib
read_liberty -corner ff ${pdk_sram_lib}/RM_IHPSG13_1P_256x64_c2_bm_bist_fast_1p32V_m55C.lib

read_liberty -corner tt ${pdk_sram_lib}/RM_IHPSG13_1P_512x64_c2_bm_bist_typ_1p20V_25C.lib
read_liberty -corner ff ${pdk_sram_lib}/RM_IHPSG13_1P_512x64_c2_bm_bist_fast_1p32V_m55C.lib

read_liberty -corner tt ${pdk_sram_lib}/RM_IHPSG13_1P_1024x64_c2_bm_bist_typ_1p20V_25C.lib
read_liberty -corner ff ${pdk_sram_lib}/RM_IHPSG13_1P_1024x64_c2_bm_bist_fast_1p32V_m55C.lib

read_liberty -corner tt ${pdk_sram_lib}/RM_IHPSG13_1P_2048x64_c2_bm_bist_typ_1p20V_25C.lib
read_liberty -corner ff ${pdk_sram_lib}/RM_IHPSG13_1P_2048x64_c2_bm_bist_fast_1p32V_m55C.lib

puts "Init delay-line macro"
read_liberty -corner tt ${dlyline_dir}/delay_line_D4_O1_6P000.mid_guess.lib
read_liberty -corner ff ${dlyline_dir}/delay_line_D4_O1_6P000.min_guess.lib

puts "Init tech-lef"
read_lef ${pdk_cells_lef}/sg13g2_tech.lef

puts "Init cell-lef"
read_lef ${pdk_cells_lef}/sg13g2_stdcell.lef
read_lef ${pdk_io_lef}/sg13g2_iocell.lef
read_lef ${pdk_sram_lef}/RM_IHPSG13_1P_64x64_c2_bm_bist.lef
read_lef ${pdk_sram_lef}/RM_IHPSG13_1P_256x48_c2_bm_bist.lef
read_lef ${pdk_sram_lef}/RM_IHPSG13_1P_256x64_c2_bm_bist.lef
read_lef ${pdk_sram_lef}/RM_IHPSG13_1P_512x64_c2_bm_bist.lef
read_lef ${pdk_sram_lef}/RM_IHPSG13_1P_1024x64_c2_bm_bist.lef
read_lef ${pdk_sram_lef}/RM_IHPSG13_1P_2048x64_c2_bm_bist.lef
read_lef ${dlyline_dir}/delay_line_D4_O1_6P000.abst.lef

set ctsBuf [ list sg13g2_buf_16 sg13g2_buf_8 sg13g2_buf_4 sg13g2_buf_2 ]
set ctsBufRoot sg13g2_buf_8

set iocorner corner
set iofill [ list filler10u filler4u filler2u filler1u ]

# the repair_timing/repair_design commands try to use IO cells as buffers...
set dont_use_cells {ixc013_i16x ixc013_b16m ixc013_b16mpup ixc013_b16mpdn}
