From: hch@infradead.org (Christoph Hellwig)
Date: Wed, 15 Apr 2015 07:25:35 -0700
Subject: uapi/linux/nvme.h
In-Reply-To: <alpine.LNX.2.00.1504151412380.32385@localhost.lm.intel.com>
References: <20150415061142.GA14354@infradead.org>
 <alpine.LNX.2.00.1504151412380.32385@localhost.lm.intel.com>
Message-ID: <20150415142535.GA29983@infradead.org>

On Wed, Apr 15, 2015@02:22:07PM +0000, Keith Busch wrote:
> I'll stop adding new stuff here if the kernel driver isn't explicitly
> using it, but should we remove everything it's not currently using?

In theory we should never break userspace, but given how relatively
recent NVMe is we might try to get away with it (the rule is you can
break userspace APIs if no one notices..).

If people notice and complain we can set the current defs in stone
under #ifndef __KERNEL__.
