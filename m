From: sagi@grimberg.me (Sagi Grimberg)
Date: Sat, 22 Oct 2016 00:48:06 +0300
Subject: [PATCH RFC v2 3/3] nvme-rdma: use rdma_reject_msg() to log
 connection rejects
In-Reply-To: <20161021122318.GB17325@lst.de>
References: <cover.1477003235.git.swise@opengridcomputing.com>
 <60243a2ce17e08cdc93600b9998698dbd7f83306.1477003235.git.swise@opengridcomputing.com>
 <20161021122318.GB17325@lst.de>
Message-ID: <c2080444-9258-1bb4-83e2-7f6cef161ec3@grimberg.me>


> Given the nasty casting issues in the current RDMA/CM API maybe we should
> actually expand the scope of the rdma_consumer_reject helper to include
> the above check, e.g. check that there is a private data len and then
> return a pointer to the private data?
>
> Something like
>
> static int nvme_rdma_conn_rejected(struct nvme_rdma_queue *queue,
> 		struct rdma_cm_event *ev)
> {
> 	struct rdma_cm_id *cm_id = queue->cm_id;
> 	struct nvme_rdma_cm_rej *rej
> 	short nvme_status = -1;
>
> 	rej = rdma_cm_reject_message(ev);
> 	if (rej)
> 		nvme_status = le16_to_cpu(rej->sts);
>

Looks nicer...

>>
>> +	dev_err(queue->ctrl->ctrl.device, "Connect rejected: status %d (%s) "
>> +		"nvme status %d.\n", rdma_status,
>> +		rdma_reject_msg(cm_id, rdma_status), nvme_status);
>
> And while we're pretty printing the rest it would be nice to pretty
> print the NVMe status here as well.

Would be nice...
