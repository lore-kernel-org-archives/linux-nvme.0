From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 17:37:58 -0700
Subject: [PATCH v2 02/10] PCI/P2PDMA: Add sysfs group to display p2pmem
 stats
In-Reply-To: <CAPcyv4hj5XJrsKHxZEWTSdrDAv0k7tf1ptb7_2FpTGpxqY5jUQ@mail.gmail.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-3-logang@deltatee.com>
 <20180301174450.GF13722@bhelgaas-glaptop.roam.corp.google.com>
 <d69d59c0-6182-cce7-7ba4-8552ba95bef5@deltatee.com>
 <CAPcyv4hj5XJrsKHxZEWTSdrDAv0k7tf1ptb7_2FpTGpxqY5jUQ@mail.gmail.com>
Message-ID: <c97fb967-966d-4a8e-91ab-e3f216ebdd97@deltatee.com>



On 01/03/18 05:36 PM, Dan Williams wrote:
> On Thu, Mar 1, 2018@4:15 PM, Logan Gunthorpe <logang@deltatee.com> wrote:
>>
>>
>> On 01/03/18 10:44 AM, Bjorn Helgaas wrote:
>>>
>>> I think these two statements are out of order, since the attributes
>>> dereference pdev->p2pdma.  And it looks like you set "error"
>>> unnecessarily, since you return immediately looking at it.
>>
>>
>> Per the previous series, sysfs_create_group is must_check for some reason. I
>> had a printk there but you didn't think it was necessary. So assigning it to
>> error is the only way to squash the warning.
> 
> Why not fail the setup if the sysfs_create_group() fails? Sure, it may
> not be strictly required for userspace to have access to these
> attributes, but it seems hostile that userspace can't make assumptions
> about the presence of the "p2pmem" directory relative to the
> capability being setup.

Works for me. I'll do that.

Thanks,

Logan
