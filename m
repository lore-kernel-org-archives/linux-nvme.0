From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 8 Oct 2013 09:48:26 +0200
Subject: [PATCH RFC 07/77] PCI/MSI: Re-design MSI/MSI-X interrupts
 enablement pattern
In-Reply-To: <20131007181749.GB27396@htj.dyndns.org>
References: <cover.1380703262.git.agordeev@redhat.com>
 <d8c36203ada6efbfa9f7ce92c2f713ee3b6d6b8d.1380703262.git.agordeev@redhat.com>
 <20131007181749.GB27396@htj.dyndns.org>
Message-ID: <20131008074826.GD10669@dhcp-26-207.brq.redhat.com>

On Mon, Oct 07, 2013@02:17:49PM -0400, Tejun Heo wrote:
> Hello,
> 
> On Wed, Oct 02, 2013@12:48:23PM +0200, Alexander Gordeev wrote:
> > +static int foo_driver_enable_msi(struct foo_adapter *adapter, int nvec)
> > +{
> > +	rc = pci_get_msi_cap(adapter->pdev);
> > +	if (rc < 0)
> > +		return rc;
> > +
> > +	nvec = min(nvec, rc);
> > +	if (nvec < FOO_DRIVER_MINIMUM_NVEC) {
> > +		return -ENOSPC;
> > +
> > +	rc = pci_enable_msi_block(adapter->pdev, nvec);
> > +	return rc;
> > +}
> 
> If there are many which duplicate the above pattern, it'd probably be
> worthwhile to provide a helper?  It's usually a good idea to reduce
> the amount of boilerplate code in drivers.

I wanted to limit discussion in v1 to as little changes as possible.
I 'planned' those helper(s) for a separate effort if/when the most
important change is accepted and soaked a bit.

> > @@ -975,7 +951,7 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
> >  	if (nr_entries < 0)
> >  		return nr_entries;
> >  	if (nvec > nr_entries)
> > -		return nr_entries;
> > +		return -EINVAL;
> >  
> >  	/* Check for any invalid entries */
> >  	for (i = 0; i < nvec; i++) {
> 
> If we do things this way, it breaks all drivers using this interface
> until they're converted, right?

Right. And the rest of the series does it.

> Also, it probably isn't the best idea
> to flip the behavior like this as this can go completely unnoticed (no
> compiler warning or anything, the same function just behaves
> differently).  Maybe it'd be a better idea to introduce a simpler
> interface that most can be converted to?

Well, an *other* interface is a good idea. What do you mean with the
simpler here?

> tejun

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
