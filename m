From: hare@suse.de (Hannes Reinecke)
Date: Fri, 20 Oct 2017 08:27:55 +0200
Subject: [PATCH v3 5/5] nvme_fc: add dev_loss_tmo timeout and remoteport
 resume support
In-Reply-To: <20171017233248.6769-6-jsmart2021@gmail.com>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
 <20171017233248.6769-6-jsmart2021@gmail.com>
Message-ID: <1ea7f564-36ed-a952-22c3-4f7b58be6665@suse.de>

On 10/18/2017 01:32 AM, James Smart wrote:
> This patch adds the dev_loss_tmo functionality to the transport.
> 
> When a remoteport is unregistered (connectivity lost), the following
> actions are taken:
> - the remoteport is marked DELETED
> - a dev_loss_tmo timer is started for the remoteport
> - all controllers on the remoteport are reset.
> 
> After a controller resets, it will stall in a RECONNECTING state
> waiting for one of the following:
> - the controller will continue to attempt reconnect per max_retries
>   and reconnect_delay. As no remoteport connectivity, the reconnect
>   attempt will immediately fail. if max reconnect attempts are
>   reached (e.g. ctrl_loss_tmo reached) the controller is deleted.
> - the remoteport is re-registered prior to dev_loss_tmo expiring.
>   The resume of the remoteport will immediately attempt to reconnect
>   each of its suspended controllers.
> - the remoteport's dev_loss_tmo expires, causing all of its
>   controllers to be deleted.
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> 
> v3:
>   Reworked so dev_loss_tmo specific to the remoteport. Revised
>   so connectivity loss resets controllers, and connectivity gain
>   schedules reconnect.
> ---
>  drivers/nvme/host/fc.c | 289 +++++++++++++++++++++++++++++++++++++++++++------
>  1 file changed, 257 insertions(+), 32 deletions(-)
> 
> diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
> index 61da2f92f71a..3628790371d7 100644
> --- a/drivers/nvme/host/fc.c
> +++ b/drivers/nvme/host/fc.c
> @@ -138,6 +138,7 @@ struct nvme_fc_rport {
>  	struct nvme_fc_lport		*lport;
>  	spinlock_t			lock;
>  	struct kref			ref;
> +	struct delayed_work		dev_loss_work;
>  } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
>  
>  enum nvme_fcctrl_flags {
> @@ -503,6 +504,8 @@ nvme_fc_free_rport(struct kref *ref)
>  	WARN_ON(rport->remoteport.port_state != FC_OBJSTATE_DELETED);
>  	WARN_ON(!list_empty(&rport->ctrl_list));
>  
> +	cancel_delayed_work_sync(&rport->dev_loss_work);
> +
>  	/* remove from lport list */
>  	spin_lock_irqsave(&nvme_fc_lock, flags);
>  	list_del(&rport->endp_list);
> @@ -530,6 +533,124 @@ nvme_fc_rport_get(struct nvme_fc_rport *rport)
>  	return kref_get_unless_zero(&rport->ref);
>  }
>  
> +static void
> +nvme_fc_resume_controller(struct nvme_fc_ctrl *ctrl)
> +{
> +	switch (ctrl->ctrl.state) {
> +	case NVME_CTRL_NEW:
> +	case NVME_CTRL_RECONNECTING:
> +		/*
> +		 * As all reconnects were suppressed, schedule a
> +		 * connect.
> +		 */
> +		dev_info(ctrl->ctrl.device,
> +			"NVME-FC{%d}: connectivity re-established. "
> +			"Attempting reconnect\n", ctrl->cnum);
> +
> +		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
> +		break;
> +
> +	case NVME_CTRL_RESETTING:
> +		/*
> +		 * Controller is already in the process of terminating the
> +		 * association. No need to do anything further. The reconnect
> +		 * step will naturally occur after the reset completes.
> +		 */
> +		break;
> +
> +	default:
> +		/* no action to take - let it delete */
> +		break;
> +	}
> +}
> +
> +static struct nvme_fc_rport *
> +nvme_fc_attach_to_suspended_rport(struct nvme_fc_lport *lport,
> +				struct nvme_fc_port_info *pinfo)
> +{
> +	struct nvme_fc_rport *rport;
> +	struct nvme_fc_ctrl *ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&nvme_fc_lock, flags);
> +
> +	list_for_each_entry(rport, &lport->endp_list, endp_list) {
> +		if (rport->remoteport.node_name != pinfo->node_name ||
> +		    rport->remoteport.port_name != pinfo->port_name)
> +			continue;
> +
> +		if (!nvme_fc_rport_get(rport)) {
> +			rport = ERR_PTR(-ENOLCK);
> +			goto out_done;
> +		}
> +
> +		spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +
> +		cancel_delayed_work_sync(&rport->dev_loss_work);
> +
> +		spin_lock_irqsave(&rport->lock, flags);
> +
> +		/* has it been unregistered */
> +		if (rport->remoteport.port_state != FC_OBJSTATE_DELETED) {
> +			/* means lldd called us twice */
> +			spin_unlock_irqrestore(&rport->lock, flags);
> +			nvme_fc_rport_put(rport);
> +			return ERR_PTR(-ESTALE);
> +		}
> +
Why can't we re-use this rport?
It's patently _not_ deleted, so we should be good to use it, right?
Someone else might've messed up, but if _we_ get our reference counting
right that shouldn't affect us, no?
Plus: How would we recover from such a situation?
The rport most likely will _never_ go away, meaning we'll always hit
this scenario for each and every connection attempt.
(Speaking from experience here; I've hit this scenario accidentally :-)
So the only chance we have is a reboot.

> +		rport->remoteport.port_state = FC_OBJSTATE_ONLINE;
> +
> +		/*
> +		 * kick off a reconnect attempt on all associations to the
> +		 * remote port. A successful reconnects will resume i/o.
> +		 */
> +		list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list)
> +			nvme_fc_resume_controller(ctrl);
> +
> +		spin_unlock_irqrestore(&rport->lock, flags);
> +
> +		return rport;
> +	}
> +
> +	rport = NULL;
> +
> +out_done:
> +	spin_unlock_irqrestore(&nvme_fc_lock, flags);
> +
> +	return rport;
> +}
> +
> +static void
> +nvme_fc_rport_dev_loss_work(struct work_struct *work)
> +{
> +	struct nvme_fc_rport *rport =
> +			container_of(to_delayed_work(work),
> +				struct nvme_fc_rport, dev_loss_work);
> +	struct nvme_fc_ctrl *ctrl;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&rport->lock, flags);
> +
> +	/* If port state transitioned dev loss shouldn't kick in */
> +	if (rport->remoteport.port_state != FC_OBJSTATE_DELETED) {
> +		spin_unlock_irqrestore(&rport->lock, flags);
> +		return;
> +	}
> +
> +	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
> +		dev_warn(ctrl->ctrl.device,
> +			"NVME-FC{%d}: Remote Port failed to reconnect within "
> +			"dev_loss_tmo (%d seconds). Deleting controller\n",
> +			ctrl->cnum, rport->remoteport.dev_loss_tmo);
> +		if (__nvme_fc_del_ctrl(ctrl))
> +			dev_warn(ctrl->ctrl.device,
> +				"NVME-FC{%d}: delete request failed\n",
> +				ctrl->cnum);
> +	}
> +
> +	spin_unlock_irqrestore(&rport->lock, flags);
> +}
> +
>  /**
>   * nvme_fc_register_remoteport - transport entry point called by an
>   *                              LLDD to register the existence of a NVME
> @@ -556,22 +677,46 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
>  	unsigned long flags;
>  	int ret, idx;
>  
> +	if (!nvme_fc_lport_get(lport)) {
> +		ret = -ESHUTDOWN;
> +		goto out_reghost_failed;
> +	}
> +
> +	/*
> +	 * look to see if there is already a remoteport that is waiting
> +	 * for a reconnect (within dev_loss_tmo) with the same WWN's.
> +	 * If so, transition to it and reconnect.
> +	 */
> +	newrec = nvme_fc_attach_to_suspended_rport(lport, pinfo);
> +
> +	/* found an rport, but something about its state is bad */
> +	if (IS_ERR(newrec)) {
> +		ret = PTR_ERR(newrec);
> +		goto out_lport_put;
> +
> +	/* found existing rport, which was resumed */
> +	} else if (newrec) {
> +		/* Ignore pinfo->dev_loss_tmo. Leave rport and ctlr's as is */
> +
> +		nvme_fc_lport_put(lport);
> +		nvme_fc_signal_discovery_scan(lport, newrec);
> +		*portptr = &newrec->remoteport;
> +		return 0;
> +	}
> +
> +	/* nothing found - allocate a new remoteport struct */
> +
>  	newrec = kmalloc((sizeof(*newrec) + lport->ops->remote_priv_sz),
>  			 GFP_KERNEL);
>  	if (!newrec) {
>  		ret = -ENOMEM;
> -		goto out_reghost_failed;
> -	}
> -
> -	if (!nvme_fc_lport_get(lport)) {
> -		ret = -ESHUTDOWN;
> -		goto out_kfree_rport;
> +		goto out_lport_put;
>  	}
>  
>  	idx = ida_simple_get(&lport->endp_cnt, 0, 0, GFP_KERNEL);
>  	if (idx < 0) {
>  		ret = -ENOSPC;
> -		goto out_lport_put;
> +		goto out_kfree_rport;
>  	}
>  
>  	INIT_LIST_HEAD(&newrec->endp_list);
> @@ -594,6 +739,7 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
>  		newrec->remoteport.dev_loss_tmo = pinfo->dev_loss_tmo;
>  	else
>  		newrec->remoteport.dev_loss_tmo = NVME_FC_DEFAULT_DEV_LOSS_TMO;
> +	INIT_DELAYED_WORK(&newrec->dev_loss_work, nvme_fc_rport_dev_loss_work);
>  
>  	spin_lock_irqsave(&nvme_fc_lock, flags);
>  	list_add_tail(&newrec->endp_list, &lport->endp_list);
> @@ -604,10 +750,10 @@ nvme_fc_register_remoteport(struct nvme_fc_local_port *localport,
>  	*portptr = &newrec->remoteport;
>  	return 0;
>  
> -out_lport_put:
> -	nvme_fc_lport_put(lport);
>  out_kfree_rport:
>  	kfree(newrec);
> +out_lport_put:
> +	nvme_fc_lport_put(lport);
>  out_reghost_failed:
>  	*portptr = NULL;
>  	return ret;
> @@ -638,6 +784,61 @@ nvme_fc_abort_lsops(struct nvme_fc_rport *rport)
>  	return 0;
>  }
>  
> +static void
> +nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
> +{
> +	dev_info(ctrl->ctrl.device,
> +		"NVME-FC{%d}: controller connectivity lost. Awaiting "
> +		"Reconnect", ctrl->cnum);
> +
> +	switch (ctrl->ctrl.state) {
> +	case NVME_CTRL_NEW:
> +	case NVME_CTRL_LIVE:
> +		/*
> +		 * Schedule a controller reset. The reset will
> +		 * terminate the association and schedule the
> +		 * reconnect timer. Reconnects will be attempted
> +		 * until either the ctlr_loss_tmo
> +		 * (max_retries * connect_delay) expires or the
> +		 * remoteport's dev_loss_tmo expires.
> +		 */
> +		if (nvme_reset_ctrl(&ctrl->ctrl)) {
> +			dev_warn(ctrl->ctrl.device,
> +				"NVME-FC{%d}: Couldn't schedule reset. "
> +				"Deleting controller.\n",
> +				ctrl->cnum);
> +			__nvme_fc_del_ctrl(ctrl);
> +		}
> +		break;
> +
> +	case NVME_CTRL_RECONNECTING:
> +		/*
> +		 * The association has already been terminated
> +		 * and the controller is attempting reconnects.
> +		 * No need to do anything futher. Reconnects will
> +		 * be attempted until either the ctlr_loss_tmo
> +		 * (max_retries * connect_delay) expires or the
> +		 * remoteport's dev_loss_tmo expires.
> +		 */
> +		break;
> +
> +	case NVME_CTRL_RESETTING:
> +		/*
> +		 * Controller is already in the process of
> +		 * terminating the association. No need to do
> +		 * anything further. The reconnect step will
> +		 * kick in naturally after the association is
> +		 * terminated.
> +		 */
> +		break;
> +
> +	case NVME_CTRL_DELETING:
> +	default:
> +		/* no action to take - let it delete */
> +		break;
> +	}
> +}
> +
>  /**
>   * nvme_fc_unregister_remoteport - transport entry point called by an
>   *                              LLDD to deregister/remove a previously
> @@ -667,15 +868,32 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
>  	}
>  	portptr->port_state = FC_OBJSTATE_DELETED;
>  
> -	/* tear down all associations to the remote port */
> -	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list)
> -		__nvme_fc_del_ctrl(ctrl);
> +	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
> +		/* if dev_loss_tmo==0, dev loss is immediate */
> +		if (!portptr->dev_loss_tmo) {
> +			dev_warn(ctrl->ctrl.device,
> +				"NVME-FC{%d}: controller connectivity lost. "
> +				"Deleting controller.\n",
> +				ctrl->cnum);
> +			__nvme_fc_del_ctrl(ctrl);
> +		} else
> +			nvme_fc_ctrl_connectivity_loss(ctrl);
> +	}
>  
>  	spin_unlock_irqrestore(&rport->lock, flags);
>  
>  	nvme_fc_abort_lsops(rport);
>  
> +	queue_delayed_work(nvme_wq, &rport->dev_loss_work,
> +			portptr->dev_loss_tmo * HZ);
> +
> +	/*nvme_fc_ctrl_connectivity_loss
> +	 * release the reference, which will allow, if all controllers
> +	 * go away, which should only occur after dev_loss_tmo occurs,
> +	 * for the rport to be torn down.
> +	 */
>  	nvme_fc_rport_put(rport);
> +
>  	return 0;
>  }
>  EXPORT_SYMBOL_GPL(nvme_fc_unregister_remoteport);

Hmm.
The dev_loss_tmo is pretty awkward; scheduling a per-rport structure
only to tear down all attached _controllers_ once an rport goes down.
But seeing that __nvme_fc_del_ctrl() is actually just punting the
deletion to a workqueue I guess that's okay.
Also we might end up having called __nvme_fc_del_ctrl() for each
controller, making me wonder why we need to schedule a dev_loss_work if
all controllers are being removed anyway.
Also I'm not exactly thrilled with the reference counting; we put things
on a workqueue but do not increase the reference for it.
Which means that the rport structure might be freed even though it's
still on the workqueue. Shouldn't we rather take a reference before
putting it on the workqueue, and drop the reference once we're done with
the workqueue function?

Cheers,

Hannes
-- 
Dr. Hannes Reinecke		   Teamlead Storage & Networking
hare at suse.de			               +49 911 74053 688
SUSE LINUX GmbH, Maxfeldstr. 5, 90409 N?rnberg
GF: F. Imend?rffer, J. Smithard, J. Guild, D. Upmanyu, G. Norton
HRB 21284 (AG N?rnberg)
