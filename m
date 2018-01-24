From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Jan 2018 08:39:20 +0200
Subject: [PATCH 1/4] IB/core: add support for draining Shared receive
 queues
In-Reply-To: <1516197178-26493-2-git-send-email-maxg@mellanox.com>
References: <1516197178-26493-1-git-send-email-maxg@mellanox.com>
 <1516197178-26493-2-git-send-email-maxg@mellanox.com>
Message-ID: <11f8c447-065f-ee0c-f88e-ee3a006f8571@grimberg.me>

Hi Max,

> diff --git a/drivers/infiniband/core/verbs.c b/drivers/infiniband/core/verbs.c
> index 7868727..7604450 100644
> --- a/drivers/infiniband/core/verbs.c
> +++ b/drivers/infiniband/core/verbs.c
> @@ -886,8 +886,10 @@ struct ib_qp *ib_create_qp(struct ib_pd *pd,
>   		if (qp_init_attr->recv_cq)
>   			atomic_inc(&qp_init_attr->recv_cq->usecnt);
>   		qp->srq = qp_init_attr->srq;
> -		if (qp->srq)
> +		if (qp->srq) {
>   			atomic_inc(&qp_init_attr->srq->usecnt);
> +			init_completion(&qp->srq_completion);
> +		}
>   	}

How about initializing the completion at ib_drain_srq and complete it
always in last wqe reached event in the core instead of relying on ULPs
to call ib_notify_qp?

The simplest way I can think of is to have the core register its own
event handler for that..
