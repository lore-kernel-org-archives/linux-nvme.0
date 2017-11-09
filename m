From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 10:21:10 +0100
Subject: [PATCH v2 2/3] nvme-rdma: don't complete requests before a
 send work request has completed
In-Reply-To: <20171108100616.26605-3-sagi@grimberg.me>
References: <20171108100616.26605-1-sagi@grimberg.me>
 <20171108100616.26605-3-sagi@grimberg.me>
Message-ID: <20171109092110.GB16966@lst.de>

> +	}
> +
> +	spin_lock_irqsave(&req->lock, flags);
> +	req->send_completed = true;
> +	end = req->resp_completed;
> +	spin_unlock_irqrestore(&req->lock, flags);

Wouldn't it be better to use atomic bitops (test_and_set_bit and co)
for these flags instead of needing a irqsave lock?

>  	err = nvme_rdma_post_send(queue, sqe, req->sge, req->num_sge,
> -			req->mr->need_inval ? &req->reg_wr.wr : NULL);
> +			req->mr->need_inval ? &req->reg_wr.wr : NULL, true);

Looks like the unsignalled completions just removed in the last patch
are coming back here.
