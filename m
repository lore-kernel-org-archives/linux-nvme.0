From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 21 Nov 2016 23:41:31 -0800
Subject: [PATCH 2/2] nvme-rdma: align to generic ib_event logging helper
In-Reply-To: <1479761145-13264-2-git-send-email-maxg@mellanox.com>
References: <1479761145-13264-1-git-send-email-maxg@mellanox.com>
 <1479761145-13264-2-git-send-email-maxg@mellanox.com>
Message-ID: <20161122074131.GB5497@infradead.org>

On Mon, Nov 21, 2016@10:45:45PM +0200, Max Gurtovoy wrote:
> Signed-off-by: Max Gurtovoy <maxg at mellanox.com>
> ---
>  drivers/nvme/host/rdma.c |    4 +++-
>  1 files changed, 3 insertions(+), 1 deletions(-)
> 
> diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> index 3d25add..bad4ce1 100644
> --- a/drivers/nvme/host/rdma.c
> +++ b/drivers/nvme/host/rdma.c
> @@ -241,7 +241,9 @@ static void nvme_rdma_free_ring(struct ib_device *ibdev,
>  
>  static void nvme_rdma_qp_event(struct ib_event *event, void *context)
>  {
> -	pr_debug("QP event %d\n", event->event);
> +	pr_err("QP event %s (%d)\n",
> +	       ib_event_msg(event->event), event->event);
> +
>  }

Why not keep the pr_debug?
