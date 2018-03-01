From: logang@deltatee.com (Logan Gunthorpe)
Date: Thu, 1 Mar 2018 12:30:17 -0700
Subject: [PATCH v2 00/10] Copy Offload in NVMe Fabrics with P2P PCI Memory
In-Reply-To: <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
References: <20180228234006.21093-1-logang@deltatee.com>
 <1519876489.4592.3.camel@kernel.crashing.org>
 <1519876569.4592.4.camel@au1.ibm.com>
 <CAPcyv4h7mcFphv3j_vW-CGxXa2pjQgLqpBOLzHuTzAFzygai-Q@mail.gmail.com>
Message-ID: <51bd1c37-e569-379b-0e03-a33a8b5bc94b@deltatee.com>



On 01/03/18 12:21 PM, Dan Williams wrote:
>> Note: I think the above means it won't work behind a switch on x86
>> either, will it ?
> 
> The devm_memremap_pages() infrastructure allows placing the memmap in
> "System-RAM" even if the hotplugged range is in PCI space. So, even if
> it is an issue on some configurations, it's just a simple adjustment
> to where the memmap is placed.

Thanks for the confirmation Dan!

Logan
