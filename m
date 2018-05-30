From: sagi@grimberg.me (Sagi Grimberg)
Date: Thu, 31 May 2018 00:42:03 +0300
Subject: [PATCH v3 2/3] nvme-rdma: support up to 4 segments of inline data
In-Reply-To: <57928ebb0e1b3b8e6fedd613fd2ad6c2c8d84425.1527618402.git.swise@opengridcomputing.com>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <57928ebb0e1b3b8e6fedd613fd2ad6c2c8d84425.1527618402.git.swise@opengridcomputing.com>
Message-ID: <2a3d3a38-9ab9-d83f-33c4-51a1ea05a7d7@grimberg.me>



On 05/29/2018 09:25 PM, Steve Wise wrote:
> Allow up to 4 segments of inline data for NVMF WRITE operations. This
> reduces latency for small WRITEs by removing the need for the target to
> issue a READ WR for IB, or a REG_MR + READ WR chain for iWarp.
> 
> Also cap the inline segments used based on the limitations of the
> device.
> 
> Signed-off-by: Steve Wise <swise at opengridcomputing.com>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> ---
>   drivers/nvme/host/rdma.c | 39 ++++++++++++++++++++++++++++-----------
>   1 file changed, 28 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index f11faa8..32d2f4c 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -40,13 +40,14 @@
>   
>   #define NVME_RDMA_MAX_SEGMENTS		256
>   
> -#define NVME_RDMA_MAX_INLINE_SEGMENTS	1
> +#define NVME_RDMA_MAX_INLINE_SEGMENTS	4
>   
>   struct nvme_rdma_device {
>   	struct ib_device	*dev;
>   	struct ib_pd		*pd;
>   	struct kref		ref;
>   	struct list_head	entry;
> +	unsigned int		num_inline_segments;
>   };
>   
>   struct nvme_rdma_qe {
> @@ -117,6 +118,7 @@ struct nvme_rdma_ctrl {
>   	struct sockaddr_storage src_addr;
>   
>   	struct nvme_ctrl	ctrl;
> +	bool			use_inline_data;
>   };
>   
>   static inline struct nvme_rdma_ctrl *to_rdma_ctrl(struct nvme_ctrl *ctrl)
> @@ -249,7 +251,7 @@ static int nvme_rdma_create_qp(struct nvme_rdma_queue *queue, const int factor)
>   	/* +1 for drain */
>   	init_attr.cap.max_recv_wr = queue->queue_size + 1;
>   	init_attr.cap.max_recv_sge = 1;
> -	init_attr.cap.max_send_sge = 1 + NVME_RDMA_MAX_INLINE_SEGMENTS;
> +	init_attr.cap.max_send_sge = 1 + dev->num_inline_segments;
>   	init_attr.sq_sig_type = IB_SIGNAL_REQ_WR;
>   	init_attr.qp_type = IB_QPT_RC;
>   	init_attr.send_cq = queue->ib_cq;
> @@ -374,6 +376,9 @@ static int nvme_rdma_dev_get(struct nvme_rdma_device *dev)
>   		goto out_free_pd;
>   	}
>   
> +	ndev->num_inline_segments = min(NVME_RDMA_MAX_INLINE_SEGMENTS,
> +					ndev->dev->attrs.max_sge - 1);
> +	pr_debug("num_inline_segments = %u\n", ndev->num_inline_segments);

insist on keeping it? ibv_devinfo -v can give this info to the 
user/developer.

>   	list_add(&ndev->entry, &device_list);
>   out_unlock:
>   	mutex_unlock(&device_list_mutex);
> @@ -1086,19 +1091,27 @@ static int nvme_rdma_set_sg_null(struct nvme_command *c)
>   }
>   
>   static int nvme_rdma_map_sg_inline(struct nvme_rdma_queue *queue,
> -		struct nvme_rdma_request *req, struct nvme_command *c)
> +		struct nvme_rdma_request *req, struct nvme_command *c,
> +		int count)
>   {
>   	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
> +	struct scatterlist *sgl = req->sg_table.sgl;
> +	struct ib_sge *sge = &req->sge[1];
> +	u32 len = 0;
> +	int i;
>   
> -	req->sge[1].addr = sg_dma_address(req->sg_table.sgl);
> -	req->sge[1].length = sg_dma_len(req->sg_table.sgl);
> -	req->sge[1].lkey = queue->device->pd->local_dma_lkey;
> +	for (i = 0; i < count; i++, sgl++, sge++) {
> +		sge->addr = sg_dma_address(sgl);
> +		sge->length = sg_dma_len(sgl);
> +		sge->lkey = queue->device->pd->local_dma_lkey;
> +		len += sge->length;
> +	}
>   
>   	sg->addr = cpu_to_le64(queue->ctrl->ctrl.icdoff);
> -	sg->length = cpu_to_le32(sg_dma_len(req->sg_table.sgl));
> +	sg->length = cpu_to_le32(len);
>   	sg->type = (NVME_SGL_FMT_DATA_DESC << 4) | NVME_SGL_FMT_OFFSET;
>   
> -	req->num_sge++;
> +	req->num_sge += count;
>   	return 0;
>   }
>   
> @@ -1191,13 +1204,14 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
>   		return -EIO;
>   	}
>   
> -	if (count == 1) {
> +	if (count <= dev->num_inline_segments) {
>   		if (rq_data_dir(rq) == WRITE && nvme_rdma_queue_idx(queue) &&
> +		    queue->ctrl->use_inline_data &&
>   		    blk_rq_payload_bytes(rq) <=
>   				nvme_rdma_inline_data_size(queue))
> -			return nvme_rdma_map_sg_inline(queue, req, c);
> +			return nvme_rdma_map_sg_inline(queue, req, c, count);
>   
> -		if (dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
> +		if (count == 1 && dev->pd->flags & IB_PD_UNSAFE_GLOBAL_RKEY)
>   			return nvme_rdma_map_sg_single(queue, req, c);
>   	}
>   
> @@ -1955,6 +1969,9 @@ static struct nvme_ctrl *nvme_rdma_create_ctrl(struct device *dev,
>   		goto out_remove_admin_queue;
>   	}
>   
> +	if ((ctrl->ctrl.sgls & (1 << 20)))
> +		ctrl->use_inline_data = true;
> +

Here it is... discard my last comment.
