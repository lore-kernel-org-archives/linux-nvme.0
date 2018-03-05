From: helgaas@kernel.org (Bjorn Helgaas)
Date: Mon, 5 Mar 2018 16:28:21 -0600
Subject: [PATCH v2 04/10] PCI/P2PDMA: Clear ACS P2P flags for all devices
 behind switches
In-Reply-To: <bab9fb8b-1449-4b87-94de-7da26a279331@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-5-logang@deltatee.com>
 <20180301180257.GH13722@bhelgaas-glaptop.roam.corp.google.com>
 <bab9fb8b-1449-4b87-94de-7da26a279331@deltatee.com>
Message-ID: <20180305222821.GA33706@bhelgaas-glaptop.roam.corp.google.com>

On Thu, Mar 01, 2018@12:13:10PM -0700, Logan Gunthorpe wrote:
> 
> 
> On 01/03/18 11:02 AM, Bjorn Helgaas wrote:
> > >   void pci_enable_acs(struct pci_dev *dev)
> > >   {
> > > +	if (pci_p2pdma_disable_acs(dev))
> > > +		return;
> > 
> > This doesn't read naturally to me.  I do see that when
> > CONFIG_PCI_P2PDMA is not set, pci_p2pdma_disable_acs() does nothing
> > and returns 0, so we'll go ahead and try to enable ACS as before.
> > 
> > But I think it would be clearer to have an #ifdef CONFIG_PCI_P2PDMA
> > right here so it's more obvious that we only disable ACS when it's
> > selected.
> 
> I could do this... however, I wrote it this way because I've read Linus
> dislikes using #ifdef's inside function bodies and I personally agree with
> that sentiment.

I try to avoid #ifdefs too, but in this case the plain reading of the
code makes no sense (we're in a function called "enable_acs()", and
the first thing we do is call a function to "disable_acs()".

Disabling ACS is scary for all the security reasons mentioned
elsewhere, so a reader who knows what ACS does and cares about
virtualization and security *has* to go look up the definition of
pci_p2pdma_disable_acs().

If you put the #ifdef right here, then it's easier to read because we
can see that "oh, this is a special and uncommon case that I can
probably ignore".

Bjorn
