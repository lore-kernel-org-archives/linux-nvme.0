From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Jan 2019 09:07:13 -0700
Subject: [PATCH] nvme: Block ns inventory changes during admin
In-Reply-To: <20190128155834.GA11346@lst.de>
References: <20190125194819.11476-1-keith.busch@intel.com>
 <20190128073924.GB3287@lst.de>
 <20190128153344.GA15271@localhost.localdomain>
 <20190128155834.GA11346@lst.de>
Message-ID: <20190128160712.GA15302@localhost.localdomain>

On Mon, Jan 28, 2019@04:58:34PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 28, 2019@08:33:45AM -0700, Keith Busch wrote:
> > This was reported internally from Wen. If you prefer, we can open a
> > public bz sighting and append the kernel logs for a changelog Link:.
> 
> I don't really need a bugzilla, but I'd like to understand the reported
> problem a little better.

Sure thing. The reporter is attaching namespaces in a loop. The controller
does support the NS Change Notification, so that automatically triggers
the namespace scan_work.

Occasionally the namespace scan_work appends the new namespace to the
list before the admin command effects handling is completed. The effects
handling attempts to unfreeze the namespace, but if it unfreezes the
new one, that request_queue freeze depth will be off and we'll hit the
warning in blk_mq_unfreeze_queue().

On the next namespace add, we fail to freeze that queue due to the
previous bad accounting and deadlock waiting for frozen.
