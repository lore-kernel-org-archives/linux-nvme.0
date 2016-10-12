From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 12 Oct 2016 02:42:03 -0700
Subject: [PATCH 6/7 v2] nvme-fabrics: Add target FC transport support
In-Reply-To: <57f82b13.7EhsIjBV7j7hnac1%james.smart@broadcom.com>
References: <57f82b13.7EhsIjBV7j7hnac1%james.smart@broadcom.com>
Message-ID: <20161012094203.GA6340@infradead.org>

> +nvmet_fc_getqueueid(u64 connectionid)
> +{
> +	return (u16)((connectionid) & NVMET_FC_QUEUEID_MASK);

Nitpick: superflous inner braces.

> +static LIST_HEAD(nvmet_fc_target_list);
> +static u32 nvmet_fc_tgtport_cnt;

Use an ida allocator instead?

> +	queue->assoc = assoc;
> +	queue->port = assoc->tgtport->port;
> +	INIT_LIST_HEAD(&queue->fod_list);
> +	atomic_set(&queue->connected, 0);
> +	atomic_set(&queue->sqtail, 0);
> +	atomic_set(&queue->rsn, 1);
> +	atomic_set(&queue->zrspcnt, 0);
> +	kref_init(&queue->ref);
> +
> +	nvmet_fc_tgt_a_get(assoc);

You need to check the return value here.  Also for the I/O queue
it needs to be innvmet_fc_find_target_assoc to be under tgtport->lock.

> +	/*
> +	 * beware: nvmet layer hangs waiting for a completion if
> +	 * connect command failed
> +	 */
> +	flush_workqueue(queue->work_q);

Can you elaborate on what the issue?

> +static struct nvmet_fc_tgt_queue *
> +nvmet_fc_find_target_queue(struct nvmet_fc_tgtport *tgtport,
> +				u64 connection_id)
> +{
> +	struct nvmet_fc_tgt_assoc *assoc;
> +	struct nvmet_fc_tgt_queue *queue;
> +	u64 association_id = nvmet_fc_getassociationid(connection_id);
> +	u16 qid = nvmet_fc_getqueueid(connection_id);
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&tgtport->lock, flags);
> +	list_for_each_entry(assoc, &tgtport->assoc_list, a_list) {
> +		if (association_id == assoc->association_id) {
> +			queue = assoc->queues[qid];
> +			spin_unlock_irqrestore(&tgtport->lock, flags);
> +			if (queue && !atomic_read(&queue->connected))
> +				queue = NULL;
> +			return queue;

This needs a nvmet_fc_tgt_q_get inside the lock.

> +static struct nvmet_fc_tgt_assoc *
> +nvmet_fc_alloc_target_assoc(struct nvmet_fc_tgtport *tgtport)
> +{
> +	struct nvmet_fc_tgt_assoc *assoc;
> +	unsigned long flags;
> +
> +	assoc = kzalloc(sizeof(*assoc), GFP_KERNEL);
> +	if (!assoc)
> +		return NULL;
> +
> +	assoc->tgtport = tgtport;
> +	assoc->association_id = cpu_to_le64(nvmet_fc_makeconnid(assoc, 0));
> +	INIT_LIST_HEAD(&assoc->a_list);
> +	kref_init(&assoc->ref);
> +
> +	nvmet_fc_tgtport_get(tgtport);

Needs to check the return value (At all callers)

> +	get_device(newrec->dev);

Check the return value.

> +	/*
> +	 * TODO: handle fused cmds back-to-back
> +	 */

Do you also plan to implement fused command support in the core?

> +	if (!list_empty(&nvmet_fc_target_list))
> +		pr_warn("%s: targetport list not empty\n", __func__);

WARN_ON?
