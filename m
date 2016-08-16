From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Tue, 16 Aug 2016 09:20:30 -0700
Subject: [PATCH v2 2/5] nvme-rdma: fix sqsize/hsqsize per spec
In-Reply-To: <b367c7dc-1c6f-b3d5-9492-2acbd8dad0da@grimberg.me>
References: <1471279659-25951-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1471279659-25951-3-git-send-email-james_p_freyensee@linux.intel.com>
 <b367c7dc-1c6f-b3d5-9492-2acbd8dad0da@grimberg.me>
Message-ID: <1471364430.21107.5.camel@linux.intel.com>

On Tue, 2016-08-16@11:57 +0300, Sagi Grimberg wrote:
> 
> On 15/08/16 19:47, Jay Freyensee wrote:
> > 
> > Per NVMe-over-Fabrics 1.0 spec, sqsize is represented as
> > a 0-based value.
> > 
> > Also per spec, the RDMA binding values shall be set
> > to sqsize, which makes hsqsize 0-based values.
> > 
> > Thus, the sqsize during NVMf connect() is now:
> > 
> > [root at fedora23-fabrics-host1 for-48]# dmesg
> > [??318.720645] nvme_fabrics: nvmf_connect_admin_queue(): sqsize for
> > admin queue: 31
> > [??318.720884] nvme nvme0: creating 16 I/O queues.
> > [??318.810114] nvme_fabrics: nvmf_connect_io_queue(): sqsize for
> > i/o
> > queue: 127
> > 
> > Reported-by: Daniel Verkamp <daniel.verkamp at intel.com>
> > Signed-off-by: Jay Freyensee <james_p_freyensee at linux.intel.com>
> > ---
> > ?drivers/nvme/host/rdma.c | 10 +++++-----
> > ?1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index 168cd23..6aa913e 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -649,7 +649,7 @@ static int nvme_rdma_init_io_queues(struct
> > nvme_rdma_ctrl *ctrl)
> > ?	int i, ret;
> > 
> > ?	for (i = 1; i < ctrl->queue_count; i++) {
> > -		ret = nvme_rdma_init_queue(ctrl, i, ctrl-
> > >ctrl.sqsize);
> > +		ret = nvme_rdma_init_queue(ctrl, i, ctrl-
> > >ctrl.sqsize + 1);
> 
> Just use opts->queue_size here.

OK, no problem.

> 
> > 
> > ?		if (ret) {
> > ?			dev_info(ctrl->ctrl.device,
> > ?				"failed to initialize i/o queue:
> > %d\n", ret);
> > @@ -1292,8 +1292,8 @@ static int nvme_rdma_route_resolved(struct
> > nvme_rdma_queue *queue)
> > ?		priv.hrqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
> > ?		priv.hsqsize = cpu_to_le16(NVMF_AQ_DEPTH - 1);
> > ?	} else {
> > -		priv.hrqsize = cpu_to_le16(queue->queue_size);
> > -		priv.hsqsize = cpu_to_le16(queue->queue_size);
> > +		priv.hrqsize = cpu_to_le16(queue->ctrl-
> > >ctrl.sqsize);
> > +		priv.hsqsize = cpu_to_le16(queue->ctrl-
> > >ctrl.sqsize);
> > ?	}
> > 
> > ?	ret = rdma_connect(queue->cm_id, &param);
> > @@ -1818,7 +1818,7 @@ static int nvme_rdma_create_io_queues(struct
> > nvme_rdma_ctrl *ctrl)
> > 
> > ?	memset(&ctrl->tag_set, 0, sizeof(ctrl->tag_set));
> > ?	ctrl->tag_set.ops = &nvme_rdma_mq_ops;
> > -	ctrl->tag_set.queue_depth = ctrl->ctrl.sqsize;
> > +	ctrl->tag_set.queue_depth = ctrl->ctrl.sqsize + 1;
> 
> Same here.

Dido.

Thanks,
J
