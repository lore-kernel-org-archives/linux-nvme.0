From: keith.busch@intel.com (Keith Busch)
Date: Wed, 10 Jan 2018 14:59:25 -0700
Subject: Bug report - drivers/nvme/host/pci.c?
In-Reply-To: <20180108094951.GB4673@lst.de>
References: <4dcd8c76-872e-69e3-3cbd-d051bdf0bf62@huawei.com>
 <BY2PR04MB2101903E77826A0479550572861E0@BY2PR04MB2101.namprd04.prod.outlook.com>
 <20180103200140.GA11172@localhost.localdomain>
 <20180103201131.GB11172@localhost.localdomain>
 <20180108094951.GB4673@lst.de>
Message-ID: <20180110215925.GJ15154@localhost.localdomain>

On Mon, Jan 08, 2018@10:49:51AM +0100, hch@lst.de wrote:
> Anyway, moving the decision to after dma_map makes sense.  What do you
> think of the untested patch below?  I also (so far very crudely)
> enforces we only use SGLs if they fit into the same allocation as the
> equivalent PRPs, so that we don't need to check use_sgl at allocation
> time:

Thanks, this looks pretty good. I'm not going to be able to test this
till next week, though. Would be good to hear if someone else with a
capable device can can verify this is successful.
