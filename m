From: scott.bauer@intel.com (Scott Bauer)
Date: Thu, 16 Feb 2017 13:47:07 -0700
Subject: [PATCH 2/2] block/sed-opal: allocate struct opal_dev dynamically
In-Reply-To: <20170216201053.1190-2-hch@lst.de>
References: <20170216201053.1190-1-hch@lst.de>
 <20170216201053.1190-2-hch@lst.de>
Message-ID: <20170216204707.GB3732@sbauer-Z170X-UD5>

On Thu, Feb 16, 2017@09:10:53PM +0100, Christoph Hellwig wrote:
> Insted of bloating the containing structure with it all the time this
> allocates struct opal_dev dynamically.  Additionally this allows moving
> the definition of struct opal_dev into sed-opal.c.  For this a new
> private data field is added to it that is passed to the send/receive
> callback.  After that a lot of internals can be made private as well.
> 
> Signed-off-by: Christoph Hellwig <hch at lst.de>
Don't know if we need both but:

Tested-by: Scott Bauer <scott.bauer at intel.com>
Reviewed-by: Scott Bauer <scott.bauer at intel.com>
