From: hch@lst.de (Christoph Hellwig)
Date: Mon, 1 Aug 2016 17:50:54 +0200
Subject: [PATCH v3] nvmet-rdma: Correctly handle RDMA device hot removal
In-Reply-To: <307087d1-88af-5244-38e8-5b9786285488@grimberg.me>
References: <1469967347-20466-1-git-send-email-sagi@grimberg.me>
 <20160801111530.GB16474@lst.de>
 <307087d1-88af-5244-38e8-5b9786285488@grimberg.me>
Message-ID: <20160801155054.GD22771@lst.de>

On Mon, Aug 01, 2016@02:30:37PM +0300, Sagi Grimberg wrote:
>> How is ->remove_port synchronized vs the RDMA/CM even handler?
>
> Easy, it isn't :)
>
> So we have three choices here:
> 1. Add a lock in nvmet_port that only rdma will use for now (don't like
> it)
> or
> 2. Add nvmet_rdma_port as nvmet_port->priv with a lock (don't like it)
> or
> 3. take the global nvmet_config_sem (hate it)
>
> Any preferences?

(4) use cmpxchg?
