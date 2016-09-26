From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 26 Sep 2016 08:02:52 -0700
Subject: [PATCH 1/3] nvme-fabrics: patch target code in prep for FC
 transport support
In-Reply-To: <57e93218.4CgczdRxtAdq+zwV%james.smart@broadcom.com>
References: <57e93218.4CgczdRxtAdq+zwV%james.smart@broadcom.com>
Message-ID: <20160926150251.GB9220@infradead.org>

On Mon, Sep 26, 2016@07:35:04AM -0700, James Smart wrote:
> 
> Patch nvme-fabrics target code in prep for FC transport support:
> - Add FC transport type decoding
> - Add FC address family decoding
> 
> (Patch unchanged from prior posting)
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>
> Acked-by: Johannes Thumshirn <jth at kernel.org>
> Reviewed-by: Christoph Hellwig <hch at lst.de>

Looks sensible, we'll queue this up once the rest of the FC support
is ready.
