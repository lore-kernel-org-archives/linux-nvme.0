From: JBauer@sjm.com (Bauer, John)
Date: Tue, 28 Feb 2017 21:02:32 +0000
Subject: NVMe nvme_queue_rq crash
Message-ID: <AEFEA030B02DC74F8C729339175739E672D4F97D@USC1PMSG10.ad.sjm.com>

We are having crashing problems when doing load testing with fio on multiple servers with the same hardware using NVMe storage.

We have support cases open with vendors for months without any definitive answers or results.  Can someone advise if there is a version or patch to fix this issue?

Offending command sometimes results in a crash:
fio --name=4k_benchmark --size=1T --filename=/PATH/test1T --ioengine=libaio --randrepeat=0 --iodepth=128 --direct=1 --invalidate=1 --verify=0 --verify_fatal=0 --numjobs 12 --rw=randread --blocksize=4k --group_reporting

Crash info:
[ 2850.077486] nvme 0000:87:00.0: I/O 447 QID 11 timeout, aborting
[ 2854.077154] nvme 0000:87:00.0: I/O 537 QID 1 timeout, aborting
[ 2854.077238] BUG: unable to handle kernel NULL pointer dereference at 0000000000000048
[ 2854.077303] IP: [<ffffffffa00c382f>] nvme_queue_rq+0x2af/0xa70 [nvme]
[ 2854.077368] PGD 0
[ 2854.077389] Oops: 0000 [#1] SMP
[ 2854.077421] Modules linked in: rpcsec_gss_krb5 nfsv4 dns_resolver nfsv3 nfs fscache bonding intel_powerclamp coretemp intel_rapl iosf_mbi kvm_intel kvm irqbypass crc32_pclmul ghash_clmulni_intel aesni_intel lrw gf128mul glue_helper ablk_helper cryptd iTCO_wdt iTCO_vendor_support mxm_wmi ipmi_devintf dcdbas raid456 async_raid6_recov async_memcpy async_pq ipmi_ssif raid6_pq async_xor xor async_tx pcspkr sg ipmi_si lpc_ich ipmi_msghandler wmi shpchp acpi_power_meter binfmt_misc nfsd auth_rpcgss nfs_acl lockd grace sunrpc ip_tables xfs libcrc32c sd_mod crc_t10dif crct10dif_generic crct10dif_pclmul mgag200 crct10dif_common i2c_algo_bit crc32c_intel drm_kms_helper syscopyarea sysfillrect sysimgblt fb_sys_fops ttm ahci nvme drm libahci tg3 libata i2c_core ptp megaraid_sas pps_core fjes dm_mirror dm_region_hash
[ 2854.078110]  dm_log dm_mod
[ 2854.078128] CPU: 0 PID: 1626 Comm: kworker/0:1H Not tainted 3.10.0-514.2.2.el7.x86_64 #1
[ 2854.078189] Hardware name: Dual 22 core processors, 88 threads total, 128GB RAM
[ 2854.078252] Workqueue: kblockd blk_mq_timeout_work
[ 2854.078291] task: ffff8810346b8000 ti: ffff881028e40000 task.ti: ffff881028e40000
[ 2854.078347] RIP: 0010:[<ffffffffa00c382f>]  [<ffffffffa00c382f>] nvme_queue_rq+0x2af/0xa70 [nvme]
[ 2854.078423] RSP: 0018:ffff881028e43aa8  EFLAGS: 00010246
[ 2854.078464] RAX: 0000000000000001 RBX: ffff88203a238200 RCX: 0000000000000000
[ 2854.078517] RDX: 0000000000000001 RSI: 0000000000000000 RDI: ffff881028e43b50
[ 2854.078570] RBP: ffff881028e43b80 R08: 0000000000000000 R09: ffff881028e43ba8
[ 2854.078622] R10: 0000000000000207 R11: ffff881028e43b10 R12: ffff8810f902b800
[ 2854.078675] R13: 0000000000000000 R14: 0000000000000000 R15: ffff882038de0240
[ 2854.078729] FS:  0000000000000000(0000) GS:ffff88103e600000(0000) knlGS:0000000000000000
[ 2854.078789] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[ 2854.078833] CR2: 0000000000000048 CR3: 00000000019ba000 CR4: 00000000003407f0
[ 2854.078886] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[ 2854.078939] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[ 2854.078991] Stack:
[ 2854.079009]  0000000000000006 ffff881028e43b20 ffffffff810889d4 ffffffff81d384a0
[ 2854.079072]  ffff881000000032 0000000000000026 ffff881028e43be8 ffffffff818ff51c
[ 2854.079134]  0000000000e43b20 0000000000000246 ffff881028e43b30 0000000000000004
[ 2854.079197] Call Trace:
[ 2854.079225]  [<ffffffff810889d4>] ? vprintk_emit+0x3c4/0x510
[ 2854.079274]  [<ffffffff812f89ba>] __blk_mq_run_hw_queue+0x1fa/0x3c0
[ 2854.079325]  [<ffffffff812f8795>] blk_mq_run_hw_queue+0xa5/0xd0
[ 2854.079371]  [<ffffffff812fa0c8>] blk_mq_insert_request+0x98/0x100
[ 2854.079421]  [<ffffffff812f43b3>] blk_execute_rq_nowait+0x73/0x180
[ 2854.079478]  [<ffffffffa00c4c0a>] nvme_timeout+0x1ca/0x1e0 [nvme]
[ 2854.081317]  [<ffffffff812f860f>] blk_mq_rq_timed_out+0x2f/0x80
[ 2854.083128]  [<ffffffff812f86af>] blk_mq_check_expired+0x4f/0x90
[ 2854.084927]  [<ffffffff812fad54>] bt_for_each+0xe4/0xf0
[ 2854.086718]  [<ffffffff812f8660>] ? blk_mq_rq_timed_out+0x80/0x80
[ 2854.088545]  [<ffffffff812fb6ce>] blk_mq_queue_tag_busy_iter+0x4e/0xc0
[ 2854.090334]  [<ffffffff812f8660>] ? blk_mq_rq_timed_out+0x80/0x80
[ 2854.092102]  [<ffffffff812f6ecb>] blk_mq_timeout_work+0x8b/0x180
[ 2854.093879]  [<ffffffff810a805b>] process_one_work+0x17b/0x470
[ 2854.095643]  [<ffffffff810a8e96>] worker_thread+0x126/0x410
[ 2854.097411]  [<ffffffff810a8d70>] ? rescuer_thread+0x460/0x460
[ 2854.099158]  [<ffffffff810b064f>] kthread+0xcf/0xe0
[ 2854.100875]  [<ffffffff810b0580>] ? kthread_create_on_node+0x140/0x140
[ 2854.102599]  [<ffffffff81696618>] ret_from_fork+0x58/0x90
[ 2854.104331]  [<ffffffff810b0580>] ? kthread_create_on_node+0x140/0x140
[ 2854.106028] Code: 00 00 48 83 f9 01 b9 08 00 00 00 f3 48 ab 41 8b 87 10 01 00 00 45 19 c0 83 e2 01 f7 da 41 f7 d0 83 c2 02 41 83 e0 07 66 89 45 92 <41> 8b 46 48 88 55 90 41 8b 56 4c 89 45 94 49 8b 47 68 8d 4a f7
[ 2854.109555] RIP  [<ffffffffa00c382f>] nvme_queue_rq+0x2af/0xa70 [nvme]
[ 2854.111223]  RSP <ffff881028e43aa8>
[ 2854.112822] CR2: 0000000000000048


Version info:

Linux 3.10.0-520.el7_3.bz1392923.1.x86_64 #1 SMP Wed Jan 18 16:22:09 EST 2017 x86_64 x86_64 x86_64 GNU/Linux

> modinfo nvme
filename:       /lib/modules/3.10.0-520.el7_3.bz1392923.1.x86_64/kernel/drivers/nvme/host/nvme.ko
version:        1.0
license:        GPL
author:         Matthew Wilcox <willy at linux.intel.com>
rhelversion:    7.4
srcversion:     80C25968F401246C1527FF3
alias:          pci:v*d*sv*sd*bc01sc08i02*
alias:          pci:v00001C58d00000003sv*sd*bc*sc*i*
alias:          pci:v00008086d00005845sv*sd*bc*sc*i*
alias:          pci:v00008086d00000A54sv*sd*bc*sc*i*
alias:          pci:v00008086d00000A53sv*sd*bc*sc*i*
alias:          pci:v00008086d00000953sv*sd*bc*sc*i*
depends:
intree:         Y
vermagic:       3.10.0-520.el7_3.bz1392923.1.x86_64 SMP mod_unload modversions
signer:         Red Hat Enterprise Linux kernel signing key
sig_key:        E2:7B:67:88:A8:50:97:CB:EE:6D:E4:07:CD:51:61:84:07:C8:79:DA
sig_hashalgo:   sha256
parm:           admin_timeout:timeout in seconds for admin commands (byte)
parm:           io_timeout:timeout in seconds for I/O (byte)
parm:           shutdown_timeout:timeout in seconds for controller shutdown (byte)
parm:           use_threaded_interrupts:int
parm:           use_cmb_sqes:use controller's memory buffer for I/O SQes (bool)
parm:           nvme_major:int
parm:           nvme_char_major:int

Thanks,
John

This communication may contain information that is proprietary, confidential, or exempt from disclosure. If you are not the intended recipient, please note that any other dissemination, distribution, use or copying of this communication is strictly prohibited. Anyone who receives this message in error should notify the sender immediately by telephone or by return e-mail and delete it from his or her computer.
