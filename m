From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 14:57:06 -0700
Subject: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com>
 <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
 <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
Message-ID: <43ba615f-a6e1-9444-65e1-494169cb415d@deltatee.com>



On 01/03/18 02:45 PM, Logan Gunthorpe wrote:
> It handles it fine for many situations. But when you try to map 
> something that is at the end of the physical address space then the 
> spares-vmemmap needs virtual address space that's the size of the 
> physical address space divided by PAGE_SIZE which may be a little bit 
> too large...

Though, considering this more, maybe this shouldn't be a problem...

Lets say you have 56bits of address space. That's 64PB. If you use need 
a sparse vmemmap for the entire space it will take 16TB which leaves you 
with 63.98PB of address space left. (Similar calculations for other 
numbers of address bits.)

So I'm not sure what the problem with this is.

We still have to ensure all the arches map the memory with the right 
cache bits but that should be relatively easy to solve.

Logan
