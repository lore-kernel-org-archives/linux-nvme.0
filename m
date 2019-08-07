From: helgaas@kernel.org (Bjorn Helgaas)
Date: Wed, 7 Aug 2019 14:29:19 -0500
Subject: [PATCH v2 00/14] PCI/P2PDMA: Support transactions that hit the
 host bridge
In-Reply-To: <e31f13f8-5afd-6f38-a206-163e9f77c91a@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190806234439.GW151852@google.com>
 <e31f13f8-5afd-6f38-a206-163e9f77c91a@deltatee.com>
Message-ID: <20190807192919.GY151852@google.com>

On Tue, Aug 06, 2019@06:31:07PM -0600, Logan Gunthorpe wrote:
> On 2019-08-06 5:44 p.m., Bjorn Helgaas wrote:

> > I tentatively applied these to pci/p2pdma with minor typographical
> > updates (below), but I'll update the branch if necessary.
> 
> Great, thanks! The typographical changes look good.
> 
> I already have one very minor change queued up for these. Should I just
> send you a small patch against your branch for you to squash?

Yes, an incremental patch against my branch would be nice.

Bjorn
