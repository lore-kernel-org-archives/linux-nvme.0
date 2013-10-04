From: agordeev@redhat.com (Alexander Gordeev)
Date: Fri, 4 Oct 2013 07:13:24 +0200
Subject: [PATCH RFC 06/77] PCI/MSI: Factor out pci_get_msi_cap() interface
In-Reply-To: <1380837174.3419.21.camel@bwh-desktop.uk.level5networks.com>
References: <cover.1380703262.git.agordeev@redhat.com>
 <9c282c4ab92731c719d161d2db6fc54ce33891d9.1380703262.git.agordeev@redhat.com>
 <1380837174.3419.21.camel@bwh-desktop.uk.level5networks.com>
Message-ID: <20131004051322.GA3577@dhcp-26-207.brq.redhat.com>

On Thu, Oct 03, 2013@10:52:54PM +0100, Ben Hutchings wrote:
> On Wed, 2013-10-02@12:48 +0200, Alexander Gordeev wrote:
> >  #ifndef CONFIG_PCI_MSI
> > +static inline int pci_get_msi_cap(struct pci_dev *dev)
> > +{
> > +	return -1;
> [...]
> 
> Shouldn't this also return -EINVAL?

Yep, all inliners here are better to return -EINVAL.
Will do unless someone speaks out against.

> Ben.

-- 
Regards,
Alexander Gordeev
agordeev at redhat.com
