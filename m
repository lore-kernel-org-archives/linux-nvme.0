From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 16:19:59 -0700
Subject: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <1519945204.4592.45.camel@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519936477.4592.23.camel@au1.ibm.com>
 <CAPcyv4goHsYytq60ehJUori8Xq+Z0p8dV-8_oRALj244H4YtwQ@mail.gmail.com>
 <2079ba48-5ae5-5b44-cce1-8175712dd395@deltatee.com>
 <43ba615f-a6e1-9444-65e1-494169cb415d@deltatee.com>
 <1519945204.4592.45.camel@au1.ibm.com>
Message-ID: <595acefb-18fc-e650-e172-bae271263c4c@deltatee.com>



On 01/03/18 04:00 PM, Benjamin Herrenschmidt wrote:
> We use only 52 in practice but yes.
> 
>>   That's 64PB. If you use need
>> a sparse vmemmap for the entire space it will take 16TB which leaves you
>> with 63.98PB of address space left. (Similar calculations for other
>> numbers of address bits.)
> 
> We only have 52 bits of virtual space for the kernel with the radix
> MMU.

Ok, assuming you only have 52 bits of physical address space: the sparse 
vmemmap takes 1TB and you're left with 3.9PB of address space for other 
things. So, again, why doesn't that work? Is my math wrong?

Logan
