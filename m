From: hch@lst.de (Christoph Hellwig)
Date: Thu, 19 Jul 2018 16:50:05 +0200
Subject: [PATCH 0/4] Rework NVMe abort handling
In-Reply-To: <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
References: <20180719132838.15556-1-jthumshirn@suse.de>
 <20180719134203.GA15212@lst.de>
 <20180719141025.yveza2svhvc2r4lw@linux-x5ow.site>
 <20180719142355.GA18800@lst.de>
 <20180719143534.i36vo45lhz24xbrg@linux-x5ow.site>
Message-ID: <20180719145005.GA21000@lst.de>

On Thu, Jul 19, 2018@04:35:34PM +0200, Johannes Thumshirn wrote:
> > No with the the code following what we have in PCIe that just means
> > we'll eventually controller reset after the I/O command times out
> > the second time as we still won't have seen a completion for it.
> 
> Exactly that was my intention.

Which means the only thing you do for your use case is to delay
recovery even further.

> OK, let me see where I'm stuck here. We're issuing a command, it gets
> lost due to $REASON and I'm aborting it. The upper layers then
> eventually retry the command and it arrives at the target side. But so
> does the old command as well and we have a duplicate. Correct?

The upper layer is only going to retry after tearing down the transport
connection.  And a tear down of the connection MUST clear all pending
commands on the way.  If it doesn't we are in deep, deep trouble.

A NVMe abort has no chance of clearing things at the transport layer.
