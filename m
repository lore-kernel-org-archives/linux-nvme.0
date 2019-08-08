From: rafael@kernel.org (Rafael J. Wysocki)
Date: Thu, 8 Aug 2019 16:48:42 +0200
Subject: [PATCH v2 1/2] PCI: PCIe: ASPM: Introduce pcie_aspm_enabled_mask()
In-Reply-To: <20190808131536.GE151852@google.com>
References: <4323ed84dd07474eab65699b4d007aaf@AUSX13MPC105.AMER.DELL.COM>
 <20190731221956.GB15795@localhost.localdomain> <1921165.pTveHRX1Co@kreacher>
 <3714448.mG7dE8Q3Fs@kreacher> <20190808131536.GE151852@google.com>
Message-ID: <CAJZ5v0gMzVYdC-xZYLWYmBZ-a3-R8LND=11YJFCXdzrtyyZW=Q@mail.gmail.com>

On Thu, Aug 8, 2019@3:15 PM Bjorn Helgaas <helgaas@kernel.org> wrote:
>
> On Thu, Aug 08, 2019@12:06:52PM +0200, Rafael J. Wysocki wrote:
> > From: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
> >
> > Add a function returning the mask of currently enabled ASPM link
> > states for a given device.
> >
> > It will be used by the NVMe driver to decide how to handle the
> > device during system suspend.
> >
> > Signed-off-by: Rafael J. Wysocki <rafael.j.wysocki at intel.com>
> > ---
> >
> > -> v2:
> >   * Move the PCI/PCIe ASPM changes to a separate patch.
> >   * Add the _mask suffix to the new function name.
> >   * Add EXPORT_SYMBOL_GPL() to the new function.
> >   * Avoid adding an unnecessary blank line.
> >
> > ---
> >  drivers/pci/pcie/aspm.c |   20 ++++++++++++++++++++
> >  include/linux/pci.h     |    3 +++
> >  2 files changed, 23 insertions(+)
> >
> > Index: linux-pm/drivers/pci/pcie/aspm.c
> > ===================================================================
> > --- linux-pm.orig/drivers/pci/pcie/aspm.c
> > +++ linux-pm/drivers/pci/pcie/aspm.c
> > @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
> >  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
> >       NULL, 0644);
> >
> > +/*
> > + * pcie_aspm_enabled_mask - Return the mask of enabled ASPM link states.
> > + * @pci_device: Target device.
> > + */
> > +u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device)
> > +{
> > +     struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> > +     u32 ret;
> > +
> > +     if (!bridge)
> > +             return 0;
> > +
> > +     mutex_lock(&aspm_lock);
> > +     ret = bridge->link_state ? bridge->link_state->aspm_enabled : 0;
>
> This returns the "aspm_enabled" mask, but the values of that mask are
> combinations of:
>
>   ASPM_STATE_L0S_UP
>   ASPM_STATE_L0S_DW
>   ASPM_STATE_L1
>   ...
>
> which are defined internally in drivers/pci/pcie/aspm.c and not
> visible to the caller of pcie_aspm_enabled_mask().  If there's no need
> for the actual mask (the current caller doesn't seem to use it), maybe
> this could be a boolean?

Yes, it can be a boolean.

>
> > +     mutex_unlock(&aspm_lock);
> > +
> > +     return ret;
> > +}
> > +EXPORT_SYMBOL_GPL(pcie_aspm_enabled_mask);
> > +
> >  #ifdef CONFIG_PCIEASPM_DEBUG
> >  static ssize_t link_state_show(struct device *dev,
> >               struct device_attribute *attr,
> > Index: linux-pm/include/linux/pci.h
> > ===================================================================
> > --- linux-pm.orig/include/linux/pci.h
> > +++ linux-pm/include/linux/pci.h
> > @@ -1567,8 +1567,11 @@ extern bool pcie_ports_native;
> >
> >  #ifdef CONFIG_PCIEASPM
> >  bool pcie_aspm_support_enabled(void);
> > +u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device);
> >  #else
> >  static inline bool pcie_aspm_support_enabled(void) { return false; }
> > +static inline u32 pcie_aspm_enabled_mask(struct pci_dev *pci_device)
> > +{ return 0; }
> >  #endif
> >
> >  #ifdef CONFIG_PCIEAER
> >
> >
> >
