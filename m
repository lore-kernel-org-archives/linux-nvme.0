From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 13 Jul 2016 10:06:02 -0500
Subject: [PATCH] nvme-fabrics: get ctrl reference in nvmf_dev_write
In-Reply-To: <CAF1ivSZb1kxbhjyooEG+SptaiCgBCkt4YV35PNemL=F6h_arsA@mail.gmail.com>
References: <1468363122-11073-1-git-send-email-mlin@kernel.org>
 <20160713021831.GA7782@lst.de> <1468392841.23662.5.camel@kernel.org>
 <005301d1dd15$3e7769c0$bb663d40$@opengridcomputing.com>
 <CAF1ivSZb1kxbhjyooEG+SptaiCgBCkt4YV35PNemL=F6h_arsA@mail.gmail.com>
Message-ID: <005c01d1dd18$124a0710$36de1530$@opengridcomputing.com>

> On Wed, Jul 13, 2016 at 7:45 AM, Steve Wise <swise at opengridcomputing.com>
> wrote:
> >
> > This change again avoids the first crash, but I still see the __ib_process_cq()
> crash.
> >
> 
> Could you post the call stack?

sure:

[59079.932154] nvme nvme1: Got rdma device removal event, deleting ctrl
[59080.034208] BUG: unable to handle kernel paging request at ffff880f4e6c01f8
[59080.041972] IP: [<ffffffffa02e5a46>] __ib_process_cq+0x46/0xc0 [ib_core]
[59080.049422] PGD 22a5067 PUD 10788d8067 PMD 1078864067 PTE 8000000f4e6c0060
[59080.057109] Oops: 0000 [#1] SMP DEBUG_PAGEALLOC
[59080.062365] Modules linked in: nvme_rdma(E) nvme_fabrics(E) brd iw_cxgb4(-) cxgb4 ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge 8021q mrp garp stp llc cachefiles fscache rdma_ucm rdma_cm iw_cm ib_ipoib ib_cm ib_uverbs ib_umad ocrdma be2net iw_nes libcrc32c iw_cxgb3 cxgb3 mdio ib_qib rdmavt mlx5_ib mlx5_core mlx4_en ib_mthca binfmt_misc dm_mirror dm_region_hash dm_log vhost_net macvtap macvlan vhost tun kvm irqbypass uinput iTCO_wdt iTCO_vendor_support mxm_wmi pcspkr mlx4_ib ib_core mlx4_core dm_mod i2c_i801 sg lpc_ich mfd_core mei_me mei nvme nvme_core igb dca ptp pps_core ipmi_ssif ipmi_si ipmi_msghandler wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) libata(E) mgag200(E) ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E) sysimgblt(E) sysfillrect(E) syscopyarea(E) i2c_algo_bit(E) i2c_core(E) [last unloaded: cxgb4]
[59080.164160] CPU: 0 PID: 14879 Comm: kworker/u64:2 Tainted: G            E   4.7.0-rc2-block-for-next+ #78
[59080.174704] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
[59080.182673] Workqueue: iw_cxgb4 process_work [iw_cxgb4]
[59080.188924] task: ffff8810278646c0 ti: ffff880ff271c000 task.ti: ffff880ff271c000
[59080.197448] RIP: 0010:[<ffffffffa02e5a46>]  [<ffffffffa02e5a46>] __ib_process_cq+0x46/0xc0 [ib_core]
[59080.207647] RSP: 0018:ffff881036e03e48  EFLAGS: 00010282
[59080.214000] RAX: 0000000000000010 RBX: ffff8810203f3508 RCX: 0000000000000000
[59080.222194] RDX: ffff880f4e6c01f8 RSI: ffff880f4e6a1fe8 RDI: ffff8810203f3508
[59080.230393] RBP: ffff881036e03e88 R08: 0000000000000000 R09: 000000000000000c
[59080.238598] R10: 0000000000000000 R11: 00000000000001f8 R12: 0000000000000020
[59080.246800] R13: 0000000000000100 R14: 0000000000000000 R15: 0000000000000000
[59080.255002] FS:  0000000000000000(0000) GS:ffff881036e00000(0000) knlGS:0000000000000000
[59080.264173] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[59080.271013] CR2: ffff880f4e6c01f8 CR3: 000000102105f000 CR4: 00000000000406f0
[59080.279258] Stack:
[59080.282377]  0000000000000000 00000010fcddc1f8 0000000000000246 ffff8810203f3548
[59080.290979]  ffff881036e13630 0000000000000100 ffff8810203f3508 ffff881036e03ed8
[59080.299587]  ffff881036e03eb8 ffffffffa02e5e12 ffff8810203f3548 ffff881036e13630
[59080.308198] Call Trace:
[59080.311779]  <IRQ>
[59080.313731]  [<ffffffffa02e5e12>] ib_poll_handler+0x32/0x80 [ib_core]
[59080.322653]  [<ffffffff81395695>] irq_poll_softirq+0xa5/0xf0
[59080.329484]  [<ffffffff816f186a>] __do_softirq+0xda/0x304
[59080.336047]  [<ffffffff816f15b5>] ? do_IRQ+0x65/0xf0
[59080.342193]  [<ffffffff816f08fc>] do_softirq_own_stack+0x1c/0x30
[59080.349381]  <EOI>
[59080.351351]  [<ffffffff8109004e>] do_softirq+0x4e/0x50
[59080.359018]  [<ffffffff81090127>] __local_bh_enable_ip+0x87/0x90
[59080.366178]  [<ffffffffa081b837>] t4_ofld_send+0x127/0x180 [cxgb4]
[59080.373499]  [<ffffffffa08095ae>] cxgb4_remove_tid+0x9e/0x140 [cxgb4]
[59080.381079]  [<ffffffffa039235c>] _c4iw_free_ep+0x5c/0x100 [iw_cxgb4]
[59080.388665]  [<ffffffffa0396812>] peer_close+0x102/0x260 [iw_cxgb4]
[59080.396082]  [<ffffffffa039629a>] ? process_work+0x5a/0x70 [iw_cxgb4]
[59080.403664]  [<ffffffffa039629a>] ? process_work+0x5a/0x70 [iw_cxgb4]
[59080.411254]  [<ffffffff815c42c4>] ? __kfree_skb+0x34/0x80
[59080.417762]  [<ffffffff815c4437>] ? kfree_skb+0x47/0xb0
[59080.424084]  [<ffffffff815c24e7>] ? skb_dequeue+0x67/0x80
[59080.430569]  [<ffffffffa039628e>] process_work+0x4e/0x70 [iw_cxgb4]
[59080.437940]  [<ffffffff810a4d03>] process_one_work+0x183/0x4d0
[59080.444862]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[59080.451373]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[59080.457506]  [<ffffffff810a59bd>] worker_thread+0x16d/0x530
[59080.464056]  [<ffffffff8102eb1d>] ? __switch_to+0x1cd/0x5e0
[59080.470570]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[59080.476985]  [<ffffffff810ccbc6>] ? __wake_up_common+0x56/0x90
[59080.483696]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[59080.490824]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[59080.496808]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[59080.503892]  [<ffffffff810aa5dc>] kthread+0xcc/0xf0
[59080.509573]  [<ffffffff810b4ffe>] ? schedule_tail+0x1e/0xc0
[59080.515928]  [<ffffffff816eed3f>] ret_from_fork+0x1f/0x40
[59080.522093]  [<ffffffff810aa510>] ? kthread_freezable_should_stop+0x70/0x70
[59080.529826] Code: fb 41 89 f5 48 8b 03 48 8b 53 38 be 10 00 00 00 48 89 df ff 90 f8 01 00 00 85 c0 89 45 cc 7e 6d 45 31 ff 45 31 f6 eb 13 48 89 df <ff> 12 41 83 c6 01 49 83 c7 40 44 3b 75 cc 7d 39 4c 89 fe 48 03
[59080.551475] RIP  [<ffffffffa02e5a46>] __ib_process_cq+0x46/0xc0 [ib_core]
[59080.559080]  RSP <ffff881036e03e48>
[59080.563353] CR2: ffff880f4e6c01f8
[59080.571473] ---[ end trace afbeef34ec235a65 ]---
[59082.226621] Kernel panic - not syncing: Fatal exception in interrupt
[59082.233916] Kernel Offset: disabled
[59082.291862] ---[ end Kernel panic - not syncing: Fatal exception in interrupt
[59082.299031] ------------[ cut here ]------------
[59082.303653] WARNING: CPU: 0 PID: 14879 at arch/x86/kernel/smp.c:125 native_smp_send_reschedule+0x3e/0x40
[59082.313127] Modules linked in: nvme_rdma(E) nvme_fabrics(E) brd iw_cxgb4(-) cxgb4 ip6table_filter ip6_tables ebtable_nat ebtables ipt_MASQUERADE nf_nat_masquerade_ipv4 iptable_nat nf_nat_ipv4 nf_nat nf_conntrack_ipv4 nf_defrag_ipv4 xt_state nf_conntrack ipt_REJECT nf_reject_ipv4 xt_CHECKSUM iptable_mangle iptable_filter ip_tables bridge 8021q mrp garp stp llc cachefiles fscache rdma_ucm rdma_cm iw_cm ib_ipoib ib_cm ib_uverbs ib_umad ocrdma be2net iw_nes libcrc32c iw_cxgb3 cxgb3 mdio ib_qib rdmavt mlx5_ib mlx5_core mlx4_en ib_mthca binfmt_misc dm_mirror dm_region_hash dm_log vhost_net macvtap macvlan vhost tun kvm irqbypass uinput iTCO_wdt iTCO_vendor_support mxm_wmi pcspkr mlx4_ib ib_core mlx4_core dm_mod i2c_i801 sg lpc_ich mfd_core mei_me mei nvme nvme_core igb dca ptp pps_core ipmi_ssif ipmi_si ipmi_msghandler wmi ext4(E) mbcache(E) jbd2(E) sd_mod(E) ahci(E) libahci(E) libata(E) mgag200(E) ttm(E) drm_kms_helper(E) drm(E) fb_sys_fops(E) sysimgblt(E) sysfillrect(E) syscopyarea(E) i2c_algo_bit(E) i2c_core(E) [last unloaded: cxgb4]
[59082.406185] CPU: 0 PID: 14879 Comm: kworker/u64:2 Tainted: G      D     E   4.7.0-rc2-block-for-next+ #78
[59082.415745] Hardware name: Supermicro X9DR3-F/X9DR3-F, BIOS 3.2a 07/09/2015
[59082.422719] Workqueue: iw_cxgb4 process_work [iw_cxgb4]
[59082.427960]  0000000000000000 ffff881036e03790 ffffffff81362aa7 0000000000003a1f
[59082.435413]  0000000000000000 0000000000000000 0000000000000000 ffff881036e037e0
[59082.442877]  ffffffff8108a6cd 0000000000000007 0000007d00000000 ffff881036e037e0
[59082.450342] Call Trace:
[59082.452785]  <IRQ>  [<ffffffff81362aa7>] dump_stack+0x67/0x90
[59082.458591]  [<ffffffff8108a6cd>] __warn+0xfd/0x120
[59082.463481]  [<ffffffff811076d0>] ? tick_nohz_handler+0xb0/0xb0
[59082.469396]  [<ffffffff8108a70d>] warn_slowpath_null+0x1d/0x20
[59082.475222]  [<ffffffff8105278e>] native_smp_send_reschedule+0x3e/0x40
[59082.481751]  [<ffffffff810be627>] trigger_load_balance+0x147/0x200
[59082.487929]  [<ffffffff810bd542>] ? sched_slice+0x52/0xa0
[59082.493322]  [<ffffffff811076d0>] ? tick_nohz_handler+0xb0/0xb0
[59082.499256]  [<ffffffff81187647>] ? perf_event_task_tick+0x77/0xe0
[59082.505432]  [<ffffffff810b2121>] scheduler_tick+0xb1/0xf0
[59082.510934]  [<ffffffff810f5301>] update_process_times+0x51/0x70
[59082.516949]  [<ffffffff81106db7>] tick_sched_handle+0x37/0x70
[59082.522691]  [<ffffffff81107714>] tick_sched_timer+0x44/0x80
[59082.528364]  [<ffffffff810f7d4a>] __run_hrtimer+0x6a/0x200
[59082.533886]  [<ffffffff8144ed88>] ? vt_console_print+0x68/0x380
[59082.539804]  [<ffffffff810f7f47>] __hrtimer_run_queues+0x67/0x90
[59082.545810]  [<ffffffff810d2b16>] ? up+0x36/0x50
[59082.550422]  [<ffffffff810f80fb>] hrtimer_interrupt+0x9b/0x190
[59082.556271]  [<ffffffff810559b9>] local_apic_timer_interrupt+0x39/0x60
[59082.562801]  [<ffffffff816f1771>] smp_apic_timer_interrupt+0x41/0x55
[59082.569147]  [<ffffffff816ef7dc>] apic_timer_interrupt+0x8c/0xa0
[59082.575162]  [<ffffffff8119513d>] ? panic+0x1e5/0x22e
[59082.580208]  [<ffffffff81195139>] ? panic+0x1e1/0x22e
[59082.585283]  [<ffffffff810dfd5b>] ? kmsg_dump+0x9b/0xc0
[59082.590507]  [<ffffffff81032a02>] oops_end+0xe2/0xf0
[59082.595497]  [<ffffffff8106d748>] no_context+0x128/0x200
[59082.600804]  [<ffffffff8106d920>] __bad_area_nosemaphore+0x100/0x1d0
[59082.607151]  [<ffffffff8106da04>] bad_area_nosemaphore+0x14/0x20
[59082.613157]  [<ffffffff8106deef>] __do_page_fault+0x1ef/0x4f0
[59082.618906]  [<ffffffff8106e367>] do_page_fault+0x37/0x90
[59082.624320]  [<ffffffffa0271285>] ? nvme_change_ctrl_state+0x35/0xc0 [nvme_core]
[59082.631708]  [<ffffffff816f0d88>] page_fault+0x28/0x30
[59082.636853]  [<ffffffffa02e5a46>] ? __ib_process_cq+0x46/0xc0 [ib_core]
[59082.643468]  [<ffffffffa02e5a34>] ? __ib_process_cq+0x34/0xc0 [ib_core]
[59082.650083]  [<ffffffffa02e5e12>] ib_poll_handler+0x32/0x80 [ib_core]
[59082.656518]  [<ffffffff81395695>] irq_poll_softirq+0xa5/0xf0
[59082.662169]  [<ffffffff816f186a>] __do_softirq+0xda/0x304
[59082.667563]  [<ffffffff816f15b5>] ? do_IRQ+0x65/0xf0
[59082.672530]  [<ffffffff816f08fc>] do_softirq_own_stack+0x1c/0x30
[59082.678535]  <EOI>  [<ffffffff8109004e>] do_softirq+0x4e/0x50
[59082.684293]  [<ffffffff81090127>] __local_bh_enable_ip+0x87/0x90
[59082.690305]  [<ffffffffa081b837>] t4_ofld_send+0x127/0x180 [cxgb4]
[59082.696484]  [<ffffffffa08095ae>] cxgb4_remove_tid+0x9e/0x140 [cxgb4]
[59082.702925]  [<ffffffffa039235c>] _c4iw_free_ep+0x5c/0x100 [iw_cxgb4]
[59082.709365]  [<ffffffffa0396812>] peer_close+0x102/0x260 [iw_cxgb4]
[59082.715632]  [<ffffffffa039629a>] ? process_work+0x5a/0x70 [iw_cxgb4]
[59082.722072]  [<ffffffffa039629a>] ? process_work+0x5a/0x70 [iw_cxgb4]
[59082.728512]  [<ffffffff815c42c4>] ? __kfree_skb+0x34/0x80
[59082.733913]  [<ffffffff815c4437>] ? kfree_skb+0x47/0xb0
[59082.739138]  [<ffffffff815c24e7>] ? skb_dequeue+0x67/0x80
[59082.744533]  [<ffffffffa039628e>] process_work+0x4e/0x70 [iw_cxgb4]
[59082.750799]  [<ffffffff810a4d03>] process_one_work+0x183/0x4d0
[59082.756633]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[59082.762120]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[59082.767260]  [<ffffffff810a59bd>] worker_thread+0x16d/0x530
[59082.772834]  [<ffffffff8102eb1d>] ? __switch_to+0x1cd/0x5e0
[59082.778407]  [<ffffffff816eaa10>] ? __schedule+0x1f0/0x5b0
[59082.783896]  [<ffffffff810ccbc6>] ? __wake_up_common+0x56/0x90
[59082.789729]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[59082.795996]  [<ffffffff816eaed0>] ? schedule+0x40/0xb0
[59082.801136]  [<ffffffff810a5850>] ? maybe_create_worker+0x120/0x120
[59082.807403]  [<ffffffff810aa5dc>] kthread+0xcc/0xf0
[59082.812276]  [<ffffffff810b4ffe>] ? schedule_tail+0x1e/0xc0
[59082.817850]  [<ffffffff816eed3f>] ret_from_fork+0x1f/0x40
[59082.823251]  [<ffffffff810aa510>] ? kthread_freezable_should_stop+0x70/0x70
[59082.830211] ---[ end trace afbeef34ec235a66 ]---
