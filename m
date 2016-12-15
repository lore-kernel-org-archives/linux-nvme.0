From: keith.busch@intel.com (Keith Busch)
Date: Thu, 15 Dec 2016 10:59:58 -0500
Subject: [PATCH] nvme: simplify stripe quirk
In-Reply-To: <20161215083236.GA32244@infradead.org>
References: <1481760655-25877-1-git-send-email-keith.busch@intel.com>
 <20161215083236.GA32244@infradead.org>
Message-ID: <20161215155958.GA29688@localhost.localdomain>

On Thu, Dec 15, 2016@12:32:36AM -0800, Christoph Hellwig wrote:
> On Wed, Dec 14, 2016@07:10:55PM -0500, Keith Busch wrote:
> > Some subsystem vendors believe they own the Identify Controller vendor
> > specific region, and will repurpose it with their own values.
> 
> Well, it's vendor specific, right?

If I'm the vendor and you're the subsystem vendor, who owns the vendor
specific region?
 
> I don't understand this patch at all - you hardcode a value that was
> previously vendor specific, and your argument for that is that the
> vendor specific value is used by the value - heck, that's exactly why
> the value is there.

I'm not sure what you mean. I haven't hard-coded anything. The alignment
requirements on the hardware itself always matches MDTS, so that's what
the patch proposes to use.

The current driver expects ID_CTRL.VS[3] defines the stripe use. However,
a subsystem vendor changes the field to mean something completely
different that has nothing to do with backend striping. We can't trust
how to decode the field just by knowing the VID:DID anymore, and I'm
confident we don't want to add another layer of SVID:SSID checks to know
how to decode quirk.

Instead, I'm simplifying this by exploiting a fact about the hardware. If
you're wondering why we didn't do that in the first place, it's because we
considered making this a changeable property, but that never materialized
and it never will.
