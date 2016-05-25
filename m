From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 25 May 2016 01:18:42 -0700
Subject: [PATCH] NVMe: Fix possible scheduling while atomic error
In-Reply-To: <20160524195921.GB24347@localhost.localdomain>
References: <1463521062-16488-1-git-send-email-keith.busch@intel.com>
 <20160523105807.GC26331@infradead.org>
 <20160523134116.GA17208@localhost.localdomain>
 <20160523143631.GA28107@infradead.org>
 <20160523145556.GB17208@localhost.localdomain>
 <CAF1ivSbWrkNUu0HgDdvev6yOV9bSbOjkDQ8mtS0VSq=k9SEqng@mail.gmail.com>
 <20160524195921.GB24347@localhost.localdomain>
Message-ID: <20160525081842.GA22766@infradead.org>

On Tue, May 24, 2016@03:59:21PM -0400, Keith Busch wrote:
> On Tue, May 24, 2016@11:43:21AM -0700, Ming Lin wrote:
> > 
> > It's blk_mq_cancel_requeue_work() that potentially sleeps.
> 
> Right, I don't know what I was thinking... 
> 
> AFAICT, the patch is fine as-is if Christoph is okay with it.

I still don't why we need to delay the call to blk_mq_stop_hw_queues
to ->queue_rq.
