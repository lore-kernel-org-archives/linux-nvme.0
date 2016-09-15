From: krisman@linux.vnet.ibm.com (Gabriel Krisman Bertazi)
Date: Thu, 15 Sep 2016 11:00:26 -0300
Subject: nvmf/rdma host crash during heavy load and keep alive recovery
In-Reply-To: <022701d20d31$a9645850$fc2d08f0$@opengridcomputing.com> (Steve
 Wise's message of "Mon, 12 Sep 2016 15:10:09 -0500")
References: <018301d1e9e1$da3b2e40$8eb18ac0$@opengridcomputing.com>
 <010f01d1f31e$50c8cb40$f25a61c0$@opengridcomputing.com>
 <013701d1f320$57b185d0$07149170$@opengridcomputing.com>
 <018401d1f32b$792cfdb0$6b86f910$@opengridcomputing.com>
 <01a301d1f339$55ba8e70$012fab50$@opengridcomputing.com>
 <2fb1129c-424d-8b2d-7101-b9471e897dc8@grimberg.me>
 <004701d1f3d8$760660b0$62132210$@opengridcomputing.com>
 <008101d1f3de$557d2850$007778f0$@opengridcomputing.com>
 <00fe01d1f3e8$8992b330$9cb81990$@opengridcomputing.com>
 <01c301d1f702$d28c7270$77a55750$@opengridcomputing.com>
 <6ef9b0d1-ce84-4598-74db-7adeed313bb6@grimberg.me>
 <045601d1f803$a9d73a20$fd85ae60$@opengridcomputing.com>
 <69c0e819-76d9-286b-c4fb-22f087f36ff1@grimberg.me>
 <08b701d1f8ba$a709ae10$f51d0a30$@opengridcomputing.com>
 <01c301d20485$0dfcd2c0$29f67840$@opengridcomputing.com>
 <039401d2094c$084d64e0$18e82ea0$@opengridcomputing.com>
 <021401d20a16$ed60d470$c8227d50$@opengridcomputing.com>
 <021501d20a19$327ba5b0$9772f110$@opengridcomputing.com>
 <00ab01d20ab1$ed212ff0$c7638fd0$@opengridcomputing.com>
 <022701d20d31$a9645850$fc2d08f0$@opengridcomputing.com>
Message-ID: <8760px4611.fsf@linux.vnet.ibm.com>

"Steve Wise" <swise at opengridcomputing.com> writes:


> @@ -622,6 +625,7 @@ static void nvme_rdma_stop_and_free_queue(struct
> nvme_rdma_queue *queue)
>  {
>         if (test_and_set_bit(NVME_RDMA_Q_DELETING, &queue->flags))
>                 return;
> +       BUG_ON(!test_bit(BLK_MQ_S_STOPPED, &queue->hctx->state));
>         nvme_rdma_stop_queue(queue);
>         nvme_rdma_free_queue(queue);
>  }
> @@ -1408,6 +1412,8 @@ static int nvme_rdma_queue_rq(struct blk_mq_hw_ctx *hctx,
>
>         WARN_ON_ONCE(rq->tag < 0);
>
> +       BUG_ON(hctx != queue->hctx);
> +       BUG_ON(test_bit(BLK_MQ_S_STOPPED, &hctx->state));
>         dev = queue->device->dev;
>         ib_dma_sync_single_for_cpu(dev, sqe->dma,
>                         sizeof(struct nvme_command), DMA_TO_DEVICE);
>

This reminds me of the discussion I had with Jens a few weeks ago here:

http://lists.infradead.org/pipermail/linux-nvme/2016-August/005916.html

The BUG_ON I hit is similar to yours, but for nvme over PCI.  I think
the update queues code will reach a similar path of remapping, but I
didnt go out and check yet.

Can you check you are running with the patch he mentioned at:

http://lists.infradead.org/pipermail/linux-nvme/2016-August/005962.html

Thanks,

-- 
Gabriel Krisman Bertazi
