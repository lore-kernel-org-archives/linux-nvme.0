From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 11 Feb 2016 07:18:59 -0800
Subject: [PATCH for-4.5 13/13] NVMe: Rate limit nvme IO warnings
In-Reply-To: <20160211151245.GD11908@localhost.localdomain>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-14-git-send-email-keith.busch@intel.com>
 <20160210185404.GB10459@infradead.org>
 <20160210211025.GC23402@localhost.localdomain>
 <56BC7EC7.6020208@dev.mellanox.co.il>
 <20160211151245.GD11908@localhost.localdomain>
Message-ID: <20160211151859.GA3072@infradead.org>

On Thu, Feb 11, 2016@03:12:45PM +0000, Keith Busch wrote:
> On Thu, Feb 11, 2016@02:29:59PM +0200, Sagi Grimberg wrote:
> > 
> > >>Do we need this message at all?
> > >
> > >I don't find it useful for anything other than confirming a test hit
> > >that path. Delete it?
> > 
> > Perhaps we can have it dev_dbg.
> 
> Thanks, sounds like the right compromise to me.

Fine with me.
