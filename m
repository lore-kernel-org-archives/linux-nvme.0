From: jmoyer@redhat.com (Jeff Moyer)
Date: Mon, 23 Nov 2015 15:59:49 -0500
Subject: [PATCH 03/47] block: defer timeouts to a workqueue
In-Reply-To: <20151123204842.GA18721@lst.de> (Christoph Hellwig's message of
 "Mon, 23 Nov 2015 21:48:42 +0100")
References: <1448037342-18384-1-git-send-email-hch@lst.de>
 <1448037342-18384-4-git-send-email-hch@lst.de>
 <x49r3jgmp97.fsf@segfault.boston.devel.redhat.com>
 <20151123204842.GA18721@lst.de>
Message-ID: <x49mvu4mny2.fsf@segfault.boston.devel.redhat.com>

Christoph Hellwig <hch at lst.de> writes:

> On Mon, Nov 23, 2015@03:31:32PM -0500, Jeff Moyer wrote:
>> I don't see where the blk-mq timeout work is ever scheduled.  You
>> removed the call to setup_timer for the mq case, so what causes the mq
>> timeout work to run?  I must be missing something.
>
> No we use the timer which we initialize in blk_alloc_queue_node instead
> of overwriting it later in the blk-mq case.  The timer gets added in
> blk_add_timer either way.

Ah, I see.  I missed the call to blk_alloc_queue_node from
blk_mq_init_queue.  Thanks.

The patch looks good to me.  Everything will still be running in the
same context (irqs off).

Reviewed-by: Jeff Moyer <jmoyer at redhat.com>
