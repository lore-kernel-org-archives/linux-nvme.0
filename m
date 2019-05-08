From: Mario.Limonciello@dell.com (Mario.Limonciello@dell.com)
Date: Wed, 8 May 2019 20:28:30 +0000
Subject: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
In-Reply-To: <20190508195159.GA1530@lst.de>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
 <20190508191624.GA8365@localhost.localdomain>
 <3CDA9F13-B17C-456F-8CE1-3A63C6E0DC8F@canonical.com>
 <f8a043b00909418bad6adcdb62d16e6e@AUSX13MPC105.AMER.DELL.COM>
 <20190508195159.GA1530@lst.de>
Message-ID: <b43f2c0078f245398101fa9a40cfc2dc@AUSX13MPC105.AMER.DELL.COM>

> -----Original Message-----
> From: Christoph Hellwig <hch at lst.de>
> Sent: Wednesday, May 8, 2019 2:52 PM
> To: Limonciello, Mario
> Cc: kai.heng.feng at canonical.com; kbusch at kernel.org; keith.busch at intel.com;
> axboe at fb.com; hch at lst.de; sagi at grimberg.me; linux-nvme at lists.infradead.org;
> linux-kernel at vger.kernel.org
> Subject: Re: [PATCH] nvme-pci: Use non-operational power state instead of D3 on
> Suspend-to-Idle
> 
> 
> [EXTERNAL EMAIL]
> 
> On Wed, May 08, 2019@07:38:50PM +0000, Mario.Limonciello@dell.com wrote:
> > The existing routines have an implied assumption that firmware will come
> swinging
> > with a hammer to control the rails the SSD sits on.
> > With S2I everything needs to come from the driver side and it really is a
> > different paradigm.
> 
> And that is why is this patch is fundamentally broken.
> 
> When using the simple pm ops suspend the pm core expects the device
> to be powered off.  If fancy suspend doesn't want that we need to
> communicate what to do to the device in another way, as the whole
> thing is a platform decision.  There probabl is one (or five) methods
> in dev_pm_ops that do the right thing, but please coordinate this
> with the PM maintainers to make sure it does the right thing and
> doesn't for example break either hibernate where we really don't
> expect just a lower power state, or 

You might think this would be adding runtime_suspend/runtime_resume
callbacks, but those also get called actually at runtime which is not
the goal here.  At runtime, these types of disks should rely on APST which
should calculate the appropriate latencies around the different power states.

This code path is only applicable in the suspend to idle state, which /does/
call suspend/resume functions associated with dev_pm_ops.  There isn't
a dedicated function in there for use only in suspend to idle, which is
why pm_suspend_via_s2idle() needs to get called.

SIMPLE_DEV_PM_OPS normally sets the same function for suspend and
freeze (hibernate), so to avoid any changes to the hibernate case it seems
to me that there needs to be a new nvme_freeze() that calls into the existing
nvme_dev_disable for the freeze pm op and nvme_thaw() that calls into the
existing nvme_reset_ctrl for the thaw pm op.

> enterprise class NVMe devices
> that don't do APST and don't really do different power states at
> all in many cases.

Enterprise class NVMe devices that don't do APST - do they typically
have a non-zero value for ndev->ctrl.npss?

If not, they wouldn't enter this new codepath even if the server entered into S2I.
