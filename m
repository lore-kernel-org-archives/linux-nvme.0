Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3799C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SNly7Jwe/4q/B3a1kzOX1/36o22AU8SRE+zg1tBGQ9U=; b=fr5hU9gODHSivYAdM68ZVdw8DB
	E9NEhTJdRGhz8J4AwjcMfCob/ZvBNp+ON4O4MG3+qsTPVurvbQN2rSY3Q65ab9yMiPipbMJLLiCo6
	zWN+AFEH/pJP55thaItyUMx4lgl5YF3w0y++P0vH4aJT+xx8Yfsya0+naVlRgm9UHTUngYcl9zNOJ
	J6deetAE8mpbrFRNK5hlNs/dLu73xbXp9cJLDn00l18Y0Kkh+PO8sHyZRh4R1XnGcy+codWvjEZ00
	02HfoJ4vQNp9U/nJsAyPbb8MXwqdBf4KePwrz0fagelHTv5dXlbaNXpW3jpCWLK96x75x/GoD1UiC
	x6xtzMhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1wY-007FSf-A2; Wed, 20 Apr 2022 04:27:54 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wN-007FII-G2; Wed, 20 Apr 2022 04:27:44 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 05/15] blk-cgroup: move blk_cgroup_congested out line
Date: Wed, 20 Apr 2022 06:27:13 +0200
Message-Id: <20220420042723.1010598-6-hch@lst.de>
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

There is no urgent need to inline this function, so move it out of line.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         | 20 ++++++++++++++++++++
 include/linux/blk-cgroup.h | 20 +-------------------
 2 files changed, 21 insertions(+), 19 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8dfe62786cd5f..97266ebde975b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1950,6 +1950,26 @@ void blk_cgroup_bio_start(struct bio *bio)
 	put_cpu();
 }
 
+bool blk_cgroup_congested(void)
+{
+	struct cgroup_subsys_state *css;
+	bool ret = false;
+
+	rcu_read_lock();
+	css = kthread_blkcg();
+	if (!css)
+		css = task_css(current, io_cgrp_id);
+	while (css) {
+		if (atomic_read(&css->cgroup->congestion_count)) {
+			ret = true;
+			break;
+		}
+		css = css->parent;
+	}
+	rcu_read_unlock();
+	return ret;
+}
+
 static int __init blkcg_init(void)
 {
 	blkcg_punt_bio_wq = alloc_workqueue("blkcg_punt_bio",
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 7a2f7de30173c..988965c1c27b8 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -135,25 +135,7 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 	return NULL;
 }
 
-static inline bool blk_cgroup_congested(void)
-{
-	struct cgroup_subsys_state *css;
-	bool ret = false;
-
-	rcu_read_lock();
-	css = kthread_blkcg();
-	if (!css)
-		css = task_css(current, io_cgrp_id);
-	while (css) {
-		if (atomic_read(&css->cgroup->congestion_count)) {
-			ret = true;
-			break;
-		}
-		css = css->parent;
-	}
-	rcu_read_unlock();
-	return ret;
-}
+bool blk_cgroup_congested(void);
 
 /**
  * blkcg_parent - get the parent of a blkcg
-- 
2.30.2


