From: maxg@mellanox.com (Max Gurtovoy)
Date: Wed, 24 Jan 2018 17:57:54 +0200
Subject: [PATCH 1/1] nvme-rdma: remove redundant boolean for inline_data
In-Reply-To: <1512577280-32595-1-git-send-email-maxg@mellanox.com>
References: <1512577280-32595-1-git-send-email-maxg@mellanox.com>
Message-ID: <e5486aa5-d9e6-c1f4-3042-daf022cee270@mellanox.com>

ping :)

On 12/6/2017 6:21 PM, Max Gurtovoy wrote:
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>   drivers/nvme/host/rdma.c | 3 ---
>   1 file changed, 3 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 37af565..225f7f1 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -66,7 +66,6 @@ struct nvme_rdma_request {
>   	struct ib_sge		sge[1 + NVME_RDMA_MAX_INLINE_SEGMENTS];
>   	u32			num_sge;
>   	int			nents;
> -	bool			inline_data;
>   	struct ib_reg_wr	reg_wr;
>   	struct ib_cqe		reg_cqe;
>   	struct nvme_rdma_queue  *queue;
> @@ -1086,7 +1085,6 @@ static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
>   	sg->length = cpu_to_le32(sg_dma_len(req->sg_table.sgl));
>   	sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
>   
> -	req->inline_data = true;
>   	req->num_sge++;
>   	return 0;
>   }
> @@ -1158,7 +1156,6 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
>   	int count, ret;
>   
>   	req->num_sge = 1;
> -	req->inline_data = false;
>   	refcount_set(&req->ref, 2); /* send and recv completions */
>   
>   	c->common.flags |= NVME_CMD_SGL_METABUF;
> 
