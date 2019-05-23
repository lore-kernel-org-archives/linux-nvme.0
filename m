From: kbusch@kernel.org (Keith Busch)
Date: Thu, 23 May 2019 07:34:29 -0600
Subject: [PATCH 2/2] nvme: reset request timeouts during fw activation
In-Reply-To: <20190523101953.GA18805@ming.t460p>
References: <20190522174812.5597-1-keith.busch@intel.com>
 <20190522174812.5597-3-keith.busch@intel.com>
 <20190523101953.GA18805@ming.t460p>
Message-ID: <20190523133428.GC14049@localhost.localdomain>

On Thu, May 23, 2019@03:19:54AM -0700, Ming Lei wrote:
> On Wed, May 22, 2019@11:48:12AM -0600, Keith Busch wrote:
> > @@ -3605,6 +3606,11 @@ static void nvme_fw_act_work(struct work_struct *work)
> >  				msecs_to_jiffies(admin_timeout * 1000);
> >  
> >  	nvme_stop_queues(ctrl);
> > +	nvme_sync_queues(ctrl);
> > +
> > +	blk_mq_quiesce_queue(ctrl->admin_q);
> > +	blk_sync_queue(ctrl->admin_q);
> 
> blk_sync_queue() may not halt timeout detection completely since the
> timeout work may reset timer again.

Doh! Didn't hit that in testing, but point taken.
 
> Also reset still may come during activating FW, is that a problem?

IO timeout and user initiated resets should be avoided. A state machine
addition may be useful here.
