From: keith.busch@intel.com (Keith Busch)
Date: Fri, 14 Nov 2014 17:05:58 +0000 (UTC)
Subject: [PATCH] NVMe: Add rw_page support
In-Reply-To: <54662E8B.9070409@kernel.dk>
References: <1415923538-18760-1-git-send-email-keith.busch@intel.com>
 <54655B01.9090206@kernel.dk> <20141114145858.GF11522@wil.cx>
 <54661AC5.7000605@kernel.dk> <20141114155223.GG11522@wil.cx>
 <54662E8B.9070409@kernel.dk>
Message-ID: <alpine.LNX.2.00.1411141633180.4225@localhost.lm.intel.com>

On Fri, 14 Nov 2014, Jens Axboe wrote:
> For the cases where you do indeed end up submitting multiple, it's even
> more of a shame to bypass the normal IO path. There are various tricks
> we can do in there to speed things up, like batched doorbell rings. And
> if we kill that last alloc/free per IO, then I'd really be curious to
> know why rw_page is faster. Seems it should be possible to fix that up
> instead.

Here's some perf data of just the kernel from two runs with a simple
swap testing program. I'm a novice at interpreting this for comparison,
so I'm not sure if this shows what we're looking for. The test ran for
the same amount of time in both cases, but perf couted ~16% fewer events
when using rw_page.

With rw_page disabled:

      7.33%  swap     [kernel.kallsyms]  [k] page_fault
      5.13%  swap     [kernel.kallsyms]  [k] clear_page_c
      4.46%  swap     [kernel.kallsyms]  [k] __radix_tree_lookup
      4.36%  swap     [kernel.kallsyms]  [k] do_raw_spin_lock
      2.63%  swap     [kernel.kallsyms]  [k] handle_mm_fault
      2.17%  swap     [kernel.kallsyms]  [k] get_page_from_freelist
      1.77%  swap     [kernel.kallsyms]  [k] __swap_duplicate
      1.53%  swap     [nvme]             [k] nvme_queue_rq
      1.38%  swap     [kernel.kallsyms]  [k] intel_pmu_disable_all
      1.37%  swap     [kernel.kallsyms]  [k] put_page_testzero
      1.19%  swap     [kernel.kallsyms]  [k] __do_page_fault
      1.05%  swap     [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
      0.99%  swap     [kernel.kallsyms]  [k] __free_one_page
      0.97%  swap     [kernel.kallsyms]  [k] swap_info_get
      0.90%  swap     [kernel.kallsyms]  [k] __alloc_pages_nodemask
      0.80%  swap     [kernel.kallsyms]  [k] radix_tree_insert
      0.78%  swap     [kernel.kallsyms]  [k] test_and_set_bit.constprop.90
      0.74%  swap     [kernel.kallsyms]  [k] __bt_get
      0.71%  swap     [kernel.kallsyms]  [k] sg_init_table
      0.71%  swap     [kernel.kallsyms]  [k] list_del
      0.70%  swap     [kernel.kallsyms]  [k] ____cache_alloc
      0.67%  swap     [kernel.kallsyms]  [k] __schedule
      0.66%  swap     [kernel.kallsyms]  [k] round_jiffies_common
      0.63%  swap     [kernel.kallsyms]  [k] __wait_on_bit
      0.61%  swap     [kernel.kallsyms]  [k] __rmqueue
      0.60%  swap     [kernel.kallsyms]  [k] vmacache_find
      0.54%  swap     [kernel.kallsyms]  [k] __blk_bios_map_sg
      0.54%  swap     [kernel.kallsyms]  [k] blk_mq_start_request
      0.53%  swap     [kernel.kallsyms]  [k] unmap_single_vma
      0.52%  swap     [kernel.kallsyms]  [k] __update_tg_runnable_avg.isra.23
      0.52%  swap     [kernel.kallsyms]  [k] __blk_mq_alloc_request
      0.51%  swap     [kernel.kallsyms]  [k] swiotlb_map_sg_attrs
      0.49%  swap     [nvme]             [k] nvme_alloc_iod
      0.49%  swap     [kernel.kallsyms]  [k] update_cfs_shares
      0.47%  swap     [kernel.kallsyms]  [k] __add_to_swap_cache
      0.46%  swap     [kernel.kallsyms]  [k] update_curr
      0.46%  swap     [kernel.kallsyms]  [k] swap_entry_free
      0.45%  swap     [kernel.kallsyms]  [k] swapin_readahead
      0.45%  swap     [kernel.kallsyms]  [k] __call_rcu.constprop.62
      0.44%  swap     [kernel.kallsyms]  [k] page_waitqueue
      0.44%  swap     [kernel.kallsyms]  [k] tag_get
      0.43%  swap     [kernel.kallsyms]  [k] next_zones_zonelist
      0.43%  swap     [kernel.kallsyms]  [k] kmem_cache_alloc
      0.42%  swap     [nvme]             [k] nvme_process_cq

With rw_page enabled:

      8.33%  swap     [kernel.kallsyms]  [k] page_fault
      6.36%  swap     [kernel.kallsyms]  [k] clear_page_c
      5.15%  swap     [kernel.kallsyms]  [k] do_raw_spin_lock
      5.10%  swap     [kernel.kallsyms]  [k] __radix_tree_lookup
      3.01%  swap     [kernel.kallsyms]  [k] handle_mm_fault
      2.57%  swap     [kernel.kallsyms]  [k] get_page_from_freelist
      2.06%  swap     [kernel.kallsyms]  [k] __swap_duplicate
      1.57%  swap     [kernel.kallsyms]  [k] put_page_testzero
      1.44%  swap     [kernel.kallsyms]  [k] intel_pmu_disable_all
      1.37%  swap     [kernel.kallsyms]  [k] test_and_set_bit.constprop.90
      1.20%  swap     [kernel.kallsyms]  [k] _raw_spin_lock_irqsave
      1.19%  swap     [kernel.kallsyms]  [k] __free_one_page
      1.15%  swap     [kernel.kallsyms]  [k] radix_tree_insert
      1.15%  swap     [kernel.kallsyms]  [k] __do_page_fault
      1.07%  swap     [kernel.kallsyms]  [k] swap_info_get
      0.89%  swap     [kernel.kallsyms]  [k] __alloc_pages_nodemask
      0.85%  swap     [kernel.kallsyms]  [k] list_del
      0.81%  swap     [kernel.kallsyms]  [k] __bt_get
      0.78%  swap     [nvme]             [k] nvme_rw_page
      0.74%  swap     [kernel.kallsyms]  [k] __rmqueue
      0.74%  swap     [kernel.kallsyms]  [k] __wait_on_bit
      0.69%  swap     [kernel.kallsyms]  [k] __schedule
      0.63%  swap     [kernel.kallsyms]  [k] unmap_single_vma
      0.62%  swap     [kernel.kallsyms]  [k] vmacache_find
      0.60%  swap     [kernel.kallsyms]  [k] update_cfs_shares
      0.59%  swap     [kernel.kallsyms]  [k] tag_get
      0.55%  swap     [kernel.kallsyms]  [k] update_curr
      0.53%  swap     [kernel.kallsyms]  [k] __update_tg_runnable_avg.isra.23
      0.51%  swap     [kernel.kallsyms]  [k] next_zones_zonelist
      0.51%  swap     [kernel.kallsyms]  [k] __radix_tree_create
      0.50%  swap     [kernel.kallsyms]  [k] __blk_mq_alloc_request
      0.50%  swap     [kernel.kallsyms]  [k] __call_rcu.constprop.62
      0.49%  swap     [kernel.kallsyms]  [k] page_waitqueue
      0.48%  swap     [kernel.kallsyms]  [k] swap_entry_free
      0.47%  swap     [kernel.kallsyms]  [k] __add_to_swap_cache
      0.46%  swap     [kernel.kallsyms]  [k] down_read_trylock
      0.44%  swap     [kernel.kallsyms]  [k] up_read
      0.43%  swap     [kernel.kallsyms]  [k] __wake_up_bit
      0.43%  swap     [kernel.kallsyms]  [k] io_schedule
      0.42%  swap     [kernel.kallsyms]  [k] __mod_zone_page_state
      0.42%  swap     [kernel.kallsyms]  [k] do_wp_page
      0.39%  swap     [kernel.kallsyms]  [k] __inc_zone_state
      0.39%  swap     [kernel.kallsyms]  [k] dequeue_task_fair
      0.39%  swap     [kernel.kallsyms]  [k] prepare_to_wait
