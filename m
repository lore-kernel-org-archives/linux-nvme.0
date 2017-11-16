From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 16 Nov 2017 20:32:41 +0200
Subject: [PATCH 1/3] IB/core: add a simple SRQ pool per PD
In-Reply-To: <1510852885-25519-2-git-send-email-maxg@mellanox.com>
References: <1510852885-25519-1-git-send-email-maxg@mellanox.com>
 <1510852885-25519-2-git-send-email-maxg@mellanox.com>
Message-ID: <49940a5c-4a9e-7c66-5077-79fe45415155@grimberg.me>


> +EXPORT_SYMBOL(ib_srq_pool_init);
> +
> +void ib_srq_pool_destroy(struct ib_pd *pd)
> +{
> +	struct ib_srq *srq;
> +	unsigned long flags;
> +
> +	spin_lock_irqsave(&pd->srq_lock, flags);
> +	while (!list_empty(&pd->srqs)) {
> +		srq = list_first_entry(&pd->srqs, struct ib_srq, pd_entry);
> +		list_del(&srq->pd_entry);
> +
> +		spin_unlock_irqrestore(&pd->srq_lock, flags);
> +		ib_destroy_srq(srq);
> +		spin_lock_irqsave(&pd->srq_lock, flags);
> +	}
> +	spin_unlock_irqrestore(&pd->srq_lock, flags);

Why not just splicing the list and iterate sanely?
