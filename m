From: hch@lst.de (Christoph Hellwig)
Date: Sat, 23 May 2015 15:01:50 +0200
Subject: [PATCH] NVMe: Fix obtaining command result
In-Reply-To: <1432319311-2895-1-git-send-email-keith.busch@intel.com>
References: <1432319311-2895-1-git-send-email-keith.busch@intel.com>
Message-ID: <20150523130150.GA18701@lst.de>

On Fri, May 22, 2015@12:28:31PM -0600, Keith Busch wrote:
> Replaces req->sense_len usage, which is not owned by the LLD, to
> req->special to contain the command result for driver created commands,
> and sets the result unconditionally on completion.

Thanks Keith,

sorry for the mess, after porting this from my series to use replace
the BLOCK_PC specific fields to mainline I only tested this on Qemu
which only has a single queue.  I'll make sure to always do final
testing on real hardware as well.
