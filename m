From: hch@infradead.org (Christoph Hellwig)
Date: Fri, 2 Dec 2016 05:26:00 -0800
Subject: [PATCH v2] nvme/pci: Log PCI_STATUS when the controller dies
In-Reply-To: <f028ad4073488a571f2e19e19ccff0f6daa4af33.1480639321.git.luto@kernel.org>
References: <f028ad4073488a571f2e19e19ccff0f6daa4af33.1480639321.git.luto@kernel.org>
Message-ID: <20161202132600.GA2827@infradead.org>

On Thu, Dec 01, 2016@04:42:41PM -0800, Andy Lutomirski wrote:
> When debugging nvme controller crashes, it's nice to know whether
> the controller died cleanly so that the failure is just reflected in
> CSTS, it died and put an error in PCI_STATUS, or whether it died so
> badly that it stopped responding to PCI configuration space reads.

Just curious:  what controller did this happen with?

> +			/* Read a config register to help see what died. */
> +			u16 pci_status;
> +			int result;
> +
> +			result = pci_read_config_word(to_pci_dev(dev->dev),
> +						      PCI_STATUS, &pci_status);
> +			if (result == PCIBIOS_SUCCESSFUL)
> +				dev_warn(dev->dev,
> +					 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
> +					 csts, pci_status);
> +			else
> +				dev_warn(dev->dev,
> +					 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
> +					 csts, result);
> +		}

Can you factor all this debug code into a separate function to keep
the main flow easier to read?

Except for that this patch looks fine to me:

Reviewed-by: Christoph Hellwig <hch at lst.de>
