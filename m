From: helgaas@kernel.org (Bjorn Helgaas)
Date: Fri, 21 Sep 2018 08:00:10 -0500
Subject: [PATCH v6 01/13] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <ab733346-9518-ed68-492d-e52929586293@deltatee.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-2-logang@deltatee.com>
 <20180920223829.GD224714@bhelgaas-glaptop.roam.corp.google.com>
 <ab733346-9518-ed68-492d-e52929586293@deltatee.com>
Message-ID: <20180921130010.GE224714@bhelgaas-glaptop.roam.corp.google.com>

On Thu, Sep 20, 2018@04:47:49PM -0600, Logan Gunthorpe wrote:
> On 2018-09-20 4:38 PM, Bjorn Helgaas wrote:
> >> +#define pr_fmt(fmt) "pci-p2pdma: " fmt
> > 
> > Is pr_fmt() actually used anywhere?
> 
> It's used in a Patch 4 to print errors in the configfs helpers.

Ideally pr_fmt() would be added in the same patch that uses it, but
obviously pretty trivial.
