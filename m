From: swise@opengridcomputing.com (Steve Wise)
Date: Fri, 10 Jun 2016 14:17:26 -0500
Subject: nvme-fabrics: crash at nvme connect-all
In-Reply-To: <CAF1ivSb82yM94jande+kfomG3hx6PwbUAzTb3VPNygd05uVbXg@mail.gmail.com>
References: <53708289.31891804.1465463883806.JavaMail.zimbra@kalray.eu>
 <20160609132459.GA5105@infradead.org>
 <1290178000.33062227.1465486654766.JavaMail.zimbra@kalray.eu>
 <04d301d1c28d$183af7b0$48b0e710$@opengridcomputing.com>
 <CAF1ivSb2fvjEzCxWXnrxv_i74SRm2qxWZ-RiKpEaGOx-Dk3f1A@mail.gmail.com>
 <04e301d1c292$d6c34430$8449cc90$@opengridcomputing.com>
 <CAF1ivSYBtsuvm-UO6osPAVT-krpF7iXqWy_8LheyWDDoAdWL1A@mail.gmail.com>
 <055801d1c29f$e164c000$a42e4000$@opengridcomputing.com>
 <01c601d1c32a$59576ec0$0c064c40$@opengridcomputing.com>
 <020b01d1c334$45077f50$cf167df0$@opengridcomputing.com>
 <CAF1ivSb82yM94jande+kfomG3hx6PwbUAzTb3VPNygd05uVbXg@mail.gmail.com>
Message-ID: <023d01d1c34c$b9249bd0$2b6dd370$@opengridcomputing.com>

> I can reproduce this and below patch fixed it.
> [PATCH] nvme-rdma: correctly stop keep alive on error path
> http://lists.infradead.org/pipermail/linux-nvme/2016-June/004931.html
> 
> Could you also give it a try and see if it helps for the crash you saw?


I applied your patch and it does avoid the crash.  So the connect to the target
device via cxgb4 that I setup to fail in ib_alloc_mr(), correctly fails w/o
crashing.   After this connect failure, I tried to connect the same target
device but via another rdma path (mlx4 instead of cxgb4 which was setup to fail)
and got a different failure.  Not sure if this is a regression from your fix or
just another error path problem:

BUG: unable to handle kernel paging request at ffff881027d00e00
IP: [<ffffffffa04c5a49>] nvmf_parse_options+0x369/0x4a0 [nvme_fabrics]
PGD 2237067 PUD 10782d5067 PMD 1078196067 PTE 8000001027d00060
Oops: 0002 [#1] SMP DEBUG_PAGEALLOC
Modules linked in: nvme_rdma nvme_fabrics rdma_ucm rdma_cm iw_cm configfs
iw_cxgb4 cxgb4 ip6table_filter ip6_tables ebtable_nat ebtables nf_conntrack_ipv4
nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM
iptable_mangle iptable_filter ip_tables bridge autofs4 8021q garp stp llc
cachefiles fscache ib_ipoib ib_cm ib_uverbs ib_umad iw_nes libcrc32c iw_cxgb3
cxgb3 mdio ib_qib rdmavt mlx4_en ib_mthca dm_mirror dm_region_hash dm_log
vhost_net macvtap macvlan vhost tun kvm irqbypass uinput iTCO_wdt
iTCO_vendor_support pcspkr mlx4_ib ib_core ipv6 mlx4_core dm_mod sg lpc_ich
mfd_core i2c_i801 nvme nvme_core igb dca ptp pps_core acpi_cpufreq ext4(E)
mbcache(E) jbd2(E) sd_mod(E) nouveau(E) ttm(E) drm_kms_helper(E) drm(E)
fb_sys_fops(E) sysimgblt(E) sysfillrect(E) syscopyarea(E) i2c_algo_bit(E)
i2c_core(E) mxm_wmi(E) video(E) ahci(E) libahci(E) wmi(E) [last unloaded: cxgb4]
CPU: 15 PID: 10527 Comm: nvme Tainted: G            E   4.7.0-rc2-nvmf-all.2+
#42
Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
task: ffff881016754380 ti: ffff880fe95b0000 task.ti: ffff880fe95b0000
RIP: 0010:[<ffffffffa04c5a49>]  [<ffffffffa04c5a49>]
nvmf_parse_options+0x369/0x4a0 [nvme_fabrics]
RSP: 0018:ffff880fe95b3ca8  EFLAGS: 00010246
RAX: 0000000000000001 RBX: ffff88102854a380 RCX: 0000000000000000
RDX: ffff881027d00e00 RSI: ffffffffa04c6549 RDI: ffff880fe95b3ce8
RBP: ffff880fe95b3d28 R08: 000000000000003d R09: ffff8810272c7de0
R10: 0000000000000000 R11: 0000000000000010 R12: ffff880fe95b3ce8
R13: 0000000000000000 R14: ffff88102b1d6b80 R15: ffff880fe95b3cf4
FS:  00007f0264446700(0000) GS:ffff8810775c0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffff881027d00e00 CR3: 0000000fe95b8000 CR4: 00000000000406e0
Stack:
 00000000024080c0 ffff88102b1d6bae ffff88102b1d6bb6 ffff88102b1d6bba
 0000000000000040 0000000000000050 0000000000000001 0000000000000000
 0000000000000000 0000000800000246 ffff881076c13f00 ffff88102b1d6b40
Call Trace:
 [<ffffffffa04c5bc6>] nvmf_create_ctrl+0x46/0x210 [nvme_fabrics]
 [<ffffffffa04c5e3c>] nvmf_dev_write+0xac/0x110 [nvme_fabrics]
 [<ffffffff811d9c24>] __vfs_write+0x34/0x120
 [<ffffffff81002515>] ? trace_event_raw_event_sys_enter+0xb5/0x130
 [<ffffffff811d9dc9>] vfs_write+0xb9/0x130
 [<ffffffff811f9592>] ? __fdget_pos+0x12/0x50
 [<ffffffff811da9b9>] SyS_write+0x59/0xc0
 [<ffffffff81002d6d>] do_syscall_64+0x6d/0x160
 [<ffffffff81642e7c>] entry_SYSCALL64_slow_path+0x25/0x25
Code: 87 39 01 00 00 48 63 f6 48 89 73 28 e9 26 fd ff ff 45 31 ed 48 83 7b 48 00
0f 85 99 fd ff ff 48 8b 15 fc 15 00 00 b8 01 00 00 00 <f0> 0f c1 02 83 c0 01 83
f8 01 7e 1e 48 8b 05 e4 15 00 00 45 31
RIP  [<ffffffffa04c5a49>] nvmf_parse_options+0x369/0x4a0 [nvme_fabrics]
 RSP <ffff880fe95b3ca8>
CR2: ffff881027d00e00
---[ end trace 16c6dd71ae6f4532 ]---
