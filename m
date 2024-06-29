Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C686C27C4F
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Jun 2024 05:20:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=So3TtxdM/Pehl8mDbpH44rfDiNq+YRUG7Kvl4qjlX3s=; b=vpUXimnoGSPiOC0QlD1iF8cHeU
	G3w/z6KJdgiipSFBf2ehiKt3mAr366KoS7EZ6dluf8GmBNV7IXjqcGz8AkR3qhu38N0BJbRRp+KaS
	O/YpQ95Cww9v4OSOtg1wpnif1Ibpet4Bh7tVWHvKFqL0Vk/Lzm98EjF83gjRL5RiZhZ5Ozzx4A1XR
	VsPWAWnI98RZKFPqyBV1MFfrzmM3hOLPEvyyUMeo9Y51OifF990VuKRE/qgXsXV4w9p1mvoqMdbnI
	26sRmhDp+0XGyHsBj2Zxz5jOh2cZPq22V0Ut466LKutapQvq8uxmXQKHoP1fHOwzrOr4AsBGC0K30
	YlNm70Nw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNQVS-0000000Fw07-451S;
	Sat, 29 Jun 2024 05:20:14 +0000
Received: from verein.lst.de ([213.95.11.211])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sNQVP-0000000FvzR-1QRB
	for linux-nvme@lists.infradead.org;
	Sat, 29 Jun 2024 05:20:13 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
	id 0280A68BEB; Sat, 29 Jun 2024 07:19:58 +0200 (CEST)
Date: Sat, 29 Jun 2024 07:19:58 +0200
From: Christoph Hellwig <hch@lst.de>
To: John Garry <john.g.garry@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>, "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
	virtualization@lists.linux.dev, Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH 12/15] virtio_blk: pass queue_limits to
 blk_mq_alloc_disk
Message-ID: <20240629051958.GA15371@lst.de>
References: <20240122173645.1686078-1-hch@lst.de> <20240122173645.1686078-13-hch@lst.de> <4f515e0f-f370-4096-85a8-907942bb41fe@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4f515e0f-f370-4096-85a8-907942bb41fe@oracle.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240628_222011_548158_C1AC3917 
X-CRM114-Status: GOOD (  20.82  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, Jun 28, 2024 at 03:25:02PM +0100, John Garry wrote:
> I think that we might need a change like the following change after this:
>
> ----8<----
> [PATCH] virtio_blk: Fix default logical block size
>
> If we fail to read a logical block size in virtblk_read_limits() ->
> virtio_cread_feature(), then we default to what is in
> lim->logical_block_size, but that would be 0.
>
> We can deal with lim->logical_block_size = 0 later in the
> blk_mq_alloc_disk(), but the subsequent code in virtblk_read_limits() 
> cannot, so give a default of SECTOR_SIZE.

I think the right fix would be to initialize it where the virtio code
currently uses the uninitialized lim->logical_block_size.  That assumes
that we really want to handle this case.  If reading the block size
fails, can we really trust reading other less basic attributes?  Or
should we just fail the probe?

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 6c64a67ab9c901..5bde41505818f9 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1303,7 +1303,7 @@ static int virtblk_read_limits(struct virtio_blk *vblk,
 
 		lim->logical_block_size = blk_size;
 	} else
-		blk_size = lim->logical_block_size;
+		blk_size = SECTOR_SIZE;
 
 	/* Use topology information if available */
 	err = virtio_cread_feature(vdev, VIRTIO_BLK_F_TOPOLOGY,

