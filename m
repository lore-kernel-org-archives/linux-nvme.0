From: keith.busch@intel.com (Keith Busch)
Date: Wed, 15 Apr 2015 14:22:07 +0000 (UTC)
Subject: uapi/linux/nvme.h
In-Reply-To: <20150415061142.GA14354@infradead.org>
References: <20150415061142.GA14354@infradead.org>
Message-ID: <alpine.LNX.2.00.1504151412380.32385@localhost.lm.intel.com>

On Tue, 14 Apr 2015, Christoph Hellwig wrote:
> The NVME UAPI header contains a lot more than just the controller
> definitions - it's basically the whole NVME command set.
>
> Any reason for this?  IT's very unlike what we do for ATA and SCSI, and
> fairly dangerous as we now need to make all changes to the command set
> headers in a way that wouldn't break userspace software.

Yep, this was to provide user space all the nvme definitions, but tools
often redefine their own nvme commands and structures, and use the uapi
header only for the ioctls.

I'll stop adding new stuff here if the kernel driver isn't explicitly
using it, but should we remove everything it's not currently using?
