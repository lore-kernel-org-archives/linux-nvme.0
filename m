From: gregkh@linuxfoundation.org (Greg Kroah-Hartman)
Date: Sat, 17 Dec 2016 23:51:41 -0800
Subject: [RFC 1/1] MicroSemi Switchtec management interface driver
In-Reply-To: <1481994562-9283-2-git-send-email-logang@deltatee.com>
References: <1481994562-9283-1-git-send-email-logang@deltatee.com>
 <1481994562-9283-2-git-send-email-logang@deltatee.com>
Message-ID: <20161218075141.GE29850@kroah.com>

On Sat, Dec 17, 2016@10:09:22AM -0700, Logan Gunthorpe wrote:
> +struct switchtec_dev {
> +	struct pci_dev *pdev;
> +	struct msix_entry *msix;
> +	struct device *dev;
> +	struct kref kref;

Why do you have a pointer to a device, yet a kref as well?  Just have
this structure embed a 'struct device' in itself, like you did for a
kref, and you will be fine.  Otherwise you are dealing with two
different sets of reference counting here, for no good reason.

> +
> +	unsigned int event_irq;
> +
> +	void __iomem *mmio;
> +	struct mrpc_regs __iomem *mmio_mrpc;
> +	struct ntb_info_regs __iomem *mmio_ntb;
> +	struct part_cfg_regs __iomem *mmio_part_cfg;
> +
> +	/*
> +	 * The mrpc mutex must be held when accessing the other
> +	 * mrpc fields
> +	 */
> +	struct mutex mrpc_mutex;
> +	struct list_head mrpc_queue;
> +	int mrpc_busy;
> +	struct work_struct mrpc_work;
> +	struct delayed_work mrpc_timeout;
> +};
> +
> +#define stdev_pdev(stdev) ((stdev)->pdev)
> +#define stdev_pdev_dev(stdev) (&stdev_pdev(stdev)->dev)
> +#define stdev_name(stdev) pci_name(stdev_pdev(stdev))
> +#define stdev_dev(stdev) ((stdev)->dev)

Ick, just open code these please.  That's a huge hint your use of the
driver model is not correct :)

thanks,

greg k-h
