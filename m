Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 359CEC88E40
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 04:54:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xh7JsIVIqlqNdpmS1/fMVr20nh1KQUtlcaOcE6VOBMI=; b=pDs2vf0xJ7z8rUrTJVJeo4whVC
	ZOA3YdfG8VOGGd92Qbl2oAYnQ/RjqJWHUaK8crbThRb7a40/PGCKJxvaSFyFg0IkBXyDFl4zR86xG
	cY3kDlzx6gLOua+GYLLR9iNwGL2IrMIvkbzKuZnqjiN3Zs1ki7+LyGDfk4+z0o3YmVKzDe59DmbTn
	fp7dPUJhkN685tAb14JkyX24K4nzdb/Y52Ef/KRGwYykwYx9rGZpYoA5MNVHPE9GDe+ld5AK/QJd6
	UHiF7oCmEEBcscuMIP0bIiiDuvgCilx7A3BkGYDFssbreCF/3iB9KI3+Kb+urB3w1VVgXTddaMGBL
	hltjpG4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Wnn-0000000DPE5-2Nvr;
	Thu, 10 Sep 2026 04:54:23 +0000
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Wnk-0000000DPAg-14QE
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 04:54:22 +0000
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3a5a3cc;
	Thu, 10 Sep 2026 12:54:11 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v3 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Thu, 10 Sep 2026 12:53:59 +0800
Message-Id: <20260910045400.1201582-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
References: <20260902103202.GB8095@lst.de>
 <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089aa8dcf03a1kunm413fe85d18135f
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDShhCVhlITk0aGR8aSExJQ1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=l7QwzizMF6Qh78XoOPLh1sRc0qLZV3i91uLMhEcyX0d8TtDDnG3017L22U9hv3N0Wiq/hQXUKZtXxWjNcKKY3gOHEf07LPn6C05fcogHHjY3AueL0Vxwh5XSUkwkJHPqSyl+XF70/wkhnBhtOzEffSmnlqWg61sN6TUrDRMa3Sc=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=xh7JsIVIqlqNdpmS1/fMVr20nh1KQUtlcaOcE6VOBMI=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_215420_491416_7B60868C 
X-CRM114-Status: GOOD (  12.01  )
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

nvmet_ns_enable_store() runs as a configfs store callback while configfs
holds the item's frag_sem. A file-backed namespace then opens the
configured device_path with filp_open(). If the path resolves into
configfs, the open path re-enters __configfs_open_file() and attempts to
acquire the same frag_sem again.

Resolve the configured path first, reject paths resolved on configfs, and
open the resolved path with file_open_root(). This preserves the standard
open-time permission checks without performing a second pathname walk. Use
the configfs helper for the filesystem type check so this caller shares the
classification with other configfs users.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: stable@vger.kernel.org
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/io-cmd-file.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0b22d183f..fbe58aa4a 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -8,7 +8,9 @@
 #include <linux/uio.h>
 #include <linux/falloc.h>
 #include <linux/file.h>
+#include <linux/configfs.h>
 #include <linux/fs.h>
+#include <linux/namei.h>
 #include "nvmet.h"
 
 #define NVMET_MIN_MPOOL_OBJ		16
@@ -33,12 +35,28 @@ void nvmet_file_ns_disable(struct nvmet_ns *ns)
 int nvmet_file_ns_enable(struct nvmet_ns *ns)
 {
 	int flags = O_RDWR | O_LARGEFILE;
+	struct path path;
 	int ret = 0;
 
 	if (!ns->buffered_io)
 		flags |= O_DIRECT;
 
-	ns->file = filp_open(ns->device_path, flags, 0);
+	ret = kern_path(ns->device_path, LOOKUP_FOLLOW, &path);
+	if (ret) {
+		pr_err("failed to open file %s: (%d)\n",
+		       ns->device_path, ret);
+		return ret;
+	}
+
+	if (configfs_path_is_configfs(&path)) {
+		pr_err("configfs paths cannot back namespace %s\n",
+		       ns->device_path);
+		path_put(&path);
+		return -EINVAL;
+	}
+
+	ns->file = file_open_root(&path, "", flags, 0);
+	path_put(&path);
 	if (IS_ERR(ns->file)) {
 		ret = PTR_ERR(ns->file);
 		pr_err("failed to open file %s: (%d)\n",
-- 
2.34.1

