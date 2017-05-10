From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 10 May 2017 10:22:21 -0700
Subject: [PATCH] nvme_fc: replace ioabort msleep loop with completion
In-Reply-To: <20170425223212.3876-1-jsmart2021@gmail.com>
References: <20170425223212.3876-1-jsmart2021@gmail.com>
Message-ID: <20170510172221.GA28599@infradead.org>

> +			if (!(--ctrl->iocnt))

No need for the inner braces here.

> -	while (ctrl->iocnt) {
> +	if (ctrl->iocnt) {
> +		init_completion(&ctrl->ioaborts_done);
>  		spin_unlock_irqrestore(&ctrl->lock, flags);
> -		msleep(1000);
> +
> +		wait_for_completion(&ctrl->ioaborts_done);
> +
>  		spin_lock_irqsave(&ctrl->lock, flags);
> +		WARN_ON(ctrl->iocnt);

But more importantly the single wait is potentially wrong.  Please
switch to a waitqueue and use wait_event_lock_irq here.
