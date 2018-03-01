From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 14:45:09 -0700
Subject: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com>
 <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
Message-ID: <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>



On 01/03/18 02:37 PM, Dan Williams wrote:
> Ah ok, I'd need to look at the details. I had been assuming that
> sparse-vmemmap could handle such a situation, but that could indeed be
> a broken assumption.

It handles it fine for many situations. But when you try to map 
something that is at the end of the physical address space then the 
spares-vmemmap needs virtual address space that's the size of the 
physical address space divided by PAGE_SIZE which may be a little bit 
too large...

Logan
