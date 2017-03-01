From: keith.busch@intel.com (Keith Busch)
Date: Wed, 1 Mar 2017 17:59:58 -0500
Subject: [PATCH v5 0/4] New Microsemi PCI Switch Management Driver
In-Reply-To: <84556478-c01c-0925-be75-13a61d4c8f4f@deltatee.com>
References: <1488091997-12843-1-git-send-email-logang@deltatee.com>
 <20170301214120.GA30451@bhelgaas-glaptop.roam.corp.google.com>
 <20170301222651.GA14852@localhost.localdomain>
 <84556478-c01c-0925-be75-13a61d4c8f4f@deltatee.com>
Message-ID: <20170301225958.GB14852@localhost.localdomain>

On Wed, Mar 01, 2017@03:37:03PM -0700, Logan Gunthorpe wrote:
> On 01/03/17 03:26 PM, Keith Busch wrote:
> > I think this is from using the managed device resource API to request the
> > irq actions. The scope of the resource used to be tied to the pci_dev's
> > dev, but now it's the new switchec class dev, which has a different
> > lifetime while open references exist, so it's not releasing the irq's.
> 
> The scope of the IRQ was originally tied to the pci_dev. Then in v4 I
> tied it to the switchtec device in order to try and keep using the pci
> device after unbind. This didn't work, so I switched it back to using
> the pci_dev. (This seems to be the way most drivers work anyway.)

Okay, I see. Was mistakenliy looking at v4. The v5 looks right.
