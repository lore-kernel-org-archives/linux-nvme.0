From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Wed, 19 Apr 2017 09:55:57 -0600
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <1492564806.25766.124.camel@kernel.crashing.org>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
 <20170418190138.GH7181@obsidianresearch.com>
 <df1351d8-b86c-2e21-1948-4688ece5dc2b@deltatee.com>
 <CAPcyv4gScx6A7vG9VEHpNF41GOy1Nxst7QQ3QC3uZ54bWoxbMg@mail.gmail.com>
 <20170418210339.GA24257@obsidianresearch.com>
 <1492564806.25766.124.camel@kernel.crashing.org>
Message-ID: <20170419155557.GA8497@obsidianresearch.com>

On Wed, Apr 19, 2017@11:20:06AM +1000, Benjamin Herrenschmidt wrote:

> That helper wouldn't perform the actual iommu mapping. It would simply
> return something along the lines of:
> 
>  - "use that alternate bus address and don't map in the iommu"

I was thinking only this one would be supported with a core code
helper..

>  - "use that alternate bus address and do map in the iommu"
>  - "proceed as normal"

.. because I don't have an idea how a core code helper could figure
out what the platform needs for the above two ..

I think many of the iommu platforms will need to construct their own
bus address in the iommu, and we already have easy access to the CPU
address.

Presumably once a transcation passes through the iommu it needs to be
using the CPU address for the target bar, otherwise things are going
to be ambiguous..

Jason
