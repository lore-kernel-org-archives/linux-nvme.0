From: snitzer@redhat.com (Mike Snitzer)
Date: Mon, 4 Jun 2018 08:31:35 -0400
Subject: [PATCH 5/9] nvme: add ANA support
In-Reply-To: <20180604115103.0c116078@pentland.suse.de>
References: <20180601071128.7630-1-hch@lst.de>
 <20180601071128.7630-6-hch@lst.de>
 <20180604083658.55a9bc10@pentland.suse.de>
 <20180604070357.GA21329@lst.de>
 <20180604115103.0c116078@pentland.suse.de>
Message-ID: <20180604123134.GA6547@redhat.com>

On Mon, Jun 04 2018 at  5:51P -0400,
Hannes Reinecke <hare@suse.de> wrote:

> On Mon, 4 Jun 2018 09:03:57 +0200
> Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Mon, Jun 04, 2018@08:36:58AM +0200, Hannes Reinecke wrote:
> > > This suffers from the 'nvme connect' stall if the first detected
> > > namespace is inaccessible.  
> > 
> > Yes.  This isn't really different from any other NVMe target that
> > constantly returns errors when you connect.
> > 
> > If we want to do this properly we need some block level (e.g. gendisk)
> > state that a given device is ready for I/O.  And then don't scan
> > partition tables if it isn't, and instead do the scan once it becomes
> > life.  In other words: this is something that should be handled
> > mostly at the block level.
> 
> Okay; that was one option I figured out, but didn't want to mess with
> gendisk unless explicitly requested.
> I'll be looking into it.

Pretty sure this will bring about potentially trying discussion with
udev folks.  The same kinds of requirements have been around in lvm for
a while (and by lvm I mean it brokers udev readiness while it is
activating particular dm targets whose sub devices shouldn't be scanned
yet or at all).

Mike
