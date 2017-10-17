From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 16 Oct 2017 23:43:06 -0700
Subject: [PATCH v2] nvmet: protect sqhd update by a lock
In-Reply-To: <20171016151820.14766-1-jsmart2021@gmail.com>
References: <20171016151820.14766-1-jsmart2021@gmail.com>
Message-ID: <20171017064306.GA16133@infradead.org>

>  	if (status)
>  		nvmet_set_status(req, status);
>  
> +	spin_lock_irqsave(&req->sq->sqhd_lock, flags);
>  	if (req->sq->size)
>  		req->sq->sqhd = (req->sq->sqhd + 1) % req->sq->size;
>  	req->rsp->sq_head = cpu_to_le16(req->sq->sqhd);
> +	spin_unlock_irqrestore(&req->sq->sqhd_lock, flags);

What performance impact does this have?   I'm really reluctant to put
an irq disabling spinlock into a hot path for a feature that
theoretically is in the spec but ignored by every host.

I'd much rather play games with cmpxchg or similar here.
