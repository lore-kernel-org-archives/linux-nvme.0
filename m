From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 8 Oct 2013 14:22:16 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131007180111.GC2481@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
 <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>
 <1381040386.645.143.camel@pasglop>
 <20131006071027.GA29143@dhcp-26-207.brq.redhat.com>
 <20131007180111.GC2481@htj.dyndns.org>
Message-ID: <20131008122215.GA14389@dhcp-26-207.brq.redhat.com>

On Mon, Oct 07, 2013@02:01:11PM -0400, Tejun Heo wrote:
> > What about introducing pci_lock_msi() and pci_unlock_msi() and let device
> > drivers care about their ranges and specifics in race-safe manner?
> > I do not call to introduce it right now (since it appears pSeries has not
> > been hitting the race for years) just as a possible alternative to Ben's
> > proposal.
> 
> I don't think the same race condition would happen with the loop.

We need to distinguish the contexts we're discussing.

If we talk about pSeries quota, then the current pSeries pci_enable_msix()
implementation is racy internally and could fail if the quota went down
*while* pci_enable_msix() is executing. In this case the loop will have to
exit rather than retry with a lower number (what number?).

In this regard the new scheme does not bring anything new and relies on
the fact this race does not hit and therefore does not worry.

If we talk about quota as it has to be, then yes - the loop scheme seems
more preferable.

Overall, looks like we just need to fix the pSeries implementation,
if the guys want it, he-he :)

> The problem case is where multiple msi(x) allocation fails completely
> because the global limit went down before inquiry and allocation.  In
> the loop based interface, it'd retry with the lower number.

I am probably missing something here. If the global limit went down before
inquiry then the inquiry will get what is available and try to allocate with
than number.

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
