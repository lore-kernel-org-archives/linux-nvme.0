From: hch@lst.de (Christoph Hellwig)
Date: Tue, 22 Mar 2016 08:31:47 +0100
Subject: [PATCH v2 2/4] block: add offset in blk_add_request_payload()
In-Reply-To: <1458631486-14120-3-git-send-email-mlin@kernel.org>
References: <1458631486-14120-1-git-send-email-mlin@kernel.org>
 <1458631486-14120-3-git-send-email-mlin@kernel.org>
Message-ID: <20160322073147.GB23271@lst.de>

On Tue, Mar 22, 2016@12:24:44AM -0700, Ming Lin wrote:
> From: Ming Lin <ming.l at ssi.samsung.com>
> 
> We could kmalloc() the payload, so need the offset in page.
> 
> Signed-off-by: Ming Lin <ming.l at ssi.samsung.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
