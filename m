From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 25 Jul 2019 11:54:18 -0600
Subject: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
In-Reply-To: <20190725175023.GA30641@bombadil.infradead.org>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-5-logang@deltatee.com>
 <20190725175023.GA30641@bombadil.infradead.org>
Message-ID: <da58f91e-6cfa-02e0-dd89-3cfa23764a0e@deltatee.com>



On 2019-07-25 11:50 a.m., Matthew Wilcox wrote:
> On Thu, Jul 25, 2019@11:23:23AM -0600, Logan Gunthorpe wrote:
>> nvme_get_by_path() is analagous to blkdev_get_by_path() except it
>> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
>>
>> The purpose of this function is to support NVMe-OF target passthru.
> 
> I can't find anywhere that you use this in this patchset.
> 

Oh sorry, the commit message is out of date the function was actually
called nvme_ctrl_get_by_path() and it's used in Patch 10.

I'll fix the commit message for the next version.

Logan
