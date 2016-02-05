From: wenbo.wang@memblaze.com (Wenbo Wang)
Date: Fri, 5 Feb 2016 06:53:34 +0000
Subject: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination
In-Reply-To: <20160204154454.GB28747@localhost.localdomain>
References: <1454417099-19332-1-git-send-email-sagig@mellanox.com>
 <1454417099-19332-3-git-send-email-sagig@mellanox.com>
 <BJXPR01MB1992E35D667BC3289F424CAE0DF0@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160202164915.GB10728@localhost.localdomain>
 <BJXPR01MB1999CBB2644C70CE07E4B28E0D00@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160203012638.GC21046@localhost.localdomain>
 <BJXPR01MB19990484665533561B21DB3E0D10@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>
 <20160204154454.GB28747@localhost.localdomain>
Message-ID: <BJXPR01MB19999BF4E16A2752494C2F3E0D20@BJXPR01MB199.CHNPR01.prod.partner.outlook.cn>

Thanks.

The problem is that just after nvme_cancel_queue_ios checks the request is started, someone else move the request to q->requeue_list. 
The following patch I proposed has this issue. Queue_rq returns BLK_MQ_RQ_QUEUE_BUSY to __blk_mq_run_hw_queue, which re-queues the request to q->queue_list.
The solution may be call blk_mq_start_request after checking cq_vector. However I suspect some other code may break nvme_cancel_queue_ios too.

Is it a general solution to add a bit lock for each request and use that lock to synchronize stuffs?

Subject: [PATCH v2] NVMe: do not touch sq door bell if nvmeq has been suspended
>@@ -678,6 +678,11 @@ static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> 	blk_mq_start_request(req);
> 
> 	spin_lock_irq(&nvmeq->q_lock);
>+	if (unlikely(nvmeq->cq_vector == -1)) {
>+		ret = BLK_MQ_RQ_QUEUE_BUSY;
>+		spin_unlock_irq(&nvmeq->q_lock);
>+		goto out;
>+	}
> 	__nvme_submit_cmd(nvmeq, &cmnd);
> 	nvme_process_cq(nvmeq);
> 	spin_unlock_irq(&nvmeq->q_lock);
>--



-----Original Message-----
From: Keith Busch [mailto:keith.busch@intel.com] 
Sent: Thursday, February 4, 2016 11:45 PM
To: Wenbo Wang
Cc: Sagi Grimberg; Jens Axboe; linux-nvme at lists.infradead.org
Subject: Re: [PATCH v1 2/3] nvme: Use blk-mq helper for IO termination

On Thu, Feb 04, 2016@02:28:24PM +0000, Wenbo Wang wrote:
> Is the following execution valid?
> 
> 1. request A is linked in q->request_list

q->request_list? Do you mean q->requeue_list?

> 2. device reset
> 3. all requests (including request A) are cancelled by 
> nvme_dev_disable()->nvme_clear_queue()

If the request is on some list owned by the request_queue, it was not started by the driver, and nvme_clear_queue doesn't do anything to it.

> 4. device restarted
> 5. flush q->request_list, and request A is again running in queue_rq.         <-- since request A has been cancelled, it shall not be running again

Request A was not cancelled if it was never started. It will be submitted when the driver restarts the queues h/w contexts.

Cancelling a command with the controller does not mean ending the request in the block layer.
