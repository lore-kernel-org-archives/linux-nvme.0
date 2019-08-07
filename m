From: hch@lst.de (Christoph Hellwig)
Date: Wed, 7 Aug 2019 07:54:55 +0200
Subject: [PATCH v2 03/14] PCI/P2PDMA: Add constants for not-supported
 result upstream_bridge_distance()
In-Reply-To: <20190730163545.4915-4-logang@deltatee.com>
References: <20190730163545.4915-1-logang@deltatee.com>
 <20190730163545.4915-4-logang@deltatee.com>
Message-ID: <20190807055455.GA6627@lst.de>

On Tue, Jul 30, 2019@10:35:34AM -0600, Logan Gunthorpe wrote:
> Add constant flags to indicate two devices are not supported or whether
> the data path goes through the host bridge instead of using the negative
> values -1 and -2.
> 
> This helps annotate the code better, but the main reason is so we
> can use the information to store the required mapping method in an
> xarray.
> 
> Signed-off-by: Logan Gunthorpe <logang at deltatee.com>
> Reviewed-by: Christian K?nig <christian.koenig at amd.com>

Is there really no way to keep the distance separate from the type of
the connection as I requested?  I think that would avoid a lot of
confusion down the road.
