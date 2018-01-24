From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 24 Jan 2018 08:29:34 +0200
Subject: [PATCH] nvme/pci: Fix queue double allocations
In-Reply-To: <20180123161619.31372-1-keith.busch@intel.com>
References: <20180123161619.31372-1-keith.busch@intel.com>
Message-ID: <4fe008a5-7786-999f-1fcb-5d36fb6c050a@grimberg.me>


> The queue count says the highest queue that's been allocated, so don't
> reallocate a queue lower than that.
> 
> Fixes: 147b27e4bd0 ("nvme-pci: allocate device queues storage space at probe")
> Signed-off-by: Keith Busch <keith.busch at intel.com>

Reviewed-by: Sagi Grimberg <sagi at grimberg.me>

I wish we wouldn't have to rely on nvme_alloc_queue for this though..
