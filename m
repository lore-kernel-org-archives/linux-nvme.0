Return-Path: <SRS0=5twQ=XA=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB8B7C43331
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:44:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A15162067B
	for <linux-nvme@archiver.kernel.org>; Thu,  5 Sep 2019 16:44:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="snx5SH1f"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A15162067B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=mellanox.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=I5PxAERYYBJjNzSFd0IL2d0iCd4MMloL73rtSd7lBuk=; b=snx5SH1fU7C3KfP4veFFWvE70c
	pTqUwE/HiAyNvjSAK57a/t8lH1drw8WCmINhz+SDHYGbD5nHdNIjEmfBfFOAxMONISv0o30Y2CbdT
	AJt1PJopIO8N7TJemU7eEllAaoU5V9w33Qffrw2B7h9xfPH0WTsndxVW/0bU9Vvx1nGVQuyN74aBv
	4W3yIwKN42y6kyc3QVsT31IERfCnZMRotP+lu2oi/2hVkokilZp8Kl4+6FsFzj9X6tP1u4Oycg+kH
	Qic/g2lcGjJuqsfdsYmwWPeInzwn8y7qScIM1E3j00a8FIOSsG0BkJ9710qSrP74rJNnCu9Riq++B
	jSchCs+g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i5us1-0006AD-I9; Thu, 05 Sep 2019 16:44:29 +0000
Received: from mail-il-dmz.mellanox.com ([193.47.165.129] helo=mellanox.co.il)
 by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
 id 1i5urf-0005bL-L5
 for linux-nvme@lists.infradead.org; Thu, 05 Sep 2019 16:44:10 +0000
Received: from Internal Mail-Server by MTLPINE1 (envelope-from
 maxg@mellanox.com)
 with ESMTPS (AES256-SHA encrypted); 5 Sep 2019 19:43:57 +0300
Received: from r-vnc12.mtr.labs.mlnx (r-vnc12.mtr.labs.mlnx [10.208.0.12])
 by labmailer.mlnx (8.13.8/8.13.8) with ESMTP id x85Ghux4018224;
 Thu, 5 Sep 2019 19:43:57 +0300
From: Max Gurtovoy <maxg@mellanox.com>
To: linux-block@vger.kernel.org, axboe@kernel.dk, martin.petersen@oracle.com, 
 linux-nvme@lists.infradead.org, keith.busch@intel.com, hch@lst.de,
 sagi@grimberg.me
Subject: [PATCH 3/3] nvme: remove PI values definition from NVMe subsystem
Date: Thu,  5 Sep 2019 19:43:56 +0300
Message-Id: <1567701836-29725-3-git-send-email-maxg@mellanox.com>
X-Mailer: git-send-email 1.7.1
In-Reply-To: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
References: <1567701836-29725-1-git-send-email-maxg@mellanox.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20190905_094408_088922_F38598FF 
X-CRM114-Status: UNSURE (   8.23  )
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
Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/nvme/host/core.c | 12 ++++++------
 include/linux/nvme.h     |  3 ---
 2 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1850ccd..0f799bd 100644
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
