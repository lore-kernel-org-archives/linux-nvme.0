Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34287C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 20 Apr 2022 04:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=N20iLcUnxfvG1HpPozYt/60ZT2Vdv9e3jRTpgUOWF1w=; b=JQkilt5ZpLnNBB0KNfDGLNXSUa
	wFNiOMgpAGlDeWno2wmTXXmw7YvoaOZzrPPuukqWJg/HEKCluMzaAPn5fwF5obp9lt7meZIBIMcqr
	Qw4+2hXaUQ7cLR+AgiRYovg85cvlBafm7DF7Ti/R1awEDPnHt43JDVQZ6K32ntYzt51DncGVMhK/p
	kH4vhSY63Qp9IJ/yrTvYOVbs75Etf+hjg6QnK1MUbZ+VJGqGGjtIn5oNjFj4VQB5z6qpA83hxpmZr
	wU34bOjJsbVzDPIStiY3LrpveyjqOQTkmiV6B/5MtrZXt2I+dD0WSKzrN4szntFSEeP/pgTyw0Pmr
	I7sp4ZEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nh1xA-007FzV-9b; Wed, 20 Apr 2022 04:28:32 +0000
Received: from 089144220023.atnat0029.highway.webapn.at ([89.144.220.23]
 helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nh1wf-007FXK-8A; Wed, 20 Apr 2022 04:28:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Paolo Valente <paolo.valente@linaro.org>, Tejun Heo <tj@kernel.org>,
 James Smart <james.smart@broadcom.com>,
 Dick Kennedy <dick.kennedy@broadcom.com>, linux-block@vger.kernel.org,
 cgroups@vger.kernel.org, linux-nvme@lists.infradead.org, linux-mm@kvack.org
Subject: [PATCH 11/15] blk-cgroup: remove unneeded includes from
 <linux/blk-cgroup.h>
Date: Wed, 20 Apr 2022 06:27:19 +0200
Message-Id: <20220420042723.1010598-12-hch@lst.de>
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

Remove all the includes that aren't actually needed from
<linux/blk-cgroup.h> and push them to the actual source files where
needed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-cgroup.h         |  2 ++
 include/linux/blk-cgroup.h | 15 +++++----------
 mm/backing-dev.c           |  1 +
 mm/readahead.c             |  1 +
 mm/swapfile.c              |  1 +
 5 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/block/blk-cgroup.h b/block/blk-cgroup.h
index a948f4eb0bff8..62ed8ed50b6e3 100644
--- a/block/blk-cgroup.h
+++ b/block/blk-cgroup.h
@@ -15,6 +15,8 @@
  */
 
 #include <linux/blk-cgroup.h>
+#include <linux/cgroup.h>
+#include <linux/kthread.h>
 #include <linux/blk-mq.h>
 
 struct blkcg_gq;
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index abbfa97d6d46f..9f40dbc65f82c 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -14,16 +14,11 @@
  * 	              Nauman Rafique <nauman@google.com>
  */
 
-#include <linux/cgroup.h>
-#include <linux/percpu.h>
-#include <linux/percpu_counter.h>
-#include <linux/u64_stats_sync.h>
-#include <linux/seq_file.h>
-#include <linux/radix-tree.h>
-#include <linux/blkdev.h>
-#include <linux/atomic.h>
-#include <linux/kthread.h>
-#include <linux/fs.h>
+#include <linux/types.h>
+
+struct bio;
+struct cgroup_subsys_state;
+struct request_queue;
 
 #define FC_APPID_LEN              129
 
diff --git a/mm/backing-dev.c b/mm/backing-dev.c
index 98f8f62e52ca5..ff60bd7d74e07 100644
--- a/mm/backing-dev.c
+++ b/mm/backing-dev.c
@@ -1,5 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 
+#include <linux/blkdev.h>
 #include <linux/wait.h>
 #include <linux/rbtree.h>
 #include <linux/kthread.h>
diff --git a/mm/readahead.c b/mm/readahead.c
index 8e3775829513e..c93671a2bf0f7 100644
--- a/mm/readahead.c
+++ b/mm/readahead.c
@@ -113,6 +113,7 @@
  * ->readpage() which may be less efficient.
  */
 
+#include <linux/blkdev.h>
 #include <linux/kernel.h>
 #include <linux/dax.h>
 #include <linux/gfp.h>
diff --git a/mm/swapfile.c b/mm/swapfile.c
index a2b31fea0c42e..981a6e85c88e7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -6,6 +6,7 @@
  *  Swap reorganised 29.12.95, Stephen Tweedie
  */
 
+#include <linux/blkdev.h>
 #include <linux/mm.h>
 #include <linux/sched/mm.h>
 #include <linux/sched/task.h>
-- 
2.30.2


