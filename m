From: hch@lst.de (Christoph Hellwig)
Date: Thu, 8 Aug 2019 10:48:04 +0200
Subject: [PATCH] nvme-pci: Allow PCI bus-level PM to be used if ASPM is
 disabled
In-Reply-To: <2583975.4sIyE3leJj@kreacher>
References: <47415939.KV5G6iaeJG@kreacher>
 <20190730144134.GA12844@localhost.localdomain>
 <100ba4aff1c6434a81e47774ab4acddc@AUSX13MPC105.AMER.DELL.COM>
 <8246360B-F7D9-42EB-94FC-82995A769E28@canonical.com>
 <20190730191934.GD13948@localhost.localdomain>
 <7d3e0b8ba1444194a153c93faa1cabb3@AUSX13MPC105.AMER.DELL.COM>
 <20190730213114.GK13948@localhost.localdomain>
 <CAJZ5v0gxfeMN8eCNRjcXmUOkReVsdozb3EccaYMpnmSHu3771g@mail.gmail.com>
 <20190731221956.GB15795@localhost.localdomain> <2583975.4sIyE3leJj@kreacher>
Message-ID: <20190808084804.GA31404@lst.de>

> -     ndev->last_ps = 0;
>       ret = nvme_get_power_state(ctrl, &ndev->last_ps);
> -     if (ret < 0)
> +     if (ret < 0 || ndev->last_ps == U32_MAX)

Is the intent of the magic U32_MAX check to see if the
nvme_get_power_state failed at the nvme level?  In that case just
checking for any non-zero return value from nvme_get_power_state might
be the easier and more clear way to do it.

> Index: linux-pm/drivers/pci/pcie/aspm.c
> ===================================================================
> --- linux-pm.orig/drivers/pci/pcie/aspm.c
> +++ linux-pm/drivers/pci/pcie/aspm.c

Shouldn't we split PCI vs nvme in two patches?

> @@ -1170,6 +1170,26 @@ static int pcie_aspm_get_policy(char *bu
>  module_param_call(policy, pcie_aspm_set_policy, pcie_aspm_get_policy,
>  	NULL, 0644);
>  
> +/*
> + * pcie_aspm_enabled - Return the mask of enabled ASPM link states.
> + * @pci_device: Target device.
> + */
> +u32 pcie_aspm_enabled(struct pci_dev *pci_device)

pcie_aspm_enabled sounds like it returns a boolean.  Shouldn't there be
a mask or so in the name better documenting what it returns?

> +{
> +	struct pci_dev *bridge = pci_upstream_bridge(pci_device);
> +	u32 ret;
> +
> +	if (!bridge)
> +		return 0;
> +
> +	mutex_lock(&aspm_lock);
> +	ret = bridge->link_state ? bridge->link_state->aspm_enabled : 0;
> +	mutex_unlock(&aspm_lock);
> +
> +	return ret;
> +}

I think this will need a EXPORT_SYMBOL_GPL thrown in so that modular
nvme continues working.

> +
> +
>  #ifdef CONFIG_PCIEASPM_DEBUG

Nit: double blank line here.
