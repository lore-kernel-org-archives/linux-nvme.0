From: roland@purestorage.com (Roland Dreier)
Date: Tue, 20 Nov 2018 16:21:04 -0800
Subject: [PATCH] drivers/nvme/host/rdma.c: Fix double freeing of async
 event data
In-Reply-To: <1542744673-28129-1-git-send-email-psajeepa@purestorage.com>
References: <1542744673-28129-1-git-send-email-psajeepa@purestorage.com>
Message-ID: <CAL1RGDXrdn1krOyoVMVuRRuuAv8HSNHMusuwq2Evg9fDCGJN8A@mail.gmail.com>

On Tue, Nov 20, 2018 at 12:11 PM Prabhath Sajeepa
<psajeepa@purestorage.com> wrote:

> Some error paths in configuration of admin queue free data buffer
> associated with async request SQE without resetting the data buffer
> pointer to NULL, This buffer is also freed up again if the controller
> is shutdown or reset.

> @@ -823,6 +823,7 @@ static int nvme_rdma_configure_admin_queue(struct nvme_rdma_ctrl *ctrl,
>  out_free_async_qe:
>         nvme_rdma_free_qe(ctrl->device->dev, &ctrl->async_event_sqe,
>                 sizeof(struct nvme_command), DMA_TO_DEVICE);
> +       ctrl->async_event_sqe.data = NULL;
>  out_free_queue:
>         nvme_rdma_free_queue(&ctrl->queues[0]);
>         return error;

Fix looks good to me, although while reviewing this I noticed we have
a related bug too.

In nvme_rdma_alloc_qe() we do:

    qe->data = kzalloc(capsule_size, GFP_KERNEL);
    if (!qe->data)
        return -ENOMEM;

    qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
    if (ib_dma_mapping_error(ibdev, qe->dma)) {
        kfree(qe->data);
        return -ENOMEM;
    }

if the ib_dma_map_single() fails then we'll free qe->data but not NULL
it out.  If this happens for async_event_sqe in
nvme_rdma_configure_admin_queue() then we'll be vulnerable to the same
double free in nvme_rdma_destroy_admin_queue() that this patch is
fixing.

Not sure if that's worth fixing in the same patch here; but I guess we
should NULL out qe->data if the DMA mapping fails in alloc_qe...

 - R.
