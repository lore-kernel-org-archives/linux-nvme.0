From: jgunthorpe@obsidianresearch.com (Jason Gunthorpe)
Date: Tue, 18 Apr 2017 13:01:38 -0600
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <cce00131-1f28-27b3-40ab-04f8783f1e5a@deltatee.com>
Message-ID: <20170418190138.GH7181@obsidianresearch.com>

On Tue, Apr 18, 2017@12:30:59PM -0600, Logan Gunthorpe wrote:

> >  - The dma ops provider must be able to tell if source memory is bar
> >    mapped and recover the pci device backing the mapping.
> 
> Do you mean to say that every dma-ops provider needs to be taught about
> p2p backed pages? I was hoping we could have dma_map_* just use special
> p2p dma-ops if it was passed p2p pages (though there are some
> complications to this too).

I think that is how it will end up working out if this is the path..

Ultimately every dma_ops will need special code to support P2P with
the special hardware that ops is controlling, so it makes some sense
to start by pushing the check down there in the first place. This
advice is partially motivated by how dma_map_sg is just a small
wrapper around the function pointer call...

Something like:

foo_dma_map_sg(...)
{
  for (every page in sg)
      if (page is p2p)
           dma_addr[I] = p2p_same_segment_map_page(...);
}

Where p2p_same_segment_map_page checks if the two devices are on the
'same switch' and if so returns the address translated to match the
bus address programmed into the BAR or fails. We knows this case is
required to work by the PCI spec, so it makes sense to use it as the
first canned helper.

This also proves out the basic idea that the dma ops can recover the
pci device and perform an inspection of the traversed fabric path.

>From there every arch would have to expand the implementation to
support a wider range of things. Eg x86 with no iommu and no offset
could allow every address to be used based on a host bridge white
list.

Jason
