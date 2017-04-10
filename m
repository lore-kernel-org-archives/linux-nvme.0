From: Bart.VanAssche@sandisk.com (Bart Van Assche)
Date: Mon, 10 Apr 2017 15:27:14 +0000
Subject: [PATCH v2] nvme-rdma: support devices with queue size < 32
In-Reply-To: <20170410151657.GA15173@lst.de>
References: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
 <20170410151657.GA15173@lst.de>
Message-ID: <1491838033.4199.3.camel@sandisk.com>

On Mon, 2017-04-10@17:16 +0200, Christoph Hellwig wrote:
> > +static inline nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
> > +{
> > +       int sig_limit;
> > +
> > +       /* We signal completion every queue depth/2 and also
> > +        * handle the case of possible device with queue_depth=1,
> > +        * where we would need to signal every message.
> > +        */
> > +       sig_limit = max(queue->queue_size / 2, 1);
> > +       return (++queue->sig_count % sig_limit) == 0;
> > +}
> 
> I would love if we could do this at the ib_qp level.

Hello Christoph,

Please keep in mind that some but not all RDMA drivers need a construct like
this.

Bart.
