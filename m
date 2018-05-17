From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 17 May 2018 08:33:11 -0700
Subject: [PATCH 2/3] nvme: split the nvme queue lock into submission and
 completion locks
In-Reply-To: <1526569337-3489-3-git-send-email-axboe@kernel.dk>
References: <1526569337-3489-1-git-send-email-axboe@kernel.dk>
 <1526569337-3489-3-git-send-email-axboe@kernel.dk>
Message-ID: <20180517153311.GD19042@infradead.org>

> -	spin_lock_irq(&nvmeq->q_lock);
> +	spin_lock_irq(&nvmeq->sq_lock);
>  	__nvme_submit_cmd(nvmeq, &cmnd);
> -	spin_unlock_irq(&nvmeq->q_lock);
> +	spin_unlock_irq(&nvmeq->sq_lock);

I don't think we need to disable irqs here anymore.
