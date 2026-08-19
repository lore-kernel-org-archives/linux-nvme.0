Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B026C5DF85
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ibe22cMUDWrdIKNBbA5Osf/dOdBYA7FGe74ypRustCg=; b=2FKm+40YZVNXe2QtSqv4PGEpIM
	PGCS6QNDkt3MJ5Q+gVKQzVYBYumx8yJG5nG+mJM65WRvl8vY31Ju49YvP1gIMnoUGsEUSNpfsSJ8r
	LcuzcrOY9w2Ravp7UDBOJ/0OLVQW/kg6OMk/Ls+eSJBe/76s5ObwqaasXKCzDuJbhMQBYGTli65R/
	YmyWtvWx5BFcqEuFGgmokfWCYLsyoH6lPSC/JacrdvO3IrDeDelHAIcM1SfurzrLvqNSkTJh5ZTh2
	qKetbdPQ7soVCU5yCzY2CtLHIn4g5yI3Ksdc57ANS0QIEOqNiSi4eBaPp06ashGSNxULd7vdVpR+2
	wq6pWH0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiav-0000000A7uT-1xQv;
	Wed, 19 Aug 2026 15:52:49 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiat-0000000A7tG-2TyH
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:52:48 +0000
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a95ff6e1;
	Wed, 19 Aug 2026 23:52:45 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v2 3/3] nvmet: avoid recursive configfs open for passthru
Date: Wed, 19 Aug 2026 23:52:28 +0800
Message-Id: <20260819155228.84938-4-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01ab9958f03a1kunm38a93da01445c0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaT0xJVkkaHh1JHxhCHk5NSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=MjX3Td8fO9zdpAjI8ziB+YxXTGbtgmZGeDSj11H+VqU0HQGNSzpmnqi4jak2mLRyAlaZmb5bROCEOwLBFT+o25Amklx6ClrNEVtm509XW0RXDPRv9WOm++kD6vMM8b76f/W9UO//yULlJvx/E0MOBhjcxj36WJzTY1754aKy36k=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=ibe22cMUDWrdIKNBbA5Osf/dOdBYA7FGe74ypRustCg=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_085247_837060_30232FD6 
X-CRM114-Status: GOOD (  11.40  )
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

nvmet_passthru_ctrl_enable() runs under configfs frag_sem. If the
configured passthru controller path resolves into configfs, filp_open()
can re-enter configfs and recurse on the same semaphore.

Reject configfs-backed paths after kern_path() and open the resolved path
with dentry_open() instead.

Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/passthru.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 0c361b1e3566..b3c57bf033e1 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -9,6 +9,8 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
+#include <linux/configfs.h>
+#include <linux/namei.h>
 
 #include "../host/nvme.h"
 #include "nvmet.h"
@@ -578,6 +580,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
 	struct file *file;
+	struct path path;
 	int ret = -EINVAL;
 	void *old;
 
@@ -592,7 +595,19 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	ret = kern_path(subsys->passthru_ctrl_path, LOOKUP_FOLLOW, &path);
+	if (ret)
+		goto out_unlock;
+
+	if (configfs_path_is_configfs(&path)) {
+		pr_err("configfs paths cannot back passthru controller %s\n",
+		       subsys->passthru_ctrl_path);
+		path_put(&path);
+		goto out_unlock;
+	}
+
+	file = dentry_open(&path, O_RDWR, current_cred());
+	path_put(&path);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto out_unlock;
-- 
2.34.1

