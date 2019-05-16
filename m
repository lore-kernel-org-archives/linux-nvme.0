From: kbusch@kernel.org (Keith Busch)
Date: Thu, 16 May 2019 08:26:58 -0600
Subject: [PATCHv2 6/6] nvme-pci: Use host managed power state for suspend
In-Reply-To: <CAJZ5v0iC44O_gLMHnLui+tH+BuHKJzh_WC7PV3JFJwhj041=1A@mail.gmail.com>
References: <20190515163625.21776-1-keith.busch@intel.com>
 <20190515163625.21776-6-keith.busch@intel.com>
 <CAJZ5v0iC44O_gLMHnLui+tH+BuHKJzh_WC7PV3JFJwhj041=1A@mail.gmail.com>
Message-ID: <20190516142657.GD23333@localhost.localdomain>

On Thu, May 16, 2019@02:29:10AM -0700, Rafael J. Wysocki wrote:
> This is a bit problematic with respect to hibernation.
> 
> Sorry for failing to mention that before, it escaped me somehow.
> 
> So the problem is that this will be invoked as the ->restore()
> callback and it need not be suitable for that depending on whether or
> not the driver is present in the restore kernel.  [There is another
> issue related to the fact that the last stage of hibernation doesn't
> return "true" from pm_suspend_via_firmware(), but that needs to be
> fixed elsewhere.]  If it is there, it will run nvme_deep_state(ndev),
> so all should be fine, but if it isn't there, the PCI bus type will
> apply the default handling to the device and that's to disable it via
> do_pci_disable_device() it this particular case, as per
> pci_pm_freeze(), so nvme_make_operational(ndev) should not be called
> then AFAICS.
> 
> IMO it is better to just do the nvme_dev_disable()/nvme_reset_ctrl()
> things in the hibernation path anyway, so I would rename the existing
> nvme_suspend/resume() to nvme_simple_suspend/resume() (or similar),
> respectively, and define new nvme_suspend/resume() to do something
> like:
> 
> return pm_suspend_via_firmware() || !ndev->ctrl.npss ?
> nvme_simple_suspend(dev) : nvme_deep_state(ndev);
> 
> and
> 
> return pm_resume_via_firmware() || !ndev->ctrl.npss ?
> nvme_simple_resume(dev) : nvme_make_operational(ndev);
> 
> respectively.
> 
> >         nvme_reset_ctrl(&ndev->ctrl);
> >         return 0;
> >  }
> > --
> 
> Then, you can populate nvme_dev_pm_ops as follows:
> 
> static const struct dev_pm_ops = {
>     .suspend = nvme_suspend,
>     .resume = nvme_resume,
>     .freeze = nvme_simple_suspend,
>     .thaw = nvme_simple_resume,
>     .poweroff = nvme_simple_suspend,
>     .restore = nvme_simple_resume,
> };
> 
> and it should all work.

Thanks for the pointers, I'll give that idea a shot.
