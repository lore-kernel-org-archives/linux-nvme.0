From: hch@lst.de (Christoph Hellwig)
Date: Mon, 28 Jan 2019 17:30:00 +0100
Subject: [PATCH] nvme: Block ns inventory changes during admin
In-Reply-To: <20190128160712.GA15302@localhost.localdomain>
References: <20190125194819.11476-1-keith.busch@intel.com>
 <20190128073924.GB3287@lst.de> <20190128153344.GA15271@localhost.localdomain>
 <20190128155834.GA11346@lst.de>
 <20190128160712.GA15302@localhost.localdomain>
Message-ID: <20190128163000.GA12288@lst.de>

On Mon, Jan 28, 2019@09:07:13AM -0700, Keith Busch wrote:
> Sure thing. The reporter is attaching namespaces in a loop. The controller
> does support the NS Change Notification, so that automatically triggers
> the namespace scan_work.
> 
> Occasionally the namespace scan_work appends the new namespace to the
> list before the admin command effects handling is completed. The effects
> handling attempts to unfreeze the namespace, but if it unfreezes the
> new one, that request_queue freeze depth will be off and we'll hit the
> warning in blk_mq_unfreeze_queue().
> 
> On the next namespace add, we fail to freeze that queue due to the
> previous bad accounting and deadlock waiting for frozen.

Ok, makes sense.  Can you fold this into the patch description?
