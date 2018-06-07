From: hch@lst.de (Christoph Hellwig)
Date: Thu, 7 Jun 2018 16:22:58 +0200
Subject: [PATCH 4/4] nvme: start ANATT timer on out-of-order state changes
In-Reply-To: <20180607160152.15809a29@pentland.suse.de>
References: <20180607073556.39050-1-hare@suse.de>
 <20180607073556.39050-5-hare@suse.de> <20180607121135.GD11938@lst.de>
 <20180607143750.16ddff8f@pentland.suse.de> <20180607131026.GA13273@lst.de>
 <20180607152036.275b0966@pentland.suse.de> <20180607134612.GA15587@lst.de>
 <20180607160152.15809a29@pentland.suse.de>
Message-ID: <20180607142258.GA6082@lst.de>

On Thu, Jun 07, 2018@04:01:52PM +0200, Hannes Reinecke wrote:
> There is no guarantee that we will get the AEN.
> Yes, the spec says we should, but it's just a single message which
> might easily be lost if the corresponding frame is dropped.
> Think of FC, which supposedly is a lossless fabric, yet a sizeable
> piece of the spec deals with recovery from lost frames.
> It _will_ happen.

NVMe requires a reliable transport.  The Fabrics spec very explicitly
states that, and PCIe provides the gurantees as well.

If we lose random admin command replies we have much, much deeper
problems.  E.g. if we lose the AEN reply we would never get any other
AEN ever because we are not going to resubmit the command.
