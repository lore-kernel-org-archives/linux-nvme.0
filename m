From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 27 May 2016 00:40:20 -0700
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <20160525175736.GB28668@localhost.localdomain>
References: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
 <20160523105807.GC26331@infradead.org>
 <20160523134116.GA17208@localhost.localdomain>
 <20160523143631.GA28107@infradead.org>
 <20160523145556.GB17208@localhost.localdomain>
 <CAF1ivSbWrkNUu0HgDdvev6yOV9bSbOjkDQ8mtS0VSq=k9SEqng@mail.gmail.com>
 <20160524195921.GB24347@localhost.localdomain>
 <20160525081842.GA22766@infradead.org>
 <20160525175736.GB28668@localhost.localdomain>
Message-ID: <20160527074020.GB950@infradead.org>

On Wed, May 25, 2016@01:57:37PM -0400, Keith Busch wrote:
> > > On Tue, May 24, 2016@11:43:21AM -0700, Ming Lin wrote:
> > > > 
> > > > It's blk_mq_cancel_requeue_work() that potentially sleeps.
> > > 
> > > Right, I don't know what I was thinking... 
> > > 
> > > AFAICT, the patch is fine as-is if Christoph is okay with it.
> > 
> > I still don't why we need to delay the call to blk_mq_stop_hw_queues
> > to ->queue_rq.
> 
> Eh? It's still stopped in the same place as always, so it's not
> delayed. We just call it again from queue_rq because requeue_work can
> start h/w queues on its own. This is very similar to scsi's queue_rq
> in scsi_lib.c.

The rationale in SCSI is that we stop the queue when we are above
the hosts or targets queuing limit, and only I/O ocmpletions will
wake it up again.  Kicking of the sotpped queues in blk_mq_requeue_work
is SCSI specific behavior that leaked into the core, and it's my fault..

Well' let's get the fix in as-is for now, but I really need to sort
this out properly, so maybe add some comments.

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
