From: hch@lst.de (Christoph Hellwig)
Date: Tue, 15 May 2018 09:50:55 +0200
Subject: [PATCH 3/5] nvme: call nvmf_create_ctrl before checking for
 duplicate assignment
In-Reply-To: <20180515074043.22843-4-jthumshirn@suse.de>
References: <20180515074043.22843-1-jthumshirn@suse.de>
 <20180515074043.22843-4-jthumshirn@suse.de>
Message-ID: <20180515075055.GB23659@lst.de>

On Tue, May 15, 2018@09:40:41AM +0200, Johannes Thumshirn wrote:
> In nvmf_dev_write we did check if the /dev/nvme-fabrics device node's
> private data is already set and then create a controller data
> structure afterwards. The private data is protected by the
> nvmf_dev_mutex, but there is no need to hold it while calling
> nvmf_create_ctrl().
> 
> This also reduces the number of lockdep complaints in the 'nvme
> connect' with fcloop scenario.

Something looks seriously fishy in fcloop.  How do we and up in
a RCU critical section here?

In general it seems like fc loop needs to offload any I/O to a workqueue
just like nvme-loop does, but even then I can't see how that is going to
cause an issue in this area.
