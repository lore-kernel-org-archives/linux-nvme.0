From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 30 Dec 2015 10:04:30 -0800
Subject: [PATCH 5/5] NVMe: IO queue deletion re-write
In-Reply-To: <1451496471-29370-6-git-send-email-keith.busch@intel.com>
References: <1451496471-29370-1-git-send-email-keith.busch@intel.com>
 <1451496471-29370-6-git-send-email-keith.busch@intel.com>
Message-ID: <20151230180430.GA12828@infradead.org>

On Wed, Dec 30, 2015@10:27:51AM -0700, Keith Busch wrote:
> The nvme driver deletes IO queues asynchronously since this operation
> may potentially take an undesirable amount of time with a large number
> of queues if done serially.
> 
> The driver used to manage coordinating asynchronous deletions. This
> patch simplifies that by leveraging the block layer rather than using
> kthread workers and complicated callback chaining.
> 
> Beyond just being a simpler method, this also fixes a theoretical hang
> if the controller stops responding while the worker thread was queued
> deeper than the admin queue depth.

I love the overall scheme, but I think some of the implementation
detail will need a few changes to be long term maintainable:

First the 'wait' workqueue is a per-controller wait, so it should
be in nvme_ctrl instead of a union inside the queue.  Second it
should really be a wait queue, and it should only wake the caller
when all pending queues have been deleted to avoid spurious wakeups.

The other things is the use of nvme_requeue_req for submitting
a different command, which looks rather hacky.  I'd suggest to
just wake a per-queue work item to do a proper command allocation
and submission, which also means we can use the normal on-stack
commands.

Btw:

> +static int nvme_delete_queue(struct nvme_queue *nvmeq, struct request_queue *q)
> +{
> +	struct request *req;
> +
> +	req = nvme_alloc_request(q, (struct nvme_command *)&nvmeq->dq,
> +							BLK_MQ_REQ_NOWAIT);
> +	if (IS_ERR(req))
> +		return -1;
> +
> +	memset(&nvmeq->dq, 0, sizeof(nvmeq->dq));
> +	nvmeq->dq.opcode = nvme_admin_delete_sq;
> +	nvmeq->dq.qid = cpu_to_le16(nvmeq->qid);
> +
> +	req->end_io_data = nvmeq;
> +	req->timeout = ADMIN_TIMEOUT;
> +
> +	blk_execute_rq_nowait(q, NULL, req, false, nvme_del_sq_end);
> +	return 0;

Please return either a Linux error code or a bool, but not a 0 vs -1
integer.
