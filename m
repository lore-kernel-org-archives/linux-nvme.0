From: keith.busch@intel.com (Keith Busch)
Date: Thu, 16 Feb 2017 13:07:43 -0500
Subject: hch's native NVMe multipathing [was: Re: [PATCH 1/2] Don't
 blacklist nvme]
In-Reply-To: <1487266648.2612.3.camel@sandisk.com>
References: <1487107154-24883-1-git-send-email-keith.busch@intel.com>
 <20170215145617.GA4241@infradead.org>
 <20170216025357.GA9241@redhat.com>
 <20170216142621.GA21972@infradead.org>
 <20170216151337.GA12678@redhat.com>
 <20170216173856.GB17828@localhost.localdomain>
 <1487266648.2612.3.camel@sandisk.com>
Message-ID: <20170216180742.GC17828@localhost.localdomain>

On Thu, Feb 16, 2017@05:37:41PM +0000, Bart Van Assche wrote:
> On Thu, 2017-02-16@12:38 -0500, Keith Busch wrote:
> > Maybe I'm not seeing the bigger picture. Is there some part to multipath
> > that the kernel is not in a better position to handle?
> 
> Does this mean that the code to parse /etc/multipath.conf will be moved into
> the kernel? Or will we lose the ability to configure the policies that
> /etc/multipath.conf allows to configure?

No, I'm just considering the settings for a device that won't work
at all if multipath.conf is wrong. For example, the uuid attributes,
path priority, or path checker. These can't be considered configurable
policies if all but one of them are invalid for a specific device type.

It shouldn't even be an option to let a user select TUR path checker
for NVMe, and the only checkers multipath-tools provide that even make
sense for NVMe are deprecated.
