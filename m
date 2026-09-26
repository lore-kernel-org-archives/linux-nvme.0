Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D74EC98318
	for <linux-nvme@archiver.kernel.org>; Sat, 26 Sep 2026 09:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/H/LFwbci3Eh6MNU8eJOEho61nt5VkkYkF/xMDqVmas=; b=LBRSn+/tiZUGnBxyjtwBLya3Ze
	o8YEgQrTXEit15Ge637FEO4kpjwmp71HVGANfBouEDd0J6cz56D3S7cjwx5j6gs88eSO8/MXBgdIV
	YuKvX+mRbK/ehdqk9iz+C9fNUnlbUVthuxW37yL4UD62wvjkruMLLCmpi3y8RneZkN8RwMkPghZ6d
	M0MfUP35q2v+3lzvrWdYZZYQBw5NCxVyowdR14JFs+KKOE0CsSfqz1eq4SLYltcxxvmDsbXHvVf/6
	5qB+8y2jviZdl9f9/fCAOzTgH8c9+sivhGNy6+qkewujv42GtPH6YW7ctqlYj+sbsUd97RoJeRnri
	w4wDGJRA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAObd-0000000FC9G-3j0j;
	Sat, 26 Sep 2026 09:22:05 +0000
Received: from mail-m49197.qiye.163.com ([45.254.49.197])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xAOba-0000000FC7L-0MNX
	for linux-nvme@lists.infradead.org;
	Sat, 26 Sep 2026 09:22:04 +0000
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f2ff7124;
	Sat, 26 Sep 2026 17:21:59 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Breno Leitao <leitao@debian.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Logan Gunthorpe <logang@deltatee.com>,
	"Martin K. Petersen" <mkp@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Hannes Reinecke <hare@suse.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v6 3/4] nvmet: avoid recursive configfs open for passthru
Date: Sat, 26 Sep 2026 17:21:47 +0800
Message-Id: <20260926092148.128937-4-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260926092148.128937-1-runyu.xiao@seu.edu.cn>
References: <20260926092148.128937-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0dd057d8403a1kunmac953e9e17aa28
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCGk1CVh4dTUJKT0pKHhlLH1YeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=nhe3qNpXgDUMS3kn2OffuxQfVSDATnAw3eHki1sI8zzfv9M9lvdtNz2KJ8zQEqwq1JycETPsNWX5Y+ZbPlD3tsOCwJe2Z47mtH5n8sZRPEom1P6lDQRSqqA4QQrr5R8mJqiDwZxe3d/eKIaMbEyUDsHjWYE8ZfEWsigBnrT/i1A=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=/H/LFwbci3Eh6MNU8eJOEho61nt5VkkYkF/xMDqVmas=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260926_022202_296002_CB152465 
X-CRM114-Status: UNSURE (   9.76  )
X-CRM114-Notice: Please train this message.
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
configfs holds the item frag_sem. Passthru enable used filp_open() on the
configured controller path, so a path into configfs could re-enter
__configfs_open_file() and try to acquire the same semaphore again.

Use configfs_file_open() so the path is resolved before opening,
configfs-backed paths are rejected, and the resolved path is opened with
file_open_root() while retaining the normal open-time permission and
security checks.

Fixes: cae5b01a2afc ("nvmet: introduce the passthru configfs interface")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/passthru.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/passthru.c b/drivers/nvme/target/passthru.c
index fa6527c537e26..d60256004e6cf 100644
--- a/drivers/nvme/target/passthru.c
+++ b/drivers/nvme/target/passthru.c
@@ -9,6 +9,7 @@
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 #include <linux/module.h>
+#include <linux/configfs.h>
 
 #include "../host/nvme.h"
 #include "nvmet.h"
@@ -602,7 +603,7 @@ int nvmet_passthru_ctrl_enable(struct nvmet_subsys *subsys)
 		goto out_unlock;
 	}
 
-	file = filp_open(subsys->passthru_ctrl_path, O_RDWR, 0);
+	file = configfs_file_open(subsys->passthru_ctrl_path, O_RDWR, 0);
 	if (IS_ERR(file)) {
 		ret = PTR_ERR(file);
 		goto out_unlock;
-- 
2.34.1


