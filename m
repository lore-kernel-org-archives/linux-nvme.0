From: leon@kernel.org (Leon Romanovsky)
Date: Thu, 9 Mar 2017 10:42:45 +0200
Subject: mlx4_core 0000:07:00.0: swiotlb buffer is full and OOM observed
 during stress test on reset_controller
In-Reply-To: <20170308154815.GB24437@lst.de>
References: <1908657724.31179983.1488539944957.JavaMail.zimbra@redhat.com>
 <2013049462.31187009.1488542111040.JavaMail.zimbra@redhat.com>
 <20170305081206.GI14379@mtr-leonro.local>
 <20170308154815.GB24437@lst.de>
Message-ID: <20170309084245.GX14379@mtr-leonro.local>

On Wed, Mar 08, 2017@04:48:15PM +0100, Christoph Hellwig wrote:
> Why is that system using swiotlb?  mlx4 really doesn't have any
> weird addressing limits, does it?

As far as we know, there are not.
-------------- next part --------------
A non-text attachment was scrubbed...
Name: signature.asc
Type: application/pgp-signature
Size: 833 bytes
Desc: not available
URL: <http://lists.infradead.org/pipermail/linux-nvme/attachments/20170309/d0e567f7/attachment.sig>
