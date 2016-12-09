From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 9 Dec 2016 10:32:09 -0800
Subject: [PATCH] nvme/pci: Delete misleading queue-wrap comment
In-Reply-To: <1481303338-25134-1-git-send-email-keith.busch@intel.com>
References: <1481303338-25134-1-git-send-email-keith.busch@intel.com>
Message-ID: <20161209183209.GA8964@infradead.org>

On Fri, Dec 09, 2016@12:08:58PM -0500, Keith Busch wrote:
> It is not theoretically possible for this driver to wrap twice while
> processing completions. The driver allocates only 'queue_depth - 1'
> tags, so there can never be more than that to reap when processing a
> completion queue. Removing this misleading comment makes it a little
> less likely people with broken controllers will blame the driver for
> their spurious interrupts.

heh :)

Looks fine,

Reviewed-by: Christoph Hellwig <hch at lst.de>
