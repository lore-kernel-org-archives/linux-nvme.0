From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 20 Sep 2017 14:33:07 -0700
Subject: [PATCH] nvmet_fc: sync header templates with comments
In-Reply-To: <20170920180726.31764-1-jsmart2021@gmail.com>
References: <20170920180726.31764-1-jsmart2021@gmail.com>
Message-ID: <20170920213307.GF10442@infradead.org>

On Wed, Sep 20, 2017@11:07:26AM -0700, James Smart wrote:
> Comments were incorrect:
> - defer_rcv was in host port template. moved to target port template
> - Added Mandatory statements for target port template items
> 
> Signed-off-by: James Smart <james.smart at broadcom.com>

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
