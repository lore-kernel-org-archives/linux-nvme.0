From: hch@lst.de (Christoph Hellwig)
Date: Mon, 22 May 2017 14:51:40 +0200
Subject: [PATCH v2 1/3] nvme: use blk_mq_start_hw_queues() in
 nvme_kill_queues()
In-Reply-To: <20170522013557.GD15872@ming.t460p>
References: <20170520035605.21785-1-ming.lei@redhat.com>
 <20170520035605.21785-2-ming.lei@redhat.com> <20170521062002.GB12287@lst.de>
 <20170522013557.GD15872@ming.t460p>
Message-ID: <20170522125140.GE11869@lst.de>

On Mon, May 22, 2017@09:35:58AM +0800, Ming Lei wrote:
> In theory, it should be OK to stop and start queues again before the final
> removal, so how about the following:
> 
>  		 * Note: We must make sure to not put the queues into being stopped
> 		 forever from now until the final removal.

Maybe:
		 * Note that we must ensure the queues are not stopped
		 * when the final removal happens.

?
