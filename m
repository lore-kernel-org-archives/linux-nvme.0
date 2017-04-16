From: benh@kernel.crashing.org (Benjamin Herrenschmidt)
Date: Mon, 17 Apr 2017 08:32:38 +1000
Subject: [RFC 0/8] Copy Offload with Peer-to-Peer PCI Memory
In-Reply-To: <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
References: <CAPcyv4it56J8Voo6kV0bBcO3nHsOHYLENpAtONJZTGceDDwNPg@mail.gmail.com>
 <6e732d6a-9baf-1768-3e9c-f6c887a836b2@deltatee.com>
Message-ID: <1492381958.25766.50.camel@kernel.crashing.org>

On Sun, 2017-04-16@10:47 -0600, Logan Gunthorpe wrote:
> > I think you need to give other archs a chance to support this with a
> > design that considers the offset case as a first class citizen rather
> > than an afterthought.
> 
> I'll consider this. Given the fact I can use your existing
> get_dev_pagemap infrastructure to look up the p2pmem device this
> probably isn't as hard as I thought it would be anyway (we probably
> don't even need a page flag). We'd just have lookup the dev_pagemap,
> test if it's a p2pmem device, and if so, call a p2pmem_dma_map function
> which could apply the offset or do any other arch specific logic (if
> necessary).

I'm still not 100% why do you need a "p2mem device" mind you ...

Cheers,
Ben.
