Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58A8AC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 08:09:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=+olszBkiXtF2+uFsUMXPBVEfhBoD69hAe5Km6a8avhY=; b=JjCWr2/Q5+d9NlOHsoZCb2fL35
	5UuheVpNQTmzdLaLOFqxfJtjC0kAhfLBQ6PgEI89MTkXreJY4iajaNN0Ox+NLKF5fGCxGgu/IXoEr
	EAecBkVoOmYQsQs1FjA3IyPW3YTnieeRQzL6iyAUmP6joMtDw2SEvc+lyUAcwEerIoH6k9sZRtyZ0
	rJPSGu8vGEFgdQRC3Z1Y6x6cFs8DHAQ/PWeiVqW9mXKME4l2WT7LOaX9Jv8PKufpMGBcDAJFp6AIO
	frp4ogbTT83N0eS9J2MYwaGqOtHAe8+5B3jnA9CckpjUxqGT6EOzt+m5pSZtSuQo44fynZGkIPxPB
	5MRgWmQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1petXL-00F7QM-2t;
	Wed, 22 Mar 2023 08:09:35 +0000
Received: from [2001:4bb8:182:9278:221e:ff1d:6e5d:b591] (helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
	id 1petXJ-00F7Pm-0X;
	Wed, 22 Mar 2023 08:09:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: sagi@grimberg.me,
	kch@nvidia.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvmet: remove nvmet_req_cns_error_complete
Date: Wed, 22 Mar 2023 09:09:30 +0100
Message-Id: <20230322080930.230269-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
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

Just fold it into the only caller.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/target/admin-cmd.c | 5 ++++-
 drivers/nvme/target/nvmet.h     | 8 --------
 2 files changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index afdf69f925997a..39cb570f833dde 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -721,7 +721,10 @@ static void nvmet_execute_identify(struct nvmet_req *req)
 		break;
 	}
 
-	nvmet_req_cns_error_complete(req);
+	pr_debug("unhandled identify cns %d on qid %d\n",
+	       req->cmd->identify.cns, req->sq->qid);
+	req->error_loc = offsetof(struct nvme_identify, cns);
+	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
 }
 
 /*
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 2c1522d4063bde..dc60a22646f783 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -687,14 +687,6 @@ static inline bool nvmet_use_inline_bvec(struct nvmet_req *req)
 	       req->sg_cnt <= NVMET_MAX_INLINE_BIOVEC;
 }
 
-static inline void nvmet_req_cns_error_complete(struct nvmet_req *req)
-{
-	pr_debug("unhandled identify cns %d on qid %d\n",
-	       req->cmd->identify.cns, req->sq->qid);
-	req->error_loc = offsetof(struct nvme_identify, cns);
-	nvmet_req_complete(req, NVME_SC_INVALID_FIELD | NVME_SC_DNR);
-}
-
 static inline void nvmet_req_bio_put(struct nvmet_req *req, struct bio *bio)
 {
 	if (bio != &req->b.inline_bio)
-- 
2.39.2


