From: keith.busch@intel.com (Keith Busch)
Date: Mon, 28 Jan 2019 08:33:45 -0700
Subject: [PATCH] nvme: Block ns inventory changes during admin
In-Reply-To: <20190128073924.GB3287@lst.de>
References: <20190125194819.11476-1-keith.busch@intel.com>
 <20190128073924.GB3287@lst.de>
Message-ID: <20190128153344.GA15271@localhost.localdomain>

On Sun, Jan 27, 2019@11:39:24PM -0800, Christoph Hellwig wrote:
> On Fri, Jan 25, 2019@12:48:19PM -0700, Keith Busch wrote:
> > The driver quiesces IO when the admin command effects say it may alter
> > namespaces.
> > 
> > A device that supports nvme namespace management may trigger a namespace
> > scan automatically. If this changes the namespace inventory by adding
> > more namespace, the driver's unquiesce sequence at the end of sending
> > the admin command may try to unfreeze a queue that isn't frozen,
> > breaking the freeze depth for future use.
> > 
> > Fix that by preventing scan work from altering the namespace list while
> > we are pairing freeze and unfreeze operations.
> 
> Do you have a reference for the bug report?

This was reported internally from Wen. If you prefer, we can open a
public bz sighting and append the kernel logs for a changelog Link:.
