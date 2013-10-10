From: hpa@zytor.com (H. Peter Anvin)
Date: Thu, 10 Oct 2013 09:28:27 -0700
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <5254D397.9030307@zytor.com> <1381292648.645.259.camel@pasglop>
 <20131010101704.GC11874@dhcp-26-207.brq.redhat.com>
Message-ID: <5256D5AB.4050105@zytor.com>

On 10/10/2013 03:17 AM, Alexander Gordeev wrote:
> On Wed, Oct 09, 2013@03:24:08PM +1100, Benjamin Herrenschmidt wrote:
> 
> Ok, this suggestion sounded in one or another form by several people.
> What about name it pcim_enable_msix_range() and wrap in couple more
> helpers to complete an API:
> 
> int pcim_enable_msix_range(pdev, msix_entries, nvec, minvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where minvec >= result <= nvec
> 
> int pcim_enable_msix(pdev, msix_entries, nvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where 1 >= result <= nvec 
> 
> int pcim_enable_msix_exact(pdev, msix_entries, nvec);
> 	<0 - error code
> 	>0 - number of MSIs allocated, where result == nvec
> 
> The latter's return value seems odd, but I can not help to make
> it consistent with the first two.
> 

Is there a reason for the wrappers, as opposed to just specifying either
1 or nvec as the minimum?

	-hpa
