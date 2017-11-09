From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Nov 2017 13:53:56 +0100
Subject: [PATCH 1/5] nvme: track subsystems
In-Reply-To: <fbacd62b-4228-60cb-a382-9c88daadb336@grimberg.me>
References: <20171102183034.9320-1-hch@lst.de>
 <20171102183034.9320-2-hch@lst.de>
 <fbacd62b-4228-60cb-a382-9c88daadb336@grimberg.me>
Message-ID: <20171109125356.GB21795@lst.de>

On Thu, Nov 09, 2017@01:33:16PM +0200, Sagi Grimberg wrote:
> Any reason to do all this before we know if we found an existing subsystem? 

We'd either have to do all the initialization including the memory
allocation and ida_simple_get under nvme_subsystems_lock, or search
the list first, then allocate, then search again.

Given that the not found case is vastly more common than the found
case that doesn't seem to be worth the tradeoff.

> Also can the enumeration become with "holes" because you
> acquire a subsystem ida temporarily and free it (and another subsystem
> just came in)? Not a big issue though...

It can, just like it can for the discovery controller in fabrics.
but so far that hasn't been an issue.
