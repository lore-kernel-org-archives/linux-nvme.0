From: agordeev@redhat.com (Alexander Gordeev)
Date: Thu, 10 Oct 2013 12:17:05 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <1381292648.645.259.camel@pasglop>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop>
Message-ID: <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>

On Wed, Oct 09, 2013@03:24:08PM +1100, Benjamin Herrenschmidt wrote:
> On Tue, 2013-10-08@20:55 -0700, H. Peter Anvin wrote:
> > Why not add a minimum number to pci_enable_msix(), i.e.:
> > 
> > pci_enable_msix(pdev, msix_entries, nvec, minvec)
> > 
> > ... which means "nvec" is the number of interrupts *requested*, and
> > "minvec" is the minimum acceptable number (otherwise fail).
> 
> Which is exactly what Ben (the other Ben :-) suggested and that I
> supports...

Ok, this suggestion sounded in one or another form by several people.
What about name it pcim_enable_msix_range() and wrap in couple more
helpers to complete an API:

int pcim_enable_msix_range(pdev, msix_entries, nvec, minvec);
	<0 - error code
	>0 - number of MSIs allocated, where minvec >= result <= nvec

int pcim_enable_msix(pdev, msix_entries, nvec);
	<0 - error code
	>0 - number of MSIs allocated, where 1 >= result <= nvec 

int pcim_enable_msix_exact(pdev, msix_entries, nvec);
	<0 - error code
	>0 - number of MSIs allocated, where result == nvec

The latter's return value seems odd, but I can not help to make
it consistent with the first two.


(Sorry if you see this message twice - my MUA seems struggle with one of CC).

> Cheers,
> Ben.
> 
> 

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
