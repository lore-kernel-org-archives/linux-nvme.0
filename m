From: bvanassche@acm.org (Bart Van Assche)
Date: Wed, 05 Sep 2018 08:48:05 -0700
Subject: [PATCH 0/3] Introduce a light-weight queue close feature
In-Reply-To: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1536120586-3378-1-git-send-email-jianchao.w.wang@oracle.com>
Message-ID: <1536162485.11534.3.camel@acm.org>

On Wed, 2018-09-05@12:09 +0800, Jianchao Wang wrote:
> As we know, queue freeze is used to stop new IO comming in and drain
> the request queue. And the draining queue here is necessary, because
> queue freeze kills the percpu-ref q_usage_counter and need to drain
> the q_usage_counter before switch it back to percpu mode. This could
> be a trouble when we just want to prevent new IO.
> 
> In nvme-pci, nvme_dev_disable freezes queues to prevent new IO.
> nvme_reset_work will unfreeze and wait to drain the queues. However,
> if IO timeout at the moment, no body could do recovery as nvme_reset_work
> is waiting. We will encounter IO hang.
> 
> So introduce a light-weight queue close feature in this patch set
> which could prevent new IO and needn't drain the queue.
> 
> The 1st patch introduces a queue_gate into request queue and migrate
> preempt only from queue flags on it.
> 
> The 2nd patch introduces queue close feature.
> 
> The 3rd patch apply the queue close in nvme-pci to avoid the IO hang
> issue above.

Hello Jianchao,

Is this patch series based on a theoretical concern or rather on something
you ran into? In the latter case, can you explain which scenario makes it
likely on your setup to encounter an NVMe timeout?

Thanks,

Bart.
