From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 4 Jul 2016 01:49:40 -0700
Subject: [PATCH] nvme: add a module parameter to change queue depth
In-Reply-To: <577A1F50.4070502@jp.fujitsu.com>
References: <577A1F50.4070502@jp.fujitsu.com>
Message-ID: <20160704084940.GA7777@infradead.org>

On Mon, Jul 04, 2016@05:33:20PM +0900, Masayoshi Mizuma wrote:
> This patch adds "q_depth_limit" as a module parameter. nvme_queue->q_depth
> is set below q_depth_limit.
> 
> while loop at __nvme_process_cq() sometimes takes long time and
> the loop is under IRQ context, so system slow down and hardlockup
> may occur because of the loop.
> 
> The while loop runs nvme_queue->q_depth times and the q_depth is set
> by the following (NVME_Q_DEPTH is 1024).
> 
>  dev->q_depth = min_t(int, NVME_CAP_MQES(cap) + 1, NVME_Q_DEPTH);
> 
> To reduce the times of the loop, the q_depth_limit is useful.
> 
> In addition, this patch moves the temporary fix for the Apple controller
> into the new function, get_q_depth().

While limiting the queue depth might still be useful I think we need
to look into a potential lock break in __nvme_process_cq so that it
doesn't cause hard lockups even with large queue depth first.
