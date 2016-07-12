From: agordeev@redhat.com (Alexander Gordeev)
Date: Tue, 12 Jul 2016 08:49:43 +0200
Subject: [PATCH 08/13] pci: spread interrupt vectors in
 pci_alloc_irq_vectors
In-Reply-To: <20160710035751.GC15720@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
 <1467621574-8277-9-git-send-email-hch@lst.de>
 <20160707110501.GA4917@dhcp-27-118.brq.redhat.com>
 <20160710035751.GC15720@lst.de>
Message-ID: <20160712064943.GB26968@agordeev.lab.eng.brq.redhat.com>

On Sun, Jul 10, 2016@05:57:51AM +0200, Christoph Hellwig wrote:
> On Thu, Jul 07, 2016@01:05:01PM +0200, Alexander Gordeev wrote:
> > irq_create_affinity_mask() bails out with no affinity in case of single
> > vector, but alloc_descs() (see below (*)) assigns the whole affinity
> > mask. It should be consistent instead.
> 
> I don't understand the comment.  If we only have one vector (of any
> kinds) there is no need to create an affinity mask, we'll leave the
> interrupt to the existing irq balancing code.

I got impression the affinity mask is assigned differently i.e. for
single MSI mode vs legacy mode. But I might be wrong here - I have to
look into the code again. Anyway, if it is the case it could be
addressed afterwards IMHO.
