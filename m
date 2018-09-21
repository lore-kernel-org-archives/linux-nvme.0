From: hch@lst.de (Christoph Hellwig)
Date: Fri, 21 Sep 2018 18:05:33 +0200
Subject: [PATCH v6 01/13] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <a7e2b2cb-ea35-0a97-498b-1f5753e406aa@deltatee.com>
References: <20180913001156.4115-1-logang@deltatee.com>
 <20180913001156.4115-2-logang@deltatee.com>
 <20180920223829.GD224714@bhelgaas-glaptop.roam.corp.google.com>
 <ab733346-9518-ed68-492d-e52929586293@deltatee.com>
 <20180921130010.GE224714@bhelgaas-glaptop.roam.corp.google.com>
 <a7e2b2cb-ea35-0a97-498b-1f5753e406aa@deltatee.com>
Message-ID: <20180921160533.GA26601@lst.de>

On Fri, Sep 21, 2018@09:37:33AM -0600, Logan Gunthorpe wrote:
> On 2018-09-21 7:00 AM, Bjorn Helgaas wrote:
> > On Thu, Sep 20, 2018@04:47:49PM -0600, Logan Gunthorpe wrote:
> >> On 2018-09-20 4:38 PM, Bjorn Helgaas wrote:
> >>>> +#define pr_fmt(fmt) "pci-p2pdma: " fmt
> >>>
> >>> Is pr_fmt() actually used anywhere?
> >>
> >> It's used in a Patch 4 to print errors in the configfs helpers.
> > 
> > Ideally pr_fmt() would be added in the same patch that uses it, but
> > obviously pretty trivial.
> 
> Hmm, well Christoph asked me to do it this way. ;)

Sorry.  I somehow was under the impression we already had a printk
in the earlier patch, but it looks like I was confused.
