From: hch@lst.de (Christoph Hellwig)
Date: Wed, 27 Mar 2019 09:31:42 +0100
Subject: [PATCH 5/5] nvme/pci: Remove queue IO flushing hack
In-Reply-To: <20190311193753.GE10411@localhost.localdomain>
References: <20190308174006.5032-1-keith.busch@intel.com>
 <20190308174006.5032-5-keith.busch@intel.com> <20190311184031.GA11707@lst.de>
 <20190311193753.GE10411@localhost.localdomain>
Message-ID: <20190327083142.GQ20525@lst.de>

On Mon, Mar 11, 2019@01:37:53PM -0600, Keith Busch wrote:
> > The only thing not purely block layer here is the enabled flag.
> > So if we had a per-hctx enabled flag we could lift this out of nvme,
> > and hopefully start reusing it in other drivers.
> 
> Okay, I may even be able to drop the new block exports if we do request
> termination in generic block layer. That's probably the right thing
> anyway since that layer is in a better position to check the necessary
> conditions that make tag iteration safe. Bart did point out that is
> generally not safe for drives to do, so it'd be good to safegaurd against
> incorrect usage.

Did you get a chance to look into this?
