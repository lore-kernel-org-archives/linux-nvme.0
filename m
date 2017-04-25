From: hch@lst.de (Christoph Hellwig)
Date: Tue, 25 Apr 2017 18:41:00 +0200
Subject: [PATCH] nvme/lightnvm: add missing endianess conversion in
 nvme_nvm_end_io
In-Reply-To: <20170421063017.26380-1-hch@lst.de>
References: <20170421063017.26380-1-hch@lst.de>
Message-ID: <20170425164100.GA15964@lst.de>

Javier, Matias:  can I get a quick ACK?  This is the last patch needed
to make drivers/nvme warning-free.

On Fri, Apr 21, 2017@08:30:17AM +0200, Christoph Hellwig wrote:
> Found by sparse.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> ---
>  drivers/nvme/host/lightnvm.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/nvme/host/lightnvm.c b/drivers/nvme/host/lightnvm.c
> index de61a4a03d78..e4e4e60b1224 100644
> --- a/drivers/nvme/host/lightnvm.c
> +++ b/drivers/nvme/host/lightnvm.c
> @@ -483,7 +483,7 @@ static void nvme_nvm_end_io(struct request *rq, int error)
>  {
>  	struct nvm_rq *rqd = rq->end_io_data;
>  
> -	rqd->ppa_status = nvme_req(rq)->result.u64;
> +	rqd->ppa_status = le64_to_cpu(nvme_req(rq)->result.u64);
>  	rqd->error = nvme_req(rq)->status;
>  	nvm_end_io(rqd);
>  
> -- 
> 2.11.0
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
---end quoted text---
