From: Victor.Gladkov@taec.toshiba.com (Victor Gladkov)
Date: Mon, 31 Jul 2017 09:06:32 +0000
Subject: [PATCH] nvme-rdma: "nvme disconnect" stuck after remove a target
In-Reply-To: <8daffba0-3276-39cc-27a8-9b2dbe13805c@grimberg.me>
References: <77FF42D3D537D24484F0BF5E2458C0C08507BCF3@EXMAIL1.taec.toshiba.com>
 <8daffba0-3276-39cc-27a8-9b2dbe13805c@grimberg.me>
Message-ID: <77FF42D3D537D24484F0BF5E2458C0C08507BD41@EXMAIL1.taec.toshiba.com>

> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c index
> > 3d25add..44316bc 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -1637,7 +1637,7 @@ static void nvme_rdma_shutdown_ctrl(struct
> nvme_rdma_ctrl *ctrl)
> >                  nvme_rdma_free_io_queues(ctrl);
> >          }
> >
> > -       if (test_bit(NVME_RDMA_Q_CONNECTED, &ctrl->queues[0].flags))
> > +       if (test_bit(NVME_RDMA_Q_LIVE, &ctrl->queues[0].flags))
> >                  nvme_shutdown_ctrl(&ctrl->ctrl);
> >
> >          blk_mq_stop_hw_queues(ctrl->ctrl.admin_q);
> 
> I think you are not testing upstream code which already contain this change
> from:
> 
> commit b282a88d910296facf89fd1088832f9b41fa00c5
> Author: Sagi Grimberg <sagi at grimberg.me>
> Date:   Thu May 4 13:33:11 2017 +0300
> 
>      nvme-rdma: Get rid of CONNECTED state
> 
>      We only care about if the queue is LIVE for request submission,
>      so no need for CONNECTED.
> 
>      Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
>      Signed-off-by: Christoph Hellwig <hch at lst.de>
> 

You are right. Now I see. Thank you for cooperation.
