From: sagi@grimberg.me (Sagi Grimberg)
Date: Tue, 20 Nov 2018 16:30:40 -0800
Subject: [PATCH] drivers/nvme/host/rdma.c: Fix double freeing of async
 event data
In-Reply-To: <CAL1RGDXrdn1krOyoVMVuRRuuAv8HSNHMusuwq2Evg9fDCGJN8A@mail.gmail.com>
References: <1542744673-28129-1-git-send-email-psajeepa@purestorage.com>
 <CAL1RGDXrdn1krOyoVMVuRRuuAv8HSNHMusuwq2Evg9fDCGJN8A@mail.gmail.com>
Message-ID: <47965bbe-ef63-eb54-60e3-b2662ae82e8f@grimberg.me>


> Fix looks good to me, although while reviewing this I noticed we have
> a related bug too.
> 
> In nvme_rdma_alloc_qe() we do:
> 
>      qe->data = kzalloc(capsule_size, GFP_KERNEL);
>      if (!qe->data)
>          return -ENOMEM;
> 
>      qe->dma = ib_dma_map_single(ibdev, qe->data, capsule_size, dir);
>      if (ib_dma_mapping_error(ibdev, qe->dma)) {
>          kfree(qe->data);
>          return -ENOMEM;
>      }
> 
> if the ib_dma_map_single() fails then we'll free qe->data but not NULL
> it out.  If this happens for async_event_sqe in
> nvme_rdma_configure_admin_queue() then we'll be vulnerable to the same
> double free in nvme_rdma_destroy_admin_queue() that this patch is
> fixing.

Fully agree, good catch!

> Not sure if that's worth fixing in the same patch here; but I guess we
> should NULL out qe->data if the DMA mapping fails in alloc_qe...

Probably makes sense to have it in the same patch.
