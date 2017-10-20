From: jsmart2021@gmail.com (James Smart)
Date: Fri, 20 Oct 2017 11:53:07 -0700
Subject: [PATCH v3 5/5] nvme_fc: add dev_loss_tmo timeout and remoteport
 resume support
In-Reply-To: <1ea7f564-36ed-a952-22c3-4f7b58be6665@suse.de>
References: <20171017233248.6769-1-jsmart2021@gmail.com>
 <20171017233248.6769-6-jsmart2021@gmail.com>
 <1ea7f564-36ed-a952-22c3-4f7b58be6665@suse.de>
Message-ID: <7cd69378-9ce8-6734-f164-9cd1b72b53eb@gmail.com>

On 10/19/2017 11:27 PM, Hannes Reinecke wrote:
...
>> +static struct nvme_fc_rport *
>> +nvme_fc_attach_to_suspended_rport(struct nvme_fc_lport *lport,
>> +				struct nvme_fc_port_info *pinfo)
>> +{
...
>> +
>> +		/* has it been unregistered */
>> +		if (rport->remoteport.port_state != FC_OBJSTATE_DELETED) {
>> +			/* means lldd called us twice */
>> +			spin_unlock_irqrestore(&rport->lock, flags);
>> +			nvme_fc_rport_put(rport);
>> +			return ERR_PTR(-ESTALE);
>> +		}
>> +
> Why can't we re-use this rport?
> It's patently _not_ deleted, so we should be good to use it, right?
> Someone else might've messed up, but if _we_ get our reference counting
> right that shouldn't affect us, no?
> Plus: How would we recover from such a situation?
> The rport most likely will _never_ go away, meaning we'll always hit
> this scenario for each and every connection attempt.
> (Speaking from experience here; I've hit this scenario accidentally :-)
> So the only chance we have is a reboot.


Because if it's not in a deleted state, then it's one that is 
effectively live/present and there can be only 1 remoteport with the 
same WWPN/WWNN on the localport.  This would be the case of a lldd 
calling register for the same remoteport twice, which we don't allow.
I'm not looking to allow or survive such a driver error - I'll let the 
second registration fail as it is illegal.

How did you hit this scenario ? it would really surprise me.



>>   }
>>   
>> +static void
>> +nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
>> +{
>> +	dev_info(ctrl->ctrl.device,
>> +		"NVME-FC{%d}: controller connectivity lost. Awaiting "
>> +		"Reconnect", ctrl->cnum);
>> +
>> +	switch (ctrl->ctrl.state) {
>> +	case NVME_CTRL_NEW:
>> +	case NVME_CTRL_LIVE:
>> +		/*
>> +		 * Schedule a controller reset. The reset will
>> +		 * terminate the association and schedule the
>> +		 * reconnect timer. Reconnects will be attempted
>> +		 * until either the ctlr_loss_tmo
>> +		 * (max_retries * connect_delay) expires or the
>> +		 * remoteport's dev_loss_tmo expires.
>> +		 */
>> +		if (nvme_reset_ctrl(&ctrl->ctrl)) {
>> +			dev_warn(ctrl->ctrl.device,
>> +				"NVME-FC{%d}: Couldn't schedule reset. "
>> +				"Deleting controller.\n",
>> +				ctrl->cnum);
>> +			__nvme_fc_del_ctrl(ctrl);
>> +		}
>> +		break;
>> +
>> +	case NVME_CTRL_RECONNECTING:
>> +		/*
>> +		 * The association has already been terminated
>> +		 * and the controller is attempting reconnects.
>> +		 * No need to do anything futher. Reconnects will
>> +		 * be attempted until either the ctlr_loss_tmo
>> +		 * (max_retries * connect_delay) expires or the
>> +		 * remoteport's dev_loss_tmo expires.
>> +		 */
>> +		break;
>> +
>> +	case NVME_CTRL_RESETTING:
>> +		/*
>> +		 * Controller is already in the process of
>> +		 * terminating the association. No need to do
>> +		 * anything further. The reconnect step will
>> +		 * kick in naturally after the association is
>> +		 * terminated.
>> +		 */
>> +		break;
>> +
>> +	case NVME_CTRL_DELETING:
>> +	default:
>> +		/* no action to take - let it delete */
>> +		break;
>> +	}
>> +}
>> +
>>   /**
>>    * nvme_fc_unregister_remoteport - transport entry point called by an
>>    *                              LLDD to deregister/remove a previously
>> @@ -667,15 +868,32 @@ nvme_fc_unregister_remoteport(struct nvme_fc_remote_port *portptr)
>>   	}
>>   	portptr->port_state = FC_OBJSTATE_DELETED;
>>   
>> -	/* tear down all associations to the remote port */
>> -	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list)
>> -		__nvme_fc_del_ctrl(ctrl);
>> +	list_for_each_entry(ctrl, &rport->ctrl_list, ctrl_list) {
>> +		/* if dev_loss_tmo==0, dev loss is immediate */
>> +		if (!portptr->dev_loss_tmo) {
>> +			dev_warn(ctrl->ctrl.device,
>> +				"NVME-FC{%d}: controller connectivity lost. "
>> +				"Deleting controller.\n",
>> +				ctrl->cnum);
>> +			__nvme_fc_del_ctrl(ctrl);
>> +		} else
>> +			nvme_fc_ctrl_connectivity_loss(ctrl);
>> +	}
>>   
>>   	spin_unlock_irqrestore(&rport->lock, flags);
>>   
>>   	nvme_fc_abort_lsops(rport);
>>   
>> +	queue_delayed_work(nvme_wq, &rport->dev_loss_work,
>> +			portptr->dev_loss_tmo * HZ);
>> +
>> +	/*nvme_fc_ctrl_connectivity_loss
>> +	 * release the reference, which will allow, if all controllers
>> +	 * go away, which should only occur after dev_loss_tmo occurs,
>> +	 * for the rport to be torn down.
>> +	 */
>>   	nvme_fc_rport_put(rport);
>> +
>>   	return 0;
>>   }
>>   EXPORT_SYMBOL_GPL(nvme_fc_unregister_remoteport);
> 
> Hmm.
> The dev_loss_tmo is pretty awkward; scheduling a per-rport structure
> only to tear down all attached _controllers_ once an rport goes down.
> But seeing that __nvme_fc_del_ctrl() is actually just punting the
> deletion to a workqueue I guess that's okay.

I guess so. Just reusing the existing delete code paths whcih set the
nvme controller state.

> Also we might end up having called __nvme_fc_del_ctrl() for each
> controller, making me wonder why we need to schedule a dev_loss_work if
> all controllers are being removed anyway.

I'm not sure I follow, but..  We could defer to the ctlr_loss_tmo 
completely, but it may be longer than dev_loss_tmo and I think the 
confuses people that may set the dev_loss_tmo value an expect things to 
terminate at dev_loss_tmo. Currently, the controller delete is 
min(dev_loss_tmo, ctlr_loss_tmo).


> Also I'm not exactly thrilled with the reference counting; we put things
> on a workqueue but do not increase the reference for it.
> Which means that the rport structure might be freed even though it's
> still on the workqueue. Shouldn't we rather take a reference before
> putting it on the workqueue, and drop the reference once we're done with
> the workqueue function?

ok, I agree.  I'll rework so that there is no dev_loss_tmo timer 
running. Instead, we'll record the rport connectivity loss time, and in 
the controller reconnect loops, if we try to reconnect but connectivity 
has been lost for dev_loss_tmo, we'll give up.

-- james
