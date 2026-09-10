Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 164BEC79FB9
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Sep 2026 04:54:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wPPMTFM/RlLKVmOG8oGw1kTaF1eOnMkGUDWNx0SoHbM=; b=uwN62l78QKxn6T1Eay4psYzlsL
	Vm+crqJtu8qTeU6ZzwQa4v6rmPDzVkAUCEsb3AQdilf3HUNyCqWxk58b26xnYF3OoUOFdkX7IACMl
	zSKkIdVoFG5L5izTUWjMa6ddvC5FoA16KUP/aicjeidAlsGqC5PtT/ebvjssYGjpoHZfAiS5W7cTO
	OG0gLDp1/Li9ghZXAtPFTLUbrceYOPZgWgNx2/3FqH4vgtn8ug5X66M9N5eJZVPK2P5tUK31Z1wX0
	mN1GJJ4RGp70+ulceTM4vxzvNyzkpZMbdolsbxSMW4BFZY8tZKPX3WN+EQHyDvTOTPGoIrxorkwe/
	PheWCR+Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Wnl-0000000DPCQ-00BN;
	Thu, 10 Sep 2026 04:54:21 +0000
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x4Wnh-0000000DPAp-1fKK
	for linux-nvme@lists.infradead.org;
	Thu, 10 Sep 2026 04:54:20 +0000
Received: from PC-202605011814.localdomain (unknown [223.112.146.162])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4d3a5a3ce;
	Thu, 10 Sep 2026 12:54:12 +0800 (GMT+08:00)
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
Subject: [PATCH v3 3/3] nvmet: avoid recursive configfs open for passthru
Date: Thu, 10 Sep 2026 12:54:00 +0800
Message-Id: <20260910045400.1201582-4-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
References: <20260902103202.GB8095@lst.de>
 <20260910045400.1201582-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa089aa943003a1kunm413fe85d181362
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHhlKVhkdSRpPS0hDTU9MTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUhVSkpJVUpPTVVKTUlZV1kWGg8SFR0UWUFZT0tIVUpLSU
	hOQ0NVSktLVUtZBg++
DKIM-Signature: a=rsa-sha256;
	b=VHpAZOtPlL/oqxx6NnJst7DEVqW4wFH1X3/fNiAwrbUptRyGG7E9+Cq/fuSkrkeeOWwLhNKrSQvNd+Vm2kRO8BgzKQ5FYK2ID95DZQXEKNbF4WVhkuVIa448msJyYUQXmA4sNIZWU/jIZPNm3I81lWOFaBQdG+7PVhBMjr+6kO0=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=wPPMTFM/RlLKVmOG8oGw1kTaF1eOnMkGUDWNx0SoHbM=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260909_215418_062651_A7D1D232 
X-CRM114-Status: GOOD (  11.68  )
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
configfs holds the item's frag_sem. Enabling passthru then opens the
configured passthru_ctrl_path with filp_open(). If that path resolves
into configfs, the open path re-enters __configfs_open_file() and attempts
to acquire the same frag_sem again.

Resolve the configured path first, reject paths resolved on configfs, and
open the resolved path with file_open_root(). This preserves the standard
open-time permission checks without performing a second pathname walk. Use
the configfs helper for the filesystem type check so this caller shares the
classification with other configfs users.

Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
Cc: stable@vger.kernel.org
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/passthru.c | 17 ++++++++++++++++-
 1 file changed, 16 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index fa6527c53..aa1778c9e 100644
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
@@ -588,6 +590,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 {
 	struct nvme_ctrl *ctrl;
 	struct file *file;
+	struct path path;
 	int ret = -EINVAL;
 	void *old;
 
@@ -602,7 +605,19 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
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
+	file = file_open_root(&path, "", O_RDWR, 0);
+	path_put(&path);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto out_unlock;
-- 
2.34.1

