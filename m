Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C3CC982FA
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Sep 2026 03:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Tcbi5MYjrLiwUZJP1iBOkaEwqrphN9t9A1anWrBn1xQ=; b=PpB1ihi0O8qOf2H/KCYYb6x5lK
	g3N1+maPVlveVP7SDCevo31U8Fgdj55MOKpQDc/BRoKHw9EDMi3g18XUxkoapt1++e3bP+hqtXHFr
	bR65zE04TSlAoTyK+QIGJc2PPf6Hus2mWAM5TXrMLStxojrRmnG4uYNvI9ZXD794T+QgJLzXvdYRS
	GK+PvG7qQgxIxvtyxcKA+seep4am3KAkHWKULpa2wGmE/MiLSonv3+XY+w+8coj7vEVI3COF1i7cY
	ctmLVhRedKn/BztseWtHsWoAGQddYZRvQuzVMLbdZfdtRT1ii4DqRG7JnuaF2BRV2PYko50Ves6Lt
	0Dw1RfXA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9DTo-000000071R5-2zPY;
	Wed, 23 Sep 2026 03:17:08 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x9DTi-000000071Pl-2Zal
	for linux-nvme@lists.infradead.org;
	Wed, 23 Sep 2026 03:17:06 +0000
Received: from PC-202605011814.localdomain (unknown [221.228.238.82])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4eceabcf6;
	Wed, 23 Sep 2026 11:16:59 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Breno Leitao <leitao@debian.org>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Runyu Xiao <runyu.xiao@seu.edu.cn>,
	Jianhao Xu <jianhao.xu@seu.edu.cn>
Subject: [PATCH v5 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Wed, 23 Sep 2026 11:16:40 +0800
Message-Id: <20260923031641.2016406-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260923031641.2016406-1-runyu.xiao@seu.edu.cn>
References: <20260923031641.2016406-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0cc443f7903a1kunmae5dc6a4b63d0
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZGkoaVkJLGBhJSU4aSBpPGlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUpVSUlDVUlIQ1VDSVlXWRYaDxIVHRRZQVlPS0hVSktISk
	9ITFVKS0tVSkJLS1kG
DKIM-Signature: a=rsa-sha256;
	b=BwYb6Gc8YZO9ie5MNryXP7j36pNofo90dkrWO7H1yStiU3h7yX1q42MdtevTXGIroHI2GQCJ30+pp1D/qQ2PolQwtn5ntY0nlX1AUy/b0+1prOQ2Vk1oMd2PmlZ/zrQ5mHjh7PselsanUkJJmRY6mACPqcml2EPTcoY+GZyECdo=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=Tcbi5MYjrLiwUZJP1iBOkaEwqrphN9t9A1anWrBn1xQ=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260922_201702_822520_A79485D4 
X-CRM114-Status: GOOD (  10.04  )
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
holds the item frag_sem. File-backed namespace enable used filp_open() on
the configured device_path, so a path into configfs could re-enter
__configfs_open_file() and try to acquire the same semaphore again.

Use configfs_file_open() so the path is resolved before opening,
configfs-backed paths are rejected, and the resolved path is opened with
file_open_root() while retaining the normal open-time permission and
security checks.

Fixes: d5eff33ee6f8 ("nvmet: add simple file backed ns support")
Cc: stable@vger.kernel.org
Reviewed-by: Christoph Hellwig <hch@lst.de>
Assisted-by: LLM Codex
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
 drivers/nvme/target/io-cmd-file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-file.c b/drivers/nvme/target/io-cmd-file.c
index 0b22d183f9279..2a4f25de94ba1 100644
--- a/drivers/nvme/target/io-cmd-file.c
+++ b/drivers/nvme/target/io-cmd-file.c
@@ -8,6 +8,7 @@
 #include <linux/uio.h>
 #include <linux/falloc.h>
 #include <linux/file.h>
+#include <linux/configfs.h>
 #include <linux/fs.h>
 #include "nvmet.h"
 
@@ -38,7 +39,7 @@ int nvmet_file_ns_enable(struct nvmet_ns *ns)
 	if (!ns->buffered_io)
 		flags |= O_DIRECT;
 
-	ns->file = filp_open(ns->device_path, flags, 0);
+	ns->file = configfs_file_open(ns->device_path, flags, 0);
 	if (IS_ERR(ns->file)) {
 		ret = PTR_ERR(ns->file);
 		pr_err("failed to open file %s: (%d)\n",
-- 
2.34.1


