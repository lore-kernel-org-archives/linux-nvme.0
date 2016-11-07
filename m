From: james.smart@broadcom.com (James Smart)
Date: Mon, 7 Nov 2016 10:43:07 -0800
Subject: [PATCH v5 6/7] nvme-fabrics: Add target support for FC transport
In-Reply-To: <20161107092225.kub4sdnzy5uqgybe@linux-x5ow.site>
References: <58201df5.VwHW5e3+1qgK/Why%jsmart2021@gmail.com>
 <20161107092225.kub4sdnzy5uqgybe@linux-x5ow.site>
Message-ID: <89eef04f-61ae-534b-9169-fbebf66eb082@broadcom.com>



On 11/7/2016 1:22 AM, Johannes Thumshirn wrote:
> Hi James,
>
> On Sun, Nov 06, 2016@10:23:49PM -0800, James Smart wrote:
>> Add nvme-fabrics target support for FC transport
> [...]
>
>> +static void
>> +nvmet_fc_prep_fcp_iodlist(struct nvmet_fc_tgtport *tgtport,
>> +				struct nvmet_fc_tgt_queue *queue)
>> +{
>> +	struct nvmet_fc_fcp_iod *fod = queue->fod;
>> +	int i;
>> +
>> +	for (i = 0; i < queue->sqsize; fod++, i++) {
>> +		INIT_WORK(&fod->work, nvmet_fc_handle_fcp_rqst_work);
>> +		fod->tgtport = tgtport;
>> +		fod->queue = queue;
>> +		atomic_set(&fod->active, 0);
> Hmm why exactly do you need atomics here? You're using fod->active as bool and
> don't ever do a real atomic operation such as atomic_inc()
> atomic_dev_and_test(), etc.. on it. Also you're never checking if fod->active
> is actually 1 when you come here (and if it can't what's the point of it being
> atomic in the first place)?

?? did you miss several atomic_read's/set's ?

It's a boolean flag, and the intent was to avoid taking additional locks 
when setting it as in most cases, the locks would be overkill. Where it 
was used was in queue teardown, to identify the allocated jobs, thus 
active I/O's, that the LLDD has to be called for to terminate.   But, as 
I look at this, there does seem to be a benefit in creating a more 
granular lock than is used now and avoid the atomic. I'll post a 
subsequent patch to address it.


>
> Same goes for fod->aborted.

The use of the flag is a little different but the reason the same - 
avoid creating yet another lock level or taking a higher-level lock for 
a simple state transition. I'm not inclined to remove this one though.
>> +static void
>> +nvmet_fc_abort_op(struct nvmet_fc_tgtport *tgtport,
>> +				struct nvmefc_tgt_fcp_req *fcpreq)
>> +{
>> +	int ret;
>> +
>> +	fcpreq->op = NVMET_FCOP_ABORT;
>> +	fcpreq->offset = 0;
>> +	fcpreq->timeout = 0;
>> +	fcpreq->transfer_length = 0;
>> +	fcpreq->transferred_length = 0;
>> +	fcpreq->fcp_error = 0;
>> +	fcpreq->sg_cnt = 0;
>> +
>> +	ret = tgtport->ops->fcp_op(&tgtport->fc_target_port, fcpreq);
>> +	if (ret)
>> +		WARN_ON(1);
>> +		/* should never reach here !! */
> WARN_ON(ret)?

nit/nuance either way.

-- james
