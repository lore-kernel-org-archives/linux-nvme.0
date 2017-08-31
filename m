From: yizhan@redhat.com (Yi Zhang)
Date: Thu, 31 Aug 2017 00:00:59 -0400 (EDT)
Subject: kernel tried to execute NX-protected page - exploit attempt? (uid:
 0) and kernel BUG observed on 4.13.0-rc7
In-Reply-To: <1054759477.3536176.1504148224403.JavaMail.zimbra@redhat.com>
Message-ID: <625458077.3545624.1504152059580.JavaMail.zimbra@redhat.com>

Hi

I observed one kernel BUG on 4.13.0-rc7, here is the environment/steps/console log.
With below steps I reproduced one time, will try more to find one stable reproducer, let me know if you need more info, thanks.

Environment:
Link layer is mlx5_roce
Connected by switch
Firmware version:
[   13.447246] mlx5_core 0000:04:00.0: firmware version: 12.18.1000
[   14.347008] mlx5_core 0000:04:00.1: firmware version: 12.18.1000
[   15.080944] mlx5_core 0000:05:00.0: firmware version: 14.18.1000
[   15.924917] mlx5_core 0000:05:00.1: firmware version: 14.18.1000

Two servers both installed below Mellanox cards:
04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
05:00.0 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]
05:00.1 Ethernet controller: Mellanox Technologies MT27710 Family [ConnectX-4 Lx]

Steps I used:
1. Setup NVMeoF ROCE RDMA at target side
2. connect the target at client side
3. execute below steps at client side:
#!/bin/bash
fio -filename=/dev/nvme0n1 -iodepth=1 -thread -rw=randwrite -ioengine=psync -bssplit=5k/10:9k/10:13k/10:17k/10:21k/10:25k/10:29k/10:33k/10:37k/10:41k/10 -bs_unaligned -runtime=1200 -size=-group_reporting -name=mytest -numjobs=60 &>/dev/null &
num=0
while [ $num -lt 100 ]
do
        echo "-------------------------------$num"
	echo 1 >/sys/block/nvme0n1/device/reset_controller || exit 1
	((num++))
done 

Console log:
Client:
[   67.144951] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.40.92:4420
[   67.398611] nvme nvme0: creating 40 I/O queues.
[   68.560894] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.40.92:4420
[   80.130132] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1.8005: link becomes ready
[   80.148982] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8005: link is not ready
[   80.158793] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1.8005: link becomes ready
[   80.167100] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1: link becomes ready
[   80.219463] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8005: link is not ready
[   80.227743] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8003: link is not ready
[   80.236516] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8007: link is not ready
[   80.243940] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1: link is not ready
[   80.252185] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1.8003: link becomes ready
[   80.268645] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1: link is not ready
[   80.277100] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1: link becomes ready
[   80.293184] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8003: link is not ready
[   80.302954] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1.8003: link becomes ready
[   80.337096] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1.8007: link becomes ready
[   80.354517] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8007: link is not ready
[   80.364150] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1.8007: link becomes ready
[   80.427098] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1.8005: link becomes ready
rdma-virt-03 login: 

Kernel 4.13.0-rc7 on an x86_64

rdma-virt-03 login: [  134.626661] kernel tried to execute NX-protected page - exploit attempt? (uid: 0)
[  134.635041] BUG: unable to handle kernel paging request at ffff88207d5cb5b8
[  134.642830] IP: 0xffff88207d5cb5b8
[  134.646633] PGD 207fd64067 
[  134.646633] P4D 207fd64067 
[  134.649755] PUD 10fcd9c063 
[  134.652878] PMD 800000207d4001e3 
[  134.656000] 
[  134.661370] Oops: 0011 [#1] SMP
[  134.664882] Modules linked in: nvme_rdma nvme_fabrics nvme_core sch_mqprio ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge 8021q garp mrp stp llc rpcrdr
[  134.744721]  syscopyarea sysfillrect sysimgblt fb_sys_fops ttm mlx5_core drm tg3 mlxfw ahci devlink libahci ptp crc32c_intel libata i2c_core pps_core dm_mirror dm_region_hash dd
[  134.763502] CPU: 25 PID: 2213 Comm: kworker/25:1H Not tainted 4.13.0-rc7 #8
[  134.771291] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.6.2 01/08/2016
[  134.779663] Workqueue: kblockd blk_mq_timeout_work
[  134.785012] task: ffff88207cf0c5c0 task.stack: ffffc90009460000
[  134.791634] RIP: 0010:0xffff88207d5cb5b8
[  134.796022] RSP: 0018:ffffc90009463cb0 EFLAGS: 00010202
[  134.802570] RAX: ffff88207d5cb400 RBX: ffff880f365da440 RCX: ffff88207af00000
[  134.811219] RDX: ffffc90009463cb8 RSI: ffffc90009463cc0 RDI: ffff88207d5cc400
[  134.819863] RBP: ffffc90009463d10 R08: 0000000000000008 R09: 0000000000000000
[  134.828509] R10: 00000000000002ef R11: 00000000000002ee R12: ffff88103eadc000
[  134.837140] R13: ffff88100a920000 R14: ffff88202c8a4000 R15: ffff880f3b295700
[  134.845754] FS:  0000000000000000(0000) GS:ffff88207af00000(0000) knlGS:0000000000000000
[  134.855451] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  134.862513] CR2: ffff88207d5cb5b8 CR3: 0000002039238000 CR4: 00000000001406e0
[  134.871147] Call Trace:
[  134.874547]  ? nvme_rdma_unmap_data+0x126/0x1c0 [nvme_rdma]
[  134.881427]  nvme_rdma_complete_rq+0x1c/0x30 [nvme_rdma]
[  134.888011]  __blk_mq_complete_request+0x90/0x140
[  134.893931]  blk_mq_rq_timed_out+0x66/0x70
[  134.899178]  blk_mq_check_expired+0x37/0x60
[  134.904528]  bt_iter+0x48/0x50
[  134.908652]  blk_mq_queue_tag_busy_iter+0xdd/0x1f0
[  134.914678]  ? blk_mq_rq_timed_out+0x70/0x70
[  134.920128]  ? blk_mq_rq_timed_out+0x70/0x70
[  134.925557]  blk_mq_timeout_work+0x88/0x180
[  134.930889]  process_one_work+0x149/0x360
[  134.936042]  worker_thread+0x4d/0x3c0
[  134.940791]  kthread+0x109/0x140
[  134.945051]  ? rescuer_thread+0x380/0x380
[  134.950189]  ? kthread_park+0x60/0x60
[  134.954954]  ret_from_fork+0x25/0x30
[  134.959605] Code: 88 ff ff 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 40 00 00 00 00 00 00 00 a8 b5 5c 7d 20 88 ff ff a8 b5 5c 7d 20 88 ff ff <b8> b5 5c 7d 20 88 ff ff b8  
[  134.982033] RIP: 0xffff88207d5cb5b8 RSP: ffffc90009463cb0
[  134.988749] CR2: ffff88207d5cb5b8
[  134.993152] ---[ end trace 399dfc3e7e0f9bee ]---
[  135.002359] Kernel panic - not syncing: Fatal exception
[  135.008918] Kernel Offset: disabled
[  135.016612] ---[ end Kernel panic - not syncing: Fatal exception
[  135.024025] sched: Unexpected reschedule of offline CPU#0!
[  135.030834] ------------[ cut here ]------------
[  135.036668] WARNING: CPU: 25 PID: 2213 at arch/x86/kernel/smp.c:128 native_smp_send_reschedule+0x3c/0x40
[  135.047921] Modules linked in: nvme_rdma nvme_fabrics nvme_core sch_mqprio ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge 8021q garp mrp stp llc rpcrdr
[  135.132328]  syscopyarea sysfillrect sysimgblt fb_sys_fops ttm mlx5_core drm tg3 mlxfw ahci devlink libahci ptp crc32c_intel libata i2c_core pps_core dm_mirror dm_region_hash dd
[  135.152485] CPU: 25 PID: 2213 Comm: kworker/25:1H Tainted: G      D         4.13.0-rc7 #8
[  135.162329] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.6.2 01/08/2016
[  135.171409] Workqueue: kblockd blk_mq_timeout_work
[  135.177481] task: ffff88207cf0c5c0 task.stack: ffffc90009460000
[  135.184816] RIP: 0010:native_smp_send_reschedule+0x3c/0x40
[  135.191676] RSP: 0018:ffff88207af03e50 EFLAGS: 00010046
[  135.198242] RAX: 000000000000002e RBX: 0000000000000000 RCX: 0000000000000000
[  135.206958] RDX: 0000000000000000 RSI: ffff88207af0e038 RDI: ffff88207af0e038
[  135.215649] RBP: ffff88207af03e50 R08: 0000000000000000 R09: 00000000000006dd
[  135.224340] R10: 00000000000003ff R11: 0000000000000001 R12: 0000000000000019
[  135.233020] R13: 00000000ffffbfd6 R14: ffff88207cf0c5c0 R15: ffff88207af14368
[  135.241705] FS:  0000000000000000(0000) GS:ffff88207af00000(0000) knlGS:0000000000000000
[  135.251469] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  135.258601] CR2: ffff88207d5cb5b8 CR3: 0000002039238000 CR4: 00000000001406e0
[  135.267303] Call Trace:
[  135.270752]  <IRQ>
[  135.273721]  trigger_load_balance+0x10e/0x1f0
[  135.279307]  scheduler_tick+0xab/0xe0
[  135.284118]  ? tick_sched_do_timer+0x70/0x70
[  135.289614]  update_process_times+0x47/0x60
[  135.295018]  tick_sched_handle+0x2d/0x60
[  135.300127]  tick_sched_timer+0x39/0x70
[  135.305135]  __hrtimer_run_queues+0xe5/0x230
[  135.310631]  hrtimer_interrupt+0xa8/0x1a0
[  135.315836]  local_apic_timer_interrupt+0x35/0x60
[  135.321827]  smp_apic_timer_interrupt+0x38/0x50
[  135.327651]  apic_timer_interrupt+0x93/0xa0
[  135.333059] RIP: 0010:panic+0x1fd/0x245
[  135.338056] RSP: 0018:ffffc90009463a00 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff10
[  135.347225] RAX: 0000000000000034 RBX: 0000000000000000 RCX: 0000000000000006
[  135.355903] RDX: 0000000000000000 RSI: 0000000000000096 RDI: ffff88207af0e030
[  135.364593] RBP: ffffc90009463a70 R08: 0000000000000000 R09: 00000000000006dc
[  135.373276] R10: 00000000000003ff R11: 0000000000000001 R12: ffffffff81a2e220
[  135.381956] R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000046
[  135.390633]  </IRQ>
[  135.393673]  oops_end+0xb8/0xd0
[  135.397873]  no_context+0x19e/0x3f0
[  135.402487]  __bad_area_nosemaphore+0xee/0x1d0
[  135.408137]  bad_area_nosemaphore+0x14/0x20
[  135.413480]  __do_page_fault+0x89/0x4a0
[  135.418407]  do_page_fault+0x30/0x80
[  135.423021]  page_fault+0x28/0x30
[  135.427322] RIP: 0010:0xffff88207d5cb5b8
[  135.432300] RSP: 0018:ffffc90009463cb0 EFLAGS: 00010202
[  135.438707] RAX: ffff88207d5cb400 RBX: ffff880f365da440 RCX: ffff88207af00000
[  135.447229] RDX: ffffc90009463cb8 RSI: ffffc90009463cc0 RDI: ffff88207d5cc400
[  135.455731] RBP: ffffc90009463d10 R08: 0000000000000008 R09: 0000000000000000
[  135.464220] R10: 00000000000002ef R11: 00000000000002ee R12: ffff88103eadc000
[  135.472703] R13: ffff88100a920000 R14: ffff88202c8a4000 R15: ffff880f3b295700
[  135.481185]  ? nvme_rdma_unmap_data+0x126/0x1c0 [nvme_rdma]
[  135.487911]  ? nvme_rdma_complete_rq+0x1c/0x30 [nvme_rdma]
[  135.494535]  ? __blk_mq_complete_request+0x90/0x140
[  135.500481]  ? blk_mq_rq_timed_out+0x66/0x70
[  135.505754]  ? blk_mq_check_expired+0x37/0x60
[  135.511109]  ? bt_iter+0x48/0x50
[  135.515206]  ? blk_mq_queue_tag_busy_iter+0xdd/0x1f0
[  135.521233]  ? blk_mq_rq_timed_out+0x70/0x70
[  135.526489]  ? blk_mq_rq_timed_out+0x70/0x70
[  135.531724]  ? blk_mq_timeout_work+0x88/0x180
[  135.537081]  ? process_one_work+0x149/0x360
[  135.542199]  ? worker_thread+0x4d/0x3c0
[  135.546925]  ? kthread+0x109/0x140
[  135.551163]  ? rescuer_thread+0x380/0x380
[  135.556101]  ? kthread_park+0x60/0x60
[  135.560629]  ? ret_from_fork+0x25/0x30
[  135.565252] Code: dc 00 0f 92 c0 84 c0 74 14 48 8b 05 3f 43 aa 00 be fd 00 00 00 ff 90 a0 00 00 00 5d c3 89 fe 48 c7 c7 e0 50 a3 81 e8 c7 f1 0b 00 <0f> ff 5d c3 0f 1f 44 00 00  
[  135.587290] ---[ end trace 399dfc3e7e0f9bef ]---


Target:
[   96.887568] null: module loaded
[   97.063749] nvmet: adding nsid 1 to subsystem testnqn
[   97.070033] nvmet_rdma: enabling port 2 (172.31.40.92:4420)
[  100.990739] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:00000000-0000-0000-0000-000000000000.
[  101.135413] nvmet_rdma: freeing queue 0
[  101.248275] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:NVMf:uuid:00000000-0000-0000-0000-000000000000.
[  102.216999] nvmet: adding queue 1 to ctrl 1.
[  102.221957] nvmet: adding queue 2 to ctrl 1.
[  102.226938] nvmet: adding queue 3 to ctrl 1.
[  102.231925] nvmet: adding queue 4 to ctrl 1.
[  102.236914] nvmet: adding queue 5 to ctrl 1.
[  102.241905] nvmet: adding queue 6 to ctrl 1.
[  102.246852] nvmet: adding queue 7 to ctrl 1.
[  102.251837] nvmet: adding queue 8 to ctrl 1.
[  102.256821] nvmet: adding queue 9 to ctrl 1.
[  102.261798] nvmet: adding queue 10 to ctrl 1.
[  102.266848] nvmet: adding queue 11 to ctrl 1.
[  102.271922] nvmet: adding queue 12 to ctrl 1.
[  102.277009] nvmet: adding queue 13 to ctrl 1.
[  102.282097] nvmet: adding queue 14 to ctrl 1.
[  102.287143] nvmet: adding queue 15 to ctrl 1.
[  102.292225] nvmet: adding queue 16 to ctrl 1.
[  102.297267] nvmet: adding queue 17 to ctrl 1.
[  102.302302] nvmet: adding queue 18 to ctrl 1.
[  102.307337] nvmet: adding queue 19 to ctrl 1.
[  102.312863] nvmet: adding queue 20 to ctrl 1.
[  102.318307] nvmet: adding queue 21 to ctrl 1.
[  102.323746] nvmet: adding queue 22 to ctrl 1.
[  102.329182] nvmet: adding queue 23 to ctrl 1.
[  102.334580] nvmet: adding queue 24 to ctrl 1.
[  102.339968] nvmet: adding queue 25 to ctrl 1.
[  102.345352] nvmet: adding queue 26 to ctrl 1.
[  102.350704] nvmet: adding queue 27 to ctrl 1.
[  102.356085] nvmet: adding queue 28 to ctrl 1.
[  102.361476] nvmet: adding queue 29 to ctrl 1.
[  102.366825] nvmet: adding queue 30 to ctrl 1.
[  102.372163] nvmet: adding queue 31 to ctrl 1.
[  102.377507] nvmet: adding queue 32 to ctrl 1.
[  102.382848] nvmet: adding queue 33 to ctrl 1.
[  102.388188] nvmet: adding queue 34 to ctrl 1.
[  102.393530] nvmet: adding queue 35 to ctrl 1.
[  102.398843] nvmet: adding queue 36 to ctrl 1.
[  102.404181] nvmet: adding queue 37 to ctrl 1.
[  102.409527] nvmet: adding queue 38 to ctrl 1.
[  102.414824] nvmet: adding queue 39 to ctrl 1.
[  102.420114] nvmet: adding queue 40 to ctrl 1.
[  107.163731] nvmet_rdma: freeing queue 1
[  107.168970] nvmet_rdma: freeing queue 2
[  107.174192] nvmet_rdma: freeing queue 3
[  107.179808] nvmet_rdma: freeing queue 4
[  107.185071] nvmet_rdma: freeing queue 5
[  107.190711] nvmet_rdma: freeing queue 6
[  107.196290] nvmet_rdma: freeing queue 7
[  107.201982] nvmet_rdma: freeing queue 8
[  107.208189] nvmet_rdma: freeing queue 9
[  107.214422] nvmet_rdma: freeing queue 10
[  107.220631] nvmet_rdma: freeing queue 11
[  107.226614] nvmet_rdma: freeing queue 12
[  107.232042] nvmet_rdma: freeing queue 13
[  107.238307] nvmet_rdma: freeing queue 14
[  107.245026] nvmet_rdma: freeing queue 15
[  107.251648] nvmet_rdma: freeing queue 16
[  107.257900] nvmet_rdma: freeing queue 17
[  107.264060] nvmet_rdma: freeing queue 18
[  107.270341] nvmet_rdma: freeing queue 19
[  107.276352] nvmet_rdma: freeing queue 20
[  107.282254] nvmet_rdma: freeing queue 21
[  107.288368] nvmet_rdma: freeing queue 22
[  107.293646] nvmet_rdma: freeing queue 23
[  107.299908] nvmet_rdma: freeing queue 24
[  107.322134] nvmet_rdma: freeing queue 25
[  107.328177] nvmet_rdma: freeing queue 26
[  107.334114] nvmet_rdma: freeing queue 27
[  107.340417] nvmet_rdma: freeing queue 28
[  107.346548] nvmet_rdma: freeing queue 29
[  107.352201] nvmet_rdma: freeing queue 30
[  107.358351] nvmet_rdma: freeing queue 31
[  107.365128] nvmet_rdma: freeing queue 32
[  107.371169] nvmet_rdma: freeing queue 33
[  107.377300] nvmet_rdma: freeing queue 34
[  107.383723] nvmet_rdma: freeing queue 35
[  107.390642] nvmet_rdma: freeing queue 36
[  107.397143] nvmet_rdma: freeing queue 37
[  107.402630] nvmet_rdma: freeing queue 38
[  107.409141] nvmet_rdma: freeing queue 39
[  107.414772] nvmet_rdma: freeing queue 40
[  107.441390] nvmet: got io cmd 6 while CC.EN == 0 on qid = 0
[  107.449412] nvmet_rdma: freeing queue 0



Best Regards,
  Yi Zhang
