From: james.smart@broadcom.com (James Smart)
Date: Wed, 12 Oct 2016 13:12:34 -0700
Subject: [PATCH 7/7 v2] nvme-fabrics: Add FC LLDD loopback driver to test
 FC-NVME
In-Reply-To: <20161012103723.GA25068@infradead.org>
References: <57f82b14.jWEV18LIgDqDVRgP%james.smart@broadcom.com>
 <20161012103723.GA25068@infradead.org>
Message-ID: <c438c009-48fa-5fe3-5dce-bdc105a9e489@broadcom.com>



On 10/12/2016 3:37 AM, Christoph Hellwig wrote:
>> +#define is_end_of_list(pos, head, member) ((&pos->member) == (head))
> This one isn't actually used in the code.

Yep. I realize I removed it in the last rework.

>
>> +int
>> +fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
>> +			struct nvmefc_tgt_fcp_req *tgt_fcpreq)
>> +{
>> +	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
>> +	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
>> +	u32 rsplen = 0, xfrlen = 0;
>> +	int fcp_err = 0;
>> +	u8 op = tgt_fcpreq->op;
>> +
>> +	switch (op) {
>> +	case NVMET_FCOP_WRITEDATA:
>> +		xfrlen = tgt_fcpreq->transfer_length;
>> +		fcloop_fcp_copy_data(op, tgt_fcpreq->sg, fcpreq->first_sgl,
>> +					tgt_fcpreq->offset, xfrlen);
>> +		fcpreq->transferred_length += xfrlen;
> .. but I don't even understand why we need to copy between these
> SGLs?

You've lost me. The fc-nvme api on the initiator side has a sgl relative 
to the original io request, while the fc-nvmet api on the target side 
has a different sgl from the target fc-nvme transport to the LLDD for 
the range of data to exchange. They are sgl's as they expect to go to fc 
hw on each side. As they are independent sgl's on each side, we have to 
copy between them.

>
>> +	spin_lock_irqsave(&fcloop_lock, flags);
>> +
>> +	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
>> +		if ((tlport->localport->node_name == nodename) &&
>> +		    (tlport->localport->port_name == portname)) {
>> +			lport = tlport;
>> +			break;
>> +		}
>> +	}
>> +	spin_unlock_irqrestore(&fcloop_lock, flags);
>> +
>> +	if (!lport)
>> +		return -ENOENT;
>> +
>> +	ret = __delete_local_port(lport);
> We either need a reference or do the actual deletion under the
> lock.

Well, there are only 2 conditions it matters - the user invokes the 
sysfs point twice for the same port, or sysfs and module unload occur at 
the same time.  I guess I assumed both of these to be operator issues. 
But it's no big deal to address them.  Yes - same conditions occurs on 
the other port delete calls.

>
>> +
>> +	fcloop_device =
>> +		device_create(fcloop_class, NULL, MKDEV(0, 0), NULL, "ctl");
>> +	if (IS_ERR(fcloop_device)) {
>> +		pr_err("couldn't create ctl device!\n");
>> +		ret = PTR_ERR(fcloop_device);
>> +		goto out_destroy_class;
>> +	}
>> +
>> +	ret = device_create_file(fcloop_device, &dev_attr_add_local_port);
>> +	if (ret) {
>> +		pr_err("couldn't add device add_local_port attr.\n");
>> +		goto out_destroy_device;
>> +	}
>> +
>> +	ret = device_create_file(fcloop_device, &dev_attr_del_local_port);
> ...
>
> Please use device_create_with_groups.

ok


>
>> +	for (;;) {
>> +		nport = list_first_entry_or_null(&fcloop_nports,
>> +						typeof(*nport), nport_list);
>> +		if (!nport)
>> +			break;
>> +
>> +		spin_unlock_irqrestore(&fcloop_lock, flags);
>> +
>> +		ret = __delete_target_port(nport);
>> +		if (ret)
>> +			pr_warn("%s: Failed deleting target port\n", __func__);
>> +
>> +		ret = __delete_remote_port(nport);
>> +		if (ret)
>> +			pr_warn("%s: Failed deleting remote port\n", __func__);
>> +
>> +		spin_lock_irqsave(&fcloop_lock, flags);
>> +	}
> The deletions need to happen without dropping the lock, or you need
> refcounts.

yes - I'll address it.



Ok  to the other comments

-- james
