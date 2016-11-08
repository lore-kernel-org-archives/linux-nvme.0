From: swise@opengridcomputing.com (Steve Wise)
Date: Tue, 8 Nov 2016 14:52:04 -0600
Subject: [PATCH] nvme-rdma: stop and free io queues on connect failure
In-Reply-To: <20161108200724.3F817E09E2@smtp.ogc.us>
References: <20161108200724.3F817E09E2@smtp.ogc.us>
Message-ID: <01cc01d23a01$f6465b30$e2d31190$@opengridcomputing.com>

Hey Sagi,

With v4.9-rc4 + your nvmf-4.9-rc branch rebased on rc4, and this fix below on
the host side, and your target side patch from:

http://lists.infradead.org/pipermail/linux-nvme/2016-November/007109.html

I've been up and running my keep-alive timeout/reconnect under load test for a
while now.  34 iterations of the fio.sh script I sent out in the above thread.
I'll keep testing, but I think we're getting close...

Steve.

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf Of
> Steve Wise
> Sent: Tuesday, November 08, 2016 11:16 AM
> To: sagi at grimberg.me
> Cc: hch at lst.de; linux-nvme at lists.infradead.org
> Subject: [PATCH] nvme-rdma: stop and free io queues on connect failure
> 
> While testing nvme-rdma with the spdk nvmf target over iw_cxgb4, I
> configured the target (mistakenly) to generate an error creating the
> NVMF IO queues.  This resulted a "Invalid SQE Parameter" error sent back
> to the host on the first IO queue connect:
> 
> [ 9610.928182] nvme nvme1: queue_size 128 > ctrl maxcmd 120, clamping down
> [ 9610.938745] nvme nvme1: creating 32 I/O queues.
> 
> So nvmf_connect_io_queue() returns an error to
> nvmf_connect_io_queue() / nvmf_connect_io_queues(), and that
> is returned to nvme_rdma_create_io_queues().  In the error path,
> nvmf_rdma_create_io_queues() frees the queue tagset memory _before_
> stopping and freeing the IB queues, which causes yet another
> touch-after-free crash due to SQ CQEs being flushed after the ib_cqe
> structs pointed-to by the flushed WRs have been freed (since they are
> part of the nvme_rdma_request struct).
> 
> The fix is to stop and free the queues in nvmf_connect_io_queues()
> if there is an error connecting any of the queues.
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> ---
>  drivers/nvme/host/rdma.c | 11 +++++++++--
>  1 file changed, 9 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index af1c114..0504f39 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -624,11 +624,18 @@ static int nvme_rdma_connect_io_queues(struct
> nvme_rdma_ctrl *ctrl)
> 
>  	for (i = 1; i < ctrl->queue_count; i++) {
>  		ret = nvmf_connect_io_queue(&ctrl->ctrl, i);
> -		if (ret)
> -			break;
> +		if (ret) {
> +			dev_info(ctrl->ctrl.device,
> +				"failed to connect i/o queue: %d\n", ret);
> +			goto out_free_queues;
> +		}
>  		set_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[i].flags);
>  	}
> 
> +	return 0;
> +
> +out_free_queues:
> +	nvme_rdma_free_io_queues(ctrl);
>  	return ret;
>  }
> 
> --
> 2.7.0
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
