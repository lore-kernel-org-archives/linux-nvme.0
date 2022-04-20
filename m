Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59A22C4167B
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:27:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pUx9E4bSsgTtsaDMfSE5EDajyzAF5/fHK6uAh8Ed1Gg=; b=DWRM5DTvhYar9lLFuXTQCnKNkp
	RxIfBKP4OdOBhybjiQYeZ1slWkD8jXyEZTqDivMOAZOVDSQnPD+Od5UJA/+wjoMdKUPvonBHuaupW
	QX118BywvPz6KwnkmsH4PuW5Ry9CVHxg0opkWNjT0k7upVJ3k1VshrgqHxXJyWptbKThh8U4Kj0SH
	LmzoubPzyOReJjEhCmsPYdPCYTHqoS0A6LbWKxxgNseqSttmPiiM1z/kSCU1JCXzX41+I3SGwxDO8
	uDFauFhjMeSBe4WnEw+ZXsEHXs58b+tL7ecFz1WKT+BEXw9Avk/3fm8cKNCmL0GrJJMyk41ELvU9r
	bC051FTg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1wF-007FEx-1F; Wed, 20 Apr 2022 04:27:35 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wB-007FBc-Fy; Wed, 20 Apr 2022 04:27:31 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 01/15] blk-cgroup: remove __bio_blkcg
Date: Wed, 20 Apr 2022 06:27:09 +0200
Message-Id: <20220420042723.1010598-2-hch@lst.de>
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

Remove the unused and deprecated __bio_blkcg helper.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.h | 23 -----------------------
 1 file changed, 23 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index 47e1e38390c96..49e88fc9cc391 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -139,27 +139,6 @@ static inline struct cgroup_subsys_state *blkcg_css(void)
 	return task_css(current, io_cgrp_id);
 }
 
-/**
- * __bio_blkcg - internal, inconsistent version to get blkcg
- *
- * DO NOT USE.
- * This function is inconsistent and consequently is dangerous to use.  The
- * first part of the function returns a blkcg where a reference is owned by the
- * bio.  This means it does not need to be rcu protected as it cannot go away
- * with the bio owning a reference to it.  However, the latter potentially gets
- * it from task_css().  This can race against task migration and the cgroup
- * dying.  It is also semantically different as it must be called rcu protected
- * and is susceptible to failure when trying to get a reference to it.
- * Therefore, it is not ok to assume that *_get() will always succeed on the
- * blkcg returned here.
- */
-static inline struct blkcg *__bio_blkcg(struct bio *bio)
-{
-	if (bio && bio->bi_blkg)
-		return bio->bi_blkg->blkcg;
-	return css_to_blkcg(blkcg_css());
-}
-
 /**
  * bio_issue_as_root_blkg - see if this bio needs to be issued as root blkg
  * @return: true if this bio needs to be submitted with the root blkg context.
@@ -471,8 +450,6 @@ static inline int blkcg_activate_policy(struct request_queue *q,
 static inline void blkcg_deactivate_policy(struct request_queue *q,
 					   const struct blkcg_policy *pol) { }
 
-static inline struct blkcg *__bio_blkcg(struct bio *bio) { return NULL; }
-
 static inline struct blkg_policy_data *blkg_to_pd(struct blkcg_gq *blkg,
 						  struct blkcg_policy *pol) { return NULL; }
 static inline struct blkcg_gq *pd_to_blkg(struct blkg_policy_data *pd) { return NULL; }
-- 
2.30.2


