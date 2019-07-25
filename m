From: kbusch@kernel.org (Keith Busch)
Date: Thu, 25 Jul 2019 13:58:35 -0600
Subject: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
In-Reply-To: <da58f91e-6cfa-02e0-dd89-3cfa23764a0e@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-5-logang@deltatee.com>
 <20190725175023.GA30641@bombadil.infradead.org>
 <da58f91e-6cfa-02e0-dd89-3cfa23764a0e@deltatee.com>
Message-ID: <20190725195835.GA7317@localhost.localdomain>

On Thu, Jul 25, 2019@11:54:18AM -0600, Logan Gunthorpe wrote:
> 
> 
> On 2019-07-25 11:50 a.m., Matthew Wilcox wrote:
> > On Thu, Jul 25, 2019@11:23:23AM -0600, Logan Gunthorpe wrote:
> >> nvme_get_by_path() is analagous to blkdev_get_by_path() except it
> >> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
> >>
> >> The purpose of this function is to support NVMe-OF target passthru.
> > 
> > I can't find anywhere that you use this in this patchset.
> > 
> 
> Oh sorry, the commit message is out of date the function was actually
> called nvme_ctrl_get_by_path() and it's used in Patch 10.

Instead of by path, could we have configfs take something else, like
the unique controller instance or serial number? I know that's different
than how we handle blocks and files, but that way nvme core can lookup
the cooresponding controller without adding new cdev dependencies.
