From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 5 Mar 2018 11:09:52 -0700
Subject: [PATCH v2 07/10] nvme-pci: Use PCI p2pmem subsystem to manage the
 CMB
In-Reply-To: <f4f69d48-97b2-ebeb-6c97-83878ea4c419@codeaurora.org>
References: <20180228234006.21093-1-logang@deltatee.com>
 <20180228234006.21093-8-logang@deltatee.com>
 <CAOSf1CEj1vmLLd27-642=XSnL9ODkpEC0qLHA2_W5_7rV5+4Pg@mail.gmail.com>
 <20180305160004.GA30975@localhost.localdomain>
 <3f56c76d-6a5c-7c2f-5442-c9209749b598@deltatee.com>
 <f4f69d48-97b2-ebeb-6c97-83878ea4c419@codeaurora.org>
Message-ID: <645c0d69-8942-5eb5-99ae-04ae385a32fa@deltatee.com>



On 05/03/18 11:02 AM, Sinan Kaya wrote:
> writel has a barrier inside on ARM64.
> 
> https://elixir.bootlin.com/linux/latest/source/arch/arm64/include/asm/io.h#L143

Yes, and no barrier inside memcpy_toio as it uses __raw_writes. This 
should be sufficient as we are only accessing addresses that look like 
memory and have no side effects (those enabling doorbell accesses may 
need to worry about this though). Typically, what could happen, in this 
case, is the CPU would issue writes to the BAR normally and the next 
time it programmed the DMA engine it would flush everything via the 
flush in writel.

> Why do you need another barrier?

We don't.

Thanks,

Logan
