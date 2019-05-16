From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 16 May 2019 22:24:00 +0200
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <70235CA3-0FBB-4A06-996F-647A0D95C6D0@canonical.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <CAJZ5v0iC44O_gLMHnLui+tH+BuHKJzh_WC7PV3JFJwhj041=1A@mail.gmail.com>
 <20190516142657.GD23333@localhost.localdomain>
 <70235CA3-0FBB-4A06-996F-647A0D95C6D0@canonical.com>
Message-ID: <CAJZ5v0inMAf-eh+fOxF7M3uVDGR9_=Sti3ubDBd2bpfqrTNK6A@mail.gmail.com>

On Thu, May 16, 2019 at 8:27 PM Kai-Heng Feng
<kai.heng.feng@canonical.com> wrote:
>
> Hi Keith,
>
>@22:26, Keith Busch <kbusch@kernel.org> wrote:
>
> > On Thu, May 16, 2019@02:29:10AM -0700, Rafael J. Wysocki wrote:
> >> This is a bit problematic with respect to hibernation.
> >>
> >> Sorry for failing to mention that before, it escaped me somehow.
> >>
> >> So the problem is that this will be invoked as the ->restore()
> >> callback and it need not be suitable for that depending on whether or
> >> not the driver is present in the restore kernel.  [There is another
> >> issue related to the fact that the last stage of hibernation doesn't
> >> return "true" from pm_suspend_via_firmware(), but that needs to be
> >> fixed elsewhere.]  If it is there, it will run nvme_deep_state(ndev),
> >> so all should be fine, but if it isn't there, the PCI bus type will
> >> apply the default handling to the device and that's to disable it via
> >> do_pci_disable_device() it this particular case, as per
> >> pci_pm_freeze(), so nvme_make_operational(ndev) should not be called
> >> then AFAICS.
> >>
> >> IMO it is better to just do the nvme_dev_disable()/nvme_reset_ctrl()
> >> things in the hibernation path anyway, so I would rename the existing
> >> nvme_suspend/resume() to nvme_simple_suspend/resume() (or similar),
> >> respectively, and define new nvme_suspend/resume() to do something
> >> like:
> >>
> >> return pm_suspend_via_firmware() || !ndev->ctrl.npss ?
> >> nvme_simple_suspend(dev) : nvme_deep_state(ndev);
> >>
> >> and
> >>
> >> return pm_resume_via_firmware() || !ndev->ctrl.npss ?
> >> nvme_simple_resume(dev) : nvme_make_operational(ndev);
> >>
> >> respectively.
> >>
> >>>        nvme_reset_ctrl(&ndev->ctrl);
> >>>         return 0;
> >>>  }
> >>> --
> >>
> >> Then, you can populate nvme_dev_pm_ops as follows:
> >>
> >> static const struct dev_pm_ops = {
> >>     .suspend = nvme_suspend,
> >>     .resume = nvme_resume,
> >>     .freeze = nvme_simple_suspend,
> >>     .thaw = nvme_simple_resume,
> >>     .poweroff = nvme_simple_suspend,
> >>     .restore = nvme_simple_resume,
> >> };
> >>
> >> and it should all work.
> >
> > Thanks for the pointers, I'll give that idea a shot.
>
> Thanks for your work, I?ve tested your patch series on top of nvme-5.2
> branch. It works well once I apply flag PCI_DEV_FLAGS_NO_D3.
> After some digging I think it?s another bug though:
>
> [   69.883743] PM: suspend entry (s2idle)
> [   69.883746] PM: Syncing filesystems ... done.
> [   69.892848] Freezing user space processes ... (elapsed 0.003 seconds)
> done.
> [   69.896109] OOM killer disabled.
> [   69.896111] Freezing remaining freezable tasks ... (elapsed 0.001
> seconds) done.
> [   69.897432] printk: Suspending console(s) (use no_console_suspend to
> debug)
> [   70.004120] wlp1s0: deauthenticating from d8:8f:76:7c:52:a9 by local
> choice (Reason: 3=DEAUTH_LEAVING)
> [   70.007475] intel-lpss 0000:00:15.1: power state changed by ACPI to D0
> [   70.114626] intel-lpss 0000:00:15.1: restoring config space at offset
> 0x10 (was 0x4, writing 0x7f801004)
> [   70.216084] e1000e: EEE TX LPI TIMER: 00000011
> [   70.218418] intel-lpss 0000:00:15.0: power state changed by ACPI to D0
> [   70.257955] e1000e 0000:00:1f.6: disabling bus mastering
> [   70.325930] intel-lpss 0000:00:15.0: restoring config space at offset
> 0x10 (was 0x4, writing 0x7f800004)
> [   70.358779] nvme 0000:03:00.0: PCI PM: Suspend power state: D0
> [   70.362587] i801_smbus 0000:00:1f.4: PCI PM: Suspend power state: D0
> [   70.363712] e1000e 0000:00:1f.6: PME# enabled
> [   70.366507] pcieport 0000:00:1d.4: PME# enabled
> [   70.366512] pcieport 0000:00:1d.2: PME# enabled
> [   70.366904] xhci_hcd 0000:00:14.0: PME# enabled
> [   70.377166] snd_hda_intel 0000:00:1f.3: power state changed by ACPI to
> D3hot
> [   70.377187] snd_hda_intel 0000:00:1f.3: PCI PM: Suspend power state: D3hot
> [   70.385042] pcieport 0000:00:1d.2: PCI PM: Suspend power state: D3hot
> [   70.385364] ath10k_pci 0000:01:00.0: PCI PM: Suspend power state: D3hot
> [   70.385401] mei_me 0000:00:16.0: PCI PM: Suspend power state: D3hot
> [   70.385445] intel_pch_thermal 0000:00:12.0: PCI PM: Suspend power state:
> D3hot
> [   70.385980] intel-lpss 0000:00:15.1: power state changed by ACPI to D3cold
> [   70.386229] e1000e 0000:00:1f.6: power state changed by ACPI to D3hot
> [   70.386248] e1000e 0000:00:1f.6: PCI PM: Suspend power state: D3hot
> [   70.386328] intel-lpss 0000:00:15.0: power state changed by ACPI to D3cold
> [   70.386441] xhci_hcd 0000:00:14.0: power state changed by ACPI to D3hot
> [   70.386500] xhci_hcd 0000:00:14.0: PCI PM: Suspend power state: D3hot
> [   70.386536] intel-lpss 0000:00:15.1: PCI PM: Suspend power state: D3hot
> [   70.386602] intel-lpss 0000:00:15.0: PCI PM: Suspend power state: D3hot
> [   70.389034] pcieport 0000:00:1d.4: PCI PM: Suspend power state: D3hot
> [   70.390059] xhci_hcd 0000:00:14.0: power state changed by ACPI to D0
> [   70.390407] e1000e 0000:00:1f.6: power state changed by ACPI to D0
> [   70.390420] intel-lpss 0000:00:15.0: power state changed by ACPI to D0
> [   70.390504] intel-lpss 0000:00:15.1: power state changed by ACPI to D0
> [   70.390934] snd_hda_intel 0000:00:1f.3: power state changed by ACPI to D0
> [   70.411038] e1000e 0000:00:1f.6: restoring config space at offset 0x4
> (was 0x100000, writing 0x100002)
> [   70.412050] pcieport 0000:00:1d.2: restoring config space at offset 0x2c
> (was 0x0, writing 0x0)
> [   70.412348] pcieport 0000:00:1d.4: restoring config space at offset 0x2c
> (was 0x0, writing 0x0)
> [   70.412637] pcieport 0000:00:1d.2: restoring config space at offset 0x28
> (was 0x0, writing 0x0)
> [   70.412866] pcieport 0000:00:1d.4: restoring config space at offset 0x28
> (was 0x0, writing 0x0)
> [   70.413097] pcieport 0000:00:1d.2: restoring config space at offset 0x24
> (was 0x1fff1, writing 0x1fff1)
> [   70.413312] pcieport 0000:00:1d.4: restoring config space at offset 0x24
> (was 0x1fff1, writing 0x1fff1)
> [   70.419876] intel-lpss 0000:00:15.0: restoring config space at offset
> 0x10 (was 0x4, writing 0x7f800004)
> [   70.420094] intel-lpss 0000:00:15.1: restoring config space at offset
> 0x10 (was 0x4, writing 0x7f801004)
> [   70.437001] rtsx_pci 0000:02:00.0: restoring config space at offset 0x4
> (was 0x100402, writing 0x100406)
> [   70.451991] i801_smbus 0000:00:1f.4: PCI PM: Suspend power state: D0
> [   70.474839] mei_me 0000:00:16.0: PCI PM: Suspend power state: D3hot
> [   70.475511] snd_hda_intel 0000:00:1f.3: power state changed by ACPI to
> D3hot
> [   70.475523] e1000e 0000:00:1f.6: power state changed by ACPI to D3hot
> [   70.475535] e1000e 0000:00:1f.6: PCI PM: Suspend power state: D3hot
> [   70.475537] snd_hda_intel 0000:00:1f.3: PCI PM: Suspend power state: D3hot
> [   70.475543] i915 0000:00:02.0: PCI PM: Suspend power state: D3hot
> [   70.492594] intel_pch_thermal 0000:00:12.0: PCI PM: Suspend power state:
> D3hot
> [   70.492960] ath10k_pci 0000:01:00.0: PCI PM: Suspend power state: D3hot
> [   70.493056] pcieport 0000:00:1d.2: PCI PM: Suspend power state: D3hot
> [   70.493192] pcieport 0000:00:1d.0: PME# enabled
> [   70.493358] intel-lpss 0000:00:15.1: power state changed by ACPI to D3cold
> [   70.493650] intel-lpss 0000:00:15.0: power state changed by ACPI to D3cold
> [   70.493747] intel-lpss 0000:00:15.1: PCI PM: Suspend power state: D3hot
> [   70.493862] intel-lpss 0000:00:15.0: PCI PM: Suspend power state: D3hot
> [   70.496908] nvme 0000:03:00.0: PCI PM: Suspend power state: D3hot
>
> pci_pm_suspend_noirq() gets called twice:

I don't see how that can happen.

pci_pm_suspend_noirq() is only called as the ->suspend_noirq callback
by the PCI bus type and that occurs exactly once per suspend
transition for any given device.

And the Keith's patches don't touch the PCI bus type AFAICS.

> [   70.358779] nvme 0000:03:00.0: PCI PM: Suspend power state: D0
> [   70.496908] nvme 0000:03:00.0: PCI PM: Suspend power state: D3hot

> So it?s still being put to D3.

Are you sure that there are no extra changes in your kernel?
