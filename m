From: axboe@kernel.dk (Jens Axboe)
Date: Fri, 2 Aug 2019 07:34:13 -0600
Subject: [PATCH V2 0/5] blk-mq: wait until completed req's complete fn is
 run
In-Reply-To: <20190724034843.10879-1-ming.lei@redhat.com>
References: <20190724034843.10879-1-ming.lei@redhat.com>
Message-ID: <040caa53-897e-287b-00be-7541bce88b7d@kernel.dk>

On 7/23/19 9:48 PM, Ming Lei wrote:
> Hi,
> 
> blk-mq may schedule to call queue's complete function on remote CPU via
> IPI, but never provide any way to synchronize the request's complete
> fn.
> 
> In some driver's EH(such as NVMe), hardware queue's resource may be freed &
> re-allocated. If the completed request's complete fn is run finally after the
> hardware queue's resource is released, kernel crash will be triggered.
> 
> Fixes this issue by waitting until completed req's complete fn is run.

Queued up for 5.4, thanks Ming.

-- 
Jens Axboe
