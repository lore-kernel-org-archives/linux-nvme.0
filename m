From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Feb 2017 15:40:59 -0500
Subject: hch's native NVMe multipathing [was: Re: [PATCH 1/2] Don't
 blacklist nvme]
In-Reply-To: <20170216182129.GC12678@redhat.com>
References: <1487107154-24883-1-git-send-email-keith.busch@intel.com>
 <20170215145617.GA4241@infradead.org>
 <20170216025357.GA9241@redhat.com>
 <20170216142621.GA21972@infradead.org>
 <20170216151337.GA12678@redhat.com>
 <20170216173856.GB17828@localhost.localdomain>
 <1487266648.2612.3.camel@sandisk.com>
 <20170216180742.GC17828@localhost.localdomain>
 <20170216182129.GC12678@redhat.com>
Message-ID: <20170216204058.GA1631@localhost.localdomain>

On Thu, Feb 16, 2017@01:21:29PM -0500, Mike Snitzer wrote:
> Then undeprecate them.  Decisions like marking a path checker deprecated
> were _not_ made with NVMe in mind.  They must predate NVMe.
> 
> multipath-tools has tables that specify all the defaults for a given
> target backend.  NVMe will just be yet another.  Yes some user _could_
> shoot themselves in the foot by overriding the proper configuration but
> since when are we motivated by _not_ giving users the power to hang
> themselves?
> 
> As for configurability (chosing between N valid configs/settings): At
> some point the user will want one behaviour vs another.  Thinking
> otherwise is just naive.  Think error timeouts, etc.  Any multipath
> kernel implementation (which dm-multipath is BTW) will eventually find
> itself at a crossroads where the underlying fabric could be tweaked in
> different ways.  Thinking you can just hardcode these attributes and
> settings is foolish.

Roger that, and I absolutely want to see this work with the existing
framework.

I just think it'd be easier for everyone if multipath were more like
the generic block layer, in that devices are surfaced with configurable
policies without userspace telling it which to use. The kernel knowing
safe defaults for a particular device is probably the more common case,
and userspace can still tune them as needed. Of course, I accept you're
in a better position to know if this is folly.
