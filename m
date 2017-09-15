From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 15 Sep 2017 08:43:39 -0700
Subject: [PATCH v2] nvme: stop aer posting if controller state not live
In-Reply-To: <20170914180309.20851-1-jsmart2021@gmail.com>
References: <20170914180309.20851-1-jsmart2021@gmail.com>
Message-ID: <20170915154339.GA26222@infradead.org>

> +	bool done = true, live = true;
> +
> +	spin_lock_irq(&ctrl->lock);
> +	if (unlikely(ctrl->state != NVME_CTRL_LIVE))
> +		live = false;
> +	spin_unlock_irq(&ctrl->lock);

Taking a lock isn't going to help us anything when reading a single
value.  But I can just remove it when applying, the rest of the patch
looks good to me.
