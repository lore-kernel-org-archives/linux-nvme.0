From: hch@infradead.org (Christoph Hellwig)
Date: Mon, 1 Aug 2016 08:52:06 -0700
Subject: [RFC 7/7] NVMe: CMB on DMA-BUF
In-Reply-To: <1470034653-9097-8-git-send-email-haggaie@mellanox.com>
References: <1470034653-9097-1-git-send-email-haggaie@mellanox.com>
 <1470034653-9097-8-git-send-email-haggaie@mellanox.com>
Message-ID: <20160801155206.GA23224@infradead.org>

On Mon, Aug 01, 2016@09:57:33AM +0300, Haggai Eran wrote:
> Allocate a CMB region to user-space as a DMA-BUF object.

NACK.  Absolutely no way we're going to export a low-level device
specific feature to userspace like that.  If you want to DMA to
the CMB do it from the kernel, and for that we'll need a proper
block device level API.
