Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD034C982E1
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 09:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YtRF6Vta+5vZ+xMHLfaKypEUxsauMMO8lTqR07dKzD8=; b=HzsW1ld2SvPzvbgWZ7sYnZa7Vs
	P4JwwkCZ4RjMoXtvmPAHkDKW0VS6wub6E+U7R4RJznreq/E1VjGUqVBR9+IAlgXsetYvIrwQ49GCP
	IOO7vctzJvyKNO/Qv8G/BiXI+A909VHeDAXYTQM9m3L0IyJOWqg+wWwSB2rAjhwxygxb+Z7/SxYV9
	lIetFMYXJogbf3HwHmcx/OjYiDiTdsDmN0xJtfwUpJRIeUZML5Mec65nENFU9/6bzwFhWsR6XHweF
	hzwQXOWno9zN7A0bB4q7YVdl1bWfhes2fYKHpaLvZ+W6D8kvxLH04S4OsCsdfzcWvrpDAc26daTkz
	X/ImOm4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Zz8-00000001S6N-29tG;
	Mon, 21 Sep 2026 09:06:50 +0000
Received: from mail-m155101.qiye.163.com ([101.71.155.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Zz5-00000001S4k-0PLo
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 09:06:48 +0000
Received: from PC-202605011814.localdomain (unknown [222.191.246.242])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4e8e74662;
	Mon, 21 Sep 2026 17:06:44 +0800 (GMT+08:00)
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
Subject: [PATCH v4 2/3] nvmet: avoid recursive configfs open for file-backed namespaces
Date: Mon, 21 Sep 2026 17:05:58 +0800
Message-Id: <20260921090559.41364-3-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260921090559.41364-1-runyu.xiao@seu.edu.cn>
References: <20260921090559.41364-1-runyu.xiao@seu.edu.cn>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa0c337bb2603a1kunm2bb71b5a4117b
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDGR0eVhoaHUkYHh9CGB5KSVYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlJSUlVSkJKVUlPTVVJT0lZV1kWGg8SFR0UWUFZT0tIVUpLSE
	pPSExVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=PliqQQXEERXIZvW4UdVd0d8SiaE4qlJYWjTnJBp3/NlHEJKZRF5SZJsUJKh5WeVOS5VCa8RqDw1xPmlDcTQcfOjJq6dvrLzP168av1cGW90lfWu2tF39lGbnl8rZIEtrPl7bXSTBR+tlaqYkzxhh+5dyqgUT1hML6u5grdezJ1o=; c=relaxed/relaxed; s=default; d=seu.edu.cn; v=1;
	bh=YtRF6Vta+5vZ+xMHLfaKypEUxsauMMO8lTqR07dKzD8=;
	h=date:mime-version:subject:message-id:from;
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_020647_295213_38FF7033 
X-CRM114-Status: UNSURE (   9.91  )
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


