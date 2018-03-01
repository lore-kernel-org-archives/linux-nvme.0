From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 14:11:34 -0700
Subject: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <1519938210.4592.30.camel@au1.ibm.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
 <1519938210.4592.30.camel@au1.ibm.com>
Message-ID: <1de70207-40ce-29f0-6093-337112852475@deltatee.com>



On 01/03/18 02:03 PM, Benjamin Herrenschmidt wrote:
> However, what happens if anything calls page_address() on them ? Some
> DMA ops do that for example, or some devices might ...

Although we could probably work around it with some pain, we rely on 
page_address() and virt_to_phys(), etc to work on these pages. So on 
x86, yes, it makes it into the linear mapping.

Logan
