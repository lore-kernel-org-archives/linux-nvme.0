Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BAABCCA0EF8
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Aug 2025 08:57:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=5aon1glvh/BW4F0+Su+6KLFJ1YGHPWAJqzpGrTtr+ag=; b=zkqjYs2mFmt0WIkb7rmYHz1Cvq
	zUVsYhRNo7jXVW4zqYApqwRWBK/FPSCszwuwcaiIpIEBm0ejBhwegin98v27scQAlByGklvnq1lD7
	rpX51p9ncrPdIBXl6bF9LUQXUr3Z6geLwaxCQfV8F1QH73EfL7U3pV1YKvdVeEIQuVHMPhwTPBmAb
	2Nji1BlqijBaKEkLkHaXTy8mfQcjTiYFbR2C2EdCwEiVicmSA1popA5mLJHGBjHVWl2ZcFzREReMS
	cFt1Kh6gp7Qwq/TRjmdz2AgejknxJ0Y7vpHZoNwQg1XMgv0fKikFFDRQv92nSfxG3TSWB0CodvLxy
	sdaztmcA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uoed4-0000000ColP-3v1Q;
	Wed, 20 Aug 2025 08:57:10 +0000
Received: from 2a02-8389-2341-5b80-d601-7564-c2e0-491c.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:d601:7564:c2e0:491c] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uodvG-0000000CgiW-1HDR;
	Wed, 20 Aug 2025 08:11:54 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	martin.petersen@oracle.com
Subject: [PATCH] nvme: fix PI insert on write
Date: Wed, 20 Aug 2025 10:11:47 +0200
Message-ID: <20250820081150.2463767-1-hch@lst.de>
X-Mailer: git-send-email 2.47.2
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

I recently ran into an issue where the PI generated using the block layer
integrity code differs from that from a kernel using the PRACT fallback
when the block layer integrity code is disabled, and I tracked this down
to us using PRACT incorrectly.

The NVM Command Set Specification (section 5.33 in 1.2, similar in older
versions) specifies the PRACT insert behavior as:

  Inserted protection information consists of the computed CRC for the
  protection information format (refer to section 5.3.1) in the Guard
  field, the LBAT field value in the Application Tag field, the LBST
  field value in the Storage Tag field, if defined, and the computed
  reference tag in the Logical Block Reference Tag.

Where the computed reference tag is defined as following for type 1 and
type 2 using the text below that is duplicated in the respective bullet
points:

  the value of the computed reference tag for the first logical block of
  the command is the value contained in the Initial Logical Block
  Reference Tag (ILBRT) or Expected Initial Logical Block Reference Tag
  (EILBRT) field in the command, and the computed reference tag is
  incremented for each subsequent logical block.

So we need to set ILBRT field, but we currently don't.  Interestingly
this works fine on my older type 1 formatted SSD, but Qemu trips up on
this.  We already set ILBRT for Write Same since commit aeb7bb061be5
("nvme: set the PRACT bit when using Write Zeroes with T10 PI").

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 9707a0e8c431..3bd6ffd1f809 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1039,6 +1039,7 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 			if (WARN_ON_ONCE(!nvme_ns_has_pi(ns->head)))
 				return BLK_STS_NOTSUPP;
 			control |= NVME_RW_PRINFO_PRACT;
+			nvme_set_ref_tag(ns, cmnd, req);
 		}
 
 		if (bio_integrity_flagged(req->bio, BIP_CHECK_GUARD))
-- 
2.47.2


