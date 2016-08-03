From: sagi@grimberg.me (Sagi Grimberg)
Date: Wed, 3 Aug 2016 13:02:07 +0300
Subject: [RFC 7/7] NVMe: CMB on DMA-BUF
In-Reply-To: <20160801155206.GA23224@infradead.org>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-8-git-send-email-haggaie@mellanox.com>
 <20160801155206.GA23224@infradead.org>
Message-ID: <0c87a1be-96e0-6aa2-920c-53203b5ad9dc@grimberg.me>

Hey Christoph, Haggai,

>> Allocate a CMB region to user-space as a DMA-BUF object.
>
> NACK.  Absolutely no way we're going to export a low-level device
> specific feature to userspace like that.  If you want to DMA to
> the CMB do it from the kernel, and for that we'll need a proper
> block device level API.

I think that in this patch, Haggai was aiming to demonstrate the use
of dma_buf for peer2peer transactions with an RDMA device. I agree
that the CMB example can/should be exposed in the block device level,
but I also think we'd like to generalize the way we expose a bar space
of any peer device to another peer device.

How would you suggest we do that? I think Haggai's proposal is pretty
solid (considering the fact that the vast majority of RDMA applications
live in user-space).
