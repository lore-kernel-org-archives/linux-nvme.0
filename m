From: dan.j.williams@intel.com (Dan Williams)
Date: Tue, 18 Apr 2017 15:52:08 -0700
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <1492555569.25766.99.camel@kernel.crashing.org>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <1492381396.25766.43.camel@kernel.crashing.org>
 <20170418164557.GA7181@obsidianresearch.com>
 <CAPcyv4izLa2vw12ysvVfd=ysaMKcASNFm+=CaqDKhnPY9B5OJg@mail.gmail.com>
 <1492555569.25766.99.camel@kernel.crashing.org>
Message-ID: <CAPcyv4itqGu+YekHcJ+_kyDSDch43yRSqK8NnGUh2DYYMd=F1Q@mail.gmail.com>

On Tue, Apr 18, 2017 at 3:46 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Tue, 2017-04-18@10:27 -0700, Dan Williams wrote:
>> > FWIW, RDMA probably wouldn't want to use a p2mem device either, we
>> > already have APIs that map BAR memory to user space, and would like to
>> > keep using them. A 'enable P2P for bar' helper function sounds better
>> > to me.
>>
>> ...and I think it's not a helper function as much as asking the bus
>> provider "can these two device dma to each other". The "helper" is the
>> dma api redirecting through a software-iommu that handles bus address
>> translation differently than it would handle host memory dma mapping.
>
> Do we even need tat function ? The dma_ops have a dma_supported()
> call...
>
> If we have those override ops built into the "dma_target" object,
> then these things can make that decision knowing both the source
> and target device.
>

Yes.
