From: keith.busch@intel.com (Keith Busch)
Date: Mon, 14 Dec 2015 16:29:01 +0000
Subject: [PATCH for-4.4] NVMe: IO ending fixes on surprise removal
In-Reply-To: <566D87E8.3000305@dev.mellanox.co.il>
References: <1449864868-8216-1-git-send-email-keith.busch@intel.com>
 <566D87E8.3000305@dev.mellanox.co.il>
Message-ID: <20151214162901.GA24668@localhost.localdomain>

On Sun, Dec 13, 2015@04:59:52PM +0200, Sagi Grimberg wrote:
> >+		 * The controller was shutdown first if we got here through
> >+		 * device removal. The shutdown may requeue outstanding
> >+		 * requests. These need to be aborted immediately so
> >+		 * del_gendisk doesn't block indefinitely for their completion.
> >+		 */
> >+		blk_mq_abort_requeue_list(ns->queue);
> 
> Something looks convoluted a bit here.
> We abort_requeue_list here and...
> 
> >+	}
> >  	if (ns->disk->flags & GENHD_FL_UP)
> >  		del_gendisk(ns->disk);
> >  	if (kill || !blk_queue_dying(ns->queue)) {
> 
> Here again?

Correct. It's solving two different problems. The first is to end
requeued commands that del_gendisk would wait for, like what happens on
a surprise removal with filesystem data syncing. The second is to end
requeued commands that blk_cleanup_queue would wait for, like direct
and passthrough.

One might wonder why the first requeue list abort doesn't address the
second case: we don't execute the path containing the first abort requeue
list on an orderly removal to allow filesystem data to sync first.

The whole shutdown and removal sequence is a little different today than
when it was originally implemented, so will need to verify if it is even
possible to have commands on the requeue list at the second point anymore.
