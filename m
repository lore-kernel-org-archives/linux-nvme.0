From: swise@opengridcomputing.com (Steve Wise)
Date: Thu, 31 May 2018 12:17:07 -0500
Subject: [PATCH v3 1/3] nvme-rdma: correctly check for target keyed sgl
 support
In-Reply-To: <20180531170201.GB31715@lst.de>
References: <cover.1527618402.git.swise@opengridcomputing.com>
 <fb738c0b251da31747451906630cfd09a5135c7b.1527618402.git.swise@opengridcomputing.com>
 <14063C7AD467DE4B82DEDB5C278E8663B38EE822@FMSMSX108.amr.corp.intel.com>
 <3acbea43-d777-88a5-0059-10275655d545@opengridcomputing.com>
 <8da47cd4-44d5-2229-ef82-26d165dfc245@opengridcomputing.com>
 <c180e592-a11c-de09-d094-3ab569289fab@grimberg.me>
 <20180531170201.GB31715@lst.de>
Message-ID: <ecfee4dc-763b-d331-32e3-802fc07339cc@opengridcomputing.com>



On 5/31/2018 12:02 PM, hch@lst.de wrote:
> On Thu, May 31, 2018@12:37:33AM +0300, Sagi Grimberg wrote:
>>> It looks like these bits are part of the Identify Controller Data
>>> Structure, figure 90 in the 1.2.1 spec.? The SGL Support (SGLS) field
>>> within that struct.?? So I guess it belongs in include/linux/nvme.h?
>>> But I don't see any of this big structure in that header.
>>>
>> Yea, good idea, though please add the offset type sgl as well.
> Honestly, I'd rather keep defines for every little bit without
> a name out of the headers.  The bit numbers will show up right
> there when looking for the field in the nvme spec, while making
> up our own names will just create confusion.
>

Ok then, I will leave them as bit numbers...
