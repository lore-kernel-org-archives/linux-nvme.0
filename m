From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 16:58:42 +0200
Subject: [PATCH 6/9] nvme: abort requests on the reqeueue list when
 shutting down a controller
In-Reply-To: <20151022144419.GB21840@localhost.localdomain>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-7-git-send-email-hch@lst.de>
 <20151022144419.GB21840@localhost.localdomain>
Message-ID: <20151022145842.GA32062@lst.de>

On Thu, Oct 22, 2015@02:44:19PM +0000, Busch, Keith wrote:
> With this change, requests will be ended in failure even though they
> may have succeeded immediately after a reset. Nvme's unfreeze kicks the
> namespaces' requeue_list just for that reason.
> 
> We shouldn't want to abort the requeue list unless we're freeing the
> request_queue too, right?

We're aborting all active commands through nvme_dev_shutdown ->
nvme_clear_queue.  Why would we skip commands that were active and are
going to be active again ASAP?  But this part actually was just something
I suspected to be an issue first, the ->timeout return value change
turned out to fix the actual bug I was seeing.  So feel free to skip it
for now but I suspect we'll eventually need something similar.
