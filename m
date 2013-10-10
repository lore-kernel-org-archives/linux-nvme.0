From: agordeev@redhat.com (Alexander Gordeev)
Date: Thu, 10 Oct 2013 20:07:05 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <5256D5AB.4050105@zytor.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop>
 <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
 <5256D5AB.4050105@zytor.com>
Message-ID: <20131010180704.GA15719@dhcp-26-207.brq.redhat.com>

On Thu, Oct 10, 2013@09:28:27AM -0700, H. Peter Anvin wrote:
> On 10/10/2013 03:17 AM, Alexander Gordeev wrote:
> > On Wed, Oct 09, 2013@03:24:08PM +1100, Benjamin Herrenschmidt wrote:
> > 
> > Ok, this suggestion sounded in one or another form by several people.
> > What about name it pcim_enable_msix_range() and wrap in couple more
> > helpers to complete an API:
> > 
> > int pcim_enable_msix_range(pdev, msix_entries, nvec, minvec);
> > 	<0 - error code
> > 	>0 - number of MSIs allocated, where minvec >= result <= nvec
> > 
> > int pcim_enable_msix(pdev, msix_entries, nvec);
> > 	<0 - error code
> > 	>0 - number of MSIs allocated, where 1 >= result <= nvec 
> > 
> > int pcim_enable_msix_exact(pdev, msix_entries, nvec);
> > 	<0 - error code
> > 	>0 - number of MSIs allocated, where result == nvec
> > 
> > The latter's return value seems odd, but I can not help to make
> > it consistent with the first two.
> > 
> 
> Is there a reason for the wrappers, as opposed to just specifying either
> 1 or nvec as the minimum?

The wrappers are more handy IMO.

I.e. can imagine people start struggling to figure out what minvec to provide:
1 or 0? Why 1? Oh.. okay.. Or should we tolerate 0 (as opposite to -ERANGE)?

Well, do not know.. pcim_enable_msix(pdev, msix_entries, nvec, nvec) is 
less readable for me than just pcim_enable_msix_exact(pdev, msix_entries,
nvec).

> 	-hpa

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
