Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D43CACCD1AB
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Oct 2025 13:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=u9HYUgnAyW1Cs5M6I+xltY3XfJ9Xg2BRH2fQncNn2lQ=; b=qsxxQywZNPsUcSIEpEwK8MQ6xY
	H1AshDXwF5ONBGjxUFmhB6AzTh27ldMOynh6+3Dqx5G2ltGGF06QSAslGvUYmbVOOUEE/8h5fTEwI
	P4lsXC/XEjyhilDnxU9F6oI4WeZ4hXYkb0hs247klWl7lLGbuQRKkqYKfkxRybq7m9CioEKz7bYnQ
	onESmq5lhLmF3xSNxffa5XafeWC6rdkvSQep0Ch941qOsaAT1L30F2u6TIb8W7QN+AWNhjmj0F2wJ
	7ftZVwSazU/zm+IyKHTYCPfhUQdg62zPz4xaxJzlrJphQ56qt1FdyaTopFc6/qYcgLQQkeVZPqvtm
	QxMmkIEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZJ0-0000000376Q-0SMO;
	Wed, 22 Oct 2025 13:55:10 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vBZIw-0000000374x-1JK0
	for linux-nvme@lists.infradead.org;
	Wed, 22 Oct 2025 13:55:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1761141300; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=u9HYUgnAyW1Cs5M6I+xltY3XfJ9Xg2BRH2fQncNn2lQ=;
	b=Z8ELZLee4U/s3SlsaQh9EwOGfG6+7sf3d9eNyyDCtPD9hacFml7/MGrM3ODqrOmzoSscbnpq0I6+wJZ7yE/yA+4JHyfuqlXyKtYufFKapFiDwxYMh1eIiEc6EBa2wbFVUzTRs/F4ziGpIKd0l96cpVnX9qL2G5wn4JB7zEwBtCQ=
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0Wqn7dRj_1761141294 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 22 Oct 2025 21:54:58 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: introduce panic_on_double_cqe param
Date: Wed, 22 Oct 2025 21:54:54 +0800
Message-ID: <20251022135454.75767-1-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251022_065506_977290_6587847F 
X-CRM114-Status: UNSURE (   9.37  )
X-CRM114-Notice: Please train this message.
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

Add a new debug switch to control whether to trigger a kernel crash
when duplicate CQEs are detected, in order to preserve the kernel
context, such as sq, cq, and so on, for subsequent debugging and
analysis.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/host/core.c | 5 +++++
 drivers/nvme/host/nvme.h | 3 +++
 2 files changed, 8 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de73..7a3f9129a39c 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -95,6 +95,11 @@ module_param(apst_secondary_latency_tol_us, ulong, 0644);
 MODULE_PARM_DESC(apst_secondary_latency_tol_us,
 	"secondary APST latency tolerance in us");
 
+bool panic_on_double_cqe;
+EXPORT_SYMBOL_GPL(panic_on_double_cqe);
+module_param(panic_on_double_cqe, bool, 0644);
+MODULE_PARM_DESC(panic_on_double_cqe, "crash the kernel to save the scene");
+
 /*
  * Older kernels didn't enable protection information if it was at an offset.
  * Newer kernels do, so it breaks reads on the upgrade if such formats were
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 102fae6a231c..24010d5d15ce 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -595,6 +595,8 @@ static inline u16 nvme_cid(struct request *rq)
 	return nvme_cid_install_genctr(nvme_req(rq)->genctr) | rq->tag;
 }
 
+extern bool panic_on_double_cqe;
+
 static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
 		u16 command_id)
 {
@@ -612,6 +614,7 @@ static inline struct request *nvme_find_rq(struct blk_mq_tags *tags,
 		dev_err(nvme_req(rq)->ctrl->device,
 			"request %#x genctr mismatch (got %#x expected %#x)\n",
 			tag, genctr, nvme_genctr_mask(nvme_req(rq)->genctr));
+		BUG_ON(panic_on_double_cqe);
 		return NULL;
 	}
 	return rq;
-- 
2.43.0


