From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 4 Oct 2013 10:29:20 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
Message-ID: <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>

On Thu, Oct 03, 2013@11:49:45PM +0100, Ben Hutchings wrote:
> On Wed, 2013-10-02@12:48 +0200, Alexander Gordeev wrote:
> > This update converts pci_enable_msix() and pci_enable_msi_block()
> > interfaces to canonical kernel functions and makes them return a
> > error code in case of failure or 0 in case of success.
> [...]
> 
> I think this is fundamentally flawed: pci_msix_table_size() and
> pci_get_msi_cap() can only report the limits of the *device* (which the
> driver usually already knows), whereas MSI allocation can also be
> constrained due to *global* limits on the number of distinct IRQs.

Even the current implementation by no means addresses it. Although it
might seem a case for architectures to report the number of IRQs available
for a driver to retry, in fact they all just fail. The same applies to
*any* other type of resource involved: irq_desc's, CPU interrupt vector
space, msi_desc's etc. No platform cares about it and just bails out once
a constrain met (please correct me if I am wrong here). Given that Linux
has been doing well even on embedded I think we should not change it.

The only exception to the above is pSeries platform which takes advantage
of the current design (to implement MSI quota). There are indications we
can satisfy pSeries requirements, but the design proposed in this RFC
is not going to change drastically anyway. The start of the discusstion
is here: https://lkml.org/lkml/2013/9/5/293

> Currently pci_enable_msix() will report a positive value if it fails due
> to the global limit.  Your patch 7 removes that.  pci_enable_msi_block()
> unfortunately doesn't appear to do this.

pci_enable_msi_block() can do more than one MSI only on x86 (with IOMMU),
but it does not bother to return positive numbers, indeed.

> It seems to me that a more useful interface would take a minimum and
> maximum number of vectors from the driver.  This wouldn't allow the
> driver to specify that it could only accept, say, any even number within
> a certain range, but you could still leave the current functions
> available for any driver that needs that.

Mmmm.. I am not sure I am getting it. Could you please rephrase?

> Ben.

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
