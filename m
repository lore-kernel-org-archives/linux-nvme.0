From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 8 Feb 2017 08:02:07 -0800
Subject: [PATCH 5/6] f2fs: add a kernel thread to issue discard commands
 asynchronously
In-Reply-To: <20170207034403.GA24935@jaegeuk.local>
References: <20170112224407.54026-1-jaegeuk@kernel.org>
 <20170112224407.54026-5-jaegeuk@kernel.org>
 <20170113080159.GB31777@infradead.org>
 <20170113191211.GB1301@jaegeuk.local>
 <20170116173220.GA2199@infradead.org>
 <20170205085947.GA25319@infradead.org>
 <20170207034403.GA24935@jaegeuk.local>
Message-ID: <20170208160207.GA14621@infradead.org>

On Mon, Feb 06, 2017@07:44:03PM -0800, Jaegeuk Kim wrote:
> Sorry for the late response due to the travel.
> 
> When doing fstrim with a fresh f2fs image fomatted on Intel NVMe SSD whose
> model name is SSDPE2MW012T4, I've got the following trace.

<snip>

> So, I investigated why block_rq_complete() happened in more detail.
> 
> The root-caused call path looks like:
>  - submit_bio
>   - generic_make_request
>    - q->make_request_fn
>     - blk_mq_make_request
>      - blk_mq_map_request
>       - blk_mq_alloc_request
>        - blk_mq_get_tag
>         - __blk_mq_get_tag
>          - bt_get
>           - blk_mq_run_hw_queue
>           - finish_wait
>           --> this waits for pending 8 discard bios!

You're blocking on tag allocation.  How many tags per queue does
your device have?, e.g. do a

cat /sys/block/nvme0n1/mq/0/nr_tags

> It seems the problem comes from the storage processing discard commands too
> slowly comparing to normal read/write IOs.
> 
> Any thoughts?

Deallocate is always going to be an exception path compared to normal
read/write? but just how much slower is going to be device
dependent.

One option would be to reuse the number of discards, for that can you
try the series here to support vectored discards:

http://git.infradead.org/users/hch/block.git/shortlog/refs/heads/vectored-discard-for-axboe
