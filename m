From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 15:21:57 +0100
Subject: [PATCH 06/15] nvme-pci: remove nvme_init_iod
In-Reply-To: <SN6PR04MB45279F1612542CB815A5E3DA865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
References: <20190321231037.25104-1-hch@lst.de>
 <20190321231037.25104-7-hch@lst.de>
 <SN6PR04MB45279F1612542CB815A5E3DA865E0@SN6PR04MB4527.namprd04.prod.outlook.com>
Message-ID: <20190327142157.GD26200@lst.de>

On Mon, Mar 25, 2019@05:19:34AM +0000, Chaitanya Kulkarni wrote:
> > @@ -913,9 +902,14 @@ static blk_status_t nvme_queue_rq(struct blk_mq_hw_ctx *hctx,
> >   	struct nvme_queue *nvmeq = hctx->driver_data;
> >   	struct nvme_dev *dev = nvmeq->dev;
> >   	struct request *req = bd->rq;
> > +	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
> >   	struct nvme_command cmnd;
> >   	blk_status_t ret;
> >   
> > +	iod->aborted = 0;
> > +	iod->npages = -1;
> > +	iod->nents = 0;
> > +
> Maybe add an inline helper for above default IOD initialization ?

Why?  It is a few lines of code and we only ever do it here.
