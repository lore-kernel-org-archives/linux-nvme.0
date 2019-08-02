From: sagi@grimberg.me (Sagi Grimberg)
Date: Fri, 2 Aug 2019 13:46:26 -0700
Subject: nvmet_tcp: panic out of memory on writes
In-Reply-To: <B33B37937B7F3D4CB878107E305D4916D165B5@ORSMSX104.amr.corp.intel.com>
References: <B33B37937B7F3D4CB878107E305D4916D165B5@ORSMSX104.amr.corp.intel.com>
Message-ID: <7ce3b52b-002a-0bbd-e5cb-17cee8653172@grimberg.me>


> Am seeing the following Panic during 100% 4K write activity on NVMf tcp target since 5.2.1_stable.
> Exposed device (ram_disk or actual nvme disk) target makes no difference.
> Testing shows this occurring back on 5.0.7 as well.

Hi Mark,

Can you run this test with kmemleak on?

> 
> Anyone else see this and working on it, as I dig deeper..
> 
> [? 654.335950] Workqueue: nvmet_tcp_wq nvmet_tcp_io_work [nvmet_tcp]
> [? 654.335951] Call Trace:
> [? 654.335957]? dump_stack+0x5c/0x80
> [? 654.335961]? dump_header+0x51/0x307
> [? 654.335964]? ? try_to_del_timer_sync+0x4d/0x80
> [? 654.335966]? ? oom_unkillable_task+0x94/0xc0
> [? 654.335967]? oom_kill_process.cold.31+0xb/0x10
> [? 654.335968]? out_of_memory+0x1c0/0x490
> [? 654.335971]? __alloc_pages_slowpath+0xc61/0xd40
> [? 654.335974]? ? recalibrate_cpu_khz+0x10/0x10
> [? 654.335977]? ? tcp_rcv_space_adjust+0x1d/0x1c0
> [? 654.335978] ?__alloc_pages_nodemask+0x2db/0x330
> [? 654.335980]? sgl_alloc_order+0xb8/0x160
> [? 654.335982]? nvmet_tcp_map_data+0x7b/0x120 [nvmet_tcp]
> [? 654.335984]? nvmet_tcp_try_recv_pdu+0x2df/0x4f0 [nvmet_tcp]
> [? 654.335986]? ? tcp_sendpage_locked+0x44/0x60
> [? 654.335988]? nvmet_tcp_io_work+0x71/0xa90 [nvmet_tcp]
> [? 654.335992]? process_one_work+0x1a1/0x3a0
> [? 654.335993]? worker_thread+0x30/0x380
> [? 654.335995]? ? pwq_unbound_release_workfn+0xd0/0xd0
> [? 654.335996]? kthread+0x112/0x130
> [? 654.335997]? ? kthread_create_on_node+0x60/0x60
> [? 654.336000]? ret_from_fork+0x35/0x40
> [? 654.336001] Mem-Info:
> [? 654.336013] active_anon:27 inactive_anon:47 isolated_anon:0
> active_file:45 inactive_file:309 isolated_file:0
> unevictable:0 dirty:0 writeback:0 unstable:0
> slab_reclaimable:89975 slab_unreclaimable:63857
> 
> Cheers --- Mark
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 
