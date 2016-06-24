From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 24 Jun 2016 01:11:28 -0700
Subject: [PATCH 0/3] nvme: Don't add namespaces for locked drives
In-Reply-To: <20160620152639.GD12936@localhost.localdomain>
References: <20160619230634.17229-1-kernel@jbeekman.nl>
 <20160620152639.GD12936@localhost.localdomain>
Message-ID: <20160624081128.GD17446@infradead.org>

On Mon, Jun 20, 2016@11:26:39AM -0400, Keith Busch wrote:
> This is ATA security, though, so wouldn't ATA also benefit from this? The
> payload setup/decoding should then go in a generic library for everyone.

In principiple sharing this code would be fine, but right now the
actual ATA specific code is totally trivial.  Maybe we can have the
line of checking the actual data that we get from the ATA-specific
security send into a inline helper, but otherwise the to be shared bits
are mostly constants.

> Similar was said about the patch adding OPAL security to the NVMe driver:
> 
>   http://lists.infradead.org/pipermail/linux-nvme/2016-April/004428.html

OPAL is a lot more complex than checking this locked bit..
