Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62E6EC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=bBRlU0MB4o3o14sfrZ9nIu2HZBK9cfvY6qzPJHQbEBY=; b=G3PwZwCPa84xG7gL9JQkuoCu0J
	arnhBbNTfaiyD6WLAzCADP5LoBBOGCZw1wr3ghQ00YCjz2et2ybRiljCclbFzUMKesieUJkcNqmv2
	hEPf3umU8sLmpjbKqIh1BM19rZZm//ImvHZ6Ont+wOonC/2wF3S091FQfkq8gO6g+VoC1il0cuqXJ
	Eg64XL+Q1XvpYGU6iP20cCg/vPBnZ+OFp7UkyWpCCTgiH3tpJKw9tkdVYCoYYeLEVTkZS4qGOC4He
	akhOgKc4OdD5eT0umHj8zUCMk8LANjiVciT5t+FWcLt/5BNmwGQJ/4y1ZA2XGefdinxXr5Ap10CmM
	WqDWfHNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1wd-007FXE-EU; Wed, 20 Apr 2022 04:27:59 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wQ-007FK2-EX; Wed, 20 Apr 2022 04:27:47 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 06/15] blk-cgroup: move blkcg_{pin,unpin}_online out of line
Date: Wed, 20 Apr 2022 06:27:14 +0200
Message-Id: <20220420042723.1010598-7-hch@lst.de>
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

Move these two functions out of line as there is no good reason
to inline them.  Also switch to passing a cgroup_subsys_state
instead of doing the conversion in the caller to prepare for making
the blkcg structure private to blk-cgroup.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c         | 88 ++++++++++++++++++++++++++++----------
 include/linux/blk-cgroup.h | 46 +-------------------
 mm/backing-dev.c           |  5 +--
 3 files changed, 69 insertions(+), 70 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 97266ebde975b..3af0d4a619550 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -155,6 +155,17 @@ static void blkg_async_bio_workfn(struct work_struct *work)
 		blk_finish_plug(&plug);
 }
 
+/**
+ * blkcg_parent - get the parent of a blkcg
+ * @blkcg: blkcg of interest
+ *
+ * Return the parent blkcg of @blkcg.  Can be called anytime.
+ */
+static inline struct blkcg *blkcg_parent(struct blkcg *blkcg)
+{
+	return css_to_blkcg(blkcg->css.parent);
+}
+
 /**
  * blkg_alloc - allocate a blkg
  * @blkcg: block cgroup the new blkg is associated with
@@ -1015,25 +1026,6 @@ static struct cftype blkcg_legacy_files[] = {
  *    This finally frees the blkcg.
  */
 
-/**
- * blkcg_css_offline - cgroup css_offline callback
- * @css: css of interest
- *
- * This function is called when @css is about to go away.  Here the cgwbs are
- * offlined first and only once writeback associated with the blkcg has
- * finished do we start step 2 (see above).
- */
-static void blkcg_css_offline(struct cgroup_subsys_state *css)
-{
-	struct blkcg *blkcg = css_to_blkcg(css);
-
-	/* this prevents anyone from attaching or migrating to this blkcg */
-	wb_blkcg_offline(blkcg);
-
-	/* put the base online pin allowing step 2 to be triggered */
-	blkcg_unpin_online(blkcg);
-}
-
 /**
  * blkcg_destroy_blkgs - responsible for shooting down blkgs
  * @blkcg: blkcg of interest
@@ -1045,7 +1037,7 @@ static void blkcg_css_offline(struct cgroup_subsys_state *css)
  *
  * This is the blkcg counterpart of ioc_release_fn().
  */
-void blkcg_destroy_blkgs(struct blkcg *blkcg)
+static void blkcg_destroy_blkgs(struct blkcg *blkcg)
 {
 	might_sleep();
 
@@ -1075,6 +1067,57 @@ void blkcg_destroy_blkgs(struct blkcg *blkcg)
 	spin_unlock_irq(&blkcg->lock);
 }
 
+/**
+ * blkcg_pin_online - pin online state
+ * @blkcg_css: blkcg of interest
+ *
+ * While pinned, a blkcg is kept online.  This is primarily used to
+ * impedance-match blkg and cgwb lifetimes so that blkg doesn't go offline
+ * while an associated cgwb is still active.
+ */
+void blkcg_pin_online(struct cgroup_subsys_state *blkcg_css)
+{
+	refcount_inc(&css_to_blkcg(blkcg_css)->online_pin);
+}
+
+/**
+ * blkcg_unpin_online - unpin online state
+ * @blkcg_css: blkcg of interest
+ *
+ * This is primarily used to impedance-match blkg and cgwb lifetimes so
+ * that blkg doesn't go offline while an associated cgwb is still active.
+ * When this count goes to zero, all active cgwbs have finished so the
+ * blkcg can continue destruction by calling blkcg_destroy_blkgs().
+ */
+void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css)
+{
+	struct blkcg *blkcg = css_to_blkcg(blkcg_css);
+
+	do {
+		if (!refcount_dec_and_test(&blkcg->online_pin))
+			break;
+		blkcg_destroy_blkgs(blkcg);
+		blkcg = blkcg_parent(blkcg);
+	} while (blkcg);
+}
+
+/**
+ * blkcg_css_offline - cgroup css_offline callback
+ * @css: css of interest
+ *
+ * This function is called when @css is about to go away.  Here the cgwbs are
+ * offlined first and only once writeback associated with the blkcg has
+ * finished do we start step 2 (see above).
+ */
+static void blkcg_css_offline(struct cgroup_subsys_state *css)
+{
+	/* this prevents anyone from attaching or migrating to this blkcg */
+	wb_blkcg_offline(css_to_blkcg(css));
+
+	/* put the base online pin allowing step 2 to be triggered */
+	blkcg_unpin_online(css);
+}
+
 static void blkcg_css_free(struct cgroup_subsys_state *css)
 {
 	struct blkcg *blkcg = css_to_blkcg(css);
@@ -1163,8 +1206,7 @@ blkcg_css_alloc(struct cgroup_subsys_state *parent_css)
 
 static int blkcg_css_online(struct cgroup_subsys_state *css)
 {
-	struct blkcg *blkcg = css_to_blkcg(css);
-	struct blkcg *parent = blkcg_parent(blkcg);
+	struct blkcg *parent = blkcg_parent(css_to_blkcg(css));
 
 	/*
 	 * blkcg_pin_online() is used to delay blkcg offline so that blkgs
@@ -1172,7 +1214,7 @@ static int blkcg_css_online(struct cgroup_subsys_state *css)
 	 * parent so that offline always happens towards the root.
 	 */
 	if (parent)
-		blkcg_pin_online(parent);
+		blkcg_pin_online(css);
 	return 0;
 }
 
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 988965c1c27b8..0fb7459096e9f 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -111,7 +111,6 @@ struct blkcg_gq {
 
 extern struct cgroup_subsys_state * const blkcg_root_css;
 
-void blkcg_destroy_blkgs(struct blkcg *blkcg);
 void blkcg_schedule_throttle(struct request_queue *q, bool use_memdelay);
 void blkcg_maybe_throttle_current(void);
 
@@ -136,49 +135,8 @@ static inline struct blkcg *bio_blkcg(struct bio *bio)
 }
 
 bool blk_cgroup_congested(void);
-
-/**
- * blkcg_parent - get the parent of a blkcg
- * @blkcg: blkcg of interest
- *
- * Return the parent blkcg of @blkcg.  Can be called anytime.
- */
-static inline struct blkcg *blkcg_parent(struct blkcg *blkcg)
-{
-	return css_to_blkcg(blkcg->css.parent);
-}
-
-/**
- * blkcg_pin_online - pin online state
- * @blkcg: blkcg of interest
- *
- * While pinned, a blkcg is kept online.  This is primarily used to
- * impedance-match blkg and cgwb lifetimes so that blkg doesn't go offline
- * while an associated cgwb is still active.
- */
-static inline void blkcg_pin_online(struct blkcg *blkcg)
-{
-	refcount_inc(&blkcg->online_pin);
-}
-
-/**
- * blkcg_unpin_online - unpin online state
- * @blkcg: blkcg of interest
- *
- * This is primarily used to impedance-match blkg and cgwb lifetimes so
- * that blkg doesn't go offline while an associated cgwb is still active.
- * When this count goes to zero, all active cgwbs have finished so the
- * blkcg can continue destruction by calling blkcg_destroy_blkgs().
- */
-static inline void blkcg_unpin_online(struct blkcg *blkcg)
-{
-	do {
-		if (!refcount_dec_and_test(&blkcg->online_pin))
-			break;
-		blkcg_destroy_blkgs(blkcg);
-		blkcg = blkcg_parent(blkcg);
-	} while (blkcg);
-}
+void blkcg_pin_online(struct cgroup_subsys_state *blkcg_css);
+void blkcg_unpin_online(struct cgroup_subsys_state *blkcg_css);
 
 #else	/* CONFIG_BLK_CGROUP */
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 7176af65b103a..93cddbcd4eb83 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -390,7 +390,6 @@ static void cgwb_release_workfn(struct work_struct *work)
 {
 	struct bdi_writeback *wb = container_of(work, struct bdi_writeback,
 						release_work);
-	struct blkcg *blkcg = css_to_blkcg(wb->blkcg_css);
 	struct backing_dev_info *bdi = wb->bdi;
 
 	mutex_lock(&wb->bdi->cgwb_release_mutex);
@@ -401,7 +400,7 @@ static void cgwb_release_workfn(struct work_struct *work)
 	mutex_unlock(&wb->bdi->cgwb_release_mutex);
 
 	/* triggers blkg destruction if no online users left */
-	blkcg_unpin_online(blkcg);
+	blkcg_unpin_online(wb->blkcg_css);
 
 	fprop_local_destroy_percpu(&wb->memcg_completions);
 
@@ -511,7 +510,7 @@ static int cgwb_create(struct backing_dev_info *bdi,
 			list_add_tail_rcu(&wb->bdi_node, &bdi->wb_list);
 			list_add(&wb->memcg_node, memcg_cgwb_list);
 			list_add(&wb->blkcg_node, blkcg_cgwb_list);
-			blkcg_pin_online(blkcg);
+			blkcg_pin_online(blkcg_css);
 			css_get(memcg_css);
 			css_get(blkcg_css);
 		}
-- 
2.30.2


