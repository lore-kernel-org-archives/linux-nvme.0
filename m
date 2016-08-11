From: james_p_freyensee@linux.intel.com (J Freyensee)
Date: Thu, 11 Aug 2016 09:35:29 -0700
Subject: [PATCH RFC 2/4] nvme-rdma: fix sqsize/hsqsize/hrqsize per spec
In-Reply-To: <d3c8c94e-1ad1-afd1-5efc-fc7889f61bf2@grimberg.me>
References: <1470888438-823-1-git-send-email-james_p_freyensee@linux.intel.com>
 <1470888438-823-3-git-send-email-james_p_freyensee@linux.intel.com>
 <d3c8c94e-1ad1-afd1-5efc-fc7889f61bf2@grimberg.me>
Message-ID: <1470933329.2796.3.camel@linux.intel.com>

On Thu, 2016-08-11@10:03 +0300, Sagi Grimberg wrote:
> 
> On 11/08/16 07:07, Jay Freyensee wrote:
> > 
> > Per NVMe-over-Fabrics 1.0 spec, sqsize is represented as
> > a 0-based value.
> > 
> > Also per spec, the RDMA binding values shall be set
> > to sqsize, which makes hsqsize 0-based values.
> > 
> > Also per spec, but not very clear, is hrqsize is +1
> > of hsqsize.
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
> > ?drivers/nvme/host/rdma.c | 19 ++++++++++++++++---
> > ?1 file changed, 16 insertions(+), 3 deletions(-)
> > 
> > diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
> > index 3e3ce2b..8be64f1 100644
> > --- a/drivers/nvme/host/rdma.c
> > +++ b/drivers/nvme/host/rdma.c
> > @@ -1284,8 +1284,21 @@ static int nvme_rdma_route_resolved(struct
> > nvme_rdma_queue *queue)
> > 
> > ?	priv.recfmt = cpu_to_le16(NVME_RDMA_CM_FMT_1_0);
> > ?	priv.qid = cpu_to_le16(nvme_rdma_queue_idx(queue));
> > -	priv.hrqsize = cpu_to_le16(queue->queue_size);
> > -	priv.hsqsize = cpu_to_le16(queue->queue_size);
> > +
> > +	/*
> > +	?* On one end, the fabrics spec is pretty clear that
> > +	?* hsqsize variables shall be set to the value of sqsize,
> > +	?* which is a 0-based number. What is confusing is the
> > value for
> > +	?* hrqsize.??After clarification from NVMe spec committee
> > member,
> > +	?* the minimum value of hrqsize is hsqsize+1.
> > +	?*/
> > +	if (priv.qid == 0) {
> > +		priv.hsqsize = cpu_to_le16(queue->ctrl-
> > >ctrl.admin_sqsize);
> > +		priv.hrqsize = cpu_to_le16(queue->ctrl-
> > >ctrl.admin_sqsize+1);
> > +	} else {
> > +		priv.hsqsize = cpu_to_le16(queue->ctrl-
> > >ctrl.sqsize);
> > +		priv.hrqsize = cpu_to_le16(queue->ctrl-
> > >ctrl.sqsize+1);
> > +	}
> 
> Huh? (scratch...) using priv.hrqsize = priv.hsqsize+1 is pointless.

It may be pointless, but Dave said that is the current interpretation
of the NVMe-over-Fabrics spec (which I don't really understand either).

> 
> We expose to the block layer X and we send to the target X-1 and
> the target does X+1 (looks goofy, but ok). We also size our RDMA
> send/recv according to X so why on earth would we want to tell the
> target we have a recv queue of size X+1

Could be the reason I see kato timeouts then kernel crashing...
