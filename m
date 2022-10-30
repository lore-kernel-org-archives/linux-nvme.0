Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DAE39ECAAA1
	for <linux-nvme@archiver.kernel.org>; Sun, 30 Oct 2022 16:29:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=uWYun9FId45d7X3vv8f6tQorAITzzSQpJjPrMd+Yzls=; b=xZBeumoDr+scTiVEycltQNE4A5
	uuxQk6gXToZXnnFga9Kl8bAjnVMbG2jv6lXpw4YKdNfFOVmHtAyJN1yr3oFO2FfGtJaBtV2VrAgu0
	D3Em2luEb1juEv2tCwdRmvU2UZVIT67yOT3WYzgJn8nw55Cc0OnuxoTMqR2XLRVZPEW6bUucPo1JD
	yQSJR0eyngCxkJHiRqPqndogiFn1pxrLhv/yaxw8FzWqGOv7WlV4kSYo6fKIUc5Ep0ogjU5kDUUqv
	eNVtRBsQ9Hb6zEo6gEifoyoGLeGQMD6d2yVrQD9wwOf8zPSlPHlQRtqfhe//Y4NPXU4v/c8f9ge9f
	pfF9ukvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opBBO-000VsB-2Z; Sun, 30 Oct 2022 16:29:10 +0000
Received: from 213-225-37-80.nat.highway.a1.net ([213.225.37.80] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opBBM-000VqP-R5; Sun, 30 Oct 2022 16:29:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: kbusch@kernel.org,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: implement the DEAC bit for the Write Zeroes command
Date: Sun, 30 Oct 2022 17:29:06 +0100
Message-Id: <20221030162906.3390-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
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

While the specification allows devices to either deallocate data
or to actually write zeroes on any Write Zeroes command, many SSDs
only do the sensible thing and deallocate data when the DEAC bit
is specific.  Set it when it is suppored and the caller doesn't
explicitly opt out of deallocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

BTW, I'm tempted to slap a

Fixes: 6e02318eaea5 ("nvme: add support for the Write Zeroes command")

onto this.  While it doesn't fix the Write Zeroes support per se,
it should help us with a lot of the devices timing out on Write Zeroes.

 drivers/nvme/host/core.c | 6 +++++-
 drivers/nvme/host/nvme.h | 1 +
 include/linux/nvme.h     | 1 +
 3 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 0090dc0b3ae6f..14568ae308fba 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -850,8 +850,11 @@ static inline blk_status_t nvme_setup_write_zeroes(struct nvme_ns *ns,
 	cmnd->write_zeroes.length =
 		cpu_to_le16((blk_rq_bytes(req) >> ns->lba_shift) - 1);
 
+	if (!(req->cmd_flags & REQ_NOUNMAP) && ns->dlfeat & (1 << 3))
+		cmnd->write_zeroes.control |= cpu_to_le16(NVME_WZ_DEAC);
+
 	if (nvme_ns_has_pi(ns)) {
-		cmnd->write_zeroes.control = cpu_to_le16(NVME_RW_PRINFO_PRACT);
+		cmnd->write_zeroes.control |= cpu_to_le16(NVME_RW_PRINFO_PRACT);
 
 		switch (ns->pi_type) {
 		case NVME_NS_DPS_PI_TYPE1:
@@ -2004,6 +2007,7 @@ static int nvme_update_ns_info_block(struct nvme_ns *ns,
 		}
 	}
 
+	ns->dlfeat = id->dlfeat;
 	set_disk_ro(ns->disk, nvme_ns_is_readonly(ns, info));
 	set_bit(NVME_NS_READY, &ns->flags);
 	blk_mq_unfreeze_queue(ns->disk->queue);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a29877217ee65..00d3b438efe3f 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -477,6 +477,7 @@ struct nvme_ns {
 	u32 sws;
 	u8 pi_type;
 	u8 guard_type;
+	u8 dlfeat;
 #ifdef CONFIG_BLK_DEV_ZONED
 	u64 zsze;
 #endif
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 050d7d0cd81b0..c96930b2c28fe 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -963,6 +963,7 @@ enum {
 	NVME_RW_PRINFO_PRCHK_GUARD	= 1 << 12,
 	NVME_RW_PRINFO_PRACT		= 1 << 13,
 	NVME_RW_DTYPE_STREAMS		= 1 << 4,
+	NVME_WZ_DEAC			= 1 << 9,
 };
 
 struct nvme_dsm_cmd {
-- 
2.30.2


