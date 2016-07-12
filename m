From: hch@lst.de (Christoph Hellwig)
Date: Tue, 12 Jul 2016 11:13:00 +0200
Subject: [PATCH 07/13] pci: Provide sensible irq vector alloc/free routines
In-Reply-To: <20160711104340.GB21169@agordeev.lab.eng.brq.redhat.com>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-8-git-send-email-hch@lst.de>
 <20160706080545.GA14583@dhcp-27-118.brq.redhat.com>
 <20160710034737.GB15720@lst.de>
 <20160711104340.GB21169@agordeev.lab.eng.brq.redhat.com>
Message-ID: <20160712091300.GA4845@lst.de>

On Mon, Jul 11, 2016@12:43:41PM +0200, Alexander Gordeev wrote:
> > I diagreed - if we deprecated functions the only thing that should
> > be mentioned is a "don't use these". 
> 
> I will try to paraphrase myself. The new API deprecates pci_enable_msi*_range
> functions, but I am not that sure about others. Certainly, pci_msi*_vec_count
> and pci_enable_msi*_exact could have (and AFAIR do have) uses that can not be
> covered by automatic initialization of pci_alloc_irq_vectors().

pci_enable_msi*_exact is the equivalent of pci_enable_msi*_range
with minvecs == maxvecs and treating any return value >= 0 as 0.

I've updated the documentation so that the old usage examples are kept
around, but now use pci_alloc_irq_vectors.  I've also added a more detaild
blurb on pci_msi*_vec_count - I think there is no need for them, but
if I'm proven wrong we'll have to add a pci_irq_vector_count that handles
all interrupt types later.
