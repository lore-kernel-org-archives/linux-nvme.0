From: tj@kernel.org (Tejun Heo)
Date: Wed, 9 Oct 2013 11:57:52 -0400
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131008090716.GA10561@dhcp-26-207.brq.redhat.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <20131007182117.GC27396@htj.dyndns.org>
 <20131008090716.GA10561@dhcp-26-207.brq.redhat.com>
Message-ID: <20131009155752.GE22495@htj.dyndns.org>

Hello,

On Tue, Oct 08, 2013@11:07:16AM +0200, Alexander Gordeev wrote:
> Multipe MSIs is just a handful of drivers, really. MSI-X impact still

Yes, so it's pretty nice to try out things there before going full-on.

> will be huge. But if we opt a different name for the new pci_enable_msix()
> then we could first update pci/msi, then drivers (in few stages possibly)
> and finally remove the old implementation.

Yes, that probably should be the steps to follow eventually.  My point
was that you don't have to submit patches for all 7x conversions for
an RFC round.  Scanning them and seeing what would be necessary
definitely is a good idea but just giving summary of the full
conversion with several examples should be good enough before settling
on the way forward, which should be easier for all involved.

Thanks a lot for your effort!

-- 
tejun
