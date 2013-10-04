From: David.Laight@ACULAB.COM (David Laight)
Date: Fri, 4 Oct 2013 09:31:49 +0100
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>

> > It seems to me that a more useful interface would take a minimum and
> > maximum number of vectors from the driver.  This wouldn't allow the
> > driver to specify that it could only accept, say, any even number within
> > a certain range, but you could still leave the current functions
> > available for any driver that needs that.
> 
> Mmmm.. I am not sure I am getting it. Could you please rephrase?

One possibility is for drivers than can use a lot of interrupts to
request a minimum number initially and then request the additional
ones much later on.
That would make it less likely that none will be available for
devices/drivers that need them but are initialised later.

	David
