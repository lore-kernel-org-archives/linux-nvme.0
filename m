From: keith.busch@intel.com (Keith Busch)
Date: Thu, 9 Mar 2017 12:41:20 -0500
Subject: [RFC PATCH] nvmet: Back namespace with files
In-Reply-To: <20170308222014.GA635@lst.de>
References: <1489008937-31043-1-git-send-email-keith.busch@intel.com>
 <20170308213519.GA32009@lst.de>
 <20170308221527.GA1885@localhost.localdomain>
 <20170308222014.GA635@lst.de>
Message-ID: <20170309174120.GA14329@localhost.localdomain>

On Wed, Mar 08, 2017@11:20:14PM +0100, Christoph Hellwig wrote:
> Given that namespace management is tied to controller IDs it's a fairly
> bad fit for fabrics, especially so with our dynamic controller model.

Hm, implementation details aside for a second, isn't namespace management
more useful on fabrics than pci? It's like managing LUNs on a SAN,
but with spec defined commands.
