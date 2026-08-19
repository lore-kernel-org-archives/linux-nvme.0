Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9DC1C5DF81
	for <linux-nvme@archiver.kernel.org>; Wed, 19 Aug 2026 15:52:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jZ8LIQ9IsX5SI4Y97L1IUaZXjjXymwc4snkScUx/aks=; b=ol1TUKDURJYF3pQIQhY4tlEFLs
	8CI/Z9McLCsJ1l2HF3FiTXamDQznqFFoNNiH0bQcRJ1Mc1+jBdFUgi9s49E+ZMhwDHTXKP4ns0IDo
	xjAN3JAJT18Hpf5SO6VqiwTAPvpoZEVavbRYT8LiMjEkuiK1VgKF2WZh7IwTIlZiVxJ4AYrV4xnkg
	qRFcASRJS5EUQ8PylwFhSeJHDNVfcSmsgKqMITIPKWjUaZzSnetmsZNMIPjSMhUXAzcOVXw62dipr
	4q7doBtwwjiMXs5wuvYNnKoQns6FSWYN7I7zuAOvaPOGda948CDC06iaO0iatKYF9Vzbv5O3yBLPP
	6IS9pCOw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwiav-0000000A7uN-1XSP;
	Wed, 19 Aug 2026 15:52:49 +0000
Received: from mail-m49198.qiye.163.com ([45.254.49.198])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wwias-0000000A7sq-0a4S
	for linux-nvme@lists.infradead.org;
	Wed, 19 Aug 2026 15:52:48 +0000
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4a95ff6df;
	Wed, 19 Aug 2026 23:52:43 +0800 (GMT+08:00)
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
Subject: [PATCH v2 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Wed, 19 Aug 2026 23:52:27 +0800
Message-Id: <20260819155228.84938-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
References: <20260817143714.1344255-1-runyu.xiao@seu.edu.cn>
 <20260819155228.84938-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa01ab98f8203a1kunm38a93da01445bd
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaHUxCVh5KSUkaTxhJH09JTVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=mpKv67VHtJPQgFBgJxZRmLRJC0FADyvLmsSLm0dZy/Iub6qfGqshWoE2P1/tX3+shlprVcekw8XoOWIHTc98Cb9jBIJTZ4hKJ4lVgBoZLBn8DPQzA2oYKdFnIUjCRsCa1ENJ00gmDAoL9idyyys/Vx5EpupWGH0G0Nj16rVES4Y=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=jZ8LIQ9IsX5SI4Y97L1IUaZXjjXymwc4snkScUx/aks=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260819_085246_421224_CBA4F2AC 
X-CRM114-Status: GOOD (  11.71  )
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

nvmet_ns_enable_store() runs under configfs frag_sem. If a file-backed
namespace path resolves into configfs, filp_open() can re-enter configfs
and recurse on the same semaphore.

Reject configfs-backed paths after kern_path() and open the resolved path
with dentry_open() instead.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/io-cmd-file.c | 20 +++++++++++++++++++-
 1 file changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 2d068439b129..4ba3ebb82e6a 100644
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
+	ns->file = dentry_open(&path, flags, current_cred());
+	path_put(&path);
 	if (IS_ERR(ns->file)) {
 		ret = PTR_ERR(ns->file);
 		pr_err("failed to open file %s: (%d)\n",
-- 
2.34.1

