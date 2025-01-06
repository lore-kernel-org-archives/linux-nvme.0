Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0173FE77198
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 10:07:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GBHr+r0gFMC9Q2LFFRVxWSRq/duhK3fuTGmy1XB+hDM=; b=ssLuJknxTjQmd5GuujiEfVLV8w
	zlUVFtNeEU/0wWx+KMaBDIkI+tylSFuSiG6s0zsDxHzbw+hhWqDH5f+jWMn2myEKwmQAbtEoK5Ux9
	tlKb3NJCt86Jk4U7Yf3Ajp7Nx8gXkLepd465UPw+nreeU1BkgUqCeBUSaUtKXVRHonUDkgeoE8VDh
	TGEOQk3oSL8fVrEd5jeKMdaBy/7EccG2aoFE6pUWYPu+6CJiGQaBVoqdA0SATFYOVIOwX/ryPj7XS
	otq9pvNbVOCGO+P2+1rashWjMZkSwoekMrGAoxLtKFCeJuokma4RkKWjNUUjEvYl+iz7UbHj/cV49
	A/78Me6w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUk0n-00000000naH-1nXp;
	Mon, 06 Jan 2025 10:07:05 +0000
Received: from 2a02-8389-2341-5b80-db6b-99e8-3feb-3b4e.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:db6b:99e8:3feb:3b4e] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98 #2 (Red Hat Linux))
	id 1tUk0m-00000000nX2-0QoC;
	Mon, 06 Jan 2025 10:07:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Nilay Shroff <nilay@linux.ibm.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	nbd@other.debian.org,
	virtualization@lists.linux.dev,
	linux-scsi@vger.kernel.org,
	usb-storage@lists.one-eyed-alien.net
Subject: [PATCH 06/10] virtio_blk: use queue_limits_commit_update_frozen in cache_type_store
Date: Mon,  6 Jan 2025 11:06:19 +0100
Message-ID: <20250106100645.850445-7-hch@lst.de>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250106100645.850445-1-hch@lst.de>
References: <20250106100645.850445-1-hch@lst.de>
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

So far cache_type_store didn't freeze the queue, fix that by using the
queue_limits_commit_update_frozen helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0a987f195630..bbaa26b523b8 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -1105,7 +1105,7 @@ cache_type_store(struct device *dev, struct device_attribute *attr,
 		lim.features |= BLK_FEAT_WRITE_CACHE;
 	else
 		lim.features &= ~BLK_FEAT_WRITE_CACHE;
-	i = queue_limits_commit_update(disk->queue, &lim);
+	i = queue_limits_commit_update_frozen(disk->queue, &lim);
 	if (i)
 		return i;
 	return count;
-- 
2.45.2


