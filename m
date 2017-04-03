From: dan.j.williams@intel.com (Dan Williams)
Date: Mon, 3 Apr 2017 15:47:09 -0700
Subject: [RFC 5/8] scatterlist: Modify SG copy functions to support io
 memory.
In-Reply-To: <ff0dd5ec-2562-9f1d-1335-d0a8813f2f50@deltatee.com>
References: <1490911959-5146-1-git-send-email-logang@deltatee.com>
 <1490911959-5146-6-git-send-email-logang@deltatee.com>
 <20170331070950.GA9059@infradead.org>
 <435d4471-436b-87e6-8827-c9fc6cbdde2c@deltatee.com>
 <445bc352-75d7-438f-96ef-c2411215628d@deltatee.com>
 <CAPcyv4g=MHbjbY0GFPoLq3wAGwhcC7813O7iLUWGEChWh0M7Dw@mail.gmail.com>
 <ff0dd5ec-2562-9f1d-1335-d0a8813f2f50@deltatee.com>
Message-ID: <CAPcyv4gx4g3Ry_A99yTodqwm2vH72oMSLKAKF7iEsmG5G4TcbQ@mail.gmail.com>

On Mon, Apr 3, 2017@3:10 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>
>
> On 03/04/17 03:44 PM, Dan Williams wrote:
>> On Mon, Apr 3, 2017@2:20 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>> Hi Christoph,
>>>
>>> What are your thoughts on an approach like the following untested
>>> draft patch.
>>>
>>> The patch (if fleshed out) makes it so iomem can be used in an sgl
>>> and WARN_ONs will occur in places where drivers attempt to access
>>> iomem directly through the sgl.
>>>
>>> I'd also probably create a p2pmem_alloc_sgl helper function so driver
>>> writers wouldn't have to mess with sg_set_iomem_page.
>>>
>>> With all that in place, it should be relatively safe for drivers to
>>> implement p2pmem even though we'd still technically be violating the
>>> __iomem boundary in some places.
>>
>> Just reacting to this mail, I still haven't had a chance to take a
>> look at the rest of the series.
>>
>> The pfn_t type was invented to carry extra type and page lookup
>> information about the memory behind a given pfn. At first glance that
>> seems a more natural place to carry an indication that this is an
>> "I/O" pfn.
>
> I agree... But what are the plans for pfn_t? Is anyone working on using
> it in the scatterlist code? Currently it's not there yet and given the
> assertion that we will continue to be using struct page for DMA is that
> a direction we'd want to go?
>

I wouldn't necessarily conflate supporting pfn_t in the scatterlist
with the stalled stuct-page-less DMA effor. A pfn_t_to_page()
conversion will still work and be required. However you're right, the
minute we use pfn_t for this we're into the realm of special case
drivers that understand scatterlists with special "I/O-pfn_t" entries.
However, maybe that's what we want? I think peer-to-peer DMA is not a
general purpose feature unless/until we get it standardized in PCI. So
maybe drivers with special case scatterlist support is exactly what we
want for now.

Thoughts?
