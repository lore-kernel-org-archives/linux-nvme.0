From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 18:27:10 +0200
Subject: [PATCH 6/9] nvme: abort requests on the reqeueue list when
 shutting down a controller
In-Reply-To: <20151022151625.GC21840@localhost.localdomain>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-7-git-send-email-hch@lst.de>
 <20151022144419.GB21840@localhost.localdomain>
 <20151022145842.GA32062@lst.de>
 <20151022151625.GC21840@localhost.localdomain>
Message-ID: <20151022162710.GA20934@lst.de>

On Thu, Oct 22, 2015@03:16:26PM +0000, Busch, Keith wrote:
> This is a bit subtle. nvme_clear_queue at the end of shutdown allows
> active commands being aborted to requeue based on the state of the
> namespace's request_queue: if it isn't "dying", nvme_clear_queue won't
> set NVMe CQE "do-not-retry" (DNR) bit, so req_completion may requeue.
> 
> In the reset scenario, this change would fail requests that happen to be
> on the requeue_list, but active commands being cancelled will be allowed
> to retry. That's not fair to requests that got on the list early. :)
> 
> But it sounds like you may have found the real fix to the gap in a
> different patch, so I'll skip this as suggested and continue with the
> rest of the series.

Oh, so you want to resubmit them after the reset.  I guess this makes
sense in general, although in my particular case it delays recovery
significantly.
