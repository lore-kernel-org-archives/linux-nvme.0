From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Oct 2016 03:37:23 -0700
Subject: [PATCH 7/7 v2] nvme-fabrics: Add FC LLDD loopback driver to test
 FC-NVME
In-Reply-To: <57f82b14.jWEV18LIgDqDVRgP%james.smart@broadcom.com>
References: <57f82b14.jWEV18LIgDqDVRgP%james.smart@broadcom.com>
Message-ID: <20161012103723.GA25068@infradead.org>

> +#define is_end_of_list(pos, head, member) ((&pos->member) == (head))

This one isn't actually used in the code.

> +	(tgt_lsreq->done)(tgt_lsreq);

no need for the first set of braces.

> +void
> +fcloop_fcp_copy_data(u8 op, struct scatterlist *data_sg,
> +			struct scatterlist *io_sg, u32 offset, u32 length)

Should be marked static (as should most of the functions in this file)

> +int
> +fcloop_fcp_op(struct nvmet_fc_target_port *tgtport,
> +			struct nvmefc_tgt_fcp_req *tgt_fcpreq)
> +{
> +	struct fcloop_fcpreq *tfcp_req = tgt_fcp_req_to_fcpreq(tgt_fcpreq);
> +	struct nvmefc_fcp_req *fcpreq = tfcp_req->fcpreq;
> +	u32 rsplen = 0, xfrlen = 0;
> +	int fcp_err = 0;
> +	u8 op = tgt_fcpreq->op;
> +
> +	switch (op) {
> +	case NVMET_FCOP_WRITEDATA:
> +		xfrlen = tgt_fcpreq->transfer_length;
> +		fcloop_fcp_copy_data(op, tgt_fcpreq->sg, fcpreq->first_sgl,
> +					tgt_fcpreq->offset, xfrlen);
> +		fcpreq->transferred_length += xfrlen;

.. but I don't even understand why we need to copy between these
SGLs?

> +	spin_lock_irqsave(&fcloop_lock, flags);
> +
> +	list_for_each_entry(tlport, &fcloop_lports, lport_list) {
> +		if ((tlport->localport->node_name == nodename) &&
> +		    (tlport->localport->port_name == portname)) {
> +			lport = tlport;
> +			break;
> +		}
> +	}
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	if (!lport)
> +		return -ENOENT;
> +
> +	ret = __delete_local_port(lport);

We either need a reference or do the actual deletion under the
lock.

> +	list_for_each_entry(nport, &fcloop_nports, nport_list) {
> +		if ((nport->node_name == opts->wwnn) &&
> +		    (nport->port_name == opts->wwpn)) {
> +			if ((remoteport && nport->rport) ||
> +			    (!remoteport && nport->tport)) {
> +				nport = NULL;
> +				goto out_invalid_opts;
> +			}
> +
> +			fcloop_nport_get(nport);

Needs to check the return value.

> +	list_for_each_entry(tnport, &fcloop_nports, nport_list) {
> +		if ((tnport->node_name == nodename) &&
> +		    (tnport->port_name == portname) && tnport->rport) {
> +			nport = tnport;
> +			break;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	if (!nport)
> +		return -ENOENT;
> +
> +	ret = __delete_remote_port(nport);

The deletion needs to be done under fcloop_lock, or we need a refcount.

> +	list_for_each_entry(tnport, &fcloop_nports, nport_list) {
> +		if ((tnport->node_name == nodename) &&
> +		    (tnport->port_name == portname) && tnport->tport) {
> +			nport = tnport;
> +			break;
> +		}
> +	}
> +
> +	spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +	if (!nport)
> +		return -ENOENT;
> +
> +	ret = __delete_target_port(nport);

Same here.

> +
> +	fcloop_device =
> +		device_create(fcloop_class, NULL, MKDEV(0, 0), NULL, "ctl");
> +	if (IS_ERR(fcloop_device)) {
> +		pr_err("couldn't create ctl device!\n");
> +		ret = PTR_ERR(fcloop_device);
> +		goto out_destroy_class;
> +	}
> +
> +	ret = device_create_file(fcloop_device, &dev_attr_add_local_port);
> +	if (ret) {
> +		pr_err("couldn't add device add_local_port attr.\n");
> +		goto out_destroy_device;
> +	}
> +
> +	ret = device_create_file(fcloop_device, &dev_attr_del_local_port);

...

Please use device_create_with_groups.

> +	for (;;) {
> +		nport = list_first_entry_or_null(&fcloop_nports,
> +						typeof(*nport), nport_list);
> +		if (!nport)
> +			break;
> +
> +		spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +		ret = __delete_target_port(nport);
> +		if (ret)
> +			pr_warn("%s: Failed deleting target port\n", __func__);
> +
> +		ret = __delete_remote_port(nport);
> +		if (ret)
> +			pr_warn("%s: Failed deleting remote port\n", __func__);
> +
> +		spin_lock_irqsave(&fcloop_lock, flags);
> +	}

The deletions need to happen without dropping the lock, or you need
refcounts.

> +
> +	for (;;) {
> +		lport = list_first_entry_or_null(&fcloop_lports,
> +						typeof(*lport), lport_list);
> +		if (!lport)
> +			break;
> +
> +		spin_unlock_irqrestore(&fcloop_lock, flags);
> +
> +		ret = __delete_local_port(lport);
> +		if (ret)
> +			pr_warn("%s: Failed deleting local port\n", __func__);
> +
> +		spin_lock_irqsave(&fcloop_lock, flags);
> +
> +	}
> +
> +	spin_unlock_irqrestore(&fcloop_lock, flags);

Same here.
