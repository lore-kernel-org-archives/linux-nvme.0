From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 4 Oct 2013 11:21:09 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <AE90C24D6B3A694183C094C60CF0A2F6026B7371@saturn3.aculab.com>
Message-ID: <20131004092108.GB4536@dhcp-26-207.brq.redhat.com>

On Fri, Oct 04, 2013@09:31:49AM +0100, David Laight wrote:
> > Mmmm.. I am not sure I am getting it. Could you please rephrase?
> 
> One possibility is for drivers than can use a lot of interrupts to
> request a minimum number initially and then request the additional
> ones much later on.
> That would make it less likely that none will be available for
> devices/drivers that need them but are initialised later.

It sounds as a whole new topic for me. Isn't it?

Anyway, what prevents the above from being done with pci_enable_msix(nvec1) -
pci_disable_msix() - pci_enable_msix(nvec2) where nvec1 < nvec2?

> 	David

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
