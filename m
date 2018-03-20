From: hch@lst.de (Christoph Hellwig)
Date: Tue, 20 Mar 2018 08:22:55 +0100
Subject: [PATCH] nvme-pci: Fix NULL ptr deref in EEH code
In-Reply-To: <20180320002242.10416-1-mikey@neuling.org>
References: <20180320002242.10416-1-mikey@neuling.org>
Message-ID: <20180320072255.GA15059@lst.de>

On Tue, Mar 20, 2018@11:22:42AM +1100, Michael Neuling wrote:
> diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
> index b6f43b738f..404b346e3c 100644
> --- a/drivers/nvme/host/pci.c
> +++ b/drivers/nvme/host/pci.c
> @@ -2626,6 +2626,9 @@ static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
>  {
>  	struct nvme_dev *dev = pci_get_drvdata(pdev);
>  
> +	if (!dev)
> +		return PCI_ERS_RESULT_NEED_RESET;

This implies the method has been called before ->probe has been finished
or after ->remove has been called.  That would be fundamentally racy
and needs to be fixed in the PCI layer, not papered over in drivers.
