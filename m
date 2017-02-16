From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 16 Feb 2017 13:43:36 -0700
Subject: [PATCH 1/2] block/sed-opal: tone down not supported warnings
In-Reply-To: <20170216201053.1190-1-hch@lst.de>
References: <20170216201053.1190-1-hch@lst.de>
Message-ID: <20170216204335.GA3732@sbauer-Z170X-UD5>

On Thu, Feb 16, 2017@09:10:52PM +0100, Christoph Hellwig wrote:
> Not having OPAL or a sub-feature supported is an entirely normal
> condition for many drives, so don't warn about it.  Keep the messages,
> but tone them down to debug only.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
Reviewed-by: Scott Bauer <scott.bauer at intel.com>
