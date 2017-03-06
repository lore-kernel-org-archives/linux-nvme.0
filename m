From: keith.busch@intel.com (Keith Busch)
Date: Mon, 6 Mar 2017 17:46:33 -0500
Subject: nvme, allocation failures, and aborted commands
In-Reply-To: <24015519.RaUGNvtkS7@natasha>
References: <2324331.vgmPNSfijK@natasha> <1898554.3jK49l1AhF@natasha>
 <24015519.RaUGNvtkS7@natasha>
Message-ID: <20170306224633.GA21202@localhost.localdomain>

On Sun, Mar 05, 2017@11:11:45PM -0700, Thomas Fjellstrom wrote:
> Tonight I decided to try kernel 4.11-rc1. Still getting page allocation
> failures and aborted nvme commands once iozone gets to the fwrite/fread
> testing.
> 
> The taint seems to be comming from previos warnings from the radeon kernel 
> driver.
> 
> Its a pretty simple: iozone -a -s 64G  run. 
> 
> new log:
> 
> [ 5710.312195] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
> [ 5710.312202] kworker/u16:1 cpuset=/ mems_allowed=0
> [ 5710.312208] CPU: 1 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
> [ 5710.312209] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
> [ 5710.312214] Workqueue: writeback wb_workfn (flush-259:0)
> [ 5710.312217] Call Trace:
> [ 5710.312223]  dump_stack+0x4f/0x73
> [ 5710.312225]  warn_alloc+0xde/0x170
> [ 5710.312227]  ? wake_all_kswapds+0x60/0xa0
> [ 5710.312229]  __alloc_pages_slowpath+0xe21/0xe50
> [ 5710.312232]  ? __inc_zone_state+0x42/0xb0
> [ 5710.312235]  ? preempt_count_add+0xa3/0xc0
> [ 5710.312236]  __alloc_pages_nodemask+0x1c6/0x1e0
> [ 5710.312239]  alloc_pages_current+0x90/0x140
> [ 5710.312241]  kmalloc_order_trace+0x29/0xf0
> [ 5710.312243]  ? alloc_pages_current+0x90/0x140
> [ 5710.312245]  __kmalloc+0x17a/0x1a0
> [ 5710.312250]  nvme_queue_rq+0x12f/0x860 [nvme]
> [ 5710.312253]  ? __sbitmap_queue_get+0x2b/0xa0
> [ 5710.312255]  ? __blk_mq_get_tag.isra.7+0x62/0x70
> [ 5710.312256]  ? blk_mq_get_tag+0x82/0x2b0
> [ 5710.312258]  blk_mq_try_issue_directly+0x8f/0xe0
> [ 5710.312260]  blk_mq_make_request+0x1ef/0x750

I'm not familiar with iozone, but I'll offer what the nvme driver is
doing here.

The error says we failed to allocate 2 physically continguous pages from
nvme_queue_rq. The only thing we allocate is a driver IO descriptor. Order
2 means your data transfer for this IO is pretty large, somewhere between
1 and 4MB. I don't think we need contiguous memory here, though; I'll
see if we can use vmalloc in case memory is heavily fragmented.

On the timeout/abort, this appears to be happening on a functioning
device completing commands just slower than the kernel's timeout.
If your io test creates a very high outstanding depth with very large
transfer sizes, it's possible to create tail latencies higher than the
default 30 second timeout (YMMV, check your device's capabilities).

Could you throttle the device's max transfer and queue depth prior to
running your IO test and see if the error messages clear up? For example:

  echo 128 > /sys/block/nvme0n1/queue/max_hw_sectors_kb
  echo 128 > /sys/block/nvme0n1/queue/max_nr_requests
