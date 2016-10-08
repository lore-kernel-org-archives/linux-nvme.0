From: keith.busch@intel.com (Busch, Keith)
Date: Sat, 8 Oct 2016 19:00:04 +0000
Subject: nvme_admin_passthru DMA failure
In-Reply-To: <CAEhN9jtotCMNBt9Oy7M_HDe_oqDHoMegf+trki+2255gyfoO0g@mail.gmail.com>
References: <CAEhN9jtotCMNBt9Oy7M_HDe_oqDHoMegf+trki+2255gyfoO0g@mail.gmail.com>
Message-ID: <B58D82457FDA0744A320A2FC5AC253B93D75FBDE@fmsmsx104.amr.corp.intel.com>

Is this a vendor specific opcode? If so, what is the opcode value and what direction are you expecting the data transfer to go?


> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of Patrick Sheridan
> Sent: Friday, October 7, 2016 3:15 PM
> To: linux-nvme at lists.infradead.org
> Subject: nvme_admin_passthru DMA failure
>
> There is a problem when using an NVME_IOCTL_ADMIN_CMD to submit an
> nvme_admin_passthru struct such that user data
> (nvme_passthru_cmd.addr) does not get DMA'd to the drive correctly.
>
> The problem first appeared in kernel tags/v4.5.1 and was absent in
> tags/v4.5.  The only relevant difference between those was in
> block/blk-core.c, so this is likely a block layer problem:
>
> diff --git a/block/blk-core.c b/block/blk-core.c
> index b83d297..45f4d7e 100644
> --- a/block/blk-core.c
> +++ b/block/blk-core.c
> @@ -2198,7 +2198,7 @@ int blk_insert_cloned_request(struct
> request_queue *q, struct request *rq)
>         if (q->mq_ops) {
>                 if (blk_queue_io_stat(q))
>                         blk_account_io_start(rq, true);
> -               blk_mq_insert_request(rq, false, true, true);
> +               blk_mq_insert_request(rq, false, true, false);
>                 return 0;
>         }
