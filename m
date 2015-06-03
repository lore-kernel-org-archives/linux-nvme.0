From: keith.busch@intel.com (Keith Busch)
Date: Wed, 3 Jun 2015 14:14:12 +0000 (UTC)
Subject: [PATCHv2 1/2] blk-mq: Shared tag enhancements
In-Reply-To: <20150603070014.GD11344@lst.de>
References: <1433172594-32127-1-git-send-email-keith.busch@intel.com>
 <20150603070014.GD11344@lst.de>
Message-ID: <alpine.LNX.2.00.1506031406140.15930@localhost.lm.intel.com>

On Wed, 3 Jun 2015, Christoph Hellwig wrote:
> On Mon, Jun 01, 2015@09:29:53AM -0600, Keith Busch wrote:
>> Storage controllers may expose multiple block devices that share hardware
>> resources managed by blk-mq. This patch enhances the shared tags so a
>> low-level driver can access the shared resources not tied to the unshared
>> h/w contexts. This way the LLD can dynamically add and delete disks and
>> request queues without having to track all the request_queue hctx's to
>> iterate outstanding tags.
>
> Why do you add a new function instead of fully replacing the old
> blk_mq_tag_busy_iter?  The only other user is the timeout handler,
> and I think it would be fine with your version as well.  And
> blk_mq_tag_busy_iter is a much better name for your new function anyway :)

I thought about that, but looks like trouble. Each namespace has its
own request_queue and each request_queue its own timer to iterate their
busy tags. Letting any timer iterate another's tags could expire the
same command multiple times.

Maybe we could move the timer from the request_queue to the tagset
instead? There seems to be some duplicate information propagating in
the request_queue anyway that might be better suited to the common tagset.
