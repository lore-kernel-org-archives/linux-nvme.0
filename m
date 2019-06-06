From: hch@lst.de (Christoph Hellwig)
Date: Thu, 6 Jun 2019 08:45:37 +0200
Subject: [PATCH 1/1] nvme-rdma: use dynamic dma mapping per command
In-Reply-To: <1559749293-32649-1-git-send-email-maxg@mellanox.com>
References: <1559749293-32649-1-git-send-email-maxg@mellanox.com>
Message-ID: <20190606064537.GE27033@lst.de>

> Fixes: 87fd125344d6 ("nvme-rdma: remove redundant reference between ib_device and tagset")
> Suggested-by: Sagi Grimberg <sagi at grimberg.me>
> Tested-by: Jim Harris <james.r.harris at intel.com>

Shouldn't this also have a reported-by?

> -static void nvme_rdma_free_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
> -		size_t capsule_size, enum dma_data_direction dir)
> +static void nvme_rdma_free_mapped_qe(struct ib_device *ibdev,
> +		struct nvme_rdma_qe *qe, size_t capsule_size,
> +		enum dma_data_direction dir)
>  {
>  	ib_dma_unmap_single(ibdev, qe->dma, capsule_size, dir);
>  	kfree(qe->data);
>  }
>  
> -static int nvme_rdma_alloc_qe(struct ib_device *ibdev, struct nvme_rdma_qe *qe,
> -		size_t capsule_size, enum dma_data_direction dir)
> +static int nvme_rdma_alloc_mapped_qe(struct ib_device *ibdev,
> +		struct nvme_rdma_qe *qe, size_t capsule_size,
> +		enum dma_data_direction dir)

I agree with Sagi that we probably should drop the renames.

Can you write out the explanation somewhere why the AEN SQE doesn't
need this treatment?  Especially as that would actually allow moving
the DMA mapping into nvme_rdma_post_send and clean things up a bit.
