Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D9F9BC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 21:15:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=S+QOfRZAe+O58P33h28RRd/eVKnUAqLLbI2gyU+b/BM=; b=LPeBdwAkp9Drr0LOkfQRPAfUeM
	vAdpF9vnw8WABdxsPY/CTnN0S9ealkx2PTynJqRWD2bvEVgW2dHC6IyFHy1dVUX6DDgXCAgfp2/6I
	7AW55iQeMlVyUiK5ikB04KVaUv85fFDE1BUfnq7pttN+0q/SCVxtzn4cBz9LYWi3vD1+VYG5lPt7A
	lDk2XsAigguw75xHocMMnpkdFvOyFeJsv4H4F+geYFBxkglx2YCUfv3uPDoO6iC4Rv+DamVtm/ufm
	qOQF6lShwhHfPMk9AmVhFlG1n977v+SV61NSZkSlmfYUBBLHUHF8W7C7ziGV9y5D5qvHJg7qIj1CU
	zvkzzW5Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opybO-007768-PA; Tue, 01 Nov 2022 21:15:18 +0000
Received: from smtp-15.smtpout.orange.fr ([80.12.242.15] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1opybL-00772Y-B9
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 21:15:17 +0000
Received: from pop-os.home ([86.243.100.34])
	by smtp.orange.fr with ESMTPA
	id pyanoKD2rsfCIpybFoWfIh; Tue, 01 Nov 2022 22:15:10 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Tue, 01 Nov 2022 22:15:10 +0100
X-ME-IP: 86.243.100.34
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 06/30] nvme: Use kstrtobool() instead of strtobool()
Date: Tue,  1 Nov 2022 22:13:54 +0100
Message-Id: <2e8d7f2f3cb754982f5fe99f2e13cf72db9d6dba.1667336095.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
References: <cover.1667336095.git.christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_141515_546237_9A9A1671 
X-CRM114-Status: GOOD (  16.84  )
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

strtobool() is the same as kstrtobool().
However, the latter is more used within the kernel.

In order to remove strtobool() and slightly simplify kstrtox.h, switch to
the other function name.

While at it, include the corresponding header file (<linux/kstrtox.h>)

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
This patch is part of a serie that axes all usages of strtobool().
Each patch can be applied independently from the other ones.

The last patch of the serie removes the definition of strtobool().

You may not be in copy of the cover letter. So, if needed, it is available
at [1].

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
---
 drivers/nvme/host/pci.c        |  3 ++-
 drivers/nvme/target/configfs.c | 17 +++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5f1d71ac0086..7c83dfd1bca6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -15,6 +15,7 @@
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/io.h>
+#include <linux/kstrtox.h>
 #include <linux/memremap.h>
 #include <linux/mm.h>
 #include <linux/module.h>
@@ -2186,7 +2187,7 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 	bool new;
 	int ret;
 
-	if (strtobool(buf, &new) < 0)
+	if (kstrtobool(buf, &new) < 0)
 		return -EINVAL;
 
 	if (new == ndev->hmb)
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 9443ee1d4ae3..3eb8bdd4d464 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -4,6 +4,7 @@
  * Copyright (c) 2015-2016 HGST, a Western Digital Company.
  */
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/kstrtox.h>
 #include <linux/kernel.h>
 #include <linux/module.h>
 #include <linux/slab.h>
@@ -267,7 +268,7 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	bool val;
 
-	if (strtobool(page, &val))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
 	if (nvmet_is_port_enabled(port, __func__))
@@ -532,7 +533,7 @@ static ssize_t nvmet_ns_enable_store(struct config_item *item,
 	bool enable;
 	int ret = 0;
 
-	if (strtobool(page, &enable))
+	if (kstrtobool(page, &enable))
 		return -EINVAL;
 
 	if (enable)
@@ -556,7 +557,7 @@ static ssize_t nvmet_ns_buffered_io_store(struct config_item *item,
 	struct nvmet_ns *ns = to_nvmet_ns(item);
 	bool val;
 
-	if (strtobool(page, &val))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
 	mutex_lock(&ns->subsys->lock);
@@ -579,7 +580,7 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 	struct nvmet_ns *ns = to_nvmet_ns(item);
 	bool val;
 
-	if (strtobool(page, &val))
+	if (kstrtobool(page, &val))
 		return -EINVAL;
 
 	if (!val)
@@ -728,7 +729,7 @@ static ssize_t nvmet_passthru_enable_store(struct config_item *item,
 	bool enable;
 	int ret = 0;
 
-	if (strtobool(page, &enable))
+	if (kstrtobool(page, &enable))
 		return -EINVAL;
 
 	if (enable)
@@ -995,7 +996,7 @@ static ssize_t nvmet_subsys_attr_allow_any_host_store(struct config_item *item,
 	bool allow_any_host;
 	int ret = 0;
 
-	if (strtobool(page, &allow_any_host))
+	if (kstrtobool(page, &allow_any_host))
 		return -EINVAL;
 
 	down_write(&nvmet_config_sem);
@@ -1272,7 +1273,7 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 	struct nvmet_subsys *subsys = to_subsys(item);
 	bool pi_enable;
 
-	if (strtobool(page, &pi_enable))
+	if (kstrtobool(page, &pi_enable))
 		return -EINVAL;
 
 	subsys->pi_support = pi_enable;
@@ -1392,7 +1393,7 @@ static ssize_t nvmet_referral_enable_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	bool enable;
 
-	if (strtobool(page, &enable))
+	if (kstrtobool(page, &enable))
 		goto inval;
 
 	if (enable)
-- 
2.34.1


