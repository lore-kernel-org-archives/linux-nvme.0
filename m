From: kbusch@kernel.org (Keith Busch)
Date: Wed, 8 May 2019 13:16:24 -0600
Subject: [PATCH] nvme-pci: Use non-operational power state instead of D3
 on Suspend-to-Idle
In-Reply-To: <20190508185955.11406-1-kai.heng.feng@canonical.com>
References: <20190508185955.11406-1-kai.heng.feng@canonical.com>
Message-ID: <20190508191624.GA8365@localhost.localdomain>

On Thu, May 09, 2019@02:59:55AM +0800, Kai-Heng Feng wrote:
> +static int nvme_do_resume_from_idle(struct pci_dev *pdev)
> +{
> +	struct nvme_dev *ndev = pci_get_drvdata(pdev);
> +	int result;
> +
> +	pdev->dev_flags &= ~PCI_DEV_FLAGS_NO_D3;
> +	ndev->ctrl.suspend_to_idle = false;
> +
> +	result = pci_alloc_irq_vectors(pdev, 1, 1, PCI_IRQ_ALL_TYPES);
> +	if (result < 0)
> +		goto out;
> +
> +	result = nvme_pci_configure_admin_queue(ndev);
> +	if (result)
> +		goto out;
> +
> +	result = nvme_alloc_admin_tags(ndev);
> +	if (result)
> +		goto out;
> +
> +	ndev->ctrl.max_hw_sectors = NVME_MAX_KB_SZ << 1;
> +	ndev->ctrl.max_segments = NVME_MAX_SEGS;
> +	mutex_unlock(&ndev->shutdown_lock);

This lock was never locked.

But I think these special suspend/resume routines are too similar to the
existing ones, they should just incorporate this feature if we need to
do this.
