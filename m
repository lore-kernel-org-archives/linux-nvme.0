From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 1 Mar 2017 15:41:20 -0600
Subject: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <1488091997-12843-1-git-send-email-logang@deltatee.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
Message-ID: <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>

On Sat, Feb 25, 2017@11:53:13PM -0700, Logan Gunthorpe wrote:
> Changes since v4:
> 
> * Turns out pushing the pci release code into the device release
>   function didn't work as I would have liked. If you try to unbind the
>   device with an instance open, then you hit a kernel bug at
>   drivers/pci/msi.c:371. (This didn't occur in v3.)

This is in free_msi_irqs():

  368    for_each_pci_msi_entry(entry, dev)
  369            if (entry->irq)
  370                    for (i = 0; i < entry->nvec_used; i++)
  371                            BUG_ON(irq_has_action(entry->irq + i));

I don't think this is indicating a bug in the PCI core (although I do
think a BUG_ON() here is an excessive response).  I think it's an
indication that the driver didn't disconnect its ISR.  Without more
details of the failure it's hard to tell if the BUG_ON is a symptom of
a problem in the driver or what.

An "alive" flag feels racy, and I can't tell if it's really the best
way to deal with this, or if it's just avoiding the issue.  There must
be other drivers with the same cleanup issue -- do they handle it the
same way?

>   To solve this, we've moved the pci release code back into the
>   unregister function and reintroduced an alive flag. This time,
>   however, the alive flag is protected by mrpc_mutex and we're very
>   careful about what happens to devices still in use (they should
>   all be released through the timeout path and an ENODEV error
>   returned to userspace; while new commands are blocked with the
>   same error).
