Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A9FE77184
	for <linux-nvme@archiver.kernel.org>; Wed, 18 Dec 2024 02:02:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WCOIziiQc3yXhNuboxlTSddFpns8L7WWTqCYfZybbD0=; b=n+jMKpE1vF+N1IbWSpUqoIU5YV
	LJozjYGnY1G9HL/6IIrQuhw3wS3K3Rzo3tEUP4GXB/6DPaJ9tjU8QajbklSl4y+DmWuxBYcKJP1jS
	Dc8ERFaFAJxkXwTlTqwVoVvkEu3Q4zENxYFydUPd/wpEpbej4EaOrMkv/b/6HpkJSjWR/vHXb9JRM
	3cLJegg0jjvnLGkY+VCzSdIsGGV14E5HKfPBGpzKHtQgwgc5YLA+lFAMYjr4//CBYaQRGhCJ5a2Vm
	2DGZMxVpB9RxJp3NbaSMDZxokXQ5DbrNdB9zi5f1bymjzzPeL4vaNkzZxjiyf6w1AkQVXu0OPdEgQ
	oT7D5mFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjOF-0000000FLPP-0OpT;
	Wed, 18 Dec 2024 02:02:19 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.98 #2 (Red Hat Linux))
	id 1tNjO9-0000000FLOH-1IBp;
	Wed, 18 Dec 2024 02:02:13 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk,
	hch@lst.de,
	hare@suse.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	willy@infradead.org,
	dave@stgolabs.net,
	david@fromorbit.com,
	djwong@kernel.org
Cc: john.g.garry@oracle.com,
	ritesh.list@gmail.com,
	linux-fsdevel@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	linux-mm@kvack.org,
	linux-block@vger.kernel.org,
	gost.dev@samsung.com,
	p.raghav@samsung.com,
	da.gomez@samsung.com,
	kernel@pankajraghav.com,
	mcgrof@kernel.org
Subject: [PATCH 1/2] block/bdev: use helper for max block size check
Date: Tue, 17 Dec 2024 18:02:11 -0800
Message-ID: <20241218020212.3657139-2-mcgrof@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241218020212.3657139-1-mcgrof@kernel.org>
References: <20241218020212.3657139-1-mcgrof@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

We already have a helper for checking the limits on the block size
both low and high, just use that.

No functional changes.

Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 block/bdev.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index 738e3c8457e7..9d73a8fbf7f9 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -155,8 +155,7 @@ int set_blocksize(struct file *file, int size)
 	struct inode *inode = file->f_mapping->host;
 	struct block_device *bdev = I_BDEV(inode);
 
-	/* Size must be a power of two, and between 512 and PAGE_SIZE */
-	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
+	if (blk_validate_block_size(size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
-- 
2.43.0


