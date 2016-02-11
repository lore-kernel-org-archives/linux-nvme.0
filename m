From: keith.busch@intel.com (Keith Busch)
Date: Thu, 11 Feb 2016 15:12:45 +0000
Subject: [PATCH for-4.5 13/13] NVMe: Rate limit nvme IO warnings
In-Reply-To: <56BC7EC7.6020208@dev.mellanox.co.il>
References: <1455128250-5984-1-git-send-email-keith.busch@intel.com>
 <1455128250-5984-14-git-send-email-keith.busch@intel.com>
 <20160210185404.GB10459@infradead.org>
 <20160210211025.GC23402@localhost.localdomain>
 <56BC7EC7.6020208@dev.mellanox.co.il>
Message-ID: <20160211151245.GD11908@localhost.localdomain>

On Thu, Feb 11, 2016@02:29:59PM +0200, Sagi Grimberg wrote:
> 
> >>Do we need this message at all?
> >
> >I don't find it useful for anything other than confirming a test hit
> >that path. Delete it?
> 
> Perhaps we can have it dev_dbg.

Thanks, sounds like the right compromise to me.
