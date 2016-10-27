From: james.smart@broadcom.com (James Smart)
Date: Thu, 27 Oct 2016 15:46:51 -0700
Subject: [PATCH v3 5/7] nvme-fabrics: Add host support for FC transport
In-Reply-To: <1477439262.3009.77.camel@linux.intel.com>
References: <580d0ffd.cq5y7S+lNBHxNs60%james.smart@broadcom.com>
 <1477439262.3009.77.camel@linux.intel.com>
Message-ID: <fae8f874-5b27-49cf-b0c3-6cb4b519abe5@broadcom.com>



On 10/25/2016 4:47 PM, J Freyensee wrote:
> It looks like 'if(op->rq)' is checked for NULL before this 'if (ret)'
> block, but it's theoretically possible 'if(ret)' is true and things
> completely blow up here by a op->rq de-reference?

yes - very good point.


>
>> +	
>> +	if (ret)
>> +		/* io wasn't active to abort consider it done */
>> +		return BLK_EH_HANDLED;
>> +
>> +	/* TODO: force a controller reset */
>> +
>> +	return BLK_EH_HANDLED;
> Another nitpick- that 'if(ret)' statement isn't adding any value, the
> function returns BLK_EH_HANDLED regardless if the conditional is taken.

Agreed, but leaving it in. The TODO will be addressed in a subsequent 
patch and it'll make sense then.

>
>>   
>> +
>> +static struct nvme_ctrl *
>> +__nvme_fc_create_ctrl(struct device *dev, struct nvmf_ctrl_options
>> *opts,
>> +	struct nvme_fc_lport *lport, struct nvme_fc_rport *rport)
>> +{
>> +	struct nvme_fc_ctrl *ctrl;
>> +	unsigned long flags;
>> +	int ret, idx;
>> +	bool changed;
>> +
... snip
>> +
>> +	return &ctrl->ctrl;
>> +
>> +out_exit_aen_ops:
>> +	nvme_fc_exit_aen_ops(ctrl);
>> +out_remove_admin_queue:
>> +	nvme_stop_keep_alive(&ctrl->ctrl);
>> +	nvme_fc_destroy_admin_queue(ctrl);
>> +out_uninit_ctrl:
>> +	nvme_uninit_ctrl(&ctrl->ctrl);
>> +	nvme_put_ctrl(&ctrl->ctrl);
>> +	if (ret > 0)
>> +		ret = -EIO;
>> +	/* exit via here will follow ctlr ref point callbacks to
>> free */
>> +	return ERR_PTR(ret);
> Memory leak?? kfree(ctrl); i.e. the "struct_nvme_fc_ctrl *ctrl;" is not
> called before the return in this case I think?

No leak. The nvme_uninit and nvpe_put_ctrl will fall into the nvme 
ctrl's ref counting, which will call back into the transport via 
free_ctrl callback. That path will end up converting to the fc-nvme ctrl 
struct and fall into the it's ref counting, which will eventually do the 
free() call.  That's what drove the comment on "exit via here will 
follow ctlr ref point callbacks to free".
