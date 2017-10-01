From: hch@lst.de (Christoph Hellwig)
Date: Sun, 1 Oct 2017 10:07:32 +0200
Subject: [PATCH 8/9] nvme: implement multipath access to nvme subsystems
In-Reply-To: <CADL4p-rbv8eH0UYjPkA2oTNafZgv16k0rmJEcj2=jz7yyYf8KA@mail.gmail.com>
References: <20170925134031.10548-1-hch@lst.de>
 <20170925134031.10548-9-hch@lst.de>
 <20170928155315.GK8463@localhost.localdomain>
 <CADL4p-rbv8eH0UYjPkA2oTNafZgv16k0rmJEcj2=jz7yyYf8KA@mail.gmail.com>
Message-ID: <20171001080732.GB11895@lst.de>

On Fri, Sep 29, 2017@10:21:53PM +0800, Tony Yang wrote:
> Hi, All
> 
>      Because my environment requirements, the kernel must use 4.8.17,
> I would like to ask, how to use the kernel 4.8.17 nvme multi-path?
> Because I see support for multi-path versions are above 4.13

In that case we simply can't help you.
