Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 17144C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=FWpABD+wYsNJbTOYNRknLUaqgBYkljHxZCLKg/Ghs/k=; b=MoUMtwb4WDUukK07rayCe4tLmL
	O7iaZyOq5BVkWZ/x/bkHAdzV2DDw+62wliPpkDReHYwCYFhFIY2DP2HT5vC57CkgD+wCV9xKFf3Ol
	dbzKv3G74OJooYf4eSnJ79WHqhoIi+ZcHnwil/e6pl+DkIpYM9czwMdJvB68A4HfeFcUX6locxBQu
	GWt/o8rOADkL+MMwvr6vwjDvonbh3XnNCDN6bUdkTSzGCBCioKq9jyl1Du2RWeoR8rqAe8bz0WlMy
	tl5s3vjVj407NR53rVwbeju5jAQ7S6/xBp8RogUED66SUFkzo39NAQlEwqNmDpRq55Gy60YZ2I/MY
	V9uhbfJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1xk-007GR1-EI; Wed, 20 Apr 2022 04:29:08 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wq-007Fj2-TI; Wed, 20 Apr 2022 04:28:13 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 15/15] kthread: unexport kthread_blkcg
Date: Wed, 20 Apr 2022 06:27:23 +0200
Message-Id: <20220420042723.1010598-16-hch@lst.de>
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

kthread_blkcg is only used by the built-in blk-cgroup code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/kthread.h | 4 ----
 kernel/kthread.c        | 1 -
 2 files changed, 5 deletions(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index de5d75bafd665..30e5bec81d2b6 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -222,9 +222,5 @@ void kthread_associate_blkcg(struct cgroup_subsys_state *css);
 struct cgroup_subsys_state *kthread_blkcg(void);
 #else
 static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
-static inline struct cgroup_subsys_state *kthread_blkcg(void)
-{
-	return NULL;
-}
 #endif
 #endif /* _LINUX_KTHREAD_H */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 50265f69a1354..544fd40974068 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -1522,5 +1522,4 @@ struct cgroup_subsys_state *kthread_blkcg(void)
 	}
 	return NULL;
 }
-EXPORT_SYMBOL(kthread_blkcg);
 #endif
-- 
2.30.2


