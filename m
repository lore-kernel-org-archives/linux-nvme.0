Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3AB6C5DF66
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Aug 2026 14:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=AfF+O6VMncuZ2JqyZIH2RZeP5KJgvfiBK7YXB9hk6FA=; b=Dg6SYQlL39eBDxbqoy91ZNoj1z
	LldwqoKtSphoJm+2AI6GUrKZ4VBX/CnvfbsiThwlmjgw0GjMzb1K5c4vtvmhkB/Tow1BzELxgIOO5
	AnBoDviygbWsIx1zlvuUyra4mR0/mR4Z/FdAmymjhpRCl7t/SZNVLW9xVgVudUBzwvRs9kwee5TTA
	UcYi+/NMksEGfTuw+QxDGdVQ41cArPsFsU4npXw8CWjlyNwk4UnypMmSW9P5p2e4HTdu2CzIgieV+
	+2NuD1/oJq1EgpRKWvGeuocc4VxSenPtsqXAIvop87CgTSR2TsBBNKyW8y9dgr28bIy7ci7w+GI5e
	5PB9KFyA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvyT2-00000006KGV-0O86;
	Mon, 17 Aug 2026 14:37:36 +0000
Received: from [101.71.155.101] (helo=mail-m155101.qiye.163.com)
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvySy-00000006KEJ-3CF8
	for linux-nvme@lists.infradead.org;
	Mon, 17 Aug 2026 14:37:34 +0000
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a47a6f37;
	Mon, 17 Aug 2026 22:37:26 +0800 (GMT+08:00)
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
Subject: [PATCH 2/2] nvmet: avoid recursive configfs open for passthru
Date: Mon, 17 Aug 2026 22:37:14 +0800
Message-Id: <20260817143714.1344255-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01027eafc03a1kunmc75580f1e640c
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTkJPVhpMSR1JGEoZQk8dGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PJincbCRMNd6K0UNnic6L9wqQ4/9bbeX6LQFv6LQnhBWyV0ox06NcdMWRYkLHhG69RPm2h6IuHBH3r+qWK/fW2PhvcQU3JDmDLdvELQ0NzxRGwkDy6qR0zFiW40kA8VmOew+tNYm4gFgi/pywl4+Z6SPSJg6RH0hCK8epEjgHis=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=AfF+O6VMncuZ2JqyZIH2RZeP5KJgvfiBK7YXB9hk6FA=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260817_073733_044361_A3B85320 
X-CRM114-Status: GOOD (  10.95  )
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

nvmet_passthru_enable_store() runs as a configfs store callback while
configfs holds the item's frag_sem. nvmet_passthru_ctrl_enable() then
uses filp_open() on the configured passthru_ctrl_path.

If passthru_ctrl_path points back into configfs, the open path
re-enters __configfs_open_file() and tries to take the same frag_sem
again.

Resolve the path with kern_path(), reject configfs paths, and open the
resolved path with dentry_open() instead of filp_open(). Configfs paths
are not valid passthru controller backends, so rejecting them avoids
the recursion without changing valid users.

Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
Cc: stable@vger.kernel.org

Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/passthru.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index 0c361b1e3566..be302f70d0e2 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -8,6 +8,7 @@
  *
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/namei.h>
 #include <linux/module.h>
 
 #include "../host/nvme.h"
@@ -578,6 +579,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
 	struct file *file;
+	struct path path;
 	int ret = -EINVAL;
 	void *old;
 
@@ -592,7 +594,20 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	ret = kern_path(subsys->passthru_ctrl_path, LOOKUP_FOLLOW, &path);
+	if (ret)
+		goto out_unlock;
+
+	if (!strcmp(path.dentry->d_sb->s_type->name, "configfs")) {
+		pr_err("configfs paths cannot back passthru controller %s\n",
+		       subsys->passthru_ctrl_path);
+		path_put(&path);
+		ret = -EINVAL;
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

