From: keith.busch@intel.com (Keith Busch)
Date: Wed, 6 Sep 2017 16:13:02 -0400
Subject: [PATCH 2/4] nvme-pci: use appropriate initial chunk size for HMB
 allocation
In-Reply-To: <20170906135532.21358-3-hch@lst.de>
References: <20170906135532.21358-1-hch@lst.de>
 <20170906135532.21358-3-hch@lst.de>
Message-ID: <20170906201301.GG17331@localhost.localdomain>

On Wed, Sep 06, 2017@03:55:30PM +0200, Christoph Hellwig wrote:
> From: Akinobu Mita <akinobu.mita at gmail.com>
> 
> The initial chunk size for host memory buffer allocation is currently
> PAGE_SIZE << MAX_ORDER.  MAX_ORDER order allocation is usually failed
> without CONFIG_DMA_CMA.  So the HMB allocation is retried with chunk size
> PAGE_SIZE << (MAX_ORDER - 1) in general, but there is no problem if the
> retry allocation works correctly.
> 
> Signed-off-by: Akinobu Mita <akinobu.mita at gmail.com>
> [hch: rebased]
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Cc: stable at vger.kernel.org
> ---

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
