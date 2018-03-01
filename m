From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 1 Mar 2018 11:12:01 +0200
Subject: nvme-rdma corrupts memory upon timeout
In-Reply-To: <cefc1ef2-4ffb-5d6c-c047-d6233a189843@grimberg.me>
References: <CAF9HSintgS0U2X=E=_uJnU4y95HDcCUnyCKBDF_tNaDcY9pucg@mail.gmail.com>
 <65c6d928-dd82-70b6-79a7-481dc629c3db@grimberg.me>
 <9569a169-76cb-cd49-e31a-f33978fe2025@grimberg.me>
 <CAF9HSin0W-PcsK-ADENviGeydirrhjyTVnWpnjBpZCeZWaJ0ng@mail.gmail.com>
 <cefc1ef2-4ffb-5d6c-c047-d6233a189843@grimberg.me>
Message-ID: <ecc2b48a-f49f-9e2a-17a2-d68edf780b51@grimberg.me>


>> This patch still returns to userspace after queuing work and may
>> result in corruption.
> 
> That's probably that one request being timed out as we complete
> it earlier.
> 
> Does this patch on top help?
> -- 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index e793b0899d4e..50bbf88b82f6 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1590,10 +1590,7 @@ nvme_rdma_timeout(struct request *rq, bool reserved)
>  ??????? /* queue error recovery */
>  ??????? nvme_rdma_error_recovery(req->queue->ctrl);
> 
> -?????? /* fail with DNR on cmd timeout */
> -?????? nvme_req(rq)->status = NVME_SC_ABORT_REQ | NVME_SC_DNR;
> -
> -?????? return BLK_EH_HANDLED;
> +?????? return BLK_EH_RESET_TIMER;
>  ?}
> 
>  ?/*
> -- 

Did this help?
