Return-Path: <SRS0=hC3a=XD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE1BC4332F
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2019 15:27:13 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 72D97214D9
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Sep 2019 15:27:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ml57I7oA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 72D97214D9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=w6ZXqEf415wSDYfwUt6XvwDe8vKNMTB+1/XBgiTQiok=; b=Ml57I7oAOuBDUUxyZGB7u1fo9f
	8fAmveVl1C+rPhVyt4ZNVvYKi8q4AwCEZAgWWwBuZW+yPKe9yt0XXsfUQE7i/o9MPIaA6TuA5O5KF
	U2UAnP5qTBszYMabXDW9B4RsPo+zU4RvyVtCuvBZf3SGY5yKvXWRTpi9PWvh1tm6tbroglFr3++Hj
	XPGox9KhkguC4ZAcwwdnWY0iH0PbCvTWQDm2Qy1poyfz9w8Rv5oHSlwFqHP2ZN+Gb4mLr6mqG7y0e
	piSXRqglY1MqAHCIj1b9s1T9rM407tr21taAyn4Tj/hdKHW9tNFq6O6gpxiijYCpAmqSCOHGHsolt
	S8MKpGYg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i6z5q-0006N5-Pf; Sun, 08 Sep 2019 15:27:10 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i6z5d-00068Q-Cr
 for linux-nvme@lists.infradead.org; Sun, 08 Sep 2019 15:27:00 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 8 Sep 2019 18:26:45 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x88FQjLk011361;
 Sun, 8 Sep 2019 18:26:45 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com, 
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH v4 3/3] nvme: remove PI values definition from NVMe subsystem
Date: Sun,  8 Sep 2019 18:26:45 +0300
Message-Id: <1567956405-5585-3-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
References: <1567956405-5585-1-git-send-email-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190908_082657_834652_DAF393D6 
X-CRM114-Status: UNSURE (   8.55  )
X-CRM114-Notice: Please train this message.
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Max Gurtovoy <maxg@mellanox.com>, shlomin@mellanox.com,
 israelr@mellanox.com
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use block layer definition instead of re-defining it with the same
values.

Suggested-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---

changes from v3:
 - added Reviewed-by signature

---
 drivers/nvme/host/core.c | 12 ++++++------
 include/linux/nvme.h     |  3 ---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index bdc0a64..a1c0ce0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -663,11 +663,11 @@ static inline blk_status_t nvme_setup_rw(struct nvme_ns *ns,
 		}
 
 		switch (req->rq_disk->protection_type) {
-		case NVME_NS_DPS_PI_TYPE3:
+		case T10_PI_TYPE3_PROTECTION:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD;
 			break;
-		case NVME_NS_DPS_PI_TYPE1:
-		case NVME_NS_DPS_PI_TYPE2:
+		case T10_PI_TYPE1_PROTECTION:
+		case T10_PI_TYPE2_PROTECTION:
 			control |= NVME_RW_PRINFO_PRCHK_GUARD |
 					NVME_RW_PRINFO_PRCHK_REF;
 			cmnd->rw.reftag = cpu_to_le32(t10_pi_ref_tag(req));
@@ -1498,13 +1498,13 @@ static void nvme_init_integrity(struct gendisk *disk, u16 ms)
 
 	memset(&integrity, 0, sizeof(integrity));
 	switch (disk->protection_type) {
-	case NVME_NS_DPS_PI_TYPE3:
+	case T10_PI_TYPE3_PROTECTION:
 		integrity.profile = &t10_pi_type3_crc;
 		integrity.tag_size = sizeof(u16) + sizeof(u32);
 		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
 		break;
-	case NVME_NS_DPS_PI_TYPE1:
-	case NVME_NS_DPS_PI_TYPE2:
+	case T10_PI_TYPE1_PROTECTION:
+	case T10_PI_TYPE2_PROTECTION:
 		integrity.profile = &t10_pi_type1_crc;
 		integrity.tag_size = sizeof(u16);
 		integrity.flags |= BLK_INTEGRITY_DEVICE_CAPABLE;
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 01aa6a6..8d45c3e 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -381,9 +381,6 @@ enum {
 	NVME_NS_DPC_PI_TYPE1	= 1 << 0,
 	NVME_NS_DPS_PI_FIRST	= 1 << 3,
 	NVME_NS_DPS_PI_MASK	= 0x7,
-	NVME_NS_DPS_PI_TYPE1	= 1,
-	NVME_NS_DPS_PI_TYPE2	= 2,
-	NVME_NS_DPS_PI_TYPE3	= 3,
 };
 
 struct nvme_ns_id_desc {
-- 
1.8.3.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
