From: leonro@mellanox.com (Leon Romanovsky)
Date: Thu, 6 Apr 2017 17:24:38 +0300
Subject: [PATCH v2 1/6] mlx5: convert to generic pci_alloc_irq_vectors
In-Reply-To: <1491474998-16423-2-git-send-email-sagi@grimberg.me>
References: <1491474998-16423-1-git-send-email-sagi@grimberg.me>
 <1491474998-16423-2-git-send-email-sagi@grimberg.me>
Message-ID: <20170406142438.GK2269@mtr-leonro.local>

On Thu, Apr 06, 2017@01:36:33PM +0300, Sagi Grimberg wrote:
> Now that we have a generic code to allocate an array
> of irq vectors and even correctly spread their affinity,
> correctly handle cpu hotplug events and more, were much
> better off using it.
>
> Reviewed-by: Christoph Hellwig <hch at lst.de>
> Signed-off-by: Sagi Grimberg <sagi at grimberg.me>
> ---

Thanks,
Acked-by: Leon Romanovsky <leonro at mellanox.com>
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170406/9e8a5fd9/attachment.sig>
