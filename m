From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Oct 2017 09:14:05 +0200
Subject: [PATCH 13/17] nvme: track subsystems
In-Reply-To: <20171018223913.GA1846@localhost.localdomain>
References: <20171018165258.23212-1-hch@lst.de>
 <20171018165258.23212-14-hch@lst.de>
 <20171018223913.GA1846@localhost.localdomain>
Message-ID: <20171019071405.GA11980@lst.de>

> I'm having some trouble with this one. The device_initialize() initializes
> the kobj's reference counter, and then the device_add() takes another
> reference on it.
> 
> The teardown, though, only calls put_device(). Where's the call to
> device_del() supposed to go that ultimately drops the last reference
> to call the .release 'nvme_free_subsystem'?

Yes, this is buggy.  I took the code from Hannes patches without
retesting a module unload.  I'll go back to the drawing board.
