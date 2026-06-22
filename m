Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEF08CD98F6
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 03:33:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wGGk8qU8bEqjaAy50xSnqfGwcC8PoV7IDEInkdPhPI8=; b=zlutQrUfWQAkYdAzlWMwZFPUur
	OILjJ+42QLEqPSZ6kjcFjEvP/i39cZCRqgF0UnvCpHSighD/sYzl4+z2ytEykkLLmaqiWuEa09RGH
	6NGoIUzSgJ8Lz2FSg843tB2ywwiGHe7u09s7QhYCR/wReOEtf5RrSdVhzuZULzCeVf0DQIsfyQtbL
	GIRXI4zduahPQFj0yCJOKx/1ZGC24V/VoLuHrbp5iPaaLZAivvch5aPtt7y989WmSkDIrmicM5+wG
	hvaDLNioyK7qJTO1AeGGs25fnwC3+3PrrBNDaFlRrlkKFulXFNtnk13i98T/G0WB3Vfn7/nMrzzea
	1M23h9SA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbVPK-00000004LiO-03Pd;
	Mon, 22 Jun 2026 03:33:10 +0000
Received: from out30-112.freemail.mail.aliyun.com ([115.124.30.112])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbVPG-00000004LgM-04DK
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 03:33:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782099180; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=wGGk8qU8bEqjaAy50xSnqfGwcC8PoV7IDEInkdPhPI8=;
	b=GWy7ZycZ3elcfFtKATpwwRj+VOu9riDcB0CfyG87+zHQZ1eYpMfvoz+mZKb1mz5Ddp2/Cm4Wkc3BDbhhfqmxqUupsl2vMxHk+ZX0MoBMytTghj5w04ToRCNhF/8jxDuL/0I0Cl7s6Zv0biOBdHwvNvXt23pMkh3A7SXg9q++V4g=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R941e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037033178;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0X5GuDW3_1782099174;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5GuDW3_1782099174 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 11:32:58 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: fix typos in reservation related constants
Date: Mon, 22 Jun 2026 11:32:54 +0800
Message-ID: <20260622033254.1350917-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260621_203306_549034_F73879B4 
X-CRM114-Status: GOOD (  11.28  )
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

Fix the following spelling errors:
- NVMET_PR_NOTIFI_MASK_ALL -> NVMET_PR_NOTIFY_MASK_ALL
- NVME_PR_LOG_RESERVATOIN_PREEMPTED -> NVME_PR_LOG_RESERVATION_PREEMPTED
- NVME_AEN_RESV_LOG_PAGE_AVALIABLE -> NVME_AEN_RESV_LOG_PAGE_AVAILABLE

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/pr.c | 10 +++++-----
 include/linux/nvme.h     |  4 ++--
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
index c71ae46244ff..5dd2f3553d8c 100644
--- a/drivers/nvme/target/pr.c
+++ b/drivers/nvme/target/pr.c
@@ -8,7 +8,7 @@
 #include <linux/unaligned.h>
 #include "nvmet.h"
 
-#define NVMET_PR_NOTIFI_MASK_ALL \
+#define NVMET_PR_NOTIFY_MASK_ALL \
 	(1 << NVME_PR_NOTIFY_BIT_REG_PREEMPTED | \
 	 1 << NVME_PR_NOTIFY_BIT_RESV_RELEASED | \
 	 1 << NVME_PR_NOTIFY_BIT_RESV_PREEMPTED)
@@ -44,7 +44,7 @@ u16 nvmet_set_feat_resv_notif_mask(struct nvmet_req *req, u32 mask)
 	unsigned long idx;
 	u16 status;
 
-	if (mask & ~(NVMET_PR_NOTIFI_MASK_ALL)) {
+	if (mask & ~(NVMET_PR_NOTIFY_MASK_ALL)) {
 		req->error_loc = offsetof(struct nvme_common_command, cdw11);
 		return NVME_SC_INVALID_FIELD | NVME_STATUS_DNR;
 	}
@@ -169,7 +169,7 @@ static void nvmet_pr_resv_released(struct nvmet_pr *pr, uuid_t *hostid)
 			nvmet_pr_add_resv_log(ctrl,
 				NVME_PR_LOG_RESERVATION_RELEASED, ns->nsid);
 			nvmet_add_async_event(ctrl, NVME_AER_CSS,
-				NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
+				NVME_AEN_RESV_LOG_PAGE_AVAILABLE,
 				NVME_LOG_RESERVATION);
 		}
 	}
@@ -188,7 +188,7 @@ static void nvmet_pr_send_event_to_host(struct nvmet_pr *pr, uuid_t *hostid,
 		if (uuid_equal(hostid, &ctrl->hostid)) {
 			nvmet_pr_add_resv_log(ctrl, log_type, ns->nsid);
 			nvmet_add_async_event(ctrl, NVME_AER_CSS,
-				NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
+				NVME_AEN_RESV_LOG_PAGE_AVAILABLE,
 				NVME_LOG_RESERVATION);
 		}
 	}
@@ -201,7 +201,7 @@ static void nvmet_pr_resv_preempted(struct nvmet_pr *pr, uuid_t *hostid)
 		return;
 
 	nvmet_pr_send_event_to_host(pr, hostid,
-		NVME_PR_LOG_RESERVATOIN_PREEMPTED);
+		NVME_PR_LOG_RESERVATION_PREEMPTED);
 }
 
 static void nvmet_pr_registration_preempted(struct nvmet_pr *pr,
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 041f30931a90..91ce434a7e8d 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -2272,14 +2272,14 @@ struct nvme_completion {
 #define NVME_TERTIARY(ver)	((ver) & 0xff)
 
 enum {
-	NVME_AEN_RESV_LOG_PAGE_AVALIABLE	= 0x00,
+	NVME_AEN_RESV_LOG_PAGE_AVAILABLE	= 0x00,
 };
 
 enum {
 	NVME_PR_LOG_EMPTY_LOG_PAGE			= 0x00,
 	NVME_PR_LOG_REGISTRATION_PREEMPTED		= 0x01,
 	NVME_PR_LOG_RESERVATION_RELEASED		= 0x02,
-	NVME_PR_LOG_RESERVATOIN_PREEMPTED		= 0x03,
+	NVME_PR_LOG_RESERVATION_PREEMPTED		= 0x03,
 };
 
 enum {
-- 
2.43.7


