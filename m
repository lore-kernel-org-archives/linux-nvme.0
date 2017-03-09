From: hch@lst.de (Christoph Hellwig)
Date: Thu, 9 Mar 2017 18:39:10 +0100
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <20170309174120.GA14329@localhost.localdomain>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
 <20170308213519.GA32009@lst.de> <20170308221527.GA1885@localhost.localdomain>
 <20170308222014.GA635@lst.de> <20170309174120.GA14329@localhost.localdomain>
Message-ID: <20170309173910.GA27503@lst.de>

On Thu, Mar 09, 2017@12:41:20PM -0500, Keith Busch wrote:
> On Wed, Mar 08, 2017@11:20:14PM +0100, Christoph Hellwig wrote:
> > Given that namespace management is tied to controller IDs it's a fairly
> > bad fit for fabrics, especially so with our dynamic controller model.
> 
> Hm, implementation details aside for a second, isn't namespace management
> more useful on fabrics than pci? It's like managing LUNs on a SAN,
> but with spec defined commands.

It would be more useful, but for that it should operate on good
persistent identifier, e.g. Host NQNs.
