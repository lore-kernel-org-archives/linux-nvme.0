From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 8 Oct 2013 09:56:59 +0200
Subject: [PATCH RFC 05/77] PCI/MSI: Convert pci_msix_table_size() to a
 public interface
In-Reply-To: <20131007181043.GA27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <e8b51bd48c24d0fc4ee8adea5c138c9bf84191e9.1380703262.git.agordeev@redhat.com>
 <20131007181043.GA27396@htj.dyndns.org>
Message-ID: <20131008075658.GE10669@dhcp-26-207.brq.redhat.com>

On Mon, Oct 07, 2013@02:10:43PM -0400, Tejun Heo wrote:
> On Wed, Oct 02, 2013@12:48:21PM +0200, Alexander Gordeev wrote:
> > Make pci_msix_table_size() to return a error code if the device
> > does not support MSI-X. This update is needed to facilitate a
> > forthcoming re-design MSI/MSI-X interrupts enabling pattern.
> > 
> > Device drivers will use this interface to obtain maximum number
> > of MSI-X interrupts the device supports and use that value in
> > the following call to pci_enable_msix() interface.
> 
> Hmmm... I probably missed something but why is this necessary?  To
> discern between -EINVAL and -ENOSPC?  If so, does that really matter?

pci_msix_table_size() is kind of helper and returns 0 if a device does
not have MSI-X table. If we want drivers to use it we need return -EINVAL
for MSI-X incapable/disabled devices. Nothing about -ENOSPC.

> tejun

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
