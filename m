From: yi.zhang@redhat.com (Yi Zhang)
Date: Sat, 2 Jun 2018 07:25:22 -0400 (EDT)
Subject: [BUG REPORT] reset_controller stress operation lead to kernel NULL
 pointer
In-Reply-To: <1119455866.5604170.1527936593726.JavaMail.zimbra@redhat.com>
Message-ID: <174598543.5605323.1527938722046.JavaMail.zimbra@redhat.com>

Hi

I would like to report a kernel NULL pointer bug with reset_controller stress operation during fio background, here is the reproducer and kernel log, let me know if you need more info

Reproducer:
1. connect to target
2. do fio stress testing background
3. do reset_controller stress test
num=0
while [ $num -lt 100 ];
do
    echo 1 >/sys/block/nvme0n1/device/reset_controller
    ret=$?
    if [ $ret -eq 1 ]; then
        echo "reset_controller operation failed: $num"
        break
    fi
    ((num++))
    sleep 0.5
done

HW:
04:00.0 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]
04:00.1 Infiniband controller: Mellanox Technologies MT27700 Family [ConnectX-4]


Target:
[   90.562051] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8003: link is not ready
[   90.611005] mlx5_core 0000:04:00.1: MLX5E: StrdRq(0) RqSz(1024) StrdSz(512) RxCqeCmprss(0)
[   90.620998] mlx5_core 0000:04:00.1: MLX5E: StrdRq(0) RqSz(1024) StrdSz(512) RxCqeCmprss(0)
[   90.953571] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8003: link is not ready
[   90.964800] IPv6: ADDRCONF(NETDEV_UP): mlx5_ib1.8003: link is not ready
[   90.978598] IPv6: ADDRCONF(NETDEV_CHANGE): mlx5_ib1.8003: link becomes ready
[ 1296.312270] null: module loaded
[ 1296.433612] nvmet: adding nsid 1 to subsystem testnqn
[ 1296.440626] nvmet_rdma: enabling port 2 (172.31.1.92:4420)
[ 1313.304302] nvmet: creating controller 1 for subsystem nqn.2014-08.org.nvmexpress.discovery for NQN nqn.2014-08.org.nvmexpress:uuid:8d2d8eef-dd38-4b2b-bbef-49d95201d83d.
[ 1313.390460] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:8d2d8eef-dd38-4b2b-bbef-49d95201d83d.
[ 1320.424131] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:8d2d8eef-dd38-4b2b-bbef-49d95201d83d.
--snip--
[ 1369.110165] nvmet: creating controller 1 for subsystem testnqn for NQN nqn.2014-08.org.nvmexpress:uuid:8d2d8eef-dd38-4b2b-bbef-49d95201d83d.
[ 1370.069398] mlx5_1ump_cqe:270pid 1960): dump error cqe
[ 1370.076935] 00000000: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1370.085528] 00000010: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1370.094109] 00000020: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
[ 1370.102664] 00000030: 00 00 00 00 00 00 89 14 01 00 0b 8e 04 08 cf d3
[ 1370.111206] nvmet_rdma: SEND for CQE 0x000000002fd63b83 failed with status remote operation error (11).
[ 1370.123061] nvmet: ctrl 1 fatal error occurred!

Host:
[  486.369937] nvme nvme0: new ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery", addr 172.31.1.92:4420
[  486.380175] nvme nvme0: Removing ctrl: NQN "nqn.2014-08.org.nvmexpress.discovery"
[  486.389168] nvme nvme0: Property Set error: 7, offset 0x14
[  486.453361] nvme nvme0: creating 40 I/O queues.
[  487.172879] nvme nvme0: new ctrl: NQN "testnqn", addr 172.31.1.92:4420
[  493.430382] nvme nvme0: Property Set error: 7, offset 0x14
[  493.487198] nvme nvme0: creating 40 I/O queues.
[  495.996666] nvme nvme0: Property Set error: 7, offset 0x14
--snip--
[  542.174885] nvme nvme0: creating 40 I/O queues.
[  543.114917] DMAR: DRHD: handling fault status reg 2
[  543.114961] BUG: unable to handle kernel NULL pointer dereference at 0000000000000014
[  543.121034] DMAR: [DMA Read] Request device [04:00.1] fault addr 8f2c0000 [fault reason 06] PTE Read access is not set
[  543.130346] PGD 0 P4D 0
[  543.146236] Oops: 0000 [#1] SMP PTI
[  543.150673] Modules linked in: nvme_rdma nvme_fabrics nvme_core nvmet_rdma nvmet sch_mqprio ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge 8021q gara
[  543.234603]  sysfillrect sysimgblt fb_sys_fops mlx5_core ttm drm ahci libahci libata crc32c_intel tg3 mlxfw devlink dm_mirror dm_region_hash dm_log dm_mod
[  543.251468] CPU: 30 PID: 0 Comm: swapper/30 Not tainted 4.17.0-rc7 #1
[  543.259388] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.6.2 01/08/2016
[  543.268485] RIP: 0010:__nvme_rdma_recv_done.isra.46+0x1e9/0x350 [nvme_rdma]
[  543.277009] RSP: 0018:ffff98cc7fbc3e40 EFLAGS: 00010202
[  543.283589] RAX: 0000000000000000 RBX: ffff98dc2f7836c0 RCX: 0000000000000024
[  543.292304] RDX: ffff98dc68f91000 RSI: 000000000000003b RDI: ffff98dc6ec21440
[  543.301032] RBP: ffff98bd44327030 R08: 00000000000003ff R09: 0000000000000fc0
[  543.309762] R10: 0000000000000000 R11: 0000000000000000 R12: ffff98ca2a2cd8a0
[  543.318482] R13: ffff98cc7ce10000 R14: ffff98cb54db5e20 R15: ffff98dc78aca400
[  543.327206] FS:  0000000000000000(0000) GS:ffff98cc7fbc0000(0000) knlGS:0000000000000000
[  543.337015] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  543.344207] CR2: 0000000000000014 CR3: 000000139b00a003 CR4: 00000000001606e0
[  543.352959] Call Trace:
[  543.356471]  <IRQ>
[  543.359497]  __ib_process_cq+0x7d/0xd0 [ib_core]
[  543.365436]  ib_poll_handler+0x25/0x70 [ib_core]
[  543.371368]  irq_poll_softirq+0xae/0x110
[  543.376522]  __do_softirq+0xd2/0x280
[  543.381287]  irq_exit+0xd5/0xe0
[  543.385558]  do_IRQ+0x4c/0xd0
[  543.389634]  common_interrupt+0xf/0xf
[  543.394484]  </IRQ>
[  543.397581] RIP: 0010:mwait_idle+0x6c/0x150
[  543.403009] RSP: 0018:ffffa6f2c649feb0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffd8
[  543.412234] RAX: 0000000000000000 RBX: ffff98bd44641700 RCX: 0000000000000000
[  543.420981] RDX: 0000000000000000 RSI: 000000000000001e RDI: ffff98cc7fbe30c0
[  543.429728] RBP: 000000000000001e R08: 0000000000000008 R09: 0000000000000000
[  543.438474] R10: 0000000000000000 R11: 0000000000004406 R12: 0000000000000000
[  543.447214] R13: 0000000000000000 R14: ffff98bd44641700 R15: ffff98bd44641700
[  543.455958]  do_idle+0x1a6/0x290
[  543.460332]  cpu_startup_entry+0x6f/0x80
[  543.465482]  start_secondary+0x1aa/0x200
[  543.470629]  secondary_startup_64+0xa5/0xb0
[  543.476065] Code: e8 bd ec ff ff 44 89 f0 48 8b 4c 24 38 65 48 33 0c 25 28 00 00 00 0f 85 da 00 00 00 48 83 c4 40 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <8b> 50 14 41 39 57 20 0f 8
[  543.498749] RIP: __nvme_rdma_recv_done.isra.46+0x1e9/0x350 [nvme_rdma] RSP: ffff98cc7fbc3e40
[  543.508968] CR2: 0000000000000014
[  543.513447] ---[ end trace b1b498e6cc9d5dae ]---
[  543.513448] BUG: unable to handle kernel NULL pointer dereference at 0000000000000014
[  543.576424] Kernel panic - not syncing: Fatal exception in interrupt
[  543.582845] PGD 0 P4D 0
[  543.594374] Oops: 0000 [#2] SMP PTI
[  543.598998] Modules linked in: nvme_rdma nvme_fabrics nvme_core nvmet_rdma nvmet sch_mqprio ebtable_filter ebtables ip6table_filter ip6_tables iptable_filter bridge 8021q gara
[  543.683696]  sysfillrect sysimgblt fb_sys_fops mlx5_core ttm drm ahci libahci libata crc32c_intel tg3 mlxfw devlink dm_mirror dm_region_hash dm_log dm_mod
[  543.700695] CPU: 33 PID: 0 Comm: swapper/33 Tainted: G      D           4.17.0-rc7 #1
[  543.710223] Hardware name: Dell Inc. PowerEdge R430/03XKDV, BIOS 1.6.2 01/08/2016
[  543.719371] RIP: 0010:__nvme_rdma_recv_done.isra.46+0x1e9/0x350 [nvme_rdma]
[  543.727940] RSP: 0018:ffff98dc7f403e40 EFLAGS: 00010202
[  543.734561] RAX: 0000000000000000 RBX: ffff98dc2f8b36c0 RCX: 0000000000000018
[  543.743333] RDX: ffff98dc68f91000 RSI: 0000000000000065 RDI: ffff98dc6ec21d40
[  543.752101] RBP: ffff98bd44326af0 R08: 00000000000003ff R09: 0000000000000e00
[  543.760862] R10: 0000000000000000 R11: 0000000000000000 R12: ffff98caac6d97f8
[  543.769620] R13: ffff98cc7ce10000 R14: ffff98caac3a0870 R15: ffff98db89f45c00
[  543.778374] FS:  0000000000000000(0000) GS:ffff98dc7f400000(0000) knlGS:0000000000000000
[  543.788212] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  543.795429] CR2: 0000000000000014 CR3: 000000139b00a004 CR4: 00000000001606e0
[  543.804212] Call Trace:
[  543.807755]  <IRQ>
[  543.810816]  __ib_process_cq+0x7d/0xd0 [ib_core]
[  543.816791]  ib_poll_handler+0x25/0x70 [ib_core]
[  543.822763]  irq_poll_softirq+0xae/0x110
[  543.827961]  __do_softirq+0xd2/0x280
[  543.832771]  irq_exit+0xd5/0xe0
[  543.837090]  do_IRQ+0x4c/0xd0
[  543.841206]  common_interrupt+0xf/0xf
[  543.846087]  </IRQ>
[  543.849217] RIP: 0010:mwait_idle+0x6c/0x150
[  543.854678] RSP: 0018:ffffa6f2c64b7eb0 EFLAGS: 00000246 ORIG_RAX: ffffffffffffffdd
[  543.863943] RAX: 0000000000000000 RBX: ffff98ccc4db5c00 RCX: 0000000000000000
[  543.872727] RDX: 0000000000000000 RSI: 0000000000000021 RDI: ffff98dc7f4230c0
[  543.881506] RBP: 0000000000000021 R08: 0000000000000008 R09: 000000000000b000
[  543.890286] R10: 0000000000000021 R11: 0000000000000001 R12: 0000000000000000
[  543.899062] R13: 0000000000000000 R14: ffff98ccc4db5c00 R15: ffff98ccc4db5c00
[  543.907843]  do_idle+0x1a6/0x290
[  543.912239]  cpu_startup_entry+0x6f/0x80
[  543.917396]  start_secondary+0x1aa/0x200
[  543.922539]  secondary_startup_64+0xa5/0xb0
[  543.927960] Code: e8 bd ec ff ff 44 89 f0 48 8b 4c 24 38 65 48 33 0c 25 28 00 00 00 0f 85 da 00 00 00 48 83 c4 40 5b 5d 41 5c 41 5d 41 5e 41 5f c3 <8b> 50 14 41 39 57 20 0f 8
[  543.950611] RIP: __nvme_rdma_recv_done.isra.46+0x1e9/0x350 [nvme_rdma] RSP: ffff98dc7f403e40
[  543.960821] CR2: 0000000000000014
[  543.965292] ---[ end trace b1b498e6cc9d5daf ]---

Best Regards,
  Yi Zhang
