From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Aug 2019 09:31:09 +0200
Subject: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported
 result upstream_bridge_distance()
In-Reply-To: <4b0c012a-c3a1-a1c0-b098-8b350963aed1@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-4-logang@deltatee.com> <20190807055455.GA6627@lst.de>
 <4b0c012a-c3a1-a1c0-b098-8b350963aed1@deltatee.com>
Message-ID: <20190808073109.GC29852@lst.de>

On Wed, Aug 07, 2019@09:58:06AM -0600, Logan Gunthorpe wrote:
> We only calculate it at the same time as we calculate the distance. This
> is necessary because, to calculate the type, we have to walk the tree
> and check the ACS bits. If we separated it, we'd have to walk the tree
> twice in a very similar way just to determine both the distance and the
> mapping type.

Calculating it together makes perfect sense.  What I find odd is the
overloading of a single return value.  Why not return the map type as
the return value, and the distance as a by reference argument to keep
them properly separated?
