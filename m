From: marc.smith@mcc.edu (Marc Smith)
Date: Wed, 15 Feb 2017 14:27:13 -0500
Subject: Linux 4.9.8 + NVMe CiB Issue
Message-ID: <CAHkw+LcMtBp_xC6YdR-c=P-feZJvukNtkeEWueJ_y9wkAg2hUA@mail.gmail.com>

Hi,

I'm testing with a Supermicro SSG-2028R-DN2R40L NVMe CiB
(cluster-in-a-box) solution. The performance is amazing so far, but I
experienced an issue during a performance test while using the fio
tool.

Linux 4.9.8
fio 2.14

We have just (8) NVMe drives in the "enclosure", and it contains two
server nodes, but right now we're just testing from one of the nodes.

This is the command we ran:
fio --bs=4k --direct=1 --rw=randread --ioengine=libaio --iodepth=12
--numjobs=16 --name=/dev/nvme0n1 --name=/dev/nvme1n1
--name=/dev/nvme2n1 --name=/dev/nvme3n1 --name=/dev/nvme4n1
--name=/dev/nvme5n1 --name=/dev/nvme6n1 --name=/dev/nvme7n1

After a few seconds, noticed the performance numbers started dropping,
and started flaking out. This is what we saw in the kernel logs:

--snip--
[70961.868655] nvme nvme0: I/O 1009 QID 1 timeout, aborting
[70961.868666] nvme nvme0: I/O 1010 QID 1 timeout, aborting
[70961.868670] nvme nvme0: I/O 1011 QID 1 timeout, aborting
[70961.868673] nvme nvme0: I/O 1013 QID 1 timeout, aborting
[70992.073974] nvme nvme0: I/O 1009 QID 1 timeout, reset controller
[71022.727229] nvme nvme0: I/O 237 QID 0 timeout, reset controller
[71052.589227] nvme nvme0: completing aborted command with status: 0007
[71052.589230] blk_update_request: I/O error, dev nvme0n1, sector 1699051304
[71052.589240] nvme nvme0: completing aborted command with status: 0007
[71052.589241] blk_update_request: I/O error, dev nvme0n1, sector 921069792
[71052.589243] nvme nvme0: completing aborted command with status: 0007
[71052.589244] blk_update_request: I/O error, dev nvme0n1, sector 503421912
[71052.589246] nvme nvme0: completing aborted command with status: 0007
[71052.589247] blk_update_request: I/O error, dev nvme0n1, sector 459191600
[71052.589249] nvme nvme0: completing aborted command with status: 0007
[71052.589250] blk_update_request: I/O error, dev nvme0n1, sector 541938152
[71052.589252] nvme nvme0: completing aborted command with status: 0007
[71052.589253] blk_update_request: I/O error, dev nvme0n1, sector 454021704
[71052.589255] nvme nvme0: completing aborted command with status: 0007
[71052.589255] blk_update_request: I/O error, dev nvme0n1, sector 170843976
[71052.589257] nvme nvme0: completing aborted command with status: 0007
[71052.589258] blk_update_request: I/O error, dev nvme0n1, sector 1632333960
[71052.589259] nvme nvme0: completing aborted command with status: 0007
[71052.589260] blk_update_request: I/O error, dev nvme0n1, sector 463726632
[71052.589262] nvme nvme0: completing aborted command with status: 0007
[71052.589262] blk_update_request: I/O error, dev nvme0n1, sector 1402584824
[71052.589264] nvme nvme0: completing aborted command with status: 0007
[71052.589267] nvme nvme0: completing aborted command with status: 0007
[71052.589273] nvme nvme0: completing aborted command with status: 0007
[71052.589275] nvme nvme0: completing aborted command with status: 0007
[71052.589277] nvme nvme0: completing aborted command with status: 0007
[71052.589280] nvme nvme0: completing aborted command with status: 0007
[71052.589282] nvme nvme0: completing aborted command with status: 0007
[71052.589284] nvme nvme0: completing aborted command with status: 0007
[71052.589286] nvme nvme0: completing aborted command with status: 0007
[71052.589288] nvme nvme0: completing aborted command with status: 0007
[71052.589290] nvme nvme0: completing aborted command with status: 0007
[71052.589292] nvme nvme0: completing aborted command with status: 0007
[71052.589294] nvme nvme0: completing aborted command with status: 0007
[71052.589297] nvme nvme0: completing aborted command with status: 0007
[71052.589303] nvme nvme0: completing aborted command with status: 0007
[71052.589305] nvme nvme0: completing aborted command with status: 0007
[71052.589307] nvme nvme0: completing aborted command with status: 0007
[71052.589309] nvme nvme0: completing aborted command with status: 0007
[71052.589312] nvme nvme0: completing aborted command with status: 0007
[71052.589314] nvme nvme0: completing aborted command with status: 0007
[71052.589316] nvme nvme0: completing aborted command with status: 0007
[71052.589318] nvme nvme0: completing aborted command with status: 0007
[71052.589321] nvme nvme0: completing aborted command with status: 0007
[71052.589323] nvme nvme0: completing aborted command with status: 0007
[71052.589325] nvme nvme0: completing aborted command with status: 0007
[71052.589328] nvme nvme0: completing aborted command with status: 0007
[71052.589333] fio[3834]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589334] nvme nvme0: completing aborted command with status: 0007
[71052.589336] nvme nvme0: completing aborted command with status: 0007
[71052.589339]  in fio[400000+9d000]<4>[71052.589339] nvme nvme0:
completing aborted command with status: 0007
[71052.589342] nvme nvme0: completing aborted command with status: 0007
[71052.589344] nvme nvme0: completing aborted command with status: 0007
[71052.589347] nvme nvme0: completing aborted command with status: 0007
[71052.589349] nvme nvme0: completing aborted command with status: 0007
[71052.589352] nvme nvme0: completing aborted command with status: 0007
[71052.589354] nvme nvme0: completing aborted command with status: 0007
[71052.589360] nvme nvme0: completing aborted command with status: 0007
[71052.589365] fio[3832]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589365] nvme nvme0: completing aborted command with status: 0007
[71052.589367] nvme nvme0: completing aborted command with status: 0007
[71052.589370]  in fio[400000+9d000]<4>[71052.589370] nvme nvme0:
completing aborted command with status: 0007
[71052.589373] nvme nvme0: completing aborted command with status: 0007
[71052.589375] nvme nvme0: completing aborted command with status: 0007
[71052.589377] nvme nvme0: completing aborted command with status: 0007
[71052.589379] nvme nvme0: completing aborted command with status: 0007
[71052.589382] nvme nvme0: completing aborted command with status: 0007
[71052.589383] nvme nvme0: completing aborted command with status: 0007
[71052.589386] nvme nvme0: completing aborted command with status: 0007
[71052.589390] nvme nvme0: completing aborted command with status: 0007
[71052.589392] nvme nvme0: completing aborted command with status: 0007
[71052.589394] fio[3831]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589397] nvme nvme0: completing aborted command with status: 0007
[71052.589398]  in fio[400000+9d000]<4>[71052.589403] nvme nvme0:
completing aborted command with status: 0007
[71052.589408] nvme nvme0: completing aborted command with status: 0007
[71052.589410] nvme nvme0: completing aborted command with status: 0007
[71052.589412] nvme nvme0: completing aborted command with status: 0007
[71052.589414] nvme nvme0: completing aborted command with status: 0007
[71052.589417] nvme nvme0: completing aborted command with status: 0007
[71052.589419] nvme nvme0: completing aborted command with status: 0007
[71052.589422] nvme nvme0: completing aborted command with status: 0007
[71052.589424] nvme nvme0: completing aborted command with status: 0007
[71052.589428] fio[3836]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589429] nvme nvme0: completing aborted command with status: 0007
[71052.589431] nvme nvme0: completing aborted command with status: 0007
[71052.589434]  in fio[400000+9d000]<4>[71052.589434] nvme nvme0:
completing aborted command with status: 0007
[71052.589437] nvme nvme0: completing aborted command with status: 0007
[71052.589442] nvme nvme0: completing aborted command with status: 0007
[71052.589444] nvme nvme0: completing aborted command with status: 0007
[71052.589446] nvme nvme0: completing aborted command with status: 0007
[71052.589449] nvme nvme0: completing aborted command with status: 0007
[71052.589451] nvme nvme0: completing aborted command with status: 0007
[71052.589453] nvme nvme0: completing aborted command with status: 0007
[71052.589456] nvme nvme0: completing aborted command with status: 0007
[71052.589459] nvme nvme0: completing aborted command with status: 0007
[71052.589461] nvme nvme0: completing aborted command with status: 0007
[71052.589464] fio[3844]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589467] nvme nvme0: completing aborted command with status: 0007
[71052.589468]  in fio[400000+9d000]<4>[71052.589471] nvme nvme0:
completing aborted command with status: 0007
[71052.589476] nvme nvme0: completing aborted command with status: 0007
[71052.589481] nvme nvme0: completing aborted command with status: 0007
[71052.589484] nvme nvme0: completing aborted command with status: 0007
[71052.589487] nvme nvme0: completing aborted command with status: 0007
[71052.589490] nvme nvme0: completing aborted command with status: 0007
[71052.589492] nvme nvme0: completing aborted command with status: 0007
[71052.589494] nvme nvme0: completing aborted command with status: 0007
[71052.589499] fio[3841]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589499] nvme nvme0: completing aborted command with status: 0007
[71052.589501] nvme nvme0: completing aborted command with status: 0007
[71052.589504] nvme nvme0: completing aborted command with status: 0007
[71052.589506] nvme nvme0: completing aborted command with status: 0007
[71052.589507]  in fio[400000+9d000]<4>[71052.589510] nvme nvme0:
completing aborted command with status: 0007
[71052.589513] nvme nvme0: completing aborted command with status: 0007
[71052.589518] nvme nvme0: completing aborted command with status: 0007
[71052.589523] nvme nvme0: completing aborted command with status: 0007
[71052.589538] nvme nvme0: completing aborted command with status: 0007
[71052.589540] nvme nvme0: completing aborted command with status: 0007
[71052.589543] fio[3830]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4 in fio[400000+9d000]
[71052.589548] nvme nvme0: completing aborted command with status: 0007
[71052.589551] nvme nvme0: completing aborted command with status: 0007
[71052.589553] nvme nvme0: completing aborted command with status: 0007
[71052.589556] nvme nvme0: completing aborted command with status: 0007
[71052.589560] fio[3835]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589561] nvme nvme0: completing aborted command with status: 0007
[71052.589566] nvme nvme0: completing aborted command with status: 0007
[71052.589572]  in fio[400000+9d000]<4>[71052.589576] nvme nvme0:
completing aborted command with status: 0007
[71052.589584] nvme nvme0: completing aborted command with status: 0007
[71052.589591] fio[3845]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589592] nvme nvme0: completing aborted command with status: 0007
[71052.589598] fio[3833]: segfault at 8 ip 000000000046905d sp
00007ffd2d545590 error 4
[71052.589599] nvme nvme0: completing aborted command with status: 0007
[71052.589601]  in fio[400000+9d000] in
fio[400000+9d000]<4>[71052.589610] nvme nvme0: completing aborted
command with status: 0007
[71052.589616] nvme nvme0: completing aborted command with status: 0007
[71052.589620] nvme nvme0: completing aborted command with status: 0007
[71052.589624] nvme nvme0: completing aborted command with status: 0007
[71052.589629] nvme nvme0: completing aborted command with status: 0007
[71052.589634] nvme nvme0: completing aborted command with status: 0007
[71052.589638] nvme nvme0: completing aborted command with status: 0007
[71052.589640] nvme nvme0: completing aborted command with status: 0007
[71052.589642] nvme nvme0: completing aborted command with status: 0007
[71052.589643] nvme nvme0: completing aborted command with status: 0007
[71052.589645] nvme nvme0: completing aborted command with status: 0007
[71052.589647] nvme nvme0: completing aborted command with status: 0007
[71052.589650] nvme nvme0: completing aborted command with status: 0007
[71052.589652] nvme nvme0: completing aborted command with status: 0007
[71052.589654] nvme nvme0: completing aborted command with status: 0007
[71052.589656] nvme nvme0: completing aborted command with status: 0007
[71052.589657] nvme nvme0: completing aborted command with status: 0007
[71052.589659] nvme nvme0: completing aborted command with status: 0007
[71052.589661] nvme nvme0: completing aborted command with status: 0007
[71052.589663] nvme nvme0: completing aborted command with status: 0007
[71052.589666] nvme nvme0: completing aborted command with status: 0007
[71052.589683] nvme nvme0: completing aborted command with status: 0007
[71052.589685] nvme nvme0: completing aborted command with status: 0007
[71052.589687] nvme nvme0: completing aborted command with status: 0007
[71052.589692] nvme nvme0: Abort status: 0x7
[71052.589694] nvme nvme0: Abort status: 0x7
[71052.589695] nvme nvme0: Abort status: 0x7
[71052.589697] nvme nvme0: completing aborted command with status: 0007
[71052.589698] nvme nvme0: completing aborted command with status: 0007
[71052.589700] nvme nvme0: completing aborted command with status: 0007
[71052.589703] nvme nvme0: completing aborted command with status: 0007
[71052.589706] nvme nvme0: completing aborted command with status: 0007
[71052.589708] nvme nvme0: completing aborted command with status: fffffffc
[71052.589710] nvme nvme0: completing aborted command with status: 0007
[71052.589714] nvme nvme0: completing aborted command with status: 0007
[71052.589715] nvme nvme0: completing aborted command with status: 0007
[71052.589716] nvme nvme0: completing aborted command with status: 0007
[71052.589718] nvme nvme0: completing aborted command with status: 0007
[71052.589720] nvme nvme0: completing aborted command with status: 0007
[71052.589723] nvme nvme0: completing aborted command with status: 0007
[71052.589724] nvme nvme0: completing aborted command with status: 0007
[71052.589725] nvme nvme0: completing aborted command with status: 0007
[71052.589726] nvme nvme0: completing aborted command with status: 0007
[71052.589728] nvme nvme0: completing aborted command with status: 0007
[71052.589729] nvme nvme0: completing aborted command with status: 0007
[71052.589731] nvme nvme0: completing aborted command with status: 0007
[71052.589732] nvme nvme0: completing aborted command with status: 0007
[71052.589734] nvme nvme0: completing aborted command with status: 0007
[71052.589736] nvme nvme0: completing aborted command with status: 0007
[71052.589737] nvme nvme0: completing aborted command with status: 0007
[71052.589739] nvme nvme0: completing aborted command with status: 0007
[71052.589741] nvme nvme0: completing aborted command with status: 0007
[71052.589743] nvme nvme0: completing aborted command with status: 0007
[71052.589744] nvme nvme0: completing aborted command with status: 0007
[71052.589746] nvme nvme0: completing aborted command with status: 0007
[71052.589747] nvme nvme0: completing aborted command with status: 0007
[71052.589748] nvme nvme0: completing aborted command with status: 0007
[71052.589750] nvme nvme0: completing aborted command with status: 0007
[71052.589752] nvme nvme0: completing aborted command with status: 0007
[71052.589753] nvme nvme0: completing aborted command with status: 0007
[71052.589754] nvme nvme0: completing aborted command with status: 0007
[71052.589756] nvme nvme0: completing aborted command with status: 0007
[71052.589757] nvme nvme0: completing aborted command with status: 0007
[71052.589759] nvme nvme0: completing aborted command with status: 0007
[71052.589761] nvme nvme0: completing aborted command with status: 0007
[71052.589762] nvme nvme0: completing aborted command with status: 0007
[71052.589763] nvme nvme0: completing aborted command with status: 0007
[71052.589764] nvme nvme0: completing aborted command with status: 0007
[71052.589766] nvme nvme0: completing aborted command with status: 0007
[71052.589768] nvme nvme0: completing aborted command with status: 0007
[71052.589769] nvme nvme0: completing aborted command with status: 0007
[71052.589771] nvme nvme0: completing aborted command with status: 0007
[71052.589773] nvme nvme0: completing aborted command with status: 0007
[71052.589774] nvme nvme0: completing aborted command with status: 0007
[71052.589775] nvme nvme0: completing aborted command with status: 0007
[71052.589777] nvme nvme0: completing aborted command with status: 0007
[71052.589779] nvme nvme0: completing aborted command with status: 0007
[71052.589780] nvme nvme0: completing aborted command with status: 0007
[71052.589782] nvme nvme0: completing aborted command with status: 0007
[71052.589785] nvme nvme0: completing aborted command with status: 0007
[71052.589786] nvme nvme0: completing aborted command with status: 0007
[71052.589789] nvme nvme0: completing aborted command with status: 0007
[71052.589792] nvme nvme0: Abort status: 0xfffc
[71052.589796] nvme nvme0: completing aborted command with status: 0007
[71052.589799] nvme nvme0: completing aborted command with status: 0007
[71052.589800] nvme nvme0: completing aborted command with status: 0007
[71052.590177] ------------[ cut here ]------------
[71052.590188] WARNING: CPU: 4 PID: 3771 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x53/0x5f
[71052.590190] sysfs: cannot create duplicate filename
'/devices/pci0000:00/0000:00:03.0/0000:03:00.0/0000:04:04.0/0000:05:00.0/nvme/nvme0/cmb'
[71052.590191] Modules linked in: fcst(O) scst_changer(O) scst_tape(O)
scst_vdisk(O) scst_disk(O) ib_srpt(O) iscsi_scst(O) qla2x00tgt(O)
scst(O) qla2xxx bonding mlx5_core bna ib_umad rdma_ucm ib_uverbs
ib_srp iw_nes iw_cxgb4 cxgb4 iw_cxgb3 ib_qib rdmavt mlx4_ib ib_mthca
[71052.590213] CPU: 4 PID: 3771 Comm: kworker/u113:2 Tainted: G
   O    4.9.8-esos.prod #1
[71052.590213] Hardware name: Supermicro SSG-2028R-DN2R40L/X10DSN-TS,
BIOS 2.0 10/28/2016
[71052.590221] Workqueue: nvme nvme_reset_work
[71052.590223]  0000000000000000 ffffffff81397af8 ffffc9002440fcf0
0000000000000000
[71052.590225]  ffffffff81065550 ffff880806aa0000 ffffc9002440fd48
ffff88085bb855a0
[71052.590226]  ffff88085b755000 00000000b2000000 ffff880858b90138
ffffffff810655af
[71052.590229] Call Trace:
[71052.590238]  [<ffffffff81397af8>] ? dump_stack+0x46/0x59
[71052.590244]  [<ffffffff81065550>] ? __warn+0xc8/0xe1
[71052.590245]  [<ffffffff810655af>] ? warn_slowpath_fmt+0x46/0x4e
[71052.590248]  [<ffffffff81182ce0>] ? kernfs_path_from_node+0x4e/0x58
[71052.590250]  [<ffffffff81184e5c>] ? sysfs_warn_dup+0x53/0x5f
[71052.590253]  [<ffffffff81184c39>] ? sysfs_add_file_mode_ns+0xd1/0x14d
[71052.590254]  [<ffffffff81184d7c>] ? sysfs_add_file_to_group+0x3c/0x4b
[71052.590256]  [<ffffffff815dae5f>] ? nvme_reset_work+0x415/0xb25
[71052.590260]  [<ffffffff81076a58>] ? process_one_work+0x192/0x29b
[71052.590262]  [<ffffffff81077096>] ? worker_thread+0x26e/0x356
[71052.590264]  [<ffffffff81076e28>] ? rescuer_thread+0x2a0/0x2a0
[71052.590266]  [<ffffffff810686e8>] ? do_group_exit+0x39/0x91
[71052.590268]  [<ffffffff8107abe2>] ? kthread+0xc2/0xca
[71052.590269]  [<ffffffff8107ab20>] ? kthread_park+0x4e/0x4e
[71052.590275]  [<ffffffff81a7ed22>] ? ret_from_fork+0x22/0x30
[71052.590276] ---[ end trace 25be46e93007ecdb ]---
[71052.590278] nvme 0000:05:00.0: failed to add sysfs attribute for CMB
[71112.831251] nvme nvme0: I/O 110 QID 0 timeout, disable controller
[71112.831259] ------------[ cut here ]------------
[71112.831267] WARNING: CPU: 4 PID: 788 at kernel/irq/manage.c:1478
__free_irq+0x93/0x1ed
[71112.831268] Trying to free already-free IRQ 109
[71112.831269] Modules linked in: fcst(O) scst_changer(O) scst_tape(O)
scst_vdisk(O) scst_disk(O) ib_srpt(O) iscsi_scst(O) qla2x00tgt(O)
scst(O) qla2xxx bonding mlx5_core bna ib_umad rdma_ucm ib_uverbs
ib_srp iw_nes iw_cxgb4 cxgb4 iw_cxgb3 ib_qib rdmavt mlx4_ib ib_mthca
[71112.831290] CPU: 4 PID: 788 Comm: kworker/4:1H Tainted: G        W
O    4.9.8-esos.prod #1
[71112.831291] Hardware name: Supermicro SSG-2028R-DN2R40L/X10DSN-TS,
BIOS 2.0 10/28/2016
[71112.831297] Workqueue: kblockd blk_mq_timeout_work
[71112.831299]  0000000000000000 ffffffff81397af8 ffffc900098a7b88
0000000000000000
[71112.831301]  ffffffff81065550 ffff880850b26e00 ffffc900098a7be0
000000000000006d
[71112.831303]  ffff880850b26e9c ffff88085857ec80 0000000000000246
ffffffff810655af
[71112.831305] Call Trace:
[71112.831311]  [<ffffffff81397af8>] ? dump_stack+0x46/0x59
[71112.831315]  [<ffffffff81065550>] ? __warn+0xc8/0xe1
[71112.831316]  [<ffffffff810655af>] ? warn_slowpath_fmt+0x46/0x4e
[71112.831319]  [<ffffffff8139c224>] ? __radix_tree_lookup+0x2c/0x93
[71112.831320]  [<ffffffff8109d5b0>] ? __free_irq+0x93/0x1ed
[71112.831322]  [<ffffffff8109d7a5>] ? free_irq+0x61/0x72
[71112.831327]  [<ffffffff815d9e2b>] ? nvme_suspend_queue+0x66/0x6b
[71112.831328]  [<ffffffff815da001>] ? nvme_dev_disable+0x96/0x30b
[71112.831332]  [<ffffffff8148ebd6>] ? dev_warn+0x50/0x58
[71112.831334]  [<ffffffff815da368>] ? nvme_timeout+0x59/0x186
[71112.831337]  [<ffffffff810900e9>] ? complete+0x2b/0x3a
[71112.831341]  [<ffffffff81083ff6>] ? sched_clock_cpu+0xc/0x95
[71112.831343]  [<ffffffff8138691f>] ? blk_mq_rq_timed_out+0x27/0x5e
[71112.831345]  [<ffffffff8138816f>] ? bt_for_each+0xaf/0xca
[71112.831346]  [<ffffffff81386956>] ? blk_mq_rq_timed_out+0x5e/0x5e
[71112.831347]  [<ffffffff81386956>] ? blk_mq_rq_timed_out+0x5e/0x5e
[71112.831349]  [<ffffffff813885df>] ? blk_mq_queue_tag_busy_iter+0x7b/0x88
[71112.831350]  [<ffffffff81385677>] ? blk_mq_timeout_work+0x7d/0x102
[71112.831354]  [<ffffffff81076a58>] ? process_one_work+0x192/0x29b
[71112.831355]  [<ffffffff81077096>] ? worker_thread+0x26e/0x356
[71112.831357]  [<ffffffff81076e28>] ? rescuer_thread+0x2a0/0x2a0
[71112.831358]  [<ffffffff8107abe2>] ? kthread+0xc2/0xca
[71112.831360]  [<ffffffff8107ab20>] ? kthread_park+0x4e/0x4e
[71112.831364]  [<ffffffff81a7ed22>] ? ret_from_fork+0x22/0x30
[71112.831365] ---[ end trace 25be46e93007ecdc ]---
[71112.831664] nvme nvme0: Removing after probe failure status: -4
[71112.831684] nvme0n1: detected capacity change from 1000204886016 to 0
--snip--

The nvme0 and nvme0n1 devices disappeared from /dev and on the other
server connected to the same NVMe drives, we see this in the kernel
messages:

--snip--
[70533.983041] nvme 0000:05:00.0: Failed status: 0x3, reset controller.
[70533.984225] ------------[ cut here ]------------
[70533.984237] WARNING: CPU: 1 PID: 2691 at fs/sysfs/dir.c:31
sysfs_warn_dup+0x53/0x5f
[70533.984238] sysfs: cannot create duplicate filename
'/devices/pci0000:00/0000:00:03.0/0000:03:00.0/0000:04:04.0/0000:05:00.0/nvme/nvme0/cmb'
[70533.984239] Modules linked in: fcst(O) scst_changer(O) scst_tape(O)
scst_vdisk(O) scst_disk(O) ib_srpt(O) iscsi_scst(O) qla2x00tgt(O)
scst(O) qla2xxx bonding mlx5_core bna ib_umad rdma_ucm ib_uverbs
ib_srp iw_nes iw_cxgb4 cxgb4 iw_cxgb3 ib_qib rdmavt mlx4_ib ib_mthca
[70533.984259] CPU: 1 PID: 2691 Comm: kworker/u113:1 Tainted: G
   O    4.9.8-esos.prod #1
[70533.984260] Hardware name: Supermicro SSG-2028R-DN2R40L/X10DSN-TS,
BIOS 2.0 10/28/2016
[70533.984268] Workqueue: nvme nvme_reset_work
[70533.984270]  0000000000000000 ffffffff81397af8 ffffc900207abcf0
0000000000000000
[70533.984272]  ffffffff81065550 ffff88085045f000 ffffc900207abd48
ffff88105b70b5a0
[70533.984273]  ffff88085b735000 00000000b2000000 ffff880858bd0138
ffffffff810655af
[70533.984275] Call Trace:
[70533.984285]  [<ffffffff81397af8>] ? dump_stack+0x46/0x59
[70533.984291]  [<ffffffff81065550>] ? __warn+0xc8/0xe1
[70533.984293]  [<ffffffff810655af>] ? warn_slowpath_fmt+0x46/0x4e
[70533.984296]  [<ffffffff81182ce0>] ? kernfs_path_from_node+0x4e/0x58
[70533.984297]  [<ffffffff81184e5c>] ? sysfs_warn_dup+0x53/0x5f
[70533.984300]  [<ffffffff81184c39>] ? sysfs_add_file_mode_ns+0xd1/0x14d
[70533.984301]  [<ffffffff81184d7c>] ? sysfs_add_file_to_group+0x3c/0x4b
[70533.984303]  [<ffffffff815dae5f>] ? nvme_reset_work+0x415/0xb25
[70533.984308]  [<ffffffff81076a58>] ? process_one_work+0x192/0x29b
[70533.984309]  [<ffffffff81077096>] ? worker_thread+0x26e/0x356
[70533.984311]  [<ffffffff81076e28>] ? rescuer_thread+0x2a0/0x2a0
[70533.984314]  [<ffffffff8107abe2>] ? kthread+0xc2/0xca
[70533.984315]  [<ffffffff8107ab20>] ? kthread_park+0x4e/0x4e
[70533.984321]  [<ffffffff81a7ed22>] ? ret_from_fork+0x22/0x30
[70533.984322] ---[ end trace 7dbcf09b49326265 ]---
[70533.984323] nvme 0000:05:00.0: failed to add sysfs attribute for CMB
[70539.311337] nvme nvme0: Removing after probe failure status: -19
[70539.311471] nvme0n1: detected capacity change from 1000204886016 to 0
--snip--

Is it possible maybe one of our NVMe drives (nvme0) is bad? Or is this
something else? Again, we weren't trying to run any concurrent I/O
from the second server, only running fio against the drives on just
one of the servers.

Any help or advice would be greatly appreciated. And I'm new to this
list, so if this is the wrong forum, please let me know.


Thanks,

Marc
