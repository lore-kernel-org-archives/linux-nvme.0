From: hch@lst.de (Christoph Hellwig)
Date: Tue, 5 Jun 2018 14:51:14 +0200
Subject: [PATCH] nvme: do not block connect call on inaccessible devices
In-Reply-To: <20180605142318.7d566c27@pentland.suse.de>
References: <20180605082905.1740-1-hare@suse.de>
 <20180605111746.GA5802@lst.de> <20180605142318.7d566c27@pentland.suse.de>
Message-ID: <20180605125114.GC13305@lst.de>

On Tue, Jun 05, 2018@02:23:18PM +0200, Hannes Reinecke wrote:
> > > This patch inhibits partition scan if no working paths are found,
> > > and retriggers the partition scan once the device becomes active.  
> > 
> > And what updates the state once all your inaccessible or change
> > state groups become optimized?
> > 
> ANA AENs?

Not in your patch.

> Someone told me we should rely on ANA AENS or the system is hosed
> anyway :-)

Yes, of course.  But AENs aren;t going to help you if you don't
take any action upon them.
