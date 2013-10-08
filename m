From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 8 Oct 2013 11:07:16 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <20131007182117.GC27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <20131007182117.GC27396@htj.dyndns.org>
Message-ID: <20131008090716.GA10561@dhcp-26-207.brq.redhat.com>

On Mon, Oct 07, 2013@02:21:17PM -0400, Tejun Heo wrote:
> Whee.... that's a lot more than I expected.  I was just scanning
> multiple msi users.  Maybe we can stage the work in more manageable
> steps so that you don't have to go through massive conversion only to
> do it all over again afterwards and likewise people don't get
> bombarded on each iteration?  Maybe we can first update pci / msi code
> proper, msi and then msix?

Multipe MSIs is just a handful of drivers, really. MSI-X impact still
will be huge. But if we opt a different name for the new pci_enable_msix()
then we could first update pci/msi, then drivers (in few stages possibly)
and finally remove the old implementation.

> tejun

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
