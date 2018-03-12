From: corbet@lwn.net (Jonathan Corbet)
Date: Mon, 12 Mar 2018 13:41:14 -0600
Subject: [PATCH v3 05/11] PCI/P2PDMA: Add P2P DMA driver writer's
 documentation
In-Reply-To: <20180312193525.2855-6-logang@deltatee.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-6-logang@deltatee.com>
Message-ID: <20180312134114.1e4b12f8@lwn.net>

On Mon, 12 Mar 2018 13:35:19 -0600
Logan Gunthorpe <logang@deltatee.com> wrote:

> Add a restructured text file describing how to write drivers
> with support for P2P DMA transactions. The document describes
> how to use the APIs that were added in the previous few
> commits.
> 
> Also adds an index for the PCI documentation tree even though this
> is the only PCI document that has ben converted to restructured text
> at this time.

This all seems good, but...could we consider moving this documentation to
driver-api/PCI as it's converted to RST?  That would keep it together with
similar materials and bring a bit more coherence to Documentation/ as a
whole.

Thanks,

jon
