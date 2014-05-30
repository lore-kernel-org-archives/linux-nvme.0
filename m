From: willy@linux.intel.com (Matthew Wilcox)
Date: Fri, 30 May 2014 10:54:46 -0400
Subject: [PATCH v4] NVMe: basic conversion to blk-mq
In-Reply-To: <1401400285-25003-2-git-send-email-m@bjorling.me>
References: <1401400285-25003-1-git-send-email-m@bjorling.me>
 <1401400285-25003-2-git-send-email-m@bjorling.me>
Message-ID: <20140530145446.GC5499@linux.intel.com>

On Thu, May 29, 2014@11:51:25PM +0200, Matias Bj?rling wrote:
> @@ -816,9 +671,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
>  	irqreturn_t result;
>  	struct nvme_queue *nvmeq = data;
>  	spin_lock(&nvmeq->q_lock);
> -	nvme_process_cq(nvmeq);
> -	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
> -	nvmeq->cqe_seen = 0;
> +	result = nvme_process_cq(nvmeq) ? IRQ_HANDLED : IRQ_NONE;
>  	spin_unlock(&nvmeq->q_lock);
>  	return result;
>  }

Put cqe_seen back.  I already told Sam this was wrong.
http://lists.infradead.org/pipermail/linux-nvme/2014-May/000856.html
