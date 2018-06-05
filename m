From: hare@suse.de (Hannes Reinecke)
Date: Tue, 5 Jun 2018 14:23:18 +0200
Subject: [PATCH] nvme: do not block connect call on inaccessible devices
In-Reply-To: <20180605111746.GA5802@lst.de>
References: <20180605082905.1740-1-hare@suse.de> <20180605111746.GA5802@lst.de>
Message-ID: <20180605142318.7d566c27@pentland.suse.de>

On Tue, 5 Jun 2018 13:17:46 +0200
Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Jun 05, 2018@10:29:05AM +0200, Hannes Reinecke wrote:
> > When a device is in ANA inaccessible state the call to 'nvme
> > connect' will hang as a parition scan is triggered and the I/O will
> > be requeued indefinitely.
> > Or rather, requeued until the next path is connected, but we cannot
> > issue any nvme ioctls anymore as the nvmf_dev_mutex is blocked by
> > the initial 'connect' call.
> > 
> > This patch inhibits partition scan if no working paths are found,
> > and retriggers the partition scan once the device becomes active.  
> 
> And what updates the state once all your inaccessible or change
> state groups become optimized?
> 
ANA AENs?
Someone told me we should rely on ANA AENS or the system is hosed
anyway :-)

My idea was to hook into the 'revalidate_disk' call here, but then this
approach turned out to be easier.

> Also I see no point registering the disk if we can't do I/O to it.
> 
> I'd rather prefer something along the lines of the completely untested
> patch below if we really want to go down this route:
> 
Okay, I'll give it a go.

Cheers,

Hannes
