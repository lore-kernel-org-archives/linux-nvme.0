From: keith.busch@intel.com (Keith Busch)
Date: Mon, 8 Feb 2016 18:38:23 +0000
Subject: [PATCH 3/4] NVMe: Surprise removal fixes
In-Reply-To: <20160208181640.GD13126@infradead.org>
References: <1454515543-21683-1-git-send-email-keith.busch@intel.com>
 <1454515543-21683-4-git-send-email-keith.busch@intel.com>
 <20160208181640.GD13126@infradead.org>
Message-ID: <20160208183823.GA29157@localhost.localdomain>

On Mon, Feb 08, 2016@10:16:40AM -0800, Christoph Hellwig wrote:
> On Wed, Feb 03, 2016@09:05:42AM -0700, Keith Busch wrote:
> > +		blk_mq_freeze_queue_start(ns->queue);
> > +		blk_set_queue_dying(ns->queue);
> >  		blk_mq_abort_requeue_list(ns->queue);
> > +		blk_mq_start_hw_queues(ns->queue);
> >  	}
> 
> Do we really still need all this magic if ->queue_rq returns a failure
> if the queue is dying?

This is far from perfect. Let me try explaining what's happening, then
I hope to abandon this patch and do it correctly. :)

The test does buffered IO writes with 'dd'. If I yank the drive,
'dd' continues until writing the device's capacity. The device is
gone, so there is no place to write dirty pages. The capcity exceeds
available memory, so 'dd' will wait even though everything it tries to
write fails. It consumes all available memory and the system becomes
noticably slower.

Ending that process is not what this patch accomplishes. It just lets
del_gendisk and blk_cleanup_queue complete by not allowing processes
to continue entering the queue by freezing first. Driver unbind doesn't
complete without this.

But there is a possible deadlock here. If you do an orderly removal
and surprise removal immediatly after, the device will initially be
considered capable of io and let dirty data sync. The hot removal will
make that impossible, but the orderly removal is holding the namespace
mutex, so no one can cleanup the namespace's queue.

Anyway, I wish to withdraw this patch. I will send an alternate this
week using state machine driven logic that should fix the deadlock unless
there is a different proposal sooner.
