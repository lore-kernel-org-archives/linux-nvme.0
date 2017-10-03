From: jsmart2021@gmail.com (James Smart)
Date: Tue, 3 Oct 2017 13:01:39 -0700
Subject: [PATCH] nvme_fc: correct io timeout behavior
In-Reply-To: <20171001084700.GB878@infradead.org>
References: <20170927041317.6575-1-jsmart2021@gmail.com>
 <20171001084700.GB878@infradead.org>
Message-ID: <ddf42345-7e87-f618-f93d-ab756648305d@gmail.com>

On 10/1/2017 1:47 AM, Christoph Hellwig wrote:
>> --- a/drivers/nvme/host/fc.c
>> +++ b/drivers/nvme/host/fc.c
>> @@ -1374,7 +1374,7 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>>   				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
>>   
>>   	if (atomic_read(&op->state) == FCPOP_STATE_ABORTED)
>> -		status = cpu_to_le16((NVME_SC_ABORT_REQ | NVME_SC_DNR) << 1);
>> +		status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
> 
> So the DNR bit goes away, ok.

yes.  The aborted state is happening on io aborted due to resets, DNR 
was causing it to fail back to the app rather than be rescheduled for 
post reconnect.


>> @@ -1445,15 +1445,22 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>>   		goto check_error;
>>   	}
>>   
>> +	if (unlikely(!status && op->flags & FCOP_FLAGS_TERMIO))
>> +		status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
> 
> We grow another aborted case.  

actually, I believe this is overlapped on the above FCPOP_STATE_ABORTED 
flag checked above. So I believe I can remove this.

Note: these FCPOP_STATE_ABORTED/FCOP_FLAGS_TERMIO should only be set in 
cases where the controller is being torn down after a transport error, 
io timeout, or loss of connectivity.


> And btw, we really should not use
> NVME_SC_ABORT_REQ here because the command never reched the controller
> to actually get a nvme abort.  We might have to live with this for
> now, but can you please review might addition of new status codes
> for these host-internal cases in the latest ANA draft?

Ok.  Two comments:
1) The same statement must apply to nvme_cancel_request(), which is used 
whenever a controller is torn down before reconnect attempts. That's 
where I pulled the value to return from.

2) The command may have indeed reached the controller and have had some 
level of execution. True though, a NVME Abort would never have reached 
the controller to kill it.

Yes. I'll review the ANA draft recommendations. From my perspective, 
this is independent of ANA and I believe the proposal to add a couple of 
generic transport errors to the base spec was the right thing to do.

I'm good if you want me to change this to a transport error rather than 
the ABORTED status.


> 
>> +	/*
>> +	 * Force failures of commands if we're killing the controller
>> +	 * or have an error on a command used to create an new association
>> +	 */
>> +	if (status && (blk_queue_dying(rq->q) ||
>> +			ctrl->ctrl.state == NVME_CTRL_NEW ||
>> +			ctrl->ctrl.state == NVME_CTRL_RECONNECTING))
>> +		status |= cpu_to_le16(NVME_SC_DNR << 1);
> 
> And here we add back the dnr bit based on a few conditions.

yep - in these cases:
a) blk_queue_dying being where the controller is being deleted/torn down 
for good
b) the io was related to controller initial connect or reconnect  (I 
don't believe "the special" designation on the request was sufficient as 
it didn't apply to read_reg cmds that do get/set_property which could 
have failed too).

we do want them to fail back to the callee completely without retry. if 
(a) the controller dies/is removed. if (b) the controller connect 
attempt fails and the reconnect/retry policy kicks in.


> As a nitpick I think the way the conditionals are nested isn't very
> readable, can we split the first line up, please?
> 
> 	 if (status &&
> 	     (blk_queue_dying(rq->q) ||
> 	      ctrl->ctrl.state == NVME_CTRL_NEW ||
> 	      ctrl->ctrl.state == NVME_CTRL_RECONNECTING))
> 		status |= cpu_to_le16(NVME_SC_DNR << 1);
> 

yes


>>   	complete_rq = __nvme_fc_fcpop_chk_teardowns(ctrl, op);
>> +	if (!complete_rq)
>>   		nvme_end_request(rq, status, result);
>> +	else
>>   		__nvme_fc_final_op_cleanup(rq);
> 
> avoid the unneeded invert and local variable:
> 
> 	if (unlikely(__nvme_fc_fcpop_chk_teardowns(ctrl, op)))
> 		__nvme_fc_final_op_cleanup(rq);
> 	else
> 		nvme_end_request(rq, status, result);
> 

ok

> and while we're at it: the AEN special case above assigns complete_rq,
> but that value will never be read, so the complete_rq can be removed
> entirely.
> 
> Can you split the reset handler bits into a separate patch with
> a separate explanation?

ok
