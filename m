From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 16 Dec 2016 00:07:53 -0800
Subject: [PATCH] nvme: simplify stripe quirk
In-Reply-To: <20161215155958.GA29688@localhost.localdomain>
References: <1481760655-25877-1-git-send-email-keith.busch@intel.com>
 <20161215083236.GA32244@infradead.org>
 <20161215155958.GA29688@localhost.localdomain>
Message-ID: <20161216080753.GB22912@infradead.org>

On Thu, Dec 15, 2016@10:59:58AM -0500, Keith Busch wrote:
> On Thu, Dec 15, 2016@12:32:36AM -0800, Christoph Hellwig wrote:
> > On Wed, Dec 14, 2016@07:10:55PM -0500, Keith Busch wrote:
> > > Some subsystem vendors believe they own the Identify Controller vendor
> > > specific region, and will repurpose it with their own values.
> > 
> > Well, it's vendor specific, right?
> 
> If I'm the vendor and you're the subsystem vendor, who owns the vendor
> specific region?


I was initially even more confused by your sentence - NVMe only knows
about a single vendor in the device, and it's assumed both the
controller and the subsystem come from it.

But then I realized that you probably mean the PCI subsystem vendor,
at which point all this makes a little more sense.

> The current driver expects ID_CTRL.VS[3] defines the stripe use. However,
> a subsystem vendor changes the field to mean something completely
> different that has nothing to do with backend striping. We can't trust
> how to decode the field just by knowing the VID:DID anymore, and I'm
> confident we don't want to add another layer of SVID:SSID checks to know
> how to decode quirk.

So an OEM can take the Intel Cards, and stuff their own values into the
vendor specific fields?  This sounds bad as you can't rely on the
existing quirks in any old Linux version (plus FreeBSD or spdk for that
matter any more).

I'm obviously not in a postition to tell Intel not to do this, but
first claiming to Linux that a given PCI ID will always behave this way
and then later changing your opinion is a desaster.  Maybe we should
simply never have merged this vendor specific optimization, but now it's
too late.
