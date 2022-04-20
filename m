Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE2F5C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xmlR5HUFOAI8yqQFKY2MjEXGwXGx785pMDVfAqM57ow=; b=2k9IVfu/3z4O7yI0fasrSD8rpt
	hYO5jUozDmsX4q22rrRkD1wlOayjP5TcO7OIL7IYmqx35VVj3FZ51kfSAbdr0lwDoAtAR7++vf1Q1
	y2W1Gg5TvKP++ZBWyiiw3Nf7kY0lv6Bz7deAmchEZAmTzXxwd7OMQDI7WdMK426zQfKzD4QPcHtDS
	oEEwAO4khXp2nyAdETpMGX4UNWTY0EgO8ZGL+HG2MOoe02mYN7tFsEbsvIUQZnrbnGDP0Z337DZ74
	1gTtpYjnDUb03YPMNJrG1ff5ViW7wyDgYo1HsbCiSGWlNBhWrrctGKereN/6RiDlBRl+76N7ERAcf
	HpIhyvHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1xX-007GHF-JA; Wed, 20 Apr 2022 04:28:55 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wo-007FfR-41; Wed, 20 Apr 2022 04:28:10 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 14/15] blk-cgroup: cleanup blkcg_maybe_throttle_current
Date: Wed, 20 Apr 2022 06:27:22 +0200
Message-Id: <20220420042723.1010598-15-hch@lst.de>
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

Use blkcg_css instead of opencoding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 5684a8ce1f755..a91f8ae18b49b 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1808,7 +1808,6 @@ static void blkcg_maybe_throttle_blkg(struct blkcg_gq *blkg, bool use_memdelay)
 void blkcg_maybe_throttle_current(void)
 {
 	struct request_queue *q = current->throttle_queue;
-	struct cgroup_subsys_state *css;
 	struct blkcg *blkcg;
 	struct blkcg_gq *blkg;
 	bool use_memdelay = current->use_memdelay;
@@ -1820,12 +1819,7 @@ void blkcg_maybe_throttle_current(void)
 	current->use_memdelay = false;
 
 	rcu_read_lock();
-	css = kthread_blkcg();
-	if (css)
-		blkcg = css_to_blkcg(css);
-	else
-		blkcg = css_to_blkcg(task_css(current, io_cgrp_id));
-
+	blkcg = css_to_blkcg(blkcg_css());
 	if (!blkcg)
 		goto out;
 	blkg = blkg_lookup(blkcg, q);
-- 
2.30.2


