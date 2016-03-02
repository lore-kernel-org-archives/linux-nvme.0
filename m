From: keith.busch@intel.com (Keith Busch)
Date: Wed, 2 Mar 2016 18:27:58 +0000
Subject: [PATCH 3/5] nvme: fix max_segments integer truncation
In-Reply-To: <1456938434-20387-4-git-send-email-hch@lst.de>
References: <1456938434-20387-1-git-send-email-hch@lst.de>
 <1456938434-20387-4-git-send-email-hch@lst.de>
Message-ID: <20160302182758.GB27636@localhost.localdomain>

On Wed, Mar 02, 2016@06:07:12PM +0100, Christoph Hellwig wrote:
> The block layer uses an unsigned short for max_segments.  The way we
> calculate the value for NVMe tends to generate very large 32-bit values,
> which after integer truncation may lead to a zero value instead of
> the desired outcome.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
> Reported-by: Jeff Lien <Jeff.Lien at hgst.com>
> Tested-by: Jeff Lien <Jeff.Lien at hgst.com>

Looks good.

Reviewed-by: Keith Busch <keith.busch at intel.com>
