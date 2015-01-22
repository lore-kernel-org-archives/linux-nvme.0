From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 22 Jan 2015 00:45:17 -0800
Subject: [PATCH 1/1] NVMe: Do not take nsid while a passthrough IO
 command is being issued via a block device file descriptor
In-Reply-To: <alpine.LNX.2.00.1501220035170.15481@localhost.lm.intel.com>
References: <1421886503-25276-1-git-send-email-yan@purestorage.com>
 <alpine.LNX.2.00.1501220035170.15481@localhost.lm.intel.com>
Message-ID: <20150122084517.GA2093@infradead.org>

On Thu, Jan 22, 2015@12:47:24AM +0000, Keith Busch wrote:
> The IOCTL's purpose was to let someone submit completely arbitrary
> commands on IO queues. This technically shouldn't even need a namespace
> handle, but we don't have a request_queue associated to IO queues without
> one like the admin queue has. In fact, we ought to fix that so we can
> issue IO commands without namespaces.

Honestly, this sounds like a horrible idea.  As namespaces aren't really
any different from SCSI LUNs they should only be accessible through
the device associated with the namespaces, and admin commands should
only be allowed through the character device (if at all).

For these security and usability reasons we did get rid of the
SG_FLAG_LUN_INHIBIT flag in the SCSI passthrough interface, which
allowed for similar horrible things in the distant past.
