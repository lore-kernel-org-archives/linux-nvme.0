From: kbusch@kernel.org (Keith Busch)
Date: Fri, 3 May 2019 10:23:47 -0600
Subject: [PATCH] nvme-fc: trace sq head updates
In-Reply-To: <20190503141459.111641-1-hare@suse.de>
References: <20190503141459.111641-1-hare@suse.de>
Message-ID: <20190503162346.GC30291@localhost.localdomain>

On Fri, May 03, 2019@04:14:59PM +0200, Hannes Reinecke wrote:
> @@ -1675,6 +1678,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
>  	}
>  
>  	__nvme_fc_fcpop_chk_teardowns(ctrl, op, opstate);
> +	trace_nvme_sq(rq, queue->sq_head,
> +		      queue->sq_tail % ctrl->ctrl.sqsize);

Correct me if I'm wrong, but don't you need a +1 on that modulo value?
It looks like ctrl.sqsize is set to the last valid index rather than
the actual size.
