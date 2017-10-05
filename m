From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 5 Oct 2017 01:01:39 -0700
Subject: [PATCH v2 5/7] nvme_fc: check connectivity before initiating
 reconnects
In-Reply-To: <20170927045046.22238-6-jsmart2021@gmail.com>
References: <20170927045046.22238-1-jsmart2021@gmail.com>
 <20170927045046.22238-6-jsmart2021@gmail.com>
Message-ID: <20171005080139.GC5063@infradead.org>

> +nvme_fc_rport_is_online(struct nvme_fc_rport *rport)
> +{
> +	unsigned long flags;
> +	bool online;
> +
> +	spin_lock_irqsave(&rport->lock, flags);
> +	online = (rport->remoteport.port_state == FC_OBJSTATE_ONLINE);
> +	spin_unlock_irqrestore(&rport->lock, flags);
> +
> +	return online;

There is no need to take a lock for reading a value <= the native
register size ever.

So just open code the check at the callsites, and with that the
patch looks fine to me.
