From: hch@infradead.org (Christoph Hellwig)
Date: Thu, 19 Nov 2015 14:34:39 -0800
Subject: [RESEND PATCH] NVMe: Add pci error handlers
In-Reply-To: <1447966729-23141-1-git-send-email-keith.busch@intel.com>
References: <1447966729-23141-1-git-send-email-keith.busch@intel.com>
Message-ID: <20151119223439.GA17172@infradead.org>

> We've heard from a few testers that this is successful and necessary to
> recover from some errors, but this is getting more attention priority now,
> otherwise I'd have made a fuss for its inclusion earlier.


The code here seems sufficiently close to magic, so it could do with
a few comments.

>  /* These functions are yet to be implemented */
> -#define nvme_error_detected NULL
>  #define nvme_dump_registers NULL
>  #define nvme_link_reset NULL
> -#define nvme_slot_reset NULL
> -#define nvme_error_resume NULL


Can you kill the other two silly defines as well and just leave the
struct members implicitly zero initialized?

> +static pci_ers_result_t nvme_error_detected(struct pci_dev *pdev,
> +						pci_channel_state_t state)
> +{
> +	struct nvme_dev *dev = pci_get_drvdata(pdev);
> +
> +	dev_warn(&pdev->dev, "%s: state:%d\n", __func__, state);
> +	switch (state) {
> +	case pci_channel_io_normal:
> +		return PCI_ERS_RESULT_CAN_RECOVER;
> +	case pci_channel_io_frozen:
> +		nvme_dev_shutdown(dev);
> +		return PCI_ERS_RESULT_NEED_RESET;
> +	case pci_channel_io_perm_failure:
> +		return PCI_ERS_RESULT_DISCONNECT;
> +	}
> +	return PCI_ERS_RESULT_NEED_RESET;
> +}


This seems to be somewhat of a default methods used by various drivers,
and looks rather boiler plate-y.  Any reason this conversion isn't done
by core code?
