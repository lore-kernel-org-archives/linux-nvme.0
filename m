From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 18 May 2015 23:37:09 -0700
Subject: fix queue_lock usage in blk-mq and nvme
In-Reply-To: <1430984294-25859-1-git-send-email-hch@lst.de>
References: <1430984294-25859-1-git-send-email-hch@lst.de>
Message-ID: <20150519063709.GA22313@infradead.org>

ping?

On Thu, May 07, 2015@09:38:12AM +0200, Christoph Hellwig wrote:
> Historically we always take queue_lock with irqs disabled.  Blk-mq doesn't really
> use the queue_lock much, but when it does it needs to follow this rules to make
> lockdep happy.
> 
> The first patch removes a queue_lock usage instead of fixing things properly,
> and the second is a bad-aid for nvme.  In the long run I'd prefer to remove
> other users of the queue_lock from blk-mq and blk-mq based driver entirely,
> but that will require a bit more work.
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
