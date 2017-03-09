From: thomas@fjellstrom.ca (Thomas Fjellstrom)
Date: Thu, 09 Mar 2017 15:01:27 -0700
Subject: nvme, allocation failures, and aborted commands
In-Reply-To: <20170306224633.GA21202@localhost.localdomain>
References: <2324331.vgmPNSfijK@natasha> <24015519.RaUGNvtkS7@natasha>
 <20170306224633.GA21202@localhost.localdomain>
Message-ID: <3290252.oG8R0O7IFj@natasha>

On Monday, March 6, 2017 5:46:33 PM MST Keith Busch wrote:
> On Sun, Mar 05, 2017@11:11:45PM -0700, Thomas Fjellstrom wrote:
> > Tonight I decided to try kernel 4.11-rc1. Still getting page allocation
> > failures and aborted nvme commands once iozone gets to the fwrite/fread
> > testing.
> > 
> > The taint seems to be comming from previos warnings from the radeon kernel 
> > driver.
> > 
> > Its a pretty simple: iozone -a -s 64G  run. 
> > 
> > new log:
> > 
> > [ 5710.312195] kworker/u16:1: page allocation failure: order:2, mode:0x1084020(GFP_ATOMIC|__GFP_COMP), nodemask=(null)
> > [ 5710.312202] kworker/u16:1 cpuset=/ mems_allowed=0
> > [ 5710.312208] CPU: 1 PID: 30166 Comm: kworker/u16:1 Tainted: G        W       4.11.0-rc1 #2
> > [ 5710.312209] Hardware name: To be filled by O.E.M. To be filled by O.E.M./970 PRO GAMING/AURA, BIOS 0901 11/07/2016
> > [ 5710.312214] Workqueue: writeback wb_workfn (flush-259:0)
> > [ 5710.312217] Call Trace:
> > [ 5710.312223]  dump_stack+0x4f/0x73
> > [ 5710.312225]  warn_alloc+0xde/0x170
> > [ 5710.312227]  ? wake_all_kswapds+0x60/0xa0
> > [ 5710.312229]  __alloc_pages_slowpath+0xe21/0xe50
> > [ 5710.312232]  ? __inc_zone_state+0x42/0xb0
> > [ 5710.312235]  ? preempt_count_add+0xa3/0xc0
> > [ 5710.312236]  __alloc_pages_nodemask+0x1c6/0x1e0
> > [ 5710.312239]  alloc_pages_current+0x90/0x140
> > [ 5710.312241]  kmalloc_order_trace+0x29/0xf0
> > [ 5710.312243]  ? alloc_pages_current+0x90/0x140
> > [ 5710.312245]  __kmalloc+0x17a/0x1a0
> > [ 5710.312250]  nvme_queue_rq+0x12f/0x860 [nvme]
> > [ 5710.312253]  ? __sbitmap_queue_get+0x2b/0xa0
> > [ 5710.312255]  ? __blk_mq_get_tag.isra.7+0x62/0x70
> > [ 5710.312256]  ? blk_mq_get_tag+0x82/0x2b0
> > [ 5710.312258]  blk_mq_try_issue_directly+0x8f/0xe0
> > [ 5710.312260]  blk_mq_make_request+0x1ef/0x750
> 
> I'm not familiar with iozone, but I'll offer what the nvme driver is
> doing here.
> 
> The error says we failed to allocate 2 physically continguous pages from
> nvme_queue_rq. The only thing we allocate is a driver IO descriptor. Order
> 2 means your data transfer for this IO is pretty large, somewhere between
> 1 and 4MB. I don't think we need contiguous memory here, though; I'll
> see if we can use vmalloc in case memory is heavily fragmented.

My first report to linux-kernel included a log that wasn't sent to linux-nvme:
https://cloud.tomasu.org/index.php/s/DpGf6wKBLYrZGFG

In it you can see some Order 0 failures. I'm pretty sure that isn't supposed
to happen when a machine has 32GB ram, and much of it is page/disk cache.

The test often hit the error at the fread/fwrite tests. Sometimes sooner.

> On the timeout/abort, this appears to be happening on a functioning
> device completing commands just slower than the kernel's timeout.
> If your io test creates a very high outstanding depth with very large
> transfer sizes, it's possible to create tail latencies higher than the
> default 30 second timeout (YMMV, check your device's capabilities).

I'm not sure its /just/ slower. In one or two attempts, the drive completely
stopped working. Once the device nodes went away, and another it was
unresponsive.

> Could you throttle the device's max transfer and queue depth prior to
> running your IO test and see if the error messages clear up? For example:
> 
>   echo 128 > /sys/block/nvme0n1/queue/max_hw_sectors_kb
>   echo 128 > /sys/block/nvme0n1/queue/max_nr_requests
> 

First off, theres no max_nr_requests, and echoing into max_hw_sectors_kb gets
me a permission denied even as root no matter the value I tried.

I checked the scheduler, and it was set to none, so I've tried mq-deadline 
(with no other sysfs changes), and the first pass of the same iozone run
has not errored out, or put any errors or warnings in the kernel log.
I'm going to let this test run to see if maybe it'll just take longer to
show problems.

I suspect it might be possible that this Samsung 960 EVO just isn't capable
of absorbing all of the io that iozone on linux can throw at it without
some kind of scheduling?

On the run prior to the current I just reformatted and ran xfs straight on nvme0n1
with no other changes (before I was running in lvm or a partition) I got the
following: (so no allocation failures so far? but still its timing out)

[ 5340.265161] nvme nvme0: I/O 712 QID 7 timeout, aborting
[ 5340.265170] nvme nvme0: I/O 713 QID 7 timeout, aborting
[ 5340.265172] nvme nvme0: I/O 714 QID 7 timeout, aborting
[ 5340.265174] nvme nvme0: I/O 715 QID 7 timeout, aborting
[ 5340.265176] nvme nvme0: I/O 716 QID 7 timeout, aborting
[ 5340.265178] nvme nvme0: I/O 717 QID 7 timeout, aborting
[ 5340.265180] nvme nvme0: I/O 718 QID 7 timeout, aborting
[ 5340.265181] nvme nvme0: I/O 719 QID 7 timeout, aborting
[ 5340.300423] nvme nvme0: completing aborted command with status: 0000
[ 5340.301090] nvme nvme0: completing aborted command with status: 0000
[ 5340.307974] nvme nvme0: completing aborted command with status: 0000
[ 5340.308648] nvme nvme0: completing aborted command with status: 0000
[ 5340.351234] nvme nvme0: completing aborted command with status: 0000
[ 5340.353792] nvme nvme0: completing aborted command with status: 0000
[ 5340.358244] nvme nvme0: completing aborted command with status: 0000
[ 5340.404927] nvme nvme0: completing aborted command with status: 0000
[ 5340.518379] nvme nvme0: Abort status: 0x0
[ 5340.518386] nvme nvme0: Abort status: 0x0
[ 5340.518388] nvme nvme0: Abort status: 0x0
[ 5340.518397] nvme nvme0: Abort status: 0x0
[ 5340.571172] nvme nvme0: Abort status: 0x0
[ 5340.571178] nvme nvme0: Abort status: 0x0
[ 5340.571180] nvme nvme0: Abort status: 0x0
[ 5340.571195] nvme nvme0: Abort status: 0x0
[ 5343.848275] nvme nvme0: I/O 53 QID 7 timeout, aborting
[ 5343.848290] nvme nvme0: I/O 54 QID 7 timeout, aborting
[ 5343.848295] nvme nvme0: I/O 55 QID 7 timeout, aborting
[ 5343.848300] nvme nvme0: I/O 56 QID 7 timeout, aborting
[ 5343.848304] nvme nvme0: I/O 57 QID 7 timeout, aborting
[ 5343.848309] nvme nvme0: I/O 58 QID 7 timeout, aborting
[ 5343.848312] nvme nvme0: I/O 59 QID 7 timeout, aborting
[ 5343.848316] nvme nvme0: I/O 60 QID 7 timeout, aborting
[ 5343.866065] nvme nvme0: completing aborted command with status: 0000
[ 5343.870236] nvme nvme0: completing aborted command with status: 0000
[ 5343.872750] nvme nvme0: completing aborted command with status: 0000
[ 5343.876805] nvme nvme0: completing aborted command with status: 0000
[ 5343.921292] nvme nvme0: completing aborted command with status: 0000
[ 5343.923719] nvme nvme0: completing aborted command with status: 0000
[ 5343.926235] nvme nvme0: completing aborted command with status: 0000
[ 5343.928689] nvme nvme0: completing aborted command with status: 0000
[ 5344.120767] nvme nvme0: Abort status: 0x0
[ 5344.120791] nvme nvme0: Abort status: 0x0
[ 5344.120793] nvme nvme0: Abort status: 0x0
[ 5344.120804] nvme nvme0: Abort status: 0x0
[ 5344.159891] nvme nvme0: Abort status: 0x0
[ 5344.159896] nvme nvme0: Abort status: 0x0
[ 5344.159916] nvme nvme0: Abort status: 0x0
[ 5344.159932] nvme nvme0: Abort status: 0x0
[ 5344.872302] nvme nvme0: I/O 762 QID 6 timeout, aborting
[ 5344.872309] nvme nvme0: I/O 763 QID 6 timeout, aborting
[ 5344.872311] nvme nvme0: I/O 764 QID 6 timeout, aborting
[ 5344.872313] nvme nvme0: I/O 765 QID 6 timeout, aborting
[ 5344.872315] nvme nvme0: I/O 766 QID 6 timeout, aborting
[ 5344.872317] nvme nvme0: I/O 767 QID 6 timeout, aborting
[ 5344.872319] nvme nvme0: I/O 768 QID 6 timeout, aborting
[ 5344.872320] nvme nvme0: I/O 769 QID 6 timeout, aborting
[ 5344.876179] nvme nvme0: completing aborted command with status: 0000
[ 5344.879210] nvme nvme0: completing aborted command with status: 0000
[ 5344.882727] nvme nvme0: completing aborted command with status: 0000
[ 5344.885965] nvme nvme0: completing aborted command with status: 0000
[ 5344.936542] nvme nvme0: completing aborted command with status: 0000
[ 5344.937113] nvme nvme0: completing aborted command with status: 0000
[ 5344.943132] nvme nvme0: completing aborted command with status: 0000
[ 5344.943681] nvme nvme0: completing aborted command with status: 0000
[ 5345.147182] nvme nvme0: Abort status: 0x0
[ 5345.147192] nvme nvme0: Abort status: 0x0
[ 5345.147207] nvme nvme0: Abort status: 0x0
[ 5345.147234] nvme nvme0: Abort status: 0x0
[ 5345.210950] nvme nvme0: Abort status: 0x0
[ 5345.210958] nvme nvme0: Abort status: 0x0
[ 5345.210974] nvme nvme0: Abort status: 0x0
[ 5345.210987] nvme nvme0: Abort status: 0x0

-- 
Thomas Fjellstrom
thomas at fjellstrom.ca
