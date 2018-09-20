From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 20 Sep 2018 16:47:49 -0600
Subject: [PATCH v6 01/13] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <20180920223829.GD224714@bhelgaas-glaptop.roam.corp.google.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-2-logang@deltatee.com>
 <20180920223829.GD224714@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <ab733346-9518-ed68-492d-e52929586293@deltatee.com>

On 2018-09-20 4:38 PM, Bjorn Helgaas wrote:
> Acked-by: Bjorn Helgaas <bhelgaas at google.com>  # PCI pieces
> 
> Mostly trivial comments below.  Thanks for persevering with this!

Thanks Bjorn. I'll make these fixes for v7 next week.
>> +#define pr_fmt(fmt) "pci-p2pdma: " fmt
> 
> Is pr_fmt() actually used anywhere?

It's used in a Patch 4 to print errors in the configfs helpers.

Logan
