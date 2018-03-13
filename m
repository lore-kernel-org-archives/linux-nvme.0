From: okaya@codeaurora.org (Sinan Kaya)
Date: Mon, 12 Mar 2018 23:28:17 -0400
Subject: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <20180312193525.2855-2-logang@deltatee.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
Message-ID: <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>

On 3/12/2018 3:35 PM, Logan Gunthorpe wrote:
> +int pci_p2pdma_add_client(struct list_head *head, struct device *dev)

It feels like code tried to be a generic p2pdma provider first. Then got
converted to PCI, yet all dev parameters are still struct device.

Maybe, dev parameter should also be struct pci_dev so that you can get rid of
all to_pci_dev() calls in this code including find_parent_pci_dev() function.

Regarding the switch business, It is amazing how much trouble you went into
limit this functionality into very specific hardware.

I thought that we reached to an agreement that code would not impose
any limits on what user wants.

What happened to all the emails we exchanged?

I understand you are coming from what you tested. Considering that you
are singing up for providing a generic PCI functionality into the kernel,
why don't you just blacklist the products that you had problems with and
yet still allow other architectures to use your code with their root ports?

-- 
Sinan Kaya
Qualcomm Datacenter Technologies, Inc. as an affiliate of Qualcomm Technologies, Inc.
Qualcomm Technologies, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project.
