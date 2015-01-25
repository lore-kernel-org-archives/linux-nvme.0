From: hch@infradead.org (Christoph Hellwig)
Date: Sun, 25 Jan 2015 06:41:46 -0800
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO
 command is being issued via a block device file descriptor
In-Reply-To: <alpine.LNX.2.00.1501231737070.15481@localhost.lm.intel.com>
References: <1421971328-5065-1-git-send-email-yan@purestorage.com>
 <20150123075708.GA17232@infradead.org>
 <alpine.LNX.2.00.1501231451380.15481@localhost.lm.intel.com>
 <20150123172745.GA28005@infradead.org>
 <alpine.LNX.2.00.1501231737070.15481@localhost.lm.intel.com>
Message-ID: <20150125144146.GA23199@infradead.org>

On Fri, Jan 23, 2015@05:50:33PM +0000, Keith Busch wrote:
> No argument against removing the hidden attribute handling, but there
> are unadvertised NSID's that have special meaning. Like NSID 0xffffffff
> means to apply a command to all namespaces. Vendor specific commands
> may have other special NSID meanings as well.

What is the practical use of those?  Just because something is
theoretically possible we don't really need to support it.

(and yes, it's a really bad design - I wish the NVME designers had spent a
little more time with existing designs instead of applying the full NIH
mantra)
