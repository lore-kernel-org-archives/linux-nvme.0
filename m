From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 18:30:53 +0200
Subject: [PATCH 4/9] nvme: do not restart the request timeout if we're
 resetting the controller
In-Reply-To: <20151022162702.GD21840@localhost.localdomain>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-5-git-send-email-hch@lst.de>
 <20151022162702.GD21840@localhost.localdomain>
Message-ID: <20151022163053.GA21116@lst.de>

On Thu, Oct 22, 2015@04:27:03PM +0000, Busch, Keith wrote:
> On Thu, Oct 22, 2015@02:03:36PM +0200, Christoph Hellwig wrote:
> > Otherwise we're never going to complete a command when it is restarted just
> > after we completed all other outstanding commands in nvme_clear_queue.
> 
> Returning BLK_EH_HANDLED to block mq's timeout handler has the block layer
> complete the request. However, the reset work is going to force cancel
> the request anyway, so the same command will be completed twice. That
> can't be right ... right?

No, it's not going to complete it if it already was completed, check the
logic around the REQ_ATOM_COMPLETE flag.
