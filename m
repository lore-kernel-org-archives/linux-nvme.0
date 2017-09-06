From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Sep 2017 16:12:35 -0400
Subject: [PATCH 1/4] nvme-pci: fix host memory buffer allocation fallback
In-Reply-To: <20170906135532.21358-2-hch@lst.de>
References: <20170906135532.21358-1-hch@lst.de>
 <20170906135532.21358-2-hch@lst.de>
Message-ID: <20170906201235.GF17331@localhost.localdomain>

On Wed, Sep 06, 2017@03:55:29PM +0200, Christoph Hellwig wrote:
> nvme_alloc_host_mem currently contains two loops that are interwinded,
> and the outer retry loop turns out to be broken.  Fix this by untangling
> the two.
> 
> Based on a report an initial patch from Akinobu Mita.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reported-by: Akinobu Mita <akinobu.mita at gmail.com>
> Tested-by: Akinobu Mita <akinobu.mita at gmail.com>
> Cc: stable at vger.kernel.org
> ---

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
