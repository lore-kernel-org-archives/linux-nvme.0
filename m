From: swise@opengridcomputing.com (Steve Wise)
Date: Wed, 29 Jun 2016 09:11:06 -0500
Subject: target crash / host hang with nvme-all.3 branch of nvme-fabrics
In-Reply-To: <1467147851.26791.2.camel@ssi>
References: <576306EE.4020306@grimberg.me>
 <01b901d1c80b$72f83680$58e8a380$@opengridcomputing.com>
 <CAF1ivSYUG4c7Ej-gNqA=aPFR2zkNq8KhBoodhp64wdY=eQLx6g@mail.gmail.com>
 <01c101d1c80d$96d13c80$c473b580$@opengridcomputing.com>
 <20160616203437.GA19079@lst.de>
 <01e701d1c810$91d851c0$b588f540$@opengridcomputing.com>
 <020201d1c812$ec94b430$c5be1c90$@opengridcomputing.com>
 <1467066582.7205.7.camel@ssi> <20160628091433.GA14149@lst.de>
 <005001d1d147$81cd8cb0$8568a610$@opengridcomputing.com>
 <20160628155159.GA3084@lst.de>
 <01dc01d1d15a$84f42670$8edc7350$@opengridcomputing.com>
 <1467132596.7205.11.camel@ssi>
 <022701d1d172$2743d990$75cb8cb0$@opengridcomputing.com>
 <022901d1d175$48c899e0$da59cda0$@opengridcomputing.com>
 <1467147851.26791.2.camel@ssi>
Message-ID: <00ad01d1d210$13be66d0$3b3b3470$@opengridcomputing.com>

> This one should be more correct.
> Actually, the rsp was leaked when queue->state is
> NVMET_RDMA_Q_DISCONNECTING. So we should put it back.
> 
> It works for me. Could you help to verify?

works!

> 
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index 425b55c..ee8b85e 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -727,6 +727,8 @@ static void nvmet_rdma_recv_done(struct ib_cq *cq, struct
> ib_wc *wc)
>  		spin_lock_irqsave(&queue->state_lock, flags);
>  		if (queue->state == NVMET_RDMA_Q_CONNECTING)
>  			list_add_tail(&rsp->wait_list, &queue->rsp_wait_list);
> +		else
> +			nvmet_rdma_put_rsp(rsp);
>  		spin_unlock_irqrestore(&queue->state_lock, flags);
>  		return;
>  	}
> 
