From: james.smart@broadcom.com (James Smart)
Date: Tue, 12 Sep 2017 08:53:01 -0700
Subject: [PATCH 10/10] Reserved tag for active ns command
In-Reply-To: <20170912043302.uikxktbfqjfzwfvn@haynes>
References: <20170912043302.uikxktbfqjfzwfvn@haynes>
Message-ID: <8ab4b015-4c3d-256f-a842-468edbc59059@broadcom.com>

Please commonize the # of reserved tags.? There's more than 1 transport 
and they all do the same things.

-- james


On 9/11/2017 9:33 PM, Anish M Jhaveri wrote:
> Using reserved tag for setting standby namespace to active using nvme command.
>
> Signed-off-by: Anish M Jhaveri <anish.jhaveri at paviliondata.com>
> ---
>   drivers/nvme/host/rdma.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index cb6a5f8..d094793 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -1550,7 +1550,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl)
>   	memset(&ctrl->admin_tag_set, 0, sizeof(ctrl->admin_tag_set));
>   	ctrl->admin_tag_set.ops = &nvme_rdma_admin_mq_ops;
>   	ctrl->admin_tag_set.queue_depth = NVME_RDMA_AQ_BLKMQ_DEPTH;
> -	ctrl->admin_tag_set.reserved_tags = 2; /* connect + keep-alive */
> +	ctrl->admin_tag_set.reserved_tags = 3; /* connect + keep-alive */
>   	ctrl->admin_tag_set.numa_node = NUMA_NO_NODE;
>   	ctrl->admin_tag_set.cmd_size = sizeof(struct nvme_rdma_request) +
>   		SG_CHUNK_SIZE * sizeof(struct scatterlist);
