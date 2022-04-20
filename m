Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31A0DC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:28:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EB24Pl6Dnuz4BZ6riMjfOVkZhFkJeCm3U5wG0haI3CE=; b=SvxVPd8b109J55tT9Hhs7VoISX
	s/XjKhdiZysAl7/JC64c817RHGkHR0W67j/5vHZcXo3cpUdRU890/MSKdZTj3+4NaZaaTVPDA2X2R
	J/Hdtz4df0qfqCoTkvQBOxu3paYhWbweTINfSb1vc+2mS77dVvDjBBlSO1Dg0X3fdEzHfuVYNs6V9
	oSykSCfzVIjrwmJ7UiB+XtGlJSNW2FtzVVLg2q1CzhkLBYIh1P4zpt0VOsro0HNFYG7ih1nz1yYfp
	tnmrjETH04OydcCrz0aM+uSuV3iuOQAeZ5f8kScyftHgJiTKA1awG1hhOfT4VO4XYeAaX4R3/oQlb
	cmNBYq3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1xJ-007G6E-Dz; Wed, 20 Apr 2022 04:28:41 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wi-007FaW-7D; Wed, 20 Apr 2022 04:28:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 12/15] blk-cgroup: move blkcg_css to blk-cgroup.c
Date: Wed, 20 Apr 2022 06:27:20 +0200
Message-Id: <20220420042723.1010598-13-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220420042723.1010598-1-hch@lst.de>
References: <20220420042723.1010598-1-hch@lst.de>
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

blkcg_css is only used in blk-cgroup.c, so move it there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 17 +++++++++++++++++
 block/blk-cgroup.h | 17 -----------------
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8e32cc494808d..8da00ddc1766e 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -59,6 +59,23 @@ static struct workqueue_struct *blkcg_punt_bio_wq;
 
 #define BLKG_DESTROY_BATCH_SIZE  64
 
+/**
+ * blkcg_css - find the current css
+ *
+ * Find the css associated with either the kthread or the current task.
+ * This may return a dying css, so it is up to the caller to use tryget logic
+ * to confirm it is alive and well.
+ */
+static struct cgroup_subsys_state *blkcg_css(void)
+{
+	struct cgroup_subsys_state *css;
+
+	css = kthread_blkcg();
+	if (css)
+		return css;
+	return task_css(current, io_cgrp_id);
+}
+
 static bool blkcg_policy_enabled(struct request_queue *q,
 				 const struct blkcg_policy *pol)
 {
diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 62ed8ed50b6e3..bb670e53a1de2 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -210,23 +210,6 @@ int blkg_conf_prep(struct blkcg *blkcg, const struct blkcg_policy *pol,
 		   char *input, struct blkg_conf_ctx *ctx);
 void blkg_conf_finish(struct blkg_conf_ctx *ctx);
 
-/**
- * blkcg_css - find the current css
- *
- * Find the css associated with either the kthread or the current task.
- * This may return a dying css, so it is up to the caller to use tryget logic
- * to confirm it is alive and well.
- */
-static inline struct cgroup_subsys_state *blkcg_css(void)
-{
-	struct cgroup_subsys_state *css;
-
-	css = kthread_blkcg();
-	if (css)
-		return css;
-	return task_css(current, io_cgrp_id);
-}
-
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
  * @return: true if this bio needs to be submitted with the root blkg context.
-- 
2.30.2


