From: benh@au1.ibm.com (Benjamin Herrenschmidt)
Date: Fri, 02 Mar 2018 08:03:30 +1100
Subject: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
Message-ID: <1519938210.4592.30.camel@au1.ibm.com>

On Thu, 2018-03-01@11:21 -0800, Dan Williams wrote:
> 
> 
> The devm_memremap_pages() infrastructure allows placing the memmap in
> "System-RAM" even if the hotplugged range is in PCI space. So, even if
> it is an issue on some configurations, it's just a simple adjustment
> to where the memmap is placed.

Actually can you explain a bit more here ?

devm_memremap_pages() doesn't take any specific argument about what to
do with the memory.

It does create the vmemmap sections etc... but does so by calling
arch_add_memory(). So __add_memory() isn't called, which means the
pages aren't added to the linear mapping. Then you manually add them to
ZONE_DEVICE.

Am I correct ?

In that case, they indeed can't be used as normal memory pages, which
is good, and if they are indeed not in the linear mapping, then there
is no caching issues.

However, what happens if anything calls page_address() on them ? Some
DMA ops do that for example, or some devices might ...

This is all quite convoluted with no documentation I can find that
explains the various expectations.

So the question is are those pages landing in the linear mapping, and
if yes, by what code path ?

The next question is if we ever want that to work on ppc64, we need a
way to make this fit in our linear mapping and map it non-cachable,
which will require some wrangling on how we handle that mapping.

Cheers,
Ben.
