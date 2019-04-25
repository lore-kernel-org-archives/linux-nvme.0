From: minwoo.im@samsung.com (Minwoo Im)
Date: Thu, 25 Apr 2019 15:51:16 +0900
Subject: [PATCH 4/4] nvme-tcp: rename function to have nvme_tcp prefix
In-Reply-To: <20190424185319.18942-5-sagi@grimberg.me>
References: <20190424185319.18942-5-sagi@grimberg.me>
 <20190424185319.18942-1-sagi@grimberg.me>
 <CGME20190424185359epcas4p1408cfaf1978df3ab0b156d1658902b78@epcms2p3>
Message-ID: <20190425065116epcms2p3af9e81e73904c4405fbb01ad6d053560@epcms2p3>

It looks good to me.

Reviewed-by: Minwoo Im <minwoo.im at samsung.com>

> -----Original Message-----
> From: Linux-nvme [mailto:linux-nvme-bounces at lists.infradead.org] On Behalf
> Of Sagi Grimberg
> Sent: Thursday, April 25, 2019 3:53 AM
> To: Christoph Hellwig; Keith Busch
> Cc: linux-nvme at lists.infradead.org
> Subject: [PATCH 4/4] nvme-tcp: rename function to have nvme_tcp prefix
> 
> usually nvme_ prefix is for core functions.
> While we're cleaning up, remove redundant empty lines
> 
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---
>  drivers/nvme/host/tcp.c | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
> index 7201fbeb4a8f..1a5217c85158 100644
> --- a/drivers/nvme/host/tcp.c
> +++ b/drivers/nvme/host/tcp.c
> @@ -476,7 +476,6 @@ static int nvme_tcp_handle_c2h_data(struct
> nvme_tcp_queue *queue,
>  	}
> 
>  	return 0;
> -
>  }
> 
>  static int nvme_tcp_handle_comp(struct nvme_tcp_queue *queue,
> @@ -637,7 +636,6 @@ static inline void nvme_tcp_end_request(struct request
> *rq, u16 status)
>  	nvme_end_request(rq, cpu_to_le16(status << 1), res);
>  }
> 
> -
>  static int nvme_tcp_recv_data(struct nvme_tcp_queue *queue, struct
> sk_buff *skb,
>  			      unsigned int *offset, size_t *len)
>  {
> @@ -1543,7 +1541,7 @@ static int nvme_tcp_alloc_admin_queue(struct
> nvme_ctrl *ctrl)
>  	return ret;
>  }
> 
> -static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
> +static int __nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>  {
>  	int i, ret;
> 
> @@ -1574,7 +1572,7 @@ static unsigned int nvme_tcp_nr_io_queues(struct
> nvme_ctrl *ctrl)
>  	return nr_io_queues;
>  }
> 
> -static int nvme_alloc_io_queues(struct nvme_ctrl *ctrl)
> +static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
>  {
>  	unsigned int nr_io_queues;
>  	int ret;
> @@ -1591,7 +1589,7 @@ static int nvme_alloc_io_queues(struct nvme_ctrl
> *ctrl)
>  	dev_info(ctrl->device,
>  		"creating %d I/O queues.\n", nr_io_queues);
> 
> -	return nvme_tcp_alloc_io_queues(ctrl);
> +	return __nvme_tcp_alloc_io_queues(ctrl);
>  }
> 
>  static void nvme_tcp_destroy_io_queues(struct nvme_ctrl *ctrl, bool
> remove)
> @@ -1608,7 +1606,7 @@ static int nvme_tcp_configure_io_queues(struct
> nvme_ctrl *ctrl, bool new)
>  {
>  	int ret;
> 
> -	ret = nvme_alloc_io_queues(ctrl);
> +	ret = nvme_tcp_alloc_io_queues(ctrl);
>  	if (ret)
>  		return ret;
> 
> --
> 2.17.1
> 
> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme at lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
