From: thomas@fjellstrom.ca (Thomas Fjellstrom)
Date: Sun, 05 Mar 2017 23:11:45 -0700
Subject: nvme, allocation failures, and aborted commands
In-Reply-To: <1898554.3jK49l1AhF@natasha>
References: <2324331.vgmPNSfijK@natasha> <1898554.3jK49l1AhF@natasha>
Message-ID: <24015519.RaUGNvtkS7@natasha>

Tonight I decided to try kernel 4.11-rc1. Still getting page allocation
failures and aborted nvme commands once iozone gets to the fwrite/fread
testing.

The taint seems to be comming from previos warnings from the radeon kernel 
driver.

Its a pretty simple: iozone -a -s 64G  run. 

new log:

[ 5710.312195] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.312202] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5710.312208] CPU: 1 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5710.312209] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.312214] Workqueue: writeback wb_workfn (flush-259:0)
[ 5710.312217] Call Trace:
[ 5710.312223]  dump_stack+0x4f/0x73
[ 5710.312225]  warn_alloc+0xde/0x170
[ 5710.312227]  ? wake_all_kswapds+0x60/0xa0
[ 5710.312229]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.312232]  ? __inc_zone_state+0x42/0xb0
[ 5710.312235]  ? preempt_count_add+0xa3/0xc0
[ 5710.312236]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.312239]  alloc_pages_current+0x90/0x140
[ 5710.312241]  kmalloc_order_trace+0x29/0xf0
[ 5710.312243]  ? alloc_pages_current+0x90/0x140
[ 5710.312245]  __kmalloc+0x17a/0x1a0
[ 5710.312250]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.312253]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5710.312255]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5710.312256]  ? blk_mq_get_tag+0x82/0x2b0
[ 5710.312258]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5710.312260]  blk_mq_make_request+0x1ef/0x750
[ 5710.312261]  ? preempt_count_add+0x7c/0xc0
[ 5710.312264]  generic_make_request+0xcf/0x1d0
[ 5710.312265]  submit_bio+0x6e/0x150
[ 5710.312267]  ? bio_alloc_bioset+0x14b/0x240
[ 5710.312293]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5710.312304]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5710.312306]  write_cache_pages+0x1ec/0x4c0
[ 5710.312317]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5710.312329]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5710.312331]  do_writepages+0x19/0x30
[ 5710.312333]  __writeback_single_inode+0x40/0x390
[ 5710.312334]  ? preempt_count_add+0xa3/0xc0
[ 5710.312336]  writeback_sb_inodes+0x23a/0x4b0
[ 5710.312338]  __writeback_inodes_wb+0x8d/0xc0
[ 5710.312339]  wb_writeback+0x269/0x310
[ 5710.312341]  wb_workfn+0x2cc/0x410
[ 5710.312344]  process_one_work+0x1ee/0x4a0
[ 5710.312345]  worker_thread+0x43/0x4e0
[ 5710.312347]  kthread+0xfc/0x130
[ 5710.312349]  ? process_one_work+0x4a0/0x4a0
[ 5710.312350]  ? kthread_create_on_node+0x40/0x40
[ 5710.312353]  ret_from_fork+0x29/0x40
[ 5710.312355] Mem-Info:
[ 5710.312360] active_anon:962990 inactive_anon:211344 isolated_anon:0
                active_file:5594799 inactive_file:848622 isolated_file:0
                unevictable:16 dirty:148523 writeback:1002759 unstable:0
                slab_reclaimable:193950 slab_unreclaimable:25191
                mapped:160431 shmem:96884 pagetables:25000 bounce:0
                free:288990 free_pcp:2051 free_cma:0
[ 5710.312365] Node 0 active_anon:3851960kB inactive_anon:845376kB active_file:22379196kB inactive_file:3394488kB unevictable:64kB isolated(anon):0kB isolated(file):0kB mapped:641724kB dirty:594092kB writeback:4011036kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 706560kB anon_thp: 387536kB writeback_tmp:0kB unstable:0kB pages_scanned:96 all_unreclaimable? no
[ 5710.312366] Node 0 DMA free:15864kB min:32kB low:44kB high:56kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15892kB mlocked:0kB slab_reclaimable:0kB slab_unreclaimable:28kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 5710.312369] lowmem_reserve[]: 0 2881 32048 32048
[ 5710.312373] Node 0 DMA32 free:218832kB min:6072kB low:9020kB high:11968kB active_anon:286356kB inactive_anon:21876kB active_file:1994124kB inactive_file:335592kB unevictable:0kB writepending:422296kB present:3040380kB managed:3027140kB mlocked:0kB slab_reclaimable:108612kB slab_unreclaimable:10556kB kernel_stack:432kB pagetables:1964kB bounce:0kB free_pcp:4948kB local_pcp:612kB free_cma:0kB
[ 5710.312376] lowmem_reserve[]: 0 0 29166 29166
[ 5710.312380] Node 0 Normal free:921264kB min:61476kB low:91340kB high:121204kB active_anon:3565896kB inactive_anon:823500kB active_file:20384956kB inactive_file:3059052kB unevictable:64kB writepending:4182152kB present:30392316kB managed:29866764kB mlocked:64kB slab_reclaimable:667188kB slab_unreclaimable:90180kB kernel_stack:19744kB pagetables:98036kB bounce:0kB free_pcp:3252kB local_pcp:204kB free_cma:0kB
[ 5710.312383] lowmem_reserve[]: 0 0 0 0
[ 5710.312387] Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 1*32kB (U) 3*64kB (U) 2*128kB (U) 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15864kB
[ 5710.312399] Node 0 DMA32: 43286*4kB (UMEH) 5795*8kB (UMEH) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 219504kB
[ 5710.312409] Node 0 Normal: 184880*4kB (UMEH) 22657*8kB (UMEH) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 920776kB
[ 5710.312420] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[ 5710.312421] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[ 5710.312422] 6540642 total pagecache pages
[ 5710.312424] 0 pages in swap cache
[ 5710.312425] Swap cache stats: add 359, delete 359, find 0/0
[ 5710.312425] Free swap  = 6956796kB
[ 5710.312426] Total swap = 6959100kB
[ 5710.312427] 8362173 pages RAM
[ 5710.312427] 0 pages HighMem/MovableOnly
[ 5710.312428] 134724 pages reserved
[ 5710.312429] 0 pages cma reserved
[ 5710.312435] kworker/1:4H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.312438] kworker/1:4H cpuset=/ mems_allowed=0
[ 5710.312441] CPU: 1 PID: 18262 Comm: kworker/1:4H Tainted: G        W       4.11.0-rc1 #2
[ 5710.312442] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.312444] Workqueue: kblockd blk_mq_run_work_fn
[ 5710.312446] Call Trace:
[ 5710.312448]  dump_stack+0x4f/0x73
[ 5710.312450]  warn_alloc+0xde/0x170
[ 5710.312452]  ? wake_all_kswapds+0x60/0xa0
[ 5710.312454]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.312456]  ? cpuacct_charge+0x75/0x90
[ 5710.312458]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.312460]  alloc_pages_current+0x90/0x140
[ 5710.312462]  kmalloc_order_trace+0x29/0xf0
[ 5710.312464]  __kmalloc+0x17a/0x1a0
[ 5710.312466]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.312468]  ? find_next_bit+0xb/0x10
[ 5710.312470]  ? cpumask_next_and+0x2b/0x40
[ 5710.312472]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5710.312474]  blk_mq_sched_dispatch_requests+0x161/0x170
[ 5710.312476]  ? _raw_spin_unlock_irq+0x12/0x30
[ 5710.312478]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5710.312480]  blk_mq_run_work_fn+0xd/0x10
[ 5710.312481]  process_one_work+0x1ee/0x4a0
[ 5710.312483]  worker_thread+0x43/0x4e0
[ 5710.312485]  kthread+0xfc/0x130
[ 5710.312487]  ? process_one_work+0x4a0/0x4a0
[ 5710.312488]  ? kthread_create_on_node+0x40/0x40
[ 5710.312490]  ret_from_fork+0x29/0x40
[ 5710.312493] kworker/1:4H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.312497] kworker/1:4H cpuset=/ mems_allowed=0
[ 5710.312500] CPU: 1 PID: 18262 Comm: kworker/1:4H Tainted: G        W       4.11.0-rc1 #2
[ 5710.312501] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.312503] Workqueue: kblockd blk_mq_run_work_fn
[ 5710.312504] Call Trace:
[ 5710.312506]  dump_stack+0x4f/0x73
[ 5710.312507]  warn_alloc+0xde/0x170
[ 5710.312509]  ? wake_all_kswapds+0x60/0xa0
[ 5710.312510]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.312513]  ? cpuacct_charge+0x75/0x90
[ 5710.312514]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.312516]  alloc_pages_current+0x90/0x140
[ 5710.312518]  kmalloc_order_trace+0x29/0xf0
[ 5710.312520]  ? __kmalloc+0x17a/0x1a0
[ 5710.312521]  __kmalloc+0x17a/0x1a0
[ 5710.312523]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.312525]  ? insert_work+0x4a/0xc0
[ 5710.312526]  ? preempt_count_add+0xa3/0xc0
[ 5710.312528]  ? _raw_spin_unlock+0x11/0x30
[ 5710.312530]  ? __queue_work+0x16a/0x4a0
[ 5710.312532]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5710.312534]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5710.312536]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5710.312538]  blk_mq_run_work_fn+0xd/0x10
[ 5710.312540]  process_one_work+0x1ee/0x4a0
[ 5710.312542]  worker_thread+0x43/0x4e0
[ 5710.312543]  kthread+0xfc/0x130
[ 5710.312545]  ? process_one_work+0x4a0/0x4a0
[ 5710.312546]  ? kthread_create_on_node+0x40/0x40
[ 5710.312548]  ret_from_fork+0x29/0x40
[ 5710.312812] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.312815] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5710.312818] CPU: 1 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5710.312821] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.312822] Workqueue: writeback wb_workfn (flush-259:0)
[ 5710.312824] Call Trace:
[ 5710.312826]  dump_stack+0x4f/0x73
[ 5710.312827]  warn_alloc+0xde/0x170
[ 5710.312829]  ? wake_all_kswapds+0x60/0xa0
[ 5710.312830]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.312833]  ? __inc_zone_state+0x42/0xb0
[ 5710.312835]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.312837]  alloc_pages_current+0x90/0x140
[ 5710.312840]  kmalloc_order_trace+0x29/0xf0
[ 5710.312842]  ? alloc_pages_current+0x90/0x140
[ 5710.312843]  __kmalloc+0x17a/0x1a0
[ 5710.312846]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.312847]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5710.312849]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5710.312850]  ? blk_mq_get_tag+0x82/0x2b0
[ 5710.312852]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5710.312854]  blk_mq_make_request+0x1ef/0x750
[ 5710.312855]  ? preempt_count_add+0x7c/0xc0
[ 5710.312859]  generic_make_request+0xcf/0x1d0
[ 5710.312861]  submit_bio+0x6e/0x150
[ 5710.312862]  ? bio_alloc_bioset+0x14b/0x240
[ 5710.312873]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5710.312884]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5710.312889]  write_cache_pages+0x1ec/0x4c0
[ 5710.312902]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5710.312915]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5710.312920]  do_writepages+0x19/0x30
[ 5710.312922]  __writeback_single_inode+0x40/0x390
[ 5710.312923]  ? preempt_count_add+0xa3/0xc0
[ 5710.312925]  writeback_sb_inodes+0x23a/0x4b0
[ 5710.312927]  __writeback_inodes_wb+0x8d/0xc0
[ 5710.312929]  wb_writeback+0x269/0x310
[ 5710.312931]  wb_workfn+0x2cc/0x410
[ 5710.312935]  process_one_work+0x1ee/0x4a0
[ 5710.312937]  worker_thread+0x43/0x4e0
[ 5710.312939]  kthread+0xfc/0x130
[ 5710.312941]  ? process_one_work+0x4a0/0x4a0
[ 5710.312944]  ? kthread_create_on_node+0x40/0x40
[ 5710.312946]  ret_from_fork+0x29/0x40
[ 5710.312953] kworker/1:4H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.312957] kworker/1:4H cpuset=/ mems_allowed=0
[ 5710.312963] CPU: 1 PID: 18262 Comm: kworker/1:4H Tainted: G        W       4.11.0-rc1 #2
[ 5710.312964] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.312966] Workqueue: kblockd blk_mq_run_work_fn
[ 5710.312968] Call Trace:
[ 5710.312971]  dump_stack+0x4f/0x73
[ 5710.312973]  warn_alloc+0xde/0x170
[ 5710.312975]  ? wake_all_kswapds+0x60/0xa0
[ 5710.312978]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.312981]  ? cpuacct_charge+0x75/0x90
[ 5710.312984]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.312987]  alloc_pages_current+0x90/0x140
[ 5710.312988]  kmalloc_order_trace+0x29/0xf0
[ 5710.312990]  ? __kmalloc+0x17a/0x1a0
[ 5710.312993]  __kmalloc+0x17a/0x1a0
[ 5710.312995]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.312997]  ? insert_work+0x4a/0xc0
[ 5710.312999]  ? preempt_count_add+0xa3/0xc0
[ 5710.313002]  ? _raw_spin_unlock+0x11/0x30
[ 5710.313006]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5710.313008]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5710.313011]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5710.313013]  blk_mq_run_work_fn+0xd/0x10
[ 5710.313016]  process_one_work+0x1ee/0x4a0
[ 5710.313018]  worker_thread+0x43/0x4e0
[ 5710.313020]  kthread+0xfc/0x130
[ 5710.313024]  ? process_one_work+0x4a0/0x4a0
[ 5710.313025]  ? kthread_create_on_node+0x40/0x40
[ 5710.313028]  ret_from_fork+0x29/0x40
[ 5710.313382] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.313387] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5710.313390] CPU: 1 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5710.313391] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.313393] Workqueue: writeback wb_workfn (flush-259:0)
[ 5710.313397] Call Trace:
[ 5710.313399]  dump_stack+0x4f/0x73
[ 5710.313401]  warn_alloc+0xde/0x170
[ 5710.313403]  ? wake_all_kswapds+0x60/0xa0
[ 5710.313406]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.313409]  ? __inc_zone_state+0x42/0xb0
[ 5710.313411]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.313415]  alloc_pages_current+0x90/0x140
[ 5710.313417]  kmalloc_order_trace+0x29/0xf0
[ 5710.313419]  ? alloc_pages_current+0x90/0x140
[ 5710.313421]  __kmalloc+0x17a/0x1a0
[ 5710.313424]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.313426]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5710.313428]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5710.313430]  ? blk_mq_get_tag+0x82/0x2b0
[ 5710.313436]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5710.313437]  blk_mq_make_request+0x1ef/0x750
[ 5710.313439]  ? preempt_count_add+0x7c/0xc0
[ 5710.313442]  generic_make_request+0xcf/0x1d0
[ 5710.313444]  submit_bio+0x6e/0x150
[ 5710.313445]  ? bio_alloc_bioset+0x14b/0x240
[ 5710.313460]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5710.313473]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5710.313476]  write_cache_pages+0x1ec/0x4c0
[ 5710.313490]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5710.313504]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5710.313509]  do_writepages+0x19/0x30
[ 5710.313511]  __writeback_single_inode+0x40/0x390
[ 5710.313512]  ? preempt_count_add+0xa3/0xc0
[ 5710.313514]  writeback_sb_inodes+0x23a/0x4b0
[ 5710.313517]  __writeback_inodes_wb+0x8d/0xc0
[ 5710.313519]  wb_writeback+0x269/0x310
[ 5710.313521]  wb_workfn+0x2cc/0x410
[ 5710.313524]  process_one_work+0x1ee/0x4a0
[ 5710.313526]  worker_thread+0x43/0x4e0
[ 5710.313529]  kthread+0xfc/0x130
[ 5710.313531]  ? process_one_work+0x4a0/0x4a0
[ 5710.313533]  ? kthread_create_on_node+0x40/0x40
[ 5710.313535]  ret_from_fork+0x29/0x40
[ 5710.313542] kworker/1:4H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.313546] kworker/1:4H cpuset=/ mems_allowed=0
[ 5710.313549] CPU: 1 PID: 18262 Comm: kworker/1:4H Tainted: G        W       4.11.0-rc1 #2
[ 5710.313550] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.313552] Workqueue: kblockd blk_mq_run_work_fn
[ 5710.313556] Call Trace:
[ 5710.313559]  dump_stack+0x4f/0x73
[ 5710.313561]  warn_alloc+0xde/0x170
[ 5710.313563]  ? wake_all_kswapds+0x60/0xa0
[ 5710.313566]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.313569]  ? cpuacct_charge+0x75/0x90
[ 5710.313571]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.313573]  alloc_pages_current+0x90/0x140
[ 5710.313575]  kmalloc_order_trace+0x29/0xf0
[ 5710.313577]  ? __kmalloc+0x17a/0x1a0
[ 5710.313579]  __kmalloc+0x17a/0x1a0
[ 5710.313582]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.313584]  ? insert_work+0x4a/0xc0
[ 5710.313585]  ? preempt_count_add+0xa3/0xc0
[ 5710.313588]  ? _raw_spin_unlock+0x11/0x30
[ 5710.313592]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5710.313594]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5710.313596]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5710.313599]  blk_mq_run_work_fn+0xd/0x10
[ 5710.313601]  process_one_work+0x1ee/0x4a0
[ 5710.313603]  worker_thread+0x43/0x4e0
[ 5710.313605]  kthread+0xfc/0x130
[ 5710.313607]  ? process_one_work+0x4a0/0x4a0
[ 5710.313609]  ? kthread_create_on_node+0x40/0x40
[ 5710.313613]  ret_from_fork+0x29/0x40
[ 5710.313965] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.313970] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5710.313974] CPU: 1 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5710.313975] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.313978] Workqueue: writeback wb_workfn (flush-259:0)
[ 5710.313981] Call Trace:
[ 5710.313983]  dump_stack+0x4f/0x73
[ 5710.313985]  warn_alloc+0xde/0x170
[ 5710.313989]  ? wake_all_kswapds+0x60/0xa0
[ 5710.313991]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.313994]  ? __inc_zone_state+0x42/0xb0
[ 5710.313997]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.313999]  alloc_pages_current+0x90/0x140
[ 5710.314001]  kmalloc_order_trace+0x29/0xf0
[ 5710.314004]  ? alloc_pages_current+0x90/0x140
[ 5710.314008]  __kmalloc+0x17a/0x1a0
[ 5710.314010]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.314012]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5710.314014]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5710.314016]  ? blk_mq_get_tag+0x82/0x2b0
[ 5710.314018]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5710.314022]  blk_mq_make_request+0x1ef/0x750
[ 5710.314024]  ? preempt_count_add+0x7c/0xc0
[ 5710.314026]  generic_make_request+0xcf/0x1d0
[ 5710.314028]  submit_bio+0x6e/0x150
[ 5710.314030]  ? bio_alloc_bioset+0x14b/0x240
[ 5710.314044]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5710.314058]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5710.314061]  write_cache_pages+0x1ec/0x4c0
[ 5710.314074]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5710.314089]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5710.314093]  do_writepages+0x19/0x30
[ 5710.314095]  __writeback_single_inode+0x40/0x390
[ 5710.314097]  ? preempt_count_add+0xa3/0xc0
[ 5710.314101]  writeback_sb_inodes+0x23a/0x4b0
[ 5710.314103]  __writeback_inodes_wb+0x8d/0xc0
[ 5710.314105]  wb_writeback+0x269/0x310
[ 5710.314108]  wb_workfn+0x2cc/0x410
[ 5710.314113]  process_one_work+0x1ee/0x4a0
[ 5710.314115]  worker_thread+0x43/0x4e0
[ 5710.314117]  kthread+0xfc/0x130
[ 5710.314119]  ? process_one_work+0x4a0/0x4a0
[ 5710.314122]  ? kthread_create_on_node+0x40/0x40
[ 5710.314125]  ret_from_fork+0x29/0x40
[ 5710.314132] kworker/1:4H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.314136] kworker/1:4H cpuset=/ mems_allowed=0
[ 5710.314140] CPU: 1 PID: 18262 Comm: kworker/1:4H Tainted: G        W       4.11.0-rc1 #2
[ 5710.314141] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.314145] Workqueue: kblockd blk_mq_run_work_fn
[ 5710.314147] Call Trace:
[ 5710.314149]  dump_stack+0x4f/0x73
[ 5710.314151]  warn_alloc+0xde/0x170
[ 5710.314154]  ? wake_all_kswapds+0x60/0xa0
[ 5710.314156]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.314159]  ? cpuacct_charge+0x75/0x90
[ 5710.314161]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.314163]  alloc_pages_current+0x90/0x140
[ 5710.314167]  kmalloc_order_trace+0x29/0xf0
[ 5710.314168]  ? __kmalloc+0x17a/0x1a0
[ 5710.314170]  __kmalloc+0x17a/0x1a0
[ 5710.314173]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.314175]  ? insert_work+0x4a/0xc0
[ 5710.314178]  ? preempt_count_add+0xa3/0xc0
[ 5710.314180]  ? _raw_spin_unlock+0x11/0x30
[ 5710.314183]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5710.314186]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5710.314189]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5710.314192]  blk_mq_run_work_fn+0xd/0x10
[ 5710.314194]  process_one_work+0x1ee/0x4a0
[ 5710.314198]  worker_thread+0x43/0x4e0
[ 5710.314200]  kthread+0xfc/0x130
[ 5710.314202]  ? process_one_work+0x4a0/0x4a0
[ 5710.314204]  ? kthread_create_on_node+0x40/0x40
[ 5710.314206]  ret_from_fork+0x29/0x40
[ 5710.314517] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5710.314521] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5710.314525] CPU: 1 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5710.314526] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5710.314529] Workqueue: writeback wb_workfn (flush-259:0)
[ 5710.314532] Call Trace:
[ 5710.314535]  dump_stack+0x4f/0x73
[ 5710.314537]  warn_alloc+0xde/0x170
[ 5710.314540]  ? wake_all_kswapds+0x60/0xa0
[ 5710.314542]  __alloc_pages_slowpath+0xe21/0xe50
[ 5710.314545]  ? __inc_zone_state+0x42/0xb0
[ 5710.314549]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5710.314551]  alloc_pages_current+0x90/0x140
[ 5710.314553]  kmalloc_order_trace+0x29/0xf0
[ 5710.314555]  ? alloc_pages_current+0x90/0x140
[ 5710.314558]  __kmalloc+0x17a/0x1a0
[ 5710.314561]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5710.314563]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5710.314565]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5710.314567]  ? blk_mq_get_tag+0x82/0x2b0
[ 5710.314571]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5710.314573]  blk_mq_make_request+0x1ef/0x750
[ 5710.314575]  ? preempt_count_add+0x7c/0xc0
[ 5710.314578]  generic_make_request+0xcf/0x1d0
[ 5710.314581]  submit_bio+0x6e/0x150
[ 5710.314583]  ? bio_alloc_bioset+0x14b/0x240
[ 5710.314598]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5710.314612]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5710.314616]  write_cache_pages+0x1ec/0x4c0
[ 5710.314628]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5710.314643]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5710.314648]  do_writepages+0x19/0x30
[ 5710.314650]  __writeback_single_inode+0x40/0x390
[ 5710.314651]  ? preempt_count_add+0xa3/0xc0
[ 5710.314659]  writeback_sb_inodes+0x23a/0x4b0
[ 5710.314661]  __writeback_inodes_wb+0x8d/0xc0
[ 5710.314663]  wb_writeback+0x269/0x310
[ 5710.314667]  wb_workfn+0x2cc/0x410
[ 5710.314670]  process_one_work+0x1ee/0x4a0
[ 5710.314672]  worker_thread+0x43/0x4e0
[ 5710.314674]  kthread+0xfc/0x130
[ 5710.314676]  ? process_one_work+0x4a0/0x4a0
[ 5710.314678]  ? kthread_create_on_node+0x40/0x40
[ 5710.314681]  ret_from_fork+0x29/0x40
[ 5715.326906] warn_alloc: 632 callbacks suppressed
[ 5715.326909] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.326915] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.326921] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.326922] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.326928] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.326930] Call Trace:
[ 5715.326936]  dump_stack+0x4f/0x73
[ 5715.326939]  warn_alloc+0xde/0x170
[ 5715.326942]  ? wake_all_kswapds+0x60/0xa0
[ 5715.326945]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.326950]  ? preempt_count_add+0xa3/0xc0
[ 5715.326952]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.326956]  alloc_pages_current+0x90/0x140
[ 5715.326959]  kmalloc_order_trace+0x29/0xf0
[ 5715.326961]  __kmalloc+0x17a/0x1a0
[ 5715.326966]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.326970]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.326973]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.326976]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.326979]  blk_mq_run_work_fn+0xd/0x10
[ 5715.326982]  process_one_work+0x1ee/0x4a0
[ 5715.326985]  worker_thread+0x43/0x4e0
[ 5715.326987]  kthread+0xfc/0x130
[ 5715.326990]  ? process_one_work+0x4a0/0x4a0
[ 5715.326992]  ? kthread_create_on_node+0x40/0x40
[ 5715.326995]  ret_from_fork+0x29/0x40
[ 5715.326998] warn_alloc_show_mem: 9 callbacks suppressed
[ 5715.326999] Mem-Info:
[ 5715.327006] active_anon:969219 inactive_anon:209574 isolated_anon:0
                active_file:5778353 inactive_file:612382 isolated_file:0
                unevictable:16 dirty:43679 writeback:1150879 unstable:0
                slab_reclaimable:194938 slab_unreclaimable:26392
                mapped:168228 shmem:95103 pagetables:25175 bounce:0
                free:333139 free_pcp:2190 free_cma:0
[ 5715.327012] Node 0 active_anon:3876876kB inactive_anon:838296kB active_file:23113412kB inactive_file:2449528kB unevictable:64kB isolated(anon):0kB isolated(file):0kB mapped:672912kB dirty:174716kB writeback:4603516kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 706560kB anon_thp: 380412kB writeback_tmp:0kB unstable:0kB pages_scanned:0 all_unreclaimable? no
[ 5715.327014] Node 0 DMA free:15864kB min:32kB low:44kB high:56kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15892kB mlocked:0kB slab_reclaimable:0kB slab_unreclaimable:28kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 5715.327019] lowmem_reserve[]: 0 2881 32048 32048
[ 5715.327024] Node 0 DMA32 free:279976kB min:6072kB low:9020kB high:11968kB active_anon:285888kB inactive_anon:21876kB active_file:2200508kB inactive_file:67424kB unevictable:0kB writepending:420008kB present:3040380kB managed:3027140kB mlocked:0kB slab_reclaimable:108564kB slab_unreclaimable:10124kB kernel_stack:432kB pagetables:1948kB bounce:0kB free_pcp:5520kB local_pcp:700kB free_cma:0kB
[ 5715.327029] lowmem_reserve[]: 0 0 29166 29166
[ 5715.327034] Node 0 Normal free:1036716kB min:61476kB low:91340kB high:121204kB active_anon:3590988kB inactive_anon:816420kB active_file:20913032kB inactive_file:2382080kB unevictable:64kB writepending:4357252kB present:30392316kB managed:29866764kB mlocked:64kB slab_reclaimable:671188kB slab_unreclaimable:95416kB kernel_stack:19680kB pagetables:98752kB bounce:0kB free_pcp:3220kB local_pcp:512kB free_cma:0kB
[ 5715.327039] lowmem_reserve[]: 0 0 0 0
[ 5715.327043] Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 1*32kB (U) 3*64kB (U) 2*128kB (U) 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15864kB
[ 5715.327061] Node 0 DMA32: 54766*4kB (UMEH) 7699*8kB (UMEH) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 280656kB
[ 5715.327073] Node 0 Normal: 201705*4kB (UMH) 28679*8kB (UMH) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 1036252kB
[ 5715.327088] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[ 5715.327089] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[ 5715.327090] 6486290 total pagecache pages
[ 5715.327093] 11 pages in swap cache
[ 5715.327094] Swap cache stats: add 374, delete 363, find 0/4
[ 5715.327095] Free swap  = 6956796kB
[ 5715.327096] Total swap = 6959100kB
[ 5715.327097] 8362173 pages RAM
[ 5715.327098] 0 pages HighMem/MovableOnly
[ 5715.327099] 134724 pages reserved
[ 5715.327100] 0 pages cma reserved
[ 5715.328319] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.328326] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.328331] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.328333] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.328337] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.328341] Call Trace:
[ 5715.328346]  dump_stack+0x4f/0x73
[ 5715.328349]  warn_alloc+0xde/0x170
[ 5715.328352]  ? wake_all_kswapds+0x60/0xa0
[ 5715.328356]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.328361]  ? preempt_count_add+0xa3/0xc0
[ 5715.328364]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.328368]  alloc_pages_current+0x90/0x140
[ 5715.328372]  kmalloc_order_trace+0x29/0xf0
[ 5715.328375]  __kmalloc+0x17a/0x1a0
[ 5715.328380]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.328385]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.328389]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.328393]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.328397]  blk_mq_run_work_fn+0xd/0x10
[ 5715.328400]  process_one_work+0x1ee/0x4a0
[ 5715.328405]  worker_thread+0x43/0x4e0
[ 5715.328409]  kthread+0xfc/0x130
[ 5715.328412]  ? process_one_work+0x4a0/0x4a0
[ 5715.328415]  ? kthread_create_on_node+0x40/0x40
[ 5715.328418]  ret_from_fork+0x29/0x40
[ 5715.332170] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.332177] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.332184] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.332185] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.332191] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.332193] Call Trace:
[ 5715.332200]  dump_stack+0x4f/0x73
[ 5715.332203]  warn_alloc+0xde/0x170
[ 5715.332207]  ? wake_all_kswapds+0x60/0xa0
[ 5715.332210]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.332215]  ? preempt_count_add+0xa3/0xc0
[ 5715.332218]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.332222]  alloc_pages_current+0x90/0x140
[ 5715.332225]  kmalloc_order_trace+0x29/0xf0
[ 5715.332227]  __kmalloc+0x17a/0x1a0
[ 5715.332233]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.332237]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.332240]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.332243]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.332246]  blk_mq_run_work_fn+0xd/0x10
[ 5715.332249]  process_one_work+0x1ee/0x4a0
[ 5715.332252]  worker_thread+0x43/0x4e0
[ 5715.332255]  kthread+0xfc/0x130
[ 5715.332257]  ? process_one_work+0x4a0/0x4a0
[ 5715.332259]  ? kthread_create_on_node+0x40/0x40
[ 5715.332262]  ret_from_fork+0x29/0x40
[ 5715.334975] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.334981] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.334986] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.334987] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.334991] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.334994] Call Trace:
[ 5715.334998]  dump_stack+0x4f/0x73
[ 5715.335001]  warn_alloc+0xde/0x170
[ 5715.335004]  ? wake_all_kswapds+0x60/0xa0
[ 5715.335007]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.335011]  ? preempt_count_add+0xa3/0xc0
[ 5715.335013]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.335017]  alloc_pages_current+0x90/0x140
[ 5715.335020]  kmalloc_order_trace+0x29/0xf0
[ 5715.335023]  __kmalloc+0x17a/0x1a0
[ 5715.335027]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.335032]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.335035]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.335038]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.335041]  blk_mq_run_work_fn+0xd/0x10
[ 5715.335044]  process_one_work+0x1ee/0x4a0
[ 5715.335047]  worker_thread+0x43/0x4e0
[ 5715.335050]  kthread+0xfc/0x130
[ 5715.335052]  ? process_one_work+0x4a0/0x4a0
[ 5715.335054]  ? kthread_create_on_node+0x40/0x40
[ 5715.335058]  ret_from_fork+0x29/0x40
[ 5715.402125] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.402134] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.402142] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.402144] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.402151] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.402154] Call Trace:
[ 5715.402160]  dump_stack+0x4f/0x73
[ 5715.402164]  warn_alloc+0xde/0x170
[ 5715.402168]  ? wake_all_kswapds+0x60/0xa0
[ 5715.402171]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.402176]  ? preempt_count_add+0xa3/0xc0
[ 5715.402179]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.402184]  alloc_pages_current+0x90/0x140
[ 5715.402187]  kmalloc_order_trace+0x29/0xf0
[ 5715.402191]  __kmalloc+0x17a/0x1a0
[ 5715.402197]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.402202]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.402206]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.402211]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.402214]  blk_mq_run_work_fn+0xd/0x10
[ 5715.402217]  process_one_work+0x1ee/0x4a0
[ 5715.402220]  worker_thread+0x43/0x4e0
[ 5715.402224]  kthread+0xfc/0x130
[ 5715.402227]  ? process_one_work+0x4a0/0x4a0
[ 5715.402230]  ? kthread_create_on_node+0x40/0x40
[ 5715.402234]  ret_from_fork+0x29/0x40
[ 5715.402716] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.402723] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.402730] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.402733] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.402736] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.402739] Call Trace:
[ 5715.402744]  dump_stack+0x4f/0x73
[ 5715.402748]  warn_alloc+0xde/0x170
[ 5715.402751]  ? wake_all_kswapds+0x60/0xa0
[ 5715.402755]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.402759]  ? preempt_count_add+0xa3/0xc0
[ 5715.402762]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.402766]  alloc_pages_current+0x90/0x140
[ 5715.402770]  kmalloc_order_trace+0x29/0xf0
[ 5715.402772]  ? __kmalloc+0x17a/0x1a0
[ 5715.402776]  __kmalloc+0x17a/0x1a0
[ 5715.402780]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.402785]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.402789]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.402793]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.402797]  blk_mq_run_work_fn+0xd/0x10
[ 5715.402800]  process_one_work+0x1ee/0x4a0
[ 5715.402804]  worker_thread+0x43/0x4e0
[ 5715.402807]  kthread+0xfc/0x130
[ 5715.402810]  ? process_one_work+0x4a0/0x4a0
[ 5715.402813]  ? kthread_create_on_node+0x40/0x40
[ 5715.402817]  ret_from_fork+0x29/0x40
[ 5715.405814] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.405822] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.405829] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.405831] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.405836] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.405839] Call Trace:
[ 5715.405845]  dump_stack+0x4f/0x73
[ 5715.405849]  warn_alloc+0xde/0x170
[ 5715.405852]  ? wake_all_kswapds+0x60/0xa0
[ 5715.405855]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.405861]  ? preempt_count_add+0xa3/0xc0
[ 5715.405864]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.405869]  alloc_pages_current+0x90/0x140
[ 5715.405872]  kmalloc_order_trace+0x29/0xf0
[ 5715.405875]  ? __kmalloc+0x17a/0x1a0
[ 5715.405878]  __kmalloc+0x17a/0x1a0
[ 5715.405883]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.405888]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.405892]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.405896]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.405899]  blk_mq_run_work_fn+0xd/0x10
[ 5715.405902]  process_one_work+0x1ee/0x4a0
[ 5715.405906]  worker_thread+0x43/0x4e0
[ 5715.405909]  kthread+0xfc/0x130
[ 5715.405912]  ? process_one_work+0x4a0/0x4a0
[ 5715.405914]  ? kthread_create_on_node+0x40/0x40
[ 5715.405918]  ret_from_fork+0x29/0x40
[ 5715.408956] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.408968] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.408975] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.408977] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.408983] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.408986] Call Trace:
[ 5715.408992]  dump_stack+0x4f/0x73
[ 5715.408996]  warn_alloc+0xde/0x170
[ 5715.408999]  ? wake_all_kswapds+0x60/0xa0
[ 5715.409002]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.409007]  ? preempt_count_add+0xa3/0xc0
[ 5715.409010]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.409015]  alloc_pages_current+0x90/0x140
[ 5715.409018]  kmalloc_order_trace+0x29/0xf0
[ 5715.409022]  __kmalloc+0x17a/0x1a0
[ 5715.409027]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.409032]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.409037]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.409041]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.409045]  blk_mq_run_work_fn+0xd/0x10
[ 5715.409048]  process_one_work+0x1ee/0x4a0
[ 5715.409052]  worker_thread+0x43/0x4e0
[ 5715.409056]  kthread+0xfc/0x130
[ 5715.409059]  ? process_one_work+0x4a0/0x4a0
[ 5715.409061]  ? kthread_create_on_node+0x40/0x40
[ 5715.409064]  ret_from_fork+0x29/0x40
[ 5715.477921] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.477930] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.477935] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.477937] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.477943] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.477945] Call Trace:
[ 5715.477951]  dump_stack+0x4f/0x73
[ 5715.477954]  warn_alloc+0xde/0x170
[ 5715.477957]  ? wake_all_kswapds+0x60/0xa0
[ 5715.477959]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.477963]  ? preempt_count_add+0xa3/0xc0
[ 5715.477965]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.477969]  alloc_pages_current+0x90/0x140
[ 5715.477972]  kmalloc_order_trace+0x29/0xf0
[ 5715.477974]  __kmalloc+0x17a/0x1a0
[ 5715.477978]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.477982]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.477984]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.477987]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.477989]  blk_mq_run_work_fn+0xd/0x10
[ 5715.477992]  process_one_work+0x1ee/0x4a0
[ 5715.477994]  worker_thread+0x43/0x4e0
[ 5715.477996]  kthread+0xfc/0x130
[ 5715.477998]  ? process_one_work+0x4a0/0x4a0
[ 5715.478000]  ? kthread_create_on_node+0x40/0x40
[ 5715.478003]  ret_from_fork+0x29/0x40
[ 5715.480269] kworker/7:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5715.480276] kworker/7:2H cpuset=/ mems_allowed=0
[ 5715.480282] CPU: 7 PID: 22529 Comm: kworker/7:2H Tainted: G        W       4.11.0-rc1 #2
[ 5715.480283] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5715.480289] Workqueue: kblockd blk_mq_run_work_fn
[ 5715.480291] Call Trace:
[ 5715.480296]  dump_stack+0x4f/0x73
[ 5715.480299]  warn_alloc+0xde/0x170
[ 5715.480301]  ? wake_all_kswapds+0x60/0xa0
[ 5715.480304]  __alloc_pages_slowpath+0xe21/0xe50
[ 5715.480308]  ? preempt_count_add+0xa3/0xc0
[ 5715.480311]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5715.480314]  alloc_pages_current+0x90/0x140
[ 5715.480317]  kmalloc_order_trace+0x29/0xf0
[ 5715.480320]  __kmalloc+0x17a/0x1a0
[ 5715.480324]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5715.480328]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5715.480331]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5715.480334]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5715.480337]  blk_mq_run_work_fn+0xd/0x10
[ 5715.480340]  process_one_work+0x1ee/0x4a0
[ 5715.480342]  worker_thread+0x43/0x4e0
[ 5715.480345]  kthread+0xfc/0x130
[ 5715.480347]  ? process_one_work+0x4a0/0x4a0
[ 5715.480349]  ? kthread_create_on_node+0x40/0x40
[ 5715.480353]  ret_from_fork+0x29/0x40
[ 5749.776907] warn_alloc: 14 callbacks suppressed
[ 5749.776909] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.776915] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5749.776921] CPU: 6 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5749.776922] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.776929] Workqueue: writeback wb_workfn (flush-259:0)
[ 5749.776931] Call Trace:
[ 5749.776938]  dump_stack+0x4f/0x73
[ 5749.776942]  warn_alloc+0xde/0x170
[ 5749.776944]  ? wake_all_kswapds+0x60/0xa0
[ 5749.776946]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.776950]  ? __inc_zone_state+0x42/0xb0
[ 5749.776953]  ? preempt_count_add+0xa3/0xc0
[ 5749.776955]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.776959]  alloc_pages_current+0x90/0x140
[ 5749.776962]  kmalloc_order_trace+0x29/0xf0
[ 5749.776964]  ? alloc_pages_current+0x90/0x140
[ 5749.776966]  __kmalloc+0x17a/0x1a0
[ 5749.776971]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.776974]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5749.776976]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5749.776978]  ? blk_mq_get_tag+0x82/0x2b0
[ 5749.776981]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5749.776983]  blk_mq_make_request+0x1ef/0x750
[ 5749.776985]  ? preempt_count_add+0x7c/0xc0
[ 5749.776988]  generic_make_request+0xcf/0x1d0
[ 5749.776990]  submit_bio+0x6e/0x150
[ 5749.776991]  ? bio_alloc_bioset+0x14b/0x240
[ 5749.777019]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5749.777033]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5749.777036]  write_cache_pages+0x1ec/0x4c0
[ 5749.777049]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5749.777063]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5749.777066]  do_writepages+0x19/0x30
[ 5749.777067]  __writeback_single_inode+0x40/0x390
[ 5749.777069]  ? preempt_count_add+0xa3/0xc0
[ 5749.777071]  writeback_sb_inodes+0x23a/0x4b0
[ 5749.777073]  __writeback_inodes_wb+0x8d/0xc0
[ 5749.777075]  wb_writeback+0x269/0x310
[ 5749.777078]  wb_workfn+0x2cc/0x410
[ 5749.777081]  process_one_work+0x1ee/0x4a0
[ 5749.777083]  worker_thread+0x43/0x4e0
[ 5749.777086]  kthread+0xfc/0x130
[ 5749.777089]  ? process_one_work+0x4a0/0x4a0
[ 5749.777090]  ? kthread_create_on_node+0x40/0x40
[ 5749.777097]  ret_from_fork+0x29/0x40
[ 5749.777099] warn_alloc_show_mem: 9 callbacks suppressed
[ 5749.777100] Mem-Info:
[ 5749.777105] active_anon:1000718 inactive_anon:211617 isolated_anon:0
                active_file:5836246 inactive_file:633227 isolated_file:0
                unevictable:16 dirty:197523 writeback:943480 unstable:0
                slab_reclaimable:212694 slab_unreclaimable:25526
                mapped:184089 shmem:97147 pagetables:25705 bounce:0
                free:204622 free_pcp:2179 free_cma:0
[ 5749.777110] Node 0 active_anon:4002872kB inactive_anon:846468kB active_file:23344984kB inactive_file:2532908kB unevictable:64kB isolated(anon):0kB isolated(file):0kB mapped:736356kB dirty:790092kB writeback:3773920kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 706560kB anon_thp: 388588kB writeback_tmp:0kB unstable:0kB pages_scanned:0 all_unreclaimable? no
[ 5749.777111] Node 0 DMA free:15864kB min:32kB low:44kB high:56kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15892kB mlocked:0kB slab_reclaimable:0kB slab_unreclaimable:28kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 5749.777115] lowmem_reserve[]: 0 2881 32048 32048
[ 5749.777118] Node 0 DMA32 free:166956kB min:6072kB low:9020kB high:11968kB active_anon:302840kB inactive_anon:22064kB active_file:2008300kB inactive_file:338356kB unevictable:0kB writepending:453524kB present:3040380kB managed:3027140kB mlocked:0kB slab_reclaimable:133528kB slab_unreclaimable:12068kB kernel_stack:416kB pagetables:2032kB bounce:0kB free_pcp:5256kB local_pcp:740kB free_cma:0kB
[ 5749.777121] lowmem_reserve[]: 0 0 29166 29166
[ 5749.777125] Node 0 Normal free:635668kB min:61476kB low:91340kB high:121204kB active_anon:3699932kB inactive_anon:824404kB active_file:21336684kB inactive_file:2195104kB unevictable:64kB writepending:4110636kB present:30392316kB managed:29866764kB mlocked:64kB slab_reclaimable:717248kB slab_unreclaimable:90008kB kernel_stack:20096kB pagetables:100788kB bounce:0kB free_pcp:3460kB local_pcp:352kB free_cma:0kB
[ 5749.777129] lowmem_reserve[]: 0 0 0 0
[ 5749.777131] Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 1*32kB (U) 3*64kB (U) 2*128kB (U) 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15864kB
[ 5749.777144] Node 0 DMA32: 40510*4kB (UMEH) 628*8kB (UMH) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 167064kB
[ 5749.777153] Node 0 Normal: 126482*4kB (UMH) 16233*8kB (UMH) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 635792kB
[ 5749.777163] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[ 5749.777164] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[ 5749.777165] 6566882 total pagecache pages
[ 5749.777167] 10 pages in swap cache
[ 5749.777168] Swap cache stats: add 376, delete 366, find 1/7
[ 5749.777169] Free swap  = 6956796kB
[ 5749.777169] Total swap = 6959100kB
[ 5749.777170] 8362173 pages RAM
[ 5749.777170] 0 pages HighMem/MovableOnly
[ 5749.777171] 134724 pages reserved
[ 5749.777172] 0 pages cma reserved
[ 5749.777181] kworker/6:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.777184] kworker/6:2H cpuset=/ mems_allowed=0
[ 5749.777187] CPU: 6 PID: 2904 Comm: kworker/6:2H Tainted: G        W       4.11.0-rc1 #2
[ 5749.777188] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.777190] Workqueue: kblockd blk_mq_run_work_fn
[ 5749.777192] Call Trace:
[ 5749.777195]  dump_stack+0x4f/0x73
[ 5749.777197]  warn_alloc+0xde/0x170
[ 5749.777199]  ? wake_all_kswapds+0x60/0xa0
[ 5749.777201]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.777204]  ? preempt_count_add+0xa3/0xc0
[ 5749.777206]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.777209]  alloc_pages_current+0x90/0x140
[ 5749.777211]  kmalloc_order_trace+0x29/0xf0
[ 5749.777213]  __kmalloc+0x17a/0x1a0
[ 5749.777215]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.777219]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5749.777221]  blk_mq_sched_dispatch_requests+0x161/0x170
[ 5749.777223]  ? _raw_spin_unlock_irq+0x12/0x30
[ 5749.777226]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5749.777228]  blk_mq_run_work_fn+0xd/0x10
[ 5749.777230]  process_one_work+0x1ee/0x4a0
[ 5749.777232]  worker_thread+0x43/0x4e0
[ 5749.777234]  kthread+0xfc/0x130
[ 5749.777236]  ? process_one_work+0x4a0/0x4a0
[ 5749.777238]  ? kthread_create_on_node+0x40/0x40
[ 5749.777240]  ret_from_fork+0x29/0x40
[ 5749.777243] kworker/6:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.777247] kworker/6:2H cpuset=/ mems_allowed=0
[ 5749.777251] CPU: 6 PID: 2904 Comm: kworker/6:2H Tainted: G        W       4.11.0-rc1 #2
[ 5749.777252] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.777254] Workqueue: kblockd blk_mq_run_work_fn
[ 5749.777255] Call Trace:
[ 5749.777257]  dump_stack+0x4f/0x73
[ 5749.777259]  warn_alloc+0xde/0x170
[ 5749.777261]  ? wake_all_kswapds+0x60/0xa0
[ 5749.777263]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.777266]  ? preempt_count_add+0xa3/0xc0
[ 5749.777268]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.777270]  alloc_pages_current+0x90/0x140
[ 5749.777273]  kmalloc_order_trace+0x29/0xf0
[ 5749.777274]  ? __kmalloc+0x17a/0x1a0
[ 5749.777276]  __kmalloc+0x17a/0x1a0
[ 5749.777278]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.777280]  ? insert_work+0x4a/0xc0
[ 5749.777282]  ? preempt_count_add+0xa3/0xc0
[ 5749.777284]  ? _raw_spin_unlock+0x11/0x30
[ 5749.777286]  ? __queue_work+0x16a/0x4a0
[ 5749.777288]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5749.777291]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5749.777293]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5749.777295]  blk_mq_run_work_fn+0xd/0x10
[ 5749.777297]  process_one_work+0x1ee/0x4a0
[ 5749.777299]  worker_thread+0x43/0x4e0
[ 5749.777302]  kthread+0xfc/0x130
[ 5749.777304]  ? process_one_work+0x4a0/0x4a0
[ 5749.777305]  ? kthread_create_on_node+0x40/0x40
[ 5749.777307]  ret_from_fork+0x29/0x40
[ 5749.777554] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.777558] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5749.777562] CPU: 6 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5749.777563] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.777565] Workqueue: writeback wb_workfn (flush-259:0)
[ 5749.777568] Call Trace:
[ 5749.777570]  dump_stack+0x4f/0x73
[ 5749.777573]  warn_alloc+0xde/0x170
[ 5749.777575]  ? wake_all_kswapds+0x60/0xa0
[ 5749.777577]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.777581]  ? __inc_zone_state+0x42/0xb0
[ 5749.777583]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.777586]  alloc_pages_current+0x90/0x140
[ 5749.777588]  kmalloc_order_trace+0x29/0xf0
[ 5749.777590]  ? alloc_pages_current+0x90/0x140
[ 5749.777592]  __kmalloc+0x17a/0x1a0
[ 5749.777594]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.777596]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5749.777598]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5749.777600]  ? blk_mq_get_tag+0x82/0x2b0
[ 5749.777603]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5749.777605]  blk_mq_make_request+0x1ef/0x750
[ 5749.777606]  ? preempt_count_add+0x7c/0xc0
[ 5749.777609]  generic_make_request+0xcf/0x1d0
[ 5749.777610]  submit_bio+0x6e/0x150
[ 5749.777612]  ? bio_alloc_bioset+0x14b/0x240
[ 5749.777626]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5749.777640]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5749.777642]  write_cache_pages+0x1ec/0x4c0
[ 5749.777655]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5749.777669]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5749.777672]  do_writepages+0x19/0x30
[ 5749.777674]  __writeback_single_inode+0x40/0x390
[ 5749.777675]  ? preempt_count_add+0xa3/0xc0
[ 5749.777677]  writeback_sb_inodes+0x23a/0x4b0
[ 5749.777680]  __writeback_inodes_wb+0x8d/0xc0
[ 5749.777682]  wb_writeback+0x269/0x310
[ 5749.777684]  wb_workfn+0x2cc/0x410
[ 5749.777687]  process_one_work+0x1ee/0x4a0
[ 5749.777689]  worker_thread+0x43/0x4e0
[ 5749.777691]  kthread+0xfc/0x130
[ 5749.777693]  ? process_one_work+0x4a0/0x4a0
[ 5749.777695]  ? kthread_create_on_node+0x40/0x40
[ 5749.777697]  ret_from_fork+0x29/0x40
[ 5749.777703] kworker/6:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.777706] kworker/6:2H cpuset=/ mems_allowed=0
[ 5749.777709] CPU: 6 PID: 2904 Comm: kworker/6:2H Tainted: G        W       4.11.0-rc1 #2
[ 5749.777710] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.777712] Workqueue: kblockd blk_mq_run_work_fn
[ 5749.777713] Call Trace:
[ 5749.777716]  dump_stack+0x4f/0x73
[ 5749.777718]  warn_alloc+0xde/0x170
[ 5749.777720]  ? wake_all_kswapds+0x60/0xa0
[ 5749.777722]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.777725]  ? preempt_count_add+0xa3/0xc0
[ 5749.777727]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.777729]  alloc_pages_current+0x90/0x140
[ 5749.777732]  kmalloc_order_trace+0x29/0xf0
[ 5749.777733]  ? __kmalloc+0x17a/0x1a0
[ 5749.777735]  __kmalloc+0x17a/0x1a0
[ 5749.777737]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.777739]  ? insert_work+0x4a/0xc0
[ 5749.777741]  ? preempt_count_add+0xa3/0xc0
[ 5749.777743]  ? _raw_spin_unlock+0x11/0x30
[ 5749.777746]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5749.777748]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5749.777751]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5749.777753]  blk_mq_run_work_fn+0xd/0x10
[ 5749.777755]  process_one_work+0x1ee/0x4a0
[ 5749.777757]  worker_thread+0x43/0x4e0
[ 5749.777759]  kthread+0xfc/0x130
[ 5749.777761]  ? process_one_work+0x4a0/0x4a0
[ 5749.777762]  ? kthread_create_on_node+0x40/0x40
[ 5749.777764]  ret_from_fork+0x29/0x40
[ 5749.778134] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.778139] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5749.778143] CPU: 6 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5749.778144] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.778146] Workqueue: writeback wb_workfn (flush-259:0)
[ 5749.778148] Call Trace:
[ 5749.778151]  dump_stack+0x4f/0x73
[ 5749.778155]  warn_alloc+0xde/0x170
[ 5749.778157]  ? wake_all_kswapds+0x60/0xa0
[ 5749.778159]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.778162]  ? __inc_zone_state+0x42/0xb0
[ 5749.778164]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.778168]  alloc_pages_current+0x90/0x140
[ 5749.778170]  kmalloc_order_trace+0x29/0xf0
[ 5749.778172]  __kmalloc+0x17a/0x1a0
[ 5749.778175]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.778177]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5749.778179]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5749.778182]  ? blk_mq_get_tag+0x82/0x2b0
[ 5749.778185]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5749.778187]  blk_mq_make_request+0x1ef/0x750
[ 5749.778188]  ? preempt_count_add+0x7c/0xc0
[ 5749.778191]  generic_make_request+0xcf/0x1d0
[ 5749.778194]  submit_bio+0x6e/0x150
[ 5749.778196]  ? bio_alloc_bioset+0x14b/0x240
[ 5749.778211]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5749.778228]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5749.778234]  write_cache_pages+0x1ec/0x4c0
[ 5749.778248]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5749.778268]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5749.778274]  do_writepages+0x19/0x30
[ 5749.778278]  __writeback_single_inode+0x40/0x390
[ 5749.778281]  ? preempt_count_add+0xa3/0xc0
[ 5749.778286]  writeback_sb_inodes+0x23a/0x4b0
[ 5749.778290]  __writeback_inodes_wb+0x8d/0xc0
[ 5749.778294]  wb_writeback+0x269/0x310
[ 5749.778301]  wb_workfn+0x2cc/0x410
[ 5749.778308]  process_one_work+0x1ee/0x4a0
[ 5749.778312]  worker_thread+0x43/0x4e0
[ 5749.778317]  kthread+0xfc/0x130
[ 5749.778321]  ? process_one_work+0x4a0/0x4a0
[ 5749.778324]  ? kthread_create_on_node+0x40/0x40
[ 5749.778328]  ret_from_fork+0x29/0x40
[ 5749.778337] kworker/6:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.778355] kworker/6:2H cpuset=/ mems_allowed=0
[ 5749.778367] CPU: 6 PID: 2904 Comm: kworker/6:2H Tainted: G        W       4.11.0-rc1 #2
[ 5749.778370] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.778374] Workqueue: kblockd blk_mq_run_work_fn
[ 5749.778381] Call Trace:
[ 5749.778384]  dump_stack+0x4f/0x73
[ 5749.778388]  warn_alloc+0xde/0x170
[ 5749.778396]  ? wake_all_kswapds+0x60/0xa0
[ 5749.778402]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.778406]  ? preempt_count_add+0xa3/0xc0
[ 5749.778410]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.778414]  alloc_pages_current+0x90/0x140
[ 5749.778418]  kmalloc_order_trace+0x29/0xf0
[ 5749.778421]  ? __kmalloc+0x17a/0x1a0
[ 5749.778425]  __kmalloc+0x17a/0x1a0
[ 5749.778429]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.778432]  ? insert_work+0x4a/0xc0
[ 5749.778436]  ? preempt_count_add+0xa3/0xc0
[ 5749.778441]  ? _raw_spin_unlock+0x11/0x30
[ 5749.778448]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5749.778451]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5749.778453]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5749.778455]  blk_mq_run_work_fn+0xd/0x10
[ 5749.778457]  process_one_work+0x1ee/0x4a0
[ 5749.778459]  worker_thread+0x43/0x4e0
[ 5749.778462]  kthread+0xfc/0x130
[ 5749.778464]  ? process_one_work+0x4a0/0x4a0
[ 5749.778466]  ? kthread_create_on_node+0x40/0x40
[ 5749.778468]  ret_from_fork+0x29/0x40
[ 5749.778680] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.778684] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5749.778687] CPU: 6 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5749.778688] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.778690] Workqueue: writeback wb_workfn (flush-259:0)
[ 5749.778692] Call Trace:
[ 5749.778695]  dump_stack+0x4f/0x73
[ 5749.778698]  warn_alloc+0xde/0x170
[ 5749.778700]  ? wake_all_kswapds+0x60/0xa0
[ 5749.778703]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.778706]  ? __inc_zone_state+0x42/0xb0
[ 5749.778711]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.778715]  alloc_pages_current+0x90/0x140
[ 5749.778717]  kmalloc_order_trace+0x29/0xf0
[ 5749.778719]  ? alloc_pages_current+0x90/0x140
[ 5749.778720]  __kmalloc+0x17a/0x1a0
[ 5749.778723]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.778727]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5749.778730]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5749.778733]  ? blk_mq_get_tag+0x82/0x2b0
[ 5749.778738]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5749.778740]  blk_mq_make_request+0x1ef/0x750
[ 5749.778743]  ? preempt_count_add+0x7c/0xc0
[ 5749.778745]  generic_make_request+0xcf/0x1d0
[ 5749.778747]  submit_bio+0x6e/0x150
[ 5749.778748]  ? bio_alloc_bioset+0x14b/0x240
[ 5749.778761]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5749.778776]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5749.778779]  write_cache_pages+0x1ec/0x4c0
[ 5749.778792]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5749.778808]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5749.778812]  do_writepages+0x19/0x30
[ 5749.778814]  __writeback_single_inode+0x40/0x390
[ 5749.778815]  ? preempt_count_add+0xa3/0xc0
[ 5749.778817]  writeback_sb_inodes+0x23a/0x4b0
[ 5749.778819]  __writeback_inodes_wb+0x8d/0xc0
[ 5749.778821]  wb_writeback+0x269/0x310
[ 5749.778823]  wb_workfn+0x2cc/0x410
[ 5749.778826]  process_one_work+0x1ee/0x4a0
[ 5749.778831]  worker_thread+0x43/0x4e0
[ 5749.778834]  kthread+0xfc/0x130
[ 5749.778835]  ? process_one_work+0x4a0/0x4a0
[ 5749.778837]  ? kthread_create_on_node+0x40/0x40
[ 5749.778840]  ret_from_fork+0x29/0x40
[ 5749.778854] kworker/6:2H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.778865] kworker/6:2H cpuset=/ mems_allowed=0
[ 5749.778877] CPU: 6 PID: 2904 Comm: kworker/6:2H Tainted: G        W       4.11.0-rc1 #2
[ 5749.778884] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.778888] Workqueue: kblockd blk_mq_run_work_fn
[ 5749.778896] Call Trace:
[ 5749.778899]  dump_stack+0x4f/0x73
[ 5749.778906]  warn_alloc+0xde/0x170
[ 5749.778910]  ? wake_all_kswapds+0x60/0xa0
[ 5749.778914]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.778921]  ? preempt_count_add+0xa3/0xc0
[ 5749.778923]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.778928]  alloc_pages_current+0x90/0x140
[ 5749.778930]  kmalloc_order_trace+0x29/0xf0
[ 5749.778932]  ? __kmalloc+0x17a/0x1a0
[ 5749.778934]  __kmalloc+0x17a/0x1a0
[ 5749.778938]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.778940]  ? insert_work+0x4a/0xc0
[ 5749.778941]  ? preempt_count_add+0xa3/0xc0
[ 5749.778943]  ? _raw_spin_unlock+0x11/0x30
[ 5749.778946]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5749.778949]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5749.778951]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5749.778953]  blk_mq_run_work_fn+0xd/0x10
[ 5749.778957]  process_one_work+0x1ee/0x4a0
[ 5749.778959]  worker_thread+0x43/0x4e0
[ 5749.778961]  kthread+0xfc/0x130
[ 5749.778963]  ? process_one_work+0x4a0/0x4a0
[ 5749.778967]  ? kthread_create_on_node+0x40/0x40
[ 5749.778969]  ret_from_fork+0x29/0x40
[ 5749.779819] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5749.779825] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5749.779830] CPU: 6 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5749.779831] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5749.779834] Workqueue: writeback wb_workfn (flush-259:0)
[ 5749.779837] Call Trace:
[ 5749.779841]  dump_stack+0x4f/0x73
[ 5749.779843]  warn_alloc+0xde/0x170
[ 5749.779845]  ? wake_all_kswapds+0x60/0xa0
[ 5749.779848]  __alloc_pages_slowpath+0xe21/0xe50
[ 5749.779851]  ? __inc_zone_state+0x42/0xb0
[ 5749.779853]  ? preempt_count_add+0xa3/0xc0
[ 5749.779856]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5749.779859]  alloc_pages_current+0x90/0x140
[ 5749.779862]  kmalloc_order_trace+0x29/0xf0
[ 5749.779864]  ? alloc_pages_current+0x90/0x140
[ 5749.779866]  __kmalloc+0x17a/0x1a0
[ 5749.779871]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5749.779874]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5749.779876]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5749.779877]  ? blk_mq_get_tag+0x82/0x2b0
[ 5749.779881]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5749.779882]  blk_mq_make_request+0x1ef/0x750
[ 5749.779884]  ? preempt_count_add+0x7c/0xc0
[ 5749.779887]  generic_make_request+0xcf/0x1d0
[ 5749.779888]  submit_bio+0x6e/0x150
[ 5749.779891]  ? bio_alloc_bioset+0x14b/0x240
[ 5749.779907]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5749.779922]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5749.779927]  write_cache_pages+0x1ec/0x4c0
[ 5749.779940]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5749.779955]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5749.779959]  do_writepages+0x19/0x30
[ 5749.779961]  __writeback_single_inode+0x40/0x390
[ 5749.779964]  ? preempt_count_add+0xa3/0xc0
[ 5749.779967]  writeback_sb_inodes+0x23a/0x4b0
[ 5749.779970]  __writeback_inodes_wb+0x8d/0xc0
[ 5749.779971]  wb_writeback+0x269/0x310
[ 5749.779974]  wb_workfn+0x2cc/0x410
[ 5749.779978]  process_one_work+0x1ee/0x4a0
[ 5749.779980]  worker_thread+0x43/0x4e0
[ 5749.779982]  kthread+0xfc/0x130
[ 5749.779984]  ? process_one_work+0x4a0/0x4a0
[ 5749.779986]  ? kthread_create_on_node+0x40/0x40
[ 5749.779990]  ret_from_fork+0x29/0x40
[ 5755.735238] warn_alloc: 856 callbacks suppressed
[ 5755.735240] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.735245] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5755.735250] CPU: 3 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5755.735251] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.735256] Workqueue: writeback wb_workfn (flush-259:0)
[ 5755.735259] Call Trace:
[ 5755.735263]  dump_stack+0x4f/0x73
[ 5755.735266]  warn_alloc+0xde/0x170
[ 5755.735269]  ? wake_all_kswapds+0x60/0xa0
[ 5755.735270]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.735273]  ? preempt_count_add+0xa3/0xc0
[ 5755.735275]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.735277]  alloc_pages_current+0x90/0x140
[ 5755.735279]  kmalloc_order_trace+0x29/0xf0
[ 5755.735281]  __kmalloc+0x17a/0x1a0
[ 5755.735285]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.735287]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5755.735289]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5755.735291]  ? blk_mq_get_tag+0x82/0x2b0
[ 5755.735294]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5755.735295]  blk_mq_make_request+0x1ef/0x750
[ 5755.735297]  ? preempt_count_add+0x7c/0xc0
[ 5755.735299]  generic_make_request+0xcf/0x1d0
[ 5755.735300]  submit_bio+0x6e/0x150
[ 5755.735302]  ? bio_alloc_bioset+0x14b/0x240
[ 5755.735325]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5755.735336]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5755.735338]  write_cache_pages+0x1ec/0x4c0
[ 5755.735349]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5755.735361]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5755.735363]  do_writepages+0x19/0x30
[ 5755.735365]  __writeback_single_inode+0x40/0x390
[ 5755.735366]  ? preempt_count_add+0xa3/0xc0
[ 5755.735368]  writeback_sb_inodes+0x23a/0x4b0
[ 5755.735371]  __writeback_inodes_wb+0x8d/0xc0
[ 5755.735372]  wb_writeback+0x269/0x310
[ 5755.735374]  wb_workfn+0x2cc/0x410
[ 5755.735376]  process_one_work+0x1ee/0x4a0
[ 5755.735378]  worker_thread+0x43/0x4e0
[ 5755.735380]  kthread+0xfc/0x130
[ 5755.735381]  ? process_one_work+0x4a0/0x4a0
[ 5755.735383]  ? kthread_create_on_node+0x40/0x40
[ 5755.735385]  ret_from_fork+0x29/0x40
[ 5755.735387] warn_alloc_show_mem: 9 callbacks suppressed
[ 5755.735389] Mem-Info:
[ 5755.735395] active_anon:1058614 inactive_anon:210862 isolated_anon:0
                active_file:5964398 inactive_file:483306 isolated_file:0
                unevictable:16 dirty:152884 writeback:985135 unstable:0
                slab_reclaimable:214482 slab_unreclaimable:25669
                mapped:183927 shmem:96389 pagetables:26458 bounce:0
                free:164043 free_pcp:1887 free_cma:0
[ 5755.735399] Node 0 active_anon:4234456kB inactive_anon:843448kB active_file:23857592kB inactive_file:1933224kB unevictable:64kB isolated(anon):0kB isolated(file):0kB mapped:735708kB dirty:611536kB writeback:3940540kB shmem:0kB shmem_thp: 0kB shmem_pmdmapped: 706560kB anon_thp: 385556kB writeback_tmp:0kB unstable:0kB pages_scanned:0 all_unreclaimable? no
[ 5755.735400] Node 0 DMA free:15864kB min:32kB low:44kB high:56kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB present:15996kB managed:15892kB mlocked:0kB slab_reclaimable:0kB slab_unreclaimable:28kB kernel_stack:0kB pagetables:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[ 5755.735404] lowmem_reserve[]: 0 2881 32048 32048
[ 5755.735408] Node 0 DMA32 free:181556kB min:6072kB low:9020kB high:11968kB active_anon:315744kB inactive_anon:21852kB active_file:2208344kB inactive_file:111144kB unevictable:0kB writepending:416088kB present:3040380kB managed:3027140kB mlocked:0kB slab_reclaimable:134392kB slab_unreclaimable:9720kB kernel_stack:416kB pagetables:2044kB bounce:0kB free_pcp:5016kB local_pcp:632kB free_cma:0kB
[ 5755.735411] lowmem_reserve[]: 0 0 29166 29166
[ 5755.735415] Node 0 Normal free:458752kB min:61476kB low:91340kB high:121204kB active_anon:3919680kB inactive_anon:821596kB active_file:21649520kB inactive_file:1821592kB unevictable:64kB writepending:4137092kB present:30392316kB managed:29866764kB mlocked:64kB slab_reclaimable:723536kB slab_unreclaimable:92928kB kernel_stack:20528kB pagetables:103788kB bounce:0kB free_pcp:2424kB local_pcp:164kB free_cma:0kB
[ 5755.735419] lowmem_reserve[]: 0 0 0 0
[ 5755.735423] Node 0 DMA: 0*4kB 1*8kB (U) 1*16kB (U) 1*32kB (U) 3*64kB (U) 2*128kB (U) 0*256kB 0*512kB 1*1024kB (U) 1*2048kB (M) 3*4096kB (M) = 15864kB
[ 5755.735438] Node 0 DMA32: 44059*4kB (UMEH) 734*8kB (UMH) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 182108kB
[ 5755.735475] Node 0 Normal: 59020*4kB (UMEH) 27854*8kB (UMEH) 0*16kB 0*32kB 0*64kB 0*128kB 0*256kB 0*512kB 0*1024kB 0*2048kB 0*4096kB = 458912kB
[ 5755.735491] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[ 5755.735492] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=2048kB
[ 5755.735493] 6544191 total pagecache pages
[ 5755.735497] 13 pages in swap cache
[ 5755.735498] Swap cache stats: add 384, delete 371, find 4/12
[ 5755.735499] Free swap  = 6956796kB
[ 5755.735500] Total swap = 6959100kB
[ 5755.735501] 8362173 pages RAM
[ 5755.735502] 0 pages HighMem/MovableOnly
[ 5755.735503] 134724 pages reserved
[ 5755.735504] 0 pages cma reserved
[ 5755.735512] kworker/3:1H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.735515] kworker/3:1H cpuset=/ mems_allowed=0
[ 5755.735519] CPU: 3 PID: 1445 Comm: kworker/3:1H Tainted: G        W       4.11.0-rc1 #2
[ 5755.735522] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.735524] Workqueue: kblockd blk_mq_run_work_fn
[ 5755.735526] Call Trace:
[ 5755.735529]  dump_stack+0x4f/0x73
[ 5755.735531]  warn_alloc+0xde/0x170
[ 5755.735533]  ? wake_all_kswapds+0x60/0xa0
[ 5755.735536]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.735540]  ? cpumask_next_and+0x2b/0x40
[ 5755.735542]  ? cpuacct_charge+0x75/0x90
[ 5755.735544]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.735546]  alloc_pages_current+0x90/0x140
[ 5755.735550]  kmalloc_order_trace+0x29/0xf0
[ 5755.735551]  ? dequeue_task_fair+0x64b/0x17a0
[ 5755.735553]  __kmalloc+0x17a/0x1a0
[ 5755.735558]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.735560]  ? finish_task_switch+0x7e/0x220
[ 5755.735564]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5755.735567]  blk_mq_sched_dispatch_requests+0x161/0x170
[ 5755.735570]  ? _raw_spin_unlock_irq+0x12/0x30
[ 5755.735573]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5755.735576]  blk_mq_run_work_fn+0xd/0x10
[ 5755.735577]  process_one_work+0x1ee/0x4a0
[ 5755.735581]  worker_thread+0x43/0x4e0
[ 5755.735583]  kthread+0xfc/0x130
[ 5755.735585]  ? process_one_work+0x4a0/0x4a0
[ 5755.735588]  ? kthread_create_on_node+0x40/0x40
[ 5755.735591]  ret_from_fork+0x29/0x40
[ 5755.735596] kworker/3:1H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.735602] kworker/3:1H cpuset=/ mems_allowed=0
[ 5755.735605] CPU: 3 PID: 1445 Comm: kworker/3:1H Tainted: G        W       4.11.0-rc1 #2
[ 5755.735606] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.735608] Workqueue: kblockd blk_mq_run_work_fn
[ 5755.735611] Call Trace:
[ 5755.735614]  dump_stack+0x4f/0x73
[ 5755.735616]  warn_alloc+0xde/0x170
[ 5755.735619]  ? wake_all_kswapds+0x60/0xa0
[ 5755.735621]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.735624]  ? cpumask_next_and+0x2b/0x40
[ 5755.735627]  ? cpuacct_charge+0x75/0x90
[ 5755.735630]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.735633]  alloc_pages_current+0x90/0x140
[ 5755.735637]  kmalloc_order_trace+0x29/0xf0
[ 5755.735638]  ? __kmalloc+0x17a/0x1a0
[ 5755.735642]  __kmalloc+0x17a/0x1a0
[ 5755.735644]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.735647]  ? insert_work+0x4a/0xc0
[ 5755.735649]  ? preempt_count_add+0xa3/0xc0
[ 5755.735651]  ? _raw_spin_unlock+0x11/0x30
[ 5755.735653]  ? __queue_work+0x16a/0x4a0
[ 5755.735657]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5755.735660]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5755.735662]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5755.735665]  blk_mq_run_work_fn+0xd/0x10
[ 5755.735667]  process_one_work+0x1ee/0x4a0
[ 5755.735670]  worker_thread+0x43/0x4e0
[ 5755.735674]  kthread+0xfc/0x130
[ 5755.735676]  ? process_one_work+0x4a0/0x4a0
[ 5755.735678]  ? kthread_create_on_node+0x40/0x40
[ 5755.735681]  ret_from_fork+0x29/0x40
[ 5755.736431] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.736457] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5755.736474] CPU: 3 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5755.736483] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.736488] Workqueue: writeback wb_workfn (flush-259:0)
[ 5755.736506] Call Trace:
[ 5755.736517]  dump_stack+0x4f/0x73
[ 5755.736525]  warn_alloc+0xde/0x170
[ 5755.736532]  ? wake_all_kswapds+0x60/0xa0
[ 5755.736537]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.736551]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.736561]  alloc_pages_current+0x90/0x140
[ 5755.736570]  kmalloc_order_trace+0x29/0xf0
[ 5755.736576]  __kmalloc+0x17a/0x1a0
[ 5755.736587]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.736596]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5755.736604]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5755.736612]  ? blk_mq_get_tag+0x82/0x2b0
[ 5755.736621]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5755.736624]  blk_mq_make_request+0x1ef/0x750
[ 5755.736627]  ? preempt_count_add+0x7c/0xc0
[ 5755.736630]  generic_make_request+0xcf/0x1d0
[ 5755.736633]  submit_bio+0x6e/0x150
[ 5755.736635]  ? bio_alloc_bioset+0x14b/0x240
[ 5755.736649]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5755.736663]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5755.736668]  write_cache_pages+0x1ec/0x4c0
[ 5755.736681]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5755.736696]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5755.736700]  do_writepages+0x19/0x30
[ 5755.736703]  __writeback_single_inode+0x40/0x390
[ 5755.736704]  ? preempt_count_add+0xa3/0xc0
[ 5755.736707]  writeback_sb_inodes+0x23a/0x4b0
[ 5755.736710]  __writeback_inodes_wb+0x8d/0xc0
[ 5755.736712]  wb_writeback+0x269/0x310
[ 5755.736716]  wb_workfn+0x2cc/0x410
[ 5755.736719]  process_one_work+0x1ee/0x4a0
[ 5755.736722]  worker_thread+0x43/0x4e0
[ 5755.736724]  kthread+0xfc/0x130
[ 5755.736726]  ? process_one_work+0x4a0/0x4a0
[ 5755.736728]  ? kthread_create_on_node+0x40/0x40
[ 5755.736732]  ret_from_fork+0x29/0x40
[ 5755.736739] kworker/3:1H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.736744] kworker/3:1H cpuset=/ mems_allowed=0
[ 5755.736749] CPU: 3 PID: 1445 Comm: kworker/3:1H Tainted: G        W       4.11.0-rc1 #2
[ 5755.736751] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.736754] Workqueue: kblockd blk_mq_run_work_fn
[ 5755.736756] Call Trace:
[ 5755.736760]  dump_stack+0x4f/0x73
[ 5755.736762]  warn_alloc+0xde/0x170
[ 5755.736766]  ? wake_all_kswapds+0x60/0xa0
[ 5755.736769]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.736774]  ? cpumask_next_and+0x2b/0x40
[ 5755.736776]  ? cpuacct_charge+0x75/0x90
[ 5755.736779]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.736782]  alloc_pages_current+0x90/0x140
[ 5755.736784]  kmalloc_order_trace+0x29/0xf0
[ 5755.736788]  ? __kmalloc+0x17a/0x1a0
[ 5755.736790]  __kmalloc+0x17a/0x1a0
[ 5755.736792]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.736794]  ? insert_work+0x4a/0xc0
[ 5755.736795]  ? preempt_count_add+0xa3/0xc0
[ 5755.736798]  ? _raw_spin_unlock+0x11/0x30
[ 5755.736803]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5755.736806]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5755.736811]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5755.736815]  blk_mq_run_work_fn+0xd/0x10
[ 5755.736821]  process_one_work+0x1ee/0x4a0
[ 5755.736829]  worker_thread+0x43/0x4e0
[ 5755.736837]  kthread+0xfc/0x130
[ 5755.736845]  ? process_one_work+0x4a0/0x4a0
[ 5755.736853]  ? kthread_create_on_node+0x40/0x40
[ 5755.736860]  ret_from_fork+0x29/0x40
[ 5755.737407] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.737412] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5755.737416] CPU: 3 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5755.737417] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.737419] Workqueue: writeback wb_workfn (flush-259:0)
[ 5755.737422] Call Trace:
[ 5755.737425]  dump_stack+0x4f/0x73
[ 5755.737427]  warn_alloc+0xde/0x170
[ 5755.737429]  ? wake_all_kswapds+0x60/0xa0
[ 5755.737431]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.737435]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.737437]  alloc_pages_current+0x90/0x140
[ 5755.737441]  kmalloc_order_trace+0x29/0xf0
[ 5755.737443]  __kmalloc+0x17a/0x1a0
[ 5755.737446]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.737448]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5755.737449]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5755.737451]  ? blk_mq_get_tag+0x82/0x2b0
[ 5755.737454]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5755.737457]  blk_mq_make_request+0x1ef/0x750
[ 5755.737459]  ? preempt_count_add+0x7c/0xc0
[ 5755.737461]  generic_make_request+0xcf/0x1d0
[ 5755.737463]  submit_bio+0x6e/0x150
[ 5755.737465]  ? bio_alloc_bioset+0x14b/0x240
[ 5755.737478]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5755.737492]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5755.737496]  write_cache_pages+0x1ec/0x4c0
[ 5755.737509]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5755.737523]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5755.737525]  do_writepages+0x19/0x30
[ 5755.737527]  __writeback_single_inode+0x40/0x390
[ 5755.737529]  ? preempt_count_add+0xa3/0xc0
[ 5755.737531]  writeback_sb_inodes+0x23a/0x4b0
[ 5755.737534]  __writeback_inodes_wb+0x8d/0xc0
[ 5755.737536]  wb_writeback+0x269/0x310
[ 5755.737539]  wb_workfn+0x2cc/0x410
[ 5755.737541]  process_one_work+0x1ee/0x4a0
[ 5755.737544]  worker_thread+0x43/0x4e0
[ 5755.737546]  kthread+0xfc/0x130
[ 5755.737548]  ? process_one_work+0x4a0/0x4a0
[ 5755.737550]  ? kthread_create_on_node+0x40/0x40
[ 5755.737552]  ret_from_fork+0x29/0x40
[ 5755.737568] kworker/3:1H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.737583] kworker/3:1H cpuset=/ mems_allowed=0
[ 5755.737597] CPU: 3 PID: 1445 Comm: kworker/3:1H Tainted: G        W       4.11.0-rc1 #2
[ 5755.737602] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.737606] Workqueue: kblockd blk_mq_run_work_fn
[ 5755.737612] Call Trace:
[ 5755.737617]  dump_stack+0x4f/0x73
[ 5755.737622]  warn_alloc+0xde/0x170
[ 5755.737628]  ? wake_all_kswapds+0x60/0xa0
[ 5755.737633]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.737637]  ? cpumask_next_and+0x2b/0x40
[ 5755.737642]  ? cpuacct_charge+0x75/0x90
[ 5755.737647]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.737653]  alloc_pages_current+0x90/0x140
[ 5755.737657]  kmalloc_order_trace+0x29/0xf0
[ 5755.737661]  ? __kmalloc+0x17a/0x1a0
[ 5755.737666]  __kmalloc+0x17a/0x1a0
[ 5755.737671]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.737676]  ? insert_work+0x4a/0xc0
[ 5755.737679]  ? preempt_count_add+0xa3/0xc0
[ 5755.737681]  ? _raw_spin_unlock+0x11/0x30
[ 5755.737684]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5755.737685]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5755.737687]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5755.737689]  blk_mq_run_work_fn+0xd/0x10
[ 5755.737691]  process_one_work+0x1ee/0x4a0
[ 5755.737693]  worker_thread+0x43/0x4e0
[ 5755.737695]  kthread+0xfc/0x130
[ 5755.737697]  ? process_one_work+0x4a0/0x4a0
[ 5755.737698]  ? kthread_create_on_node+0x40/0x40
[ 5755.737700]  ret_from_fork+0x29/0x40
[ 5755.738309] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.738313] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5755.738317] CPU: 3 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5755.738318] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.738320] Workqueue: writeback wb_workfn (flush-259:0)
[ 5755.738322] Call Trace:
[ 5755.738324]  dump_stack+0x4f/0x73
[ 5755.738326]  warn_alloc+0xde/0x170
[ 5755.738327]  ? wake_all_kswapds+0x60/0xa0
[ 5755.738329]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.738331]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.738333]  alloc_pages_current+0x90/0x140
[ 5755.738335]  kmalloc_order_trace+0x29/0xf0
[ 5755.738337]  __kmalloc+0x17a/0x1a0
[ 5755.738339]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.738341]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5755.738343]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5755.738344]  ? blk_mq_get_tag+0x82/0x2b0
[ 5755.738347]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5755.738349]  blk_mq_make_request+0x1ef/0x750
[ 5755.738351]  ? preempt_count_add+0x7c/0xc0
[ 5755.738354]  generic_make_request+0xcf/0x1d0
[ 5755.738356]  submit_bio+0x6e/0x150
[ 5755.738358]  ? bio_alloc_bioset+0x14b/0x240
[ 5755.738370]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5755.738383]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5755.738386]  write_cache_pages+0x1ec/0x4c0
[ 5755.738399]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5755.738411]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5755.738414]  do_writepages+0x19/0x30
[ 5755.738415]  __writeback_single_inode+0x40/0x390
[ 5755.738417]  ? preempt_count_add+0xa3/0xc0
[ 5755.738419]  writeback_sb_inodes+0x23a/0x4b0
[ 5755.738421]  __writeback_inodes_wb+0x8d/0xc0
[ 5755.738423]  wb_writeback+0x269/0x310
[ 5755.738425]  wb_workfn+0x2cc/0x410
[ 5755.738428]  process_one_work+0x1ee/0x4a0
[ 5755.738430]  worker_thread+0x43/0x4e0
[ 5755.738432]  kthread+0xfc/0x130
[ 5755.738433]  ? process_one_work+0x4a0/0x4a0
[ 5755.738435]  ? kthread_create_on_node+0x40/0x40
[ 5755.738437]  ret_from_fork+0x29/0x40
[ 5755.738450] kworker/3:1H: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.738456] kworker/3:1H cpuset=/ mems_allowed=0
[ 5755.738460] CPU: 3 PID: 1445 Comm: kworker/3:1H Tainted: G        W       4.11.0-rc1 #2
[ 5755.738461] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.738463] Workqueue: kblockd blk_mq_run_work_fn
[ 5755.738466] Call Trace:
[ 5755.738469]  dump_stack+0x4f/0x73
[ 5755.738477]  warn_alloc+0xde/0x170
[ 5755.738485]  ? wake_all_kswapds+0x60/0xa0
[ 5755.738492]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.738498]  ? cpumask_next_and+0x2b/0x40
[ 5755.738508]  ? cpuacct_charge+0x75/0x90
[ 5755.738514]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.738525]  alloc_pages_current+0x90/0x140
[ 5755.738532]  kmalloc_order_trace+0x29/0xf0
[ 5755.738537]  ? __kmalloc+0x17a/0x1a0
[ 5755.738545]  __kmalloc+0x17a/0x1a0
[ 5755.738551]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.738560]  ? insert_work+0x4a/0xc0
[ 5755.738568]  ? preempt_count_add+0xa3/0xc0
[ 5755.738579]  ? _raw_spin_unlock+0x11/0x30
[ 5755.738586]  blk_mq_dispatch_rq_list+0x1a7/0x370
[ 5755.738597]  blk_mq_sched_dispatch_requests+0xe3/0x170
[ 5755.738603]  __blk_mq_run_hw_queue+0x9e/0xc0
[ 5755.738610]  blk_mq_run_work_fn+0xd/0x10
[ 5755.738615]  process_one_work+0x1ee/0x4a0
[ 5755.738624]  worker_thread+0x43/0x4e0
[ 5755.738632]  kthread+0xfc/0x130
[ 5755.738639]  ? process_one_work+0x4a0/0x4a0
[ 5755.738646]  ? kthread_create_on_node+0x40/0x40
[ 5755.738651]  ret_from_fork+0x29/0x40
[ 5755.740306] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
[ 5755.740312] kworker/u16:1 cpuset=/ mems_allowed=0
[ 5755.740317] CPU: 3 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
[ 5755.740318] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
[ 5755.740321] Workqueue: writeback wb_workfn (flush-259:0)
[ 5755.740324] Call Trace:
[ 5755.740328]  dump_stack+0x4f/0x73
[ 5755.740330]  warn_alloc+0xde/0x170
[ 5755.740333]  ? wake_all_kswapds+0x60/0xa0
[ 5755.740335]  __alloc_pages_slowpath+0xe21/0xe50
[ 5755.740339]  ? preempt_schedule+0x20/0x30
[ 5755.740341]  ? ___preempt_schedule+0x16/0x18
[ 5755.740343]  ? preempt_count_add+0xa3/0xc0
[ 5755.740346]  __alloc_pages_nodemask+0x1c6/0x1e0
[ 5755.740349]  alloc_pages_current+0x90/0x140
[ 5755.740351]  kmalloc_order_trace+0x29/0xf0
[ 5755.740354]  __kmalloc+0x17a/0x1a0
[ 5755.740356]  nvme_queue_rq+0x12f/0x860 [nvme]
[ 5755.740359]  ? __sbitmap_queue_get+0x2b/0xa0
[ 5755.740361]  ? __blk_mq_get_tag.isra.7+0x62/0x70
[ 5755.740363]  ? blk_mq_get_tag+0x82/0x2b0
[ 5755.740366]  blk_mq_try_issue_directly+0x8f/0xe0
[ 5755.740369]  blk_mq_make_request+0x1ef/0x750
[ 5755.740371]  ? preempt_count_add+0x7c/0xc0
[ 5755.740374]  generic_make_request+0xcf/0x1d0
[ 5755.740376]  submit_bio+0x6e/0x150
[ 5755.740377]  ? bio_alloc_bioset+0x14b/0x240
[ 5755.740393]  xfs_add_to_ioend+0xf5/0x1e0 [xfs]
[ 5755.740406]  xfs_do_writepage+0x2d7/0x740 [xfs]
[ 5755.740409]  write_cache_pages+0x1ec/0x4c0
[ 5755.740423]  ? xfs_add_to_ioend+0x1e0/0x1e0 [xfs]
[ 5755.740437]  xfs_vm_writepages+0x56/0x80 [xfs]
[ 5755.740440]  do_writepages+0x19/0x30
[ 5755.740442]  __writeback_single_inode+0x40/0x390
[ 5755.740444]  ? preempt_count_add+0xa3/0xc0
[ 5755.740446]  writeback_sb_inodes+0x23a/0x4b0
[ 5755.740449]  __writeback_inodes_wb+0x8d/0xc0
[ 5755.740451]  wb_writeback+0x269/0x310
[ 5755.740454]  wb_workfn+0x2cc/0x410
[ 5755.740457]  process_one_work+0x1ee/0x4a0
[ 5755.740459]  worker_thread+0x43/0x4e0
[ 5755.740462]  kthread+0xfc/0x130
[ 5755.740464]  ? process_one_work+0x4a0/0x4a0
[ 5755.740467]  ? kthread_create_on_node+0x40/0x40
[ 5755.740470]  ret_from_fork+0x29/0x40
[ 5828.411215] nvme nvme0: I/O 858 QID 4 timeout, aborting
[ 5828.411366] nvme nvme0: I/O 859 QID 4 timeout, aborting
[ 5828.411371] nvme nvme0: I/O 860 QID 4 timeout, aborting
[ 5828.411374] nvme nvme0: I/O 861 QID 4 timeout, aborting
[ 5828.411378] nvme nvme0: I/O 862 QID 4 timeout, aborting
[ 5828.411381] nvme nvme0: I/O 863 QID 4 timeout, aborting
[ 5828.411433] nvme nvme0: I/O 864 QID 4 timeout, aborting
[ 5828.411437] nvme nvme0: I/O 865 QID 4 timeout, aborting
[ 5828.418066] nvme nvme0: completing aborted command with status: 0000
[ 5828.424271] nvme nvme0: completing aborted command with status: 0000
[ 5828.433682] nvme nvme0: completing aborted command with status: 0000
[ 5828.438081] nvme nvme0: completing aborted command with status: 0000
[ 5828.545962] nvme nvme0: completing aborted command with status: 0000
[ 5828.554969] nvme nvme0: completing aborted command with status: 0000
[ 5828.555886] nvme nvme0: completing aborted command with status: 0000
[ 5828.558622] nvme nvme0: completing aborted command with status: 0000
[ 5828.851854] nvme nvme0: Abort status: 0x0
[ 5828.851861] nvme nvme0: Abort status: 0x0
[ 5828.851878] nvme nvme0: Abort status: 0x0
[ 5828.851893] nvme nvme0: Abort status: 0x0
[ 5828.980142] nvme nvme0: Abort status: 0x0
[ 5828.980167] nvme nvme0: Abort status: 0x0
[ 5828.980174] nvme nvme0: Abort status: 0x0
[ 5828.980179] nvme nvme0: Abort status: 0x0
[ 5829.436311] nvme nvme0: I/O 200 QID 3 timeout, aborting
[ 5829.436321] nvme nvme0: I/O 201 QID 3 timeout, aborting
[ 5829.436324] nvme nvme0: I/O 202 QID 3 timeout, aborting
[ 5829.436327] nvme nvme0: I/O 203 QID 3 timeout, aborting
[ 5829.436329] nvme nvme0: I/O 204 QID 3 timeout, aborting
[ 5829.436332] nvme nvme0: I/O 205 QID 3 timeout, aborting
[ 5829.436334] nvme nvme0: I/O 206 QID 3 timeout, aborting
[ 5829.436337] nvme nvme0: I/O 207 QID 3 timeout, aborting
[ 5829.500268] nvme nvme0: completing aborted command with status: 0000
[ 5829.502481] nvme nvme0: completing aborted command with status: 0000
[ 5829.522320] nvme nvme0: completing aborted command with status: 0000
[ 5829.522993] nvme nvme0: completing aborted command with status: 0000
[ 5829.631378] nvme nvme0: completing aborted command with status: 0000
[ 5829.634766] nvme nvme0: completing aborted command with status: 0000
[ 5829.646204] nvme nvme0: completing aborted command with status: 0000
[ 5829.647189] nvme nvme0: completing aborted command with status: 0000
[ 5829.960462] nvme nvme0: Abort status: 0x0
[ 5829.960470] nvme nvme0: Abort status: 0x0
[ 5829.960484] nvme nvme0: Abort status: 0x0
[ 5829.960498] nvme nvme0: Abort status: 0x0
[ 5830.082311] nvme nvme0: Abort status: 0x0
[ 5830.082316] nvme nvme0: Abort status: 0x0
[ 5830.082332] nvme nvme0: Abort status: 0x0
[ 5830.082346] nvme nvme0: Abort status: 0x0
[ 5830.459096] nvme nvme0: I/O 434 QID 3 timeout, aborting
[ 5830.459106] nvme nvme0: I/O 435 QID 3 timeout, aborting
[ 5830.459109] nvme nvme0: I/O 436 QID 3 timeout, aborting
[ 5830.459112] nvme nvme0: I/O 437 QID 3 timeout, aborting
[ 5830.459114] nvme nvme0: I/O 438 QID 3 timeout, aborting
[ 5830.459117] nvme nvme0: I/O 439 QID 3 timeout, aborting
[ 5830.459119] nvme nvme0: I/O 440 QID 3 timeout, aborting
[ 5830.459128] nvme nvme0: I/O 620 QID 3 timeout, aborting
[ 5830.934756] nvme nvme0: Abort status: 0x0
[ 5830.934765] nvme nvme0: Abort status: 0x0
[ 5830.934777] nvme nvme0: Abort status: 0x0
[ 5830.934792] nvme nvme0: Abort status: 0x0
[ 5831.062998] nvme nvme0: Abort status: 0x0
[ 5831.063010] nvme nvme0: Abort status: 0x0
[ 5831.063044] nvme nvme0: Abort status: 0x0
[ 5831.063052] nvme nvme0: Abort status: 0x0
[ 5833.403976] nvme nvme0: I/O 168 QID 5 timeout, aborting
[ 5833.403986] nvme nvme0: I/O 169 QID 5 timeout, aborting
[ 5833.403990] nvme nvme0: I/O 170 QID 5 timeout, aborting
[ 5833.403992] nvme nvme0: I/O 171 QID 5 timeout, aborting
[ 5833.403995] nvme nvme0: I/O 172 QID 5 timeout, aborting
[ 5833.403997] nvme nvme0: I/O 173 QID 5 timeout, aborting
[ 5833.403999] nvme nvme0: I/O 174 QID 5 timeout, aborting
[ 5833.404001] nvme nvme0: I/O 175 QID 5 timeout, aborting
[ 5833.464900] nvme nvme0: completing aborted command with status: 0000
[ 5833.509649] nvme nvme0: completing aborted command with status: 0000
[ 5833.510148] nvme nvme0: completing aborted command with status: 0000
[ 5833.516177] nvme nvme0: completing aborted command with status: 0000
[ 5833.599807] nvme nvme0: completing aborted command with status: 0000
[ 5833.608390] nvme nvme0: completing aborted command with status: 0000
[ 5833.608896] nvme nvme0: completing aborted command with status: 0000
[ 5833.611070] nvme nvme0: completing aborted command with status: 0000
[ 5833.878793] nvme nvme0: Abort status: 0x0
[ 5833.878801] nvme nvme0: Abort status: 0x0
[ 5833.878816] nvme nvme0: Abort status: 0x0
[ 5833.878829] nvme nvme0: Abort status: 0x0
[ 5834.000142] nvme nvme0: Abort status: 0x0
[ 5834.000149] nvme nvme0: Abort status: 0x0
[ 5834.000163] nvme nvme0: Abort status: 0x0
[ 5834.000179] nvme nvme0: Abort status: 0x0
[ 5834.049573] nvme nvme0: completing aborted command with status: 0000
[ 5834.150235] nvme nvme0: completing aborted command with status: 0000
[ 5834.156259] nvme nvme0: completing aborted command with status: 0000
[ 5834.172281] nvme nvme0: completing aborted command with status: 0000
[ 5834.177930] nvme nvme0: completing aborted command with status: 0000
[ 5834.274187] nvme nvme0: completing aborted command with status: 0000
[ 5834.280360] nvme nvme0: completing aborted command with status: 0000
[ 5834.291983] nvme nvme0: completing aborted command with status: 0000
[ 5838.522866] nvme nvme0: I/O 477 QID 3 timeout, aborting
[ 5838.522873] nvme nvme0: I/O 478 QID 3 timeout, aborting
[ 5838.522875] nvme nvme0: I/O 479 QID 3 timeout, aborting
[ 5838.522877] nvme nvme0: I/O 480 QID 3 timeout, aborting
[ 5838.522879] nvme nvme0: I/O 481 QID 3 timeout, aborting
[ 5838.522880] nvme nvme0: I/O 482 QID 3 timeout, aborting
[ 5838.522882] nvme nvme0: I/O 483 QID 3 timeout, aborting
[ 5838.522883] nvme nvme0: I/O 484 QID 3 timeout, aborting
[ 5838.541555] nvme nvme0: completing aborted command with status: 0000
[ 5838.546046] nvme nvme0: completing aborted command with status: 0000
[ 5838.550324] nvme nvme0: completing aborted command with status: 0000
[ 5838.563819] nvme nvme0: completing aborted command with status: 0000
[ 5838.710866] nvme nvme0: completing aborted command with status: 0000
[ 5838.713500] nvme nvme0: completing aborted command with status: 0000
[ 5838.735142] nvme nvme0: completing aborted command with status: 0000
[ 5838.735860] nvme nvme0: completing aborted command with status: 0000
[ 5838.978930] nvme nvme0: Abort status: 0x0
[ 5838.978948] nvme nvme0: Abort status: 0x0
[ 5838.978960] nvme nvme0: Abort status: 0x0
[ 5838.978974] nvme nvme0: Abort status: 0x0
[ 5839.126761] nvme nvme0: Abort status: 0x0
[ 5839.126783] nvme nvme0: Abort status: 0x0
[ 5839.126796] nvme nvme0: Abort status: 0x0
[ 5839.126812] nvme nvme0: Abort status: 0x0
[ 5843.642569] nvme nvme0: I/O 350 QID 3 timeout, aborting
[ 5843.642579] nvme nvme0: I/O 351 QID 3 timeout, aborting
[ 5843.642583] nvme nvme0: I/O 352 QID 3 timeout, aborting
[ 5843.642591] nvme nvme0: I/O 612 QID 3 timeout, aborting
[ 5843.642593] nvme nvme0: I/O 613 QID 3 timeout, aborting
[ 5843.642596] nvme nvme0: I/O 614 QID 3 timeout, aborting
[ 5843.642598] nvme nvme0: I/O 615 QID 3 timeout, aborting
[ 5843.642601] nvme nvme0: I/O 616 QID 3 timeout, aborting
[ 5843.724737] nvme nvme0: completing aborted command with status: 0000
[ 5843.729014] nvme nvme0: completing aborted command with status: 0000
[ 5843.747001] nvme nvme0: completing aborted command with status: 0000
[ 5843.747673] nvme nvme0: completing aborted command with status: 0000
[ 5843.848971] nvme nvme0: completing aborted command with status: 0000
[ 5843.855800] nvme nvme0: completing aborted command with status: 0000
[ 5843.868060] nvme nvme0: completing aborted command with status: 0000
[ 5843.868736] nvme nvme0: completing aborted command with status: 0000
[ 5844.159124] nvme nvme0: Abort status: 0x0
[ 5844.159141] nvme nvme0: Abort status: 0x0
[ 5844.159153] nvme nvme0: Abort status: 0x0
[ 5844.159162] nvme nvme0: Abort status: 0x0
[ 5844.282488] nvme nvme0: Abort status: 0x0
[ 5844.282493] nvme nvme0: Abort status: 0x0
[ 5844.282495] nvme nvme0: Abort status: 0x0
[ 5844.282511] nvme nvme0: Abort status: 0x0

On Sunday, March 5, 2017 7:57:40 PM MST Thomas Fjellstrom wrote:
> On Friday, March 3, 2017 8:27:40 AM MST Thomas Fjellstrom wrote:
> > I just got a new Samsung 960 Evo 256GB m.2 nvme drive, and put it through
> > some tests.
> > 
> > When I run `iozone -a -s 60G` on my desktop (that has 32GB ram and a amd FX
> > 8320), i run into some errors. One time the drive completely dropped from
> > the system (ok, only the dev device did, it still appeared in lspci) and I
> > had to reboot. The later attempt's results can be seen in the attached file
> > (its 5000 lines, so I didn't think it was good to post inline).
> > 
> > I realize that iozone isn't a good indicator of real world performance, I
> > just wanted to see some numbers :D and to stress test the card a bit.
> > 
> > I doubt this is expected behavior regardless of how pointless the exercise
> > is.
> > 
> > I'm running kernel 4.9.13 from debian sid/unstable at the moment.
> > 
> > Please CC me, as I'm not currently subscribed to the list.
> > 
> > Thanks.
> 
> Did some more testing today. Windows seems to be fine with the "same" testing
> using iozone3.
> 
> I upgraded to kernel 4.10 and I'm still having issues. Is this a block mq
> issue? It doesn't even get through the initial (4k) pass before the
> system starts to lag out. I didn't let it run long enough this time to throw 
> errors from nvme.
> 
> What can I do to trouble shoot this further?
> 
[snip old log]


-- 
Thomas Fjellstrom
thomas at fjellstrom.ca
