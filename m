From: agordeev@redhat.com (Alexander Gordeev)
Date: Sun, 6 Oct 2013 08:02:44 +0200
Subject: [PATCH RFC 00/77] Re-design MSI/MSI-X interrupts enablement
 pattern
In-Reply-To: <1381009586.645.141.camel@pasglop>
References: <cover.1380703262.git.agordeev@redhat.com>
 <1380840585.3419.50.camel@bwh-desktop.uk.level5networks.com>
 <20131004082920.GA4536@dhcp-26-207.brq.redhat.com>
 <1380922156.3214.49.camel@bwh-desktop.uk.level5networks.com>
 <20131005142054.GA11270@dhcp-26-207.brq.redhat.com>
 <1381009586.645.141.camel@pasglop>
Message-ID: <20131006060243.GB28142@dhcp-26-207.brq.redhat.com>

On Sun, Oct 06, 2013@08:46:26AM +1100, Benjamin Herrenschmidt wrote:
> On Sat, 2013-10-05@16:20 +0200, Alexander Gordeev wrote:
> > So my point is - drivers should first obtain a number of MSIs they *can*
> > get, then *derive* a number of MSIs the device is fine with and only then
> > request that number. Not terribly different from memory or any other type
> > of resource allocation ;)
> 
> What if the limit is for a group of devices ? Your interface is racy in
> that case, another driver could have eaten into the limit in between the
> calls.

Well, the another driver has had a better karma ;) But seriously, the
current scheme with a loop is not race-safe wrt to any other type of
resource which might exhaust. What makes the quota so special so we
should care about it and should not care i.e. about lack of msi_desc's?

Yeah, I know the quota might hit more likely. But why it is not addressed
right now then? Not a single function in chains...
  rtas_msi_check_device() -> msi_quota_for_device() -> traverse_pci_devices()
  rtas_setup_msi_irqs() -> msi_quota_for_device() -> traverse_pci_devices()
...is race-safe. So if it has not been bothering anyone until now then
no reason to start worrying now :)

In fact, in the current design to address the quota race decently the
drivers would have to protect the *loop* to prevent the quota change
between a pci_enable_msix() returned a positive number and the the next
call to pci_enable_msix() with that number. Is it doable?

> Ben.
> 
> 

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
