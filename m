From: keith.busch@intel.com (Keith Busch)
Date: Wed, 7 Dec 2016 12:50:50 -0500
Subject: [PATCH] nvme: support bi-directional commands
In-Reply-To: <20161207173323.GA24967@lst.de>
References: <1481132364-20583-1-git-send-email-keith.busch@intel.com>
 <20161207173323.GA24967@lst.de>
Message-ID: <20161207175049.GD29574@localhost.localdomain>

On Wed, Dec 07, 2016@06:33:23PM +0100, Christoph Hellwig wrote:
> On Wed, Dec 07, 2016@12:39:24PM -0500, Keith Busch wrote:
> > The nvme specification defines the opcode's lower 2 bits as the
> > transfer direction, which allows for bi-directional commands. While
> > there are no standard defined opcodes that use both data directions,
> > this is something a vendor unique opcode may use.
> > 
> > This patch adds support for bi-directional user commands. The block
> > layer doesn't natively support a request with both directions, but we
> > can treat it like a read and set up rq_map_data to force copying the
> > user data to the kernel buffers before the transfer.
> 
> The block layer actually supports bidi commands for SCSI OSD devices
> using two struct requests.  But it's giant mess, and given that no
> NVMe command in the spec requires it I am absoutely 100% against
> supporting this in NVMe.  It's just going to create a mess for everyone
> involved, even worse so for fabrics.
> 
> Just don't do it.

NVMe defines this capability, so why would we want to make it unreachable
in Linux? SG_DXFER_TO_FROM_DEV does bidi commands in one request for
SCSI using the same rq_map_data method this patch proposes to use.
