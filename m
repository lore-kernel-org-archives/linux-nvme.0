Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98934C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:28:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lCOBvABRVXqvoK7YjkTVz0nyOLl8eIMjcntmO1hcFBU=; b=l5HvgqDoQlQCQpqcMhxiUPZRHE
	PA1qU32gAwS12md4y2k6/tWJMT6/GP1maTrPMoD4dOwPIn66WiBZ0F2mZMBy29KaL5Dh2l4zIVLxu
	IwiK8bwNNpCnf+R7ivDv6qcfsldVs6OAwlOn/GkghfGWX3mkQwypUA3XZjo+49BT9xnmyNFhLEBUu
	zb1/dppeRJVuygR5xuSkOTCOWzUagOnnSrUM9015YX0H9iIGVTNmHowUpUw7+SlwsaDw4wAfQls1T
	USwZbPkADY4TEC90e7ts9tSaSCo7WsZ3ocJDfEkY5hVQfcbVY22qnOpjqhjHqM1kPg4oMHTT4/Lcs
	7j42cC3A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1x3-007Fuo-G1; Wed, 20 Apr 2022 04:28:25 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wc-007FVC-8s; Wed, 20 Apr 2022 04:27:58 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 10/15] blk-cgroup: remove pointless CONFIG_BLOCK ifdefs
Date: Wed, 20 Apr 2022 06:27:18 +0200
Message-Id: <20220420042723.1010598-11-hch@lst.de>
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

No need to make BLK_CGROUP stubs conditional on CONFIG_BLOCK as they
can't be used without that.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.h         | 3 ---
 include/linux/blk-cgroup.h | 4 ----
 2 files changed, 7 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 03405ddf2a7ba..a948f4eb0bff8 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -525,8 +525,6 @@ struct blkcg_policy {
 struct blkcg {
 };
 
-#ifdef CONFIG_BLOCK
-
 static inline struct blkcg_gq *blkg_lookup(struct blkcg *blkcg, void *key) { return NULL; }
 static inline struct blkcg_gq *blk_queue_root_blkg(struct request_queue *q)
 { return NULL; }
@@ -554,7 +552,6 @@ static inline bool blk_cgroup_mergeable(struct request *rq, struct bio *bio) { r
 #define blk_queue_for_each_rl(rl, q)	\
 	for ((rl) = &(q)->root_rl; (rl); (rl) = NULL)
 
-#endif	/* CONFIG_BLOCK */
 #endif	/* CONFIG_BLK_CGROUP */
 
 #endif /* _BLK_CGROUP_PRIVATE_H */
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 97c7968e32040..abbfa97d6d46f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -44,15 +44,11 @@ struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio);
 
 static inline void blkcg_maybe_throttle_current(void) { }
 static inline bool blk_cgroup_congested(void) { return false; }
-
-#ifdef CONFIG_BLOCK
 static inline void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay) { }
 static inline struct cgroup_subsys_state *bio_blkcg_css(struct bio *bio)
 {
 	return NULL;
 }
-#endif /* CONFIG_BLOCK */
-
 #endif	/* CONFIG_BLK_CGROUP */
 
 int blkcg_set_fc_appid(char *app_id, u64 cgrp_id, size_t app_id_len);
-- 
2.30.2


