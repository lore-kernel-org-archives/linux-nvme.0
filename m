From: Bart.VanAssche@wdc.com (Bart Van Assche)
Date: Wed, 23 Aug 2017 18:21:55 +0000
Subject: [PATCH 10/10] nvme: implement multipath access to nvme subsystems
In-Reply-To: <20170823175815.3646-11-hch@lst.de>
References: <20170823175815.3646-1-hch@lst.de>
 <20170823175815.3646-11-hch@lst.de>
Message-ID: <1503512512.2484.16.camel@wdc.com>

On Wed, 2017-08-23@19:58 +0200, Christoph Hellwig wrote:
> +static blk_qc_t nvme_make_request(struct request_queue *q, struct bio *bio)
> +{
> +	struct nvme_ns_head *head = q->queuedata;
> +	struct nvme_ns *ns;
> +	blk_qc_t ret = BLK_QC_T_NONE;
> +	int srcu_idx;
> +
> +	srcu_idx = srcu_read_lock(&head->srcu);
> +	ns = srcu_dereference(head->current_path, &head->srcu);
> +	if (unlikely(!ns || ns->ctrl->state != NVME_CTRL_LIVE))
> +		ns = nvme_find_path(head);
> +	if (likely(ns)) {
> +		bio->bi_disk = ns->disk;
> +		bio->bi_opf |= REQ_FAILFAST_TRANSPORT;
> +		ret = generic_make_request_fast(bio);
> +	} else if (!list_empty_careful(&head->list)) {
> +		printk_ratelimited("no path available - requeing I/O\n");
> +
> +		spin_lock_irq(&head->requeue_lock);
> +		bio_list_add(&head->requeue_list, bio);
> +		spin_unlock_irq(&head->requeue_lock);
> +	} else {
> +		printk_ratelimited("no path - failing I/O\n");
> +
> +		bio->bi_status = BLK_STS_IOERR;
> +		bio_endio(bio);
> +	}
> +
> +	srcu_read_unlock(&head->srcu, srcu_idx);
> +	return ret;
> +}

Hello Christoph,

Since generic_make_request_fast() returns BLK_STS_AGAIN for a dying path:
can the same kind of soft lockups occur with the NVMe multipathing code as
with the current upstream device mapper multipathing code? See e.g.
"[PATCH 3/7] dm-mpath: Do not lock up a CPU with requeuing activity"
(https://www.redhat.com/archives/dm-devel/2017-August/msg00124.html).

Another question about this code is what will happen if
generic_make_request_fast() returns BLK_STS_AGAIN and the submit_bio() or
generic_make_request() caller ignores the return value of the called
function? A quick grep revealed that there is plenty of code that ignores
the return value of these last two functions.

Thanks,

Bart.
