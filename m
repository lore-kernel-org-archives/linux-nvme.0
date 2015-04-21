From: willy@linux.intel.com (Matthew Wilcox)
Date: Tue, 21 Apr 2015 15:51:42 -0400
Subject: RFC: struct request cleanups
In-Reply-To: <1429303042-12078-1-git-send-email-hch@lst.de>
References: <1429303042-12078-1-git-send-email-hch@lst.de>
Message-ID: <20150421195142.GX4003@linux.intel.com>

On Fri, Apr 17, 2015@10:37:15PM +0200, Christoph Hellwig wrote:
> The real RFC is the last one which allocates the block_pc specific
> data separately in the callers instead of bloating every struct
> request with it.  I always hated what we did, but with the upcoming
> split of nvme into transports and command sets we'll need a NVME
> equivalent of BLOCK_PC, and as NVMe was designed by crackmonkeys
> dreaming of an ATA controller the "command block" for NVME is even
> bigger than what we have to deal with in SCSI.

Umm, the NVMe command was never supposed to be "transported".  The
crackmonkeys are the ones who are trying to ship it across the network
instead of designing a proper network protocol.
