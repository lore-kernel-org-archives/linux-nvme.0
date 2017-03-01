From: keith.busch@intel.com (Keith Busch)
Date: Wed, 1 Mar 2017 17:26:51 -0500
Subject: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
Message-ID: <20170301222651.GA14852@localhost.localdomain>

On Wed, Mar 01, 2017@03:41:20PM -0600, Bjorn Helgaas wrote:
> On Sat, Feb 25, 2017@11:53:13PM -0700, Logan Gunthorpe wrote:
> > Changes since v4:
> > 
> > * Turns out pushing the pci release code into the device release
> >   function didn't work as I would have liked. If you try to unbind the
> >   device with an instance open, then you hit a kernel bug at
> >   drivers/pci/msi.c:371. (This didn't occur in v3.)
> 
> This is in free_msi_irqs():
> 
>   368    for_each_pci_msi_entry(entry, dev)
>   369            if (entry->irq)
>   370                    for (i = 0; i < entry->nvec_used; i++)
>   371                            BUG_ON(irq_has_action(entry->irq + i));
> 
> I don't think this is indicating a bug in the PCI core (although I do
> think a BUG_ON() here is an excessive response).  I think it's an
> indication that the driver didn't disconnect its ISR.  Without more
> details of the failure it's hard to tell if the BUG_ON is a symptom of
> a problem in the driver or what.
> 
> An "alive" flag feels racy, and I can't tell if it's really the best
> way to deal with this, or if it's just avoiding the issue.  There must
> be other drivers with the same cleanup issue -- do they handle it the
> same way?

I think this is from using the managed device resource API to request the
irq actions. The scope of the resource used to be tied to the pci_dev's
dev, but now it's the new switchec class dev, which has a different
lifetime while open references exist, so it's not releasing the irq's.

One thing about the BUG_ON that is confusing me is how it's getting
to free_msi_irq's BUG in v4 or v5. I don't see any part releasing the
allocated ones. Maybe the devres API is harder to use than having the
driver manage all the resources...
