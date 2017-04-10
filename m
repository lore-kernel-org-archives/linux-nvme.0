From: hch@lst.de (Christoph Hellwig)
Date: Mon, 10 Apr 2017 17:16:57 +0200
Subject: [PATCH v2] nvme-rdma: support devices with queue size < 32
In-Reply-To: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
References: <1519881025.363156294.1491837154312.JavaMail.zimbra@kalray.eu>
Message-ID: <20170410151657.GA15173@lst.de>

> +static inline nvme_rdma_queue_sig_limit(struct nvme_rdma_queue *queue)
> +{
> +       int sig_limit;
> +
> +       /* We signal completion every queue depth/2 and also
> +        * handle the case of possible device with queue_depth=1,
> +        * where we would need to signal every message.
> +        */
> +       sig_limit = max(queue->queue_size / 2, 1);
> +       return (++queue->sig_count % sig_limit) == 0;
> +}

I would love if we could do this at the ib_qp level.  I also know
you found a real bug and we want it fixed ASAP, so maybe for now
we should merge this one:

Reviewed-by: Christoph Hellwig <hch at lst.de>

and then do the generic version.  Marta, do you want to tackle the
generic version or should I look into this once I get a little time.
