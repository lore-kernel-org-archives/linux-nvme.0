From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 15 Jan 2018 13:04:13 -0700
Subject: small CMB cleanups
In-Reply-To: <20180115153348.13105-1-hch@lst.de>
References: <20180115153348.13105-1-hch@lst.de>
Message-ID: <f2c2897e-6e70-3c8d-8c40-8da30f553abd@deltatee.com>

Hey,

I've reviewed both these patches and tested them on my p2p setup.

Reviewed-by: Logan Gunthorpe <logang at deltatee.com>

Logan

On 15/01/18 08:33 AM, Christoph Hellwig wrote:
> Hi all,
> 
> these two CMB cleanups were part of the p2p support series, but really
> are nvme specific.  Given that we're running out of time for the 4.16
> merge window, what about pulling them in through the nvme tree?
> 
