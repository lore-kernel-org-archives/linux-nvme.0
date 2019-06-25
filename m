From: emilne@redhat.com (Ewan D. Milne)
Date: Tue, 25 Jun 2019 15:05:17 -0400
Subject: [PATCH v2] nvme-fc: clean up error messages
In-Reply-To: <14240398-683c-1d1c-f6e8-8fa8692270c2@broadcom.com>
References: <20190624221240.25268-1-emilne@redhat.com>
 <14240398-683c-1d1c-f6e8-8fa8692270c2@broadcom.com>
Message-ID: <c1d4377628740d182e16313b444b28ea6a2b8c1d.camel@redhat.com>

On Tue, 2019-06-25@09:37 -0700, James Smart wrote:
> 
> > @@ -1259,7 +1259,7 @@ nvme_fc_connect_admin_queue(struct nvme_fc_ctrl *ctrl,
> >   	if (fcret) {
> >   		ret = -EBADF;
> >   		dev_err(ctrl->dev,
> > -			"q %d connect failed: %s\n",
> > +			"queue %d connect admin queue failed: %s\n",
> >   			queue->qnum, validation_errors[fcret]);
> >   	} else {
> >   		ctrl->association_id =
> 
> Since we're changing them...
> 
> how about "queue %d Create Association LS failed: %s"
> 
> > @@ -1358,7 +1358,7 @@ nvme_fc_connect_queue(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
> >   	if (fcret) {
> >   		ret = -EBADF;
> >   		dev_err(ctrl->dev,
> > -			"q %d connect failed: %s\n",
> > +			"queue %d connect queue failed: %s\n",
> 
> how about "queue %d Create Connection LS failed: %s"

Sure.

> 
> > @@ -2678,16 +2678,18 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
> >   		/* warn if maxcmd is lower than queue_size */
> >   		dev_warn(ctrl->ctrl.device,
> >   			"queue_size %zu > ctrl maxcmd %u, reducing "
> > -			"to queue_size\n",
> > -			opts->queue_size, ctrl->ctrl.maxcmd);
> > +			"queue_size to %u\n",
> > +			opts->queue_size, ctrl->ctrl.maxcmd, ctrl->ctrl.maxcmd);
> >   		opts->queue_size = ctrl->ctrl.maxcmd;
> >   	}
> >   
> >   	if (opts->queue_size > ctrl->ctrl.sqsize + 1) {
> >   		/* warn if sqsize is lower than queue_size */
> >   		dev_warn(ctrl->ctrl.device,
> > -			"queue_size %zu > ctrl sqsize %u, clamping down\n",
> > -			opts->queue_size, ctrl->ctrl.sqsize + 1);
> > +			"queue_size %zu > ctrl sqsize %u, reducing "
> > +			"queue_size to %u\n",
> > +			opts->queue_size, ctrl->ctrl.sqsize + 1,
> > +			ctrl->ctrl.sqsize + 1);
> >   		opts->queue_size = ctrl->ctrl.sqsize + 1;
> >   	}
> >   
> 
> Given these last two came from a template in the rdma transport - you 
> may want to consider using the same wording in all the transports.

Hmm.  The RDMA and TCP transports do not appear to actually change
opts->queue_size if > maxcmd, here, despite the warning message, but
they use sqsize when allocating the tagset.

And they both reduce the sqsize if > maxcmd, not if queue_size > sqsize
as in FC, (which does not change sqsize).

commit 5e77d61cbc7e766778037127dab69e6410a8fc48
Author: Sagi Grimberg <sagi at grimberg.me>
Date:   Tue Jun 19 15:34:13 2018 +0300

    nvme-rdma: don't override opts->queue_size

So should FC be using the same logic?

-Ewan

> 
> -- james
> 
> 
