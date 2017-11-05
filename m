From: sagi@grimberg.me (Sagi Grimberg)
Date: Sun, 5 Nov 2017 16:00:38 +0200
Subject: [PATCH v2 1/1] nvme-rdma: Introduce nvme_rdma_destroy_qp
In-Reply-To: <1509804987-656-1-git-send-email-maxg@mellanox.com>
References: <1509804987-656-1-git-send-email-maxg@mellanox.com>
Message-ID: <99ae0d5e-5ccf-a4f2-4e1c-d6e1f0e10016@grimberg.me>


> +static void nvme_rdma_destroy_qp(struct nvme_rdma_queue *queue)
> +{
> +	rdma_destroy_qp(queue->cm_id);
> +	queue->qp = NULL;

Why is setting the qp to NULL needed here?

I'd rather not do this if we don't have a good reason reason for it.
