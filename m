From: willy@infradead.org (Matthew Wilcox)
Date: Thu, 25 Jul 2019 10:50:23 -0700
Subject: [PATCH v6 04/16] nvme-core: introduce nvme_get_by_path()
In-Reply-To: <20190725172335.6825-5-logang@deltatee.com>
References: <20190725172335.6825-1-logang@deltatee.com>
 <20190725172335.6825-5-logang@deltatee.com>
Message-ID: <20190725175023.GA30641@bombadil.infradead.org>

On Thu, Jul 25, 2019@11:23:23AM -0600, Logan Gunthorpe wrote:
> nvme_get_by_path() is analagous to blkdev_get_by_path() except it
> gets a struct nvme_ctrl from the path to its char dev (/dev/nvme0).
> 
> The purpose of this function is to support NVMe-OF target passthru.

I can't find anywhere that you use this in this patchset.
