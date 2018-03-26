From: logang@deltatee.com (Logan Gunthorpe)
Date: Mon, 26 Mar 2018 14:42:05 -0600
Subject: [PATCH v3 01/11] PCI/P2PDMA: Support peer-to-peer memory
In-Reply-To: <20180326193502.GI15530@mellanox.com>
References: <20180312193525.2855-1-logang@deltatee.com>
 <20180312193525.2855-2-logang@deltatee.com>
 <59fd2f5d-177f-334a-a9c4-0f8a6ec7c303@codeaurora.org>
 <24d8e5c2-065d-8bde-3f5d-7f158be9c578@deltatee.com>
 <20180326121138.00005e30@huawei.com> <20180326164129.GF15530@mellanox.com>
 <6ead7f19-c0e5-5584-2518-1e1889a007e4@deltatee.com>
 <20180326193502.GI15530@mellanox.com>
Message-ID: <45fcaa2d-214c-f0a9-94d4-b26692b9a5f3@deltatee.com>



On 26/03/18 01:35 PM, Jason Gunthorpe wrote:
> I think this is another case of the HW can do it but the SW support is
> missing. IOMMU configuration and maybe firmware too, for instance.

Nope, not sure how you can make this leap. We've been specifically told
that peer-to-peer PCIe DMA is not supported on P9. We've also been told
there is a very limited (ie. store only), low performance mode designed
for poking mailboxes but it is disabled by default and must be enable
with some kind of special firmware calls.

Logan
