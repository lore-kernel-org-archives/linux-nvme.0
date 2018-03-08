From: keith.busch@intel.com (Keith Busch)
Date: Thu, 8 Mar 2018 08:51:47 -0700
Subject: [PATCH rfc] nvme-pci: make sure to flush sqe writes before db
 record update
In-Reply-To: <20180307175626.15222-1-sagi@grimberg.me>
References: <20180307175626.15222-1-sagi@grimberg.me>
Message-ID: <20180308155147.GD3766@localhost.localdomain>

On Wed, Mar 07, 2018@07:56:26PM +0200, Sagi Grimberg wrote:
> @@ -437,8 +437,14 @@ static void __nvme_submit_cmd(struct nvme_queue *nvmeq,
>  	if (++tail == nvmeq->q_depth)
>  		tail = 0;
>  	if (nvme_dbbuf_update_and_check_event(tail, nvmeq->dbbuf_sq_db,
> -					      nvmeq->dbbuf_sq_ei))
> +					      nvmeq->dbbuf_sq_ei)) {
> +		/*
> +		 * Make sure that descriptors are written before
> +		 * doorbell record.
> +		 */
> +		wmb();
>  		writel(tail, nvmeq->q_db);
> +	}
>  	nvmeq->sq_tail = tail;
>  }

If this really is necessary, we'd need this before updating the event
shadow registers too.

I'd like to understand this a bit more as we haven't done this in eight
years and I can't recall any issues around this section. Have we just
been fortunate that the problem this fixes is extraordinarily unlikely,
or is something else implicitly ordering within this critical section?
