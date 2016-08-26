From: hch@lst.de (Christoph Hellwig)
Date: Fri, 26 Aug 2016 16:39:52 +0200
Subject: [PATCH WIP/RFC 4/6] nvme-rdma: destroy nvme queue rdma
 resources on connect failure
In-Reply-To: <9f6479110ae58e72e78e37855aff3f8edb8a61e9.1472219586.git.swise@opengridcomputing.com>
References: <cover.1472219585.git.swise@opengridcomputing.com>
 <9f6479110ae58e72e78e37855aff3f8edb8a61e9.1472219586.git.swise@opengridcomputing.com>
Message-ID: <20160826143952.GB21869@lst.de>

On Fri, Aug 26, 2016@06:50:58AM -0700, Steve Wise wrote:
> After address resolution, the nvme_rdma_queue rdma resources are
> allocated.  If rdma route resolution or the connect fails, or the
> controller reconnect times out and gives up, then the rdma resources
> need to be freed.  Otherwise, rdma resources are leaked.

I'm pretty sure Sagi tried to convince me we'd need something like this
begfore and I tried to resists.  Sorry guys..

>  struct nvme_rdma_queue {
> @@ -488,6 +489,7 @@ static void nvme_rdma_destroy_queue_ib(struct nvme_rdma_queue *queue)
>  	struct nvme_rdma_device *dev = queue->device;
>  	struct ib_device *ibdev = dev->dev;
>  
> +	clear_bit(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags);

How about doing a

	if (!test_and_clear(NVME_RDMA_IB_QUEUE_ALLOCATED, &queue->flags))
		return;

here so the the callers don't have to worry?

Otherwise this looks fine to me.
