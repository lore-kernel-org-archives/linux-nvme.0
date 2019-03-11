From: hch@lst.de (Christoph Hellwig)
Date: Mon, 11 Mar 2019 19:31:45 +0100
Subject: [PATCH 6/8] nvme/pci: Remove q_dmadev from nvme_queue
In-Reply-To: <20190308174313.5134-6-keith.busch@intel.com>
References: <20190308174313.5134-1-keith.busch@intel.com>
 <20190308174313.5134-6-keith.busch@intel.com>
Message-ID: <20190311183145.GF11448@lst.de>

On Fri, Mar 08, 2019@10:43:11AM -0700, Keith Busch wrote:
> We don't need to save the dma device as it's not used in the hot path
> and hasn't in a long time. Shrink the struct nvme_queue removing this
> unnecessary member.

Looks good,

Reviewed-by: Christoph Hellwig <hch at lst.de>
