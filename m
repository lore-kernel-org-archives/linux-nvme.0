From: hch@lst.de (Christoph Hellwig)
Date: Thu, 22 Oct 2015 20:12:40 +0200
Subject: [PATCH 8/9] nvme: remove dead controllers from a work item
In-Reply-To: <20151022181014.GE21840@localhost.localdomain>
References: <1445515421-4940-1-git-send-email-hch@lst.de>
 <1445515421-4940-9-git-send-email-hch@lst.de>
 <20151022181014.GE21840@localhost.localdomain>
Message-ID: <20151022181240.GA22482@lst.de>

On Thu, Oct 22, 2015@06:10:15PM +0000, Busch, Keith wrote:
> On Thu, Oct 22, 2015@02:03:40PM +0200, Christoph Hellwig wrote:
> > Compared to the kthread this gives us multiple call prevention for free.
> 
> My apologies in advance, I usually try to be more helpful debugging
> new issues, but I'm running low on time today. I might be able to dig
> into this more tomorrow, but if you could, please verify what happens
> if an admin command times out during initialization. The reset_work
> gets queued twice on two different work_queues and causes trouble. I
> get one of several crashes or warnings after applying the whole series,
> but this is the most frequent I'm seeing so far:

Oops - I'm queing it both on the system workqueue and nvme_workq, which
is clearly broken.  I'll fix it in the next resend.
