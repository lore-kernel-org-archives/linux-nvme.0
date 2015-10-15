From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Oct 2015 19:34:16 +0000 (UTC)
Subject: [PATCH] NVMe: Fix memory leak on retried commands
In-Reply-To: <1444774416-12648-1-git-send-email-keith.busch@intel.com>
References: <1444774416-12648-1-git-send-email-keith.busch@intel.com>
Message-ID: <alpine.LNX.2.00.1510151904520.27742@localhost.lm.intel.com>

On Tue, 13 Oct 2015, Keith Busch wrote:
> Resources are reallocated for requeued commands, so unmap and release
> the iod for the failed command.

Hi Jens,

Since you're applying changes for 4.3, can you add this one? It's a
pretty bad memory leak and causes a kernel hang if you remove a drive
because of a busy dma pool. You'll get messages spewing like this:

   nvme 0000:xx:xx.x: dma_pool_destroy prp list 256, ffff880420dec000 busy

and lock up pci and the driver since removal never completes while
holding a lock.

I think this should go into stable back to 4.0. I'm not entirely sure how
to do that. Will the Cc on the original achieve that when this is merged?
