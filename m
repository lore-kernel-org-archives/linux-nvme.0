Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1448C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:28:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uBBj2AcJgfyLk5vl6yMy/ZDB6vllaI3H675K6PqOsyQ=; b=fS87qTuZ0elDZeOPx2N8PzuC4x
	HFSKphfKyK+Re+Cxs/6Bi52lvjABLeVPPC24WwTQpxCn3Ye7lki0+2YVka1WsoU8vlUbS+M0pfghl
	9mTVvHz8reBb9CGsy11OJsxWl+yU5A9sjE7s6Cge7Xj9zn+ERSSAd3hFUt3GKd+uW/BmnyIXQ8kCu
	40LyszQSqMdlAFjoRzssZFuCEEwgKwvo+I7BO5UJo3fRbaeUc1VnQ6QEVBOTlfNCrDZuUIXwUf5lB
	kb5h7fd1Tm77tTTUOwTkRoKPFftaa+QywdK5ZiGGLdyk6K0kkJeUFl4NBdpqweS/NWDShiH78Lroe
	BDcVpHIg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1xP-007GB3-BR; Wed, 20 Apr 2022 04:28:47 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wl-007Fcr-4z; Wed, 20 Apr 2022 04:28:07 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 13/15] blk-cgroup: cleanup blk_cgroup_congested
Date: Wed, 20 Apr 2022 06:27:21 +0200
Message-Id: <20220420042723.1010598-14-hch@lst.de>
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

Use blkcg_css instead of open coding it, and switch to a slightly
more natural for loop.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.c | 6 +-----
 1 file changed, 1 insertion(+), 5 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 8da00ddc1766e..5684a8ce1f755 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -2038,15 +2038,11 @@ bool blk_cgroup_congested(void)
 	bool ret = false;
 
 	rcu_read_lock();
-	css = kthread_blkcg();
-	if (!css)
-		css = task_css(current, io_cgrp_id);
-	while (css) {
+	for (css = blkcg_css(); css; css = css->parent) {
 		if (atomic_read(&css->cgroup->congestion_count)) {
 			ret = true;
 			break;
 		}
-		css = css->parent;
 	}
 	rcu_read_unlock();
 	return ret;
-- 
2.30.2


