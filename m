From: hch@lst.de (Christoph Hellwig)
Date: Fri, 17 Aug 2018 10:09:56 +0200
Subject: [PATCH 2/6] nvme-vendor: fixup c99 declaration in huawei plugin
In-Reply-To: <20180817072908.56784-3-hare@suse.de>
References: <20180817072908.56784-1-hare@suse.de>
 <20180817072908.56784-3-hare@suse.de>
Message-ID: <20180817080956.GB13230@lst.de>

On Fri, Aug 17, 2018@09:29:04AM +0200, Hannes Reinecke wrote:
> We can't use c99 declaration with older compilers.
> 
> Signed-off-by: Hannes Reinecke <hare at suse.com>

Not that I particularly like this feature, but do we really support
that old compilers?

Reviewed-by: Christoph Hellwig <hch at lst.de>
