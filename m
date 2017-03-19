From: leon@kernel.org (Leon Romanovsky)
Date: Sun, 19 Mar 2017 09:01:15 +0200
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <31678a43-f76c-a921-e40c-470b0de1a86c@grimberg.me>
References: <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <95e045a8-ace0-6a9a-b9a9-555cb2670572@grimberg.me>
 <d21c5571-78fd-7882-b4cc-c24f76f6ff47@redhat.com>
 <20170310165214.GC14379@mtr-leonro.local>
 <56e8ccd3-8116-89a1-2f65-eb61a91c5f84@mellanox.com>
 <860db62d-ae93-d94c-e5fb-88e7b643f737@redhat.com>
 <0a825b18-df06-9a6d-38c9-402f4ee121f7@mellanox.com>
 <7496c68a-15f3-d8cb-b17f-20f5a59a24d2@redhat.com>
 <31678a43-f76c-a921-e40c-470b0de1a86c@grimberg.me>
Message-ID: <20170319070115.GP2079@mtr-leonro.local>

On Thu, Mar 16, 2017@06:51:16PM +0200, Sagi Grimberg wrote:
>
> > > > > > Sagi,
> > > > > > The release function is placed in global workqueue. I'm not familiar
> > > > > > with NVMe design and I don't know all the details, but maybe the
> > > > > > proper way will
> > > > > > be to create special workqueue with MEM_RECLAIM flag to ensure the
> > > > > > progress?
>
> Leon, the release work makes progress, but it is inherently slower
> than the establishment work and when we are bombarded with
> establishments we have no backpressure...

Sagi,
How do you see that release is slower than alloc? In this specific
test, all queues are empty and QP drains should finish immediately.

If we rely on the prints that Yi posted in the beginning of this thread,
the release function doesn't have enough priority for execution and
constantly delayed.

>
> > I tried with 4.11.0-rc2, and still can reproduced it with less than 2000
> > times.
>
> Yi,
>
> Can you try the below (untested) patch:
>
> I'm not at all convinced this is the way to go because it will
> slow down all the connect requests, but I'm curious to know
> if it'll make the issue go away.
>
> --
> diff --git a/drivers/nvme/target/rdma.c b/drivers/nvme/target/rdma.c
> index ecc4fe862561..f15fa6e6b640 100644
> --- a/drivers/nvme/target/rdma.c
> +++ b/drivers/nvme/target/rdma.c
> @@ -1199,6 +1199,9 @@ static int nvmet_rdma_queue_connect(struct rdma_cm_id
> *cm_id,
>         }
>         queue->port = cm_id->context;
>
> +       /* Let inflight queue teardown complete */
> +       flush_scheduled_work();
> +
>         ret = nvmet_rdma_cm_accept(cm_id, queue, &event->param.conn);
>         if (ret)
>                 goto release_queue;
> --
>
> Any other good ideas are welcome...

Maybe create separate workqueue and flush its only, instead of global
system queue.

It will stress the system a little bit less.

Thanks

> --
> To unsubscribe from this list: send the line "unsubscribe linux-rdma" in
> the body of a message to majordomo at vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170319/fa1181fa/attachment-0001.sig>
