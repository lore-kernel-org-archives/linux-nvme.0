From: maxg@mellanox.com (Max Gurtovoy)
Date: Tue, 21 May 2019 11:36:26 +0300
Subject: [PATCH 5.0 66/95] nvme: cancel request synchronously
In-Reply-To: <20190509181314.082604502@linuxfoundation.org>
References: <20190509181309.180685671@linuxfoundation.org>
 <20190509181314.082604502@linuxfoundation.org>
Message-ID: <d0cd612d-1bce-50ca-1186-de67054b33c1@mellanox.com>

On 5/9/2019 9:42 PM, Greg Kroah-Hartman wrote:
> [ Upstream commit eb3afb75b57c28599af0dfa03a99579d410749e9 ]
>
> nvme_cancel_request() is used in error handler, and it is always
> reliable to cancel request synchronously, and avoids possible race
> in which request may be completed after real hw queue is destroyed.

Ming,

If the completion is async in the block layer, can't a "good" request 
(not a canceled one..) complete after real HW queue is destroyed ?


>
> One issue is reported by our customer on NVMe RDMA, in which freed ib
> queue pair may be used in nvme_rdma_complete_rq().
>
> Cc: Sagi Grimberg <sagi at grimberg.me>
> Cc: Bart Van Assche <bvanassche at acm.org>
> Cc: James Smart <james.smart at broadcom.com>
> Cc: linux-nvme at lists.infradead.org
> Reviewed-by: Keith Busch <keith.busch at intel.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Ming Lei <ming.lei at redhat.com>
> Signed-off-by: Jens Axboe <axboe at kernel.dk>
> Signed-off-by: Sasha Levin <sashal at kernel.org>
> ---
>   drivers/nvme/host/core.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
> index 6a9dd68c0f4fe..4c4413ad3ceb3 100644
> --- a/drivers/nvme/host/core.c
> +++ b/drivers/nvme/host/core.c
> @@ -291,7 +291,7 @@ bool nvme_cancel_request(struct request *req, void *data, bool reserved)
>   				"Cancelling I/O %d", req->tag);
>   
>   	nvme_req(req)->status = NVME_SC_ABORT_REQ;
> -	blk_mq_complete_request(req);
> +	blk_mq_complete_request_sync(req);
>   	return true;
>   }
>   EXPORT_SYMBOL_GPL(nvme_cancel_request);
