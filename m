From: keith.busch@intel.com (Keith Busch)
Date: Fri, 22 Jan 2016 22:16:22 +0000
Subject: [GIT PULL] NVMe changes for 4.5-rc1
In-Reply-To: <20160122220805.GA30907@localhost.localdomain>
References: <20160121212738.GA15727@kernel.dk>
 <CA+55aFzaxsVDXC0SCQpBym9PR6cyKkACS5N9AsxhEWC+GaX1YQ@mail.gmail.com>
 <56A251C2.101@fb.com>
 <CA+55aFwy5YJdV5Xk_Mj1niWUQeUbXUS6igNZBw710cibQfY48A@mail.gmail.com>
 <56A258F1.1060207@fb.com>
 <20160122220805.GA30907@localhost.localdomain>
Message-ID: <20160122221622.GA31221@localhost.localdomain>

On Fri, Jan 22, 2016@10:08:05PM +0000, Keith Busch wrote:
> Looks like IO ending is the only conflict. The cleanup below will
> get the functionality back.

Oh sorry, but something's actually off with this. I tested removal w/
IO using O_DIRECT by mistake, but the failure this was supposed to
fix requires using page cache. I disabled direct in the fio profile,
and now getting a hung surprise removal.

I'll have to circle back on this on Monday.

> ---
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index 72ef832..5d31cfc 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2118,6 +2118,15 @@ static void nvme_remove(struct pci_dev *pdev)
>  	pci_set_drvdata(pdev, NULL);
>  	flush_work(&dev->reset_work);
>  	flush_work(&dev->scan_work);
> +
> +	/*
> +	 * If the controller can't do IO (surprise removal, for example), we
> +	 * need to disable prior to deleting namespaces. This ends outstanding
> +	 * requests and prevents attempts to sync dirty data.
> +	 */
> +	if (nvme_io_incapable(&dev->ctrl))
> +		nvme_dev_disable(dev, true);
> +
>  	nvme_remove_namespaces(&dev->ctrl);
>  	nvme_uninit_ctrl(&dev->ctrl);
>  	nvme_dev_disable(dev, true);
> --
