From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 18 Jan 2017 17:14:36 +0200
Subject: [LSF/MM TOPIC][LSF/MM ATTEND] NAPI polling for block drivers
In-Reply-To: <20170118145816.GI3514@linux-x5ow.site>
References: <20170111134312.GH6286@linux-x5ow.site>
 <cc00cc1f-17d7-105e-ef2c-61791b7cc676@kernel.dk>
 <d60d4499-6ed8-0a69-edbf-db205a6dba6a@kernel.dk>
 <8b47ca34-d2ff-26dc-721e-2cb1e18f1efc@grimberg.me>
 <499af528-7810-f82d-1f11-cbf8f3a5b21c@grimberg.me>
 <53a3fb6c-c75a-519a-f669-2bcab404e01d@grimberg.me>
 <20170117162752.GE6067@linux-x5ow.site>
 <6df6bf6a-7cd3-1700-2b0a-e140325ebf47@grimberg.me>
 <20170118135156.GG3514@linux-x5ow.site>
 <e3438024-e0f2-db96-5122-4508863be603@grimberg.me>
 <20170118145816.GI3514@linux-x5ow.site>
Message-ID: <c7eabe1c-5dcd-9859-2b41-9683f68a0534@grimberg.me>


> Hannes just spotted this:
> static int nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
>                          const struct blk_mq_queue_data *bd)
> {
> [...]
>         __nvme_submit_cmd(nvmeq, &cmnd);
>         nvme_process_cq(nvmeq);
>         spin_unlock_irq(&nvmeq->q_lock);
>         return BLK_MQ_RQ_QUEUE_OK;
> out_cleanup_iod:
>         nvme_free_iod(dev, req);
> out_free_cmd:
>         nvme_cleanup_cmd(req);
>         return ret;
> }
>
> So we're draining the CQ on submit. This of cause makes polling for
> completions in the IRQ handler rather pointless as we already did in the
> submission path.

I think you missed:
http://git.infradead.org/nvme.git/commit/49c91e3e09dc3c9dd1718df85112a8cce3ab7007
