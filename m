From: hch@lst.de (Christoph Hellwig)
Date: Fri, 8 Mar 2019 08:18:10 +0100
Subject: [PATCH 1/2] [RFC] ata: ahci: Respect bus DMA constraints
In-Reply-To: <a8b5b75f-2660-e216-033a-77808e2afb76@gmail.com>
References: <20190307000440.8708-1-marek.vasut@gmail.com>
 <7c051bbd-7835-9cab-30b2-0acde1364781@arm.com>
 <356f3ee8-407f-f865-e5cc-333695d4f857@gmail.com>
 <79e44e90-b16a-5315-e02f-101a2ebbb6a0@arm.com>
 <a8b5b75f-2660-e216-033a-77808e2afb76@gmail.com>
Message-ID: <20190308071810.GA11959@lst.de>

On Thu, Mar 07, 2019@12:14:06PM +0100, Marek Vasut wrote:
> > Right, but whoever *interprets* the device masks after the driver has
> > overridden them should be taking the (smaller) bus mask into account as
> > well, so the question is where is *that* not being done correctly?
> 
> Do you have a hint where I should look for that ?

If this a 32-bit ARM platform it might the complete lack of support
for bus_dma_mask in arch/arm/mm/dma-mapping.c..
