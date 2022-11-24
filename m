Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A40D2C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 24 Nov 2022 21:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=BMVbjlB+wHrttxedtCp/NyECzuG3m4NrYWQZ/eCae/c=; b=h8IMR0X0OZB6TL48Bg3wuQnwgF
	Cam5LMH8M3ZK3K5YjrhN9DhO1iFs6r5+Yi9sd2JQ9P8+DYumeh576pI/RhVNkMi+G5N7O/9LLe5y0
	X/Ps7PaljSsqUEFANuZRrPtW4RghmQjLcc+XW8poHE87ySAWbsDpEtCvCiAJnS8KYZl+yIeaTJCSd
	3kJT5+Px6cV9/vnwX0nwIDYNY902P5GCpy0JnXX4Xe+Xp+BzmkoUtqdWhvk5zAM/15FQpSj8PEdxm
	pp5rdPkWbo0jqvp9khbKAlGvqoyrwjK5ZjObIfrGeWJqp8D0P4YP2kGLclcNbvJx5kYozxd8HOb2L
	KfO62sLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyJll-00BaLv-Si; Thu, 24 Nov 2022 21:28:29 +0000
Received: from smtp-18.smtpout.orange.fr ([80.12.242.18] helo=smtp.smtpout.orange.fr)
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oyJlh-00BaKC-NF
	for linux-nvme@lists.infradead.org; Thu, 24 Nov 2022 21:28:29 +0000
Received: from pop-os.home ([86.243.100.34])
	by smtp.orange.fr with ESMTPA
	id yJlWods52CoWhyJlWo2n87; Thu, 24 Nov 2022 22:28:15 +0100
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 24 Nov 2022 22:28:15 +0100
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
Subject: [PATCH v2] nvme: Use kstrtobool() instead of strtobool()
Date: Thu, 24 Nov 2022 22:28:12 +0100
Message-Id: <5edef1b51c865faf61752c991eaf292c8a68cc01.1669324969.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221124_132825_937517_A9E1D10A 
X-CRM114-Status: GOOD (  14.96  )
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
This patch was initially part of a serie ([1]) that axed all usages of
strtobool().

It is synched with latest -next and resent as an individual patch as
requested in [2].

[1]: https://lore.kernel.org/all/cover.1667336095.git.christophe.jaillet@wanadoo.fr/
[2]: https://lore.kernel.org/all/20221102064747.GA8903@lst.de/
---
 drivers/nvme/host/pci.c        |  3 ++-
 drivers/nvme/target/configfs.c | 17 +++++++++--------
 2 files changed, 11 insertions(+), 9 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0163bfa925aa..be70229c0b94 100644
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
@@ -2185,7 +2186,7 @@ static ssize_t hmb_store(struct device *dev, struct device_attribute *attr,
 	bool new;
 	int ret;
 
-	if (strtobool(buf, &new) < 0)
+	if (kstrtobool(buf, &new) < 0)
 		return -EINVAL;
 
 	if (new == ndev->hmb)
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 6a2816f3b4e8..f14a5db3f02c 100644
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
@@ -1275,7 +1276,7 @@ static ssize_t nvmet_subsys_attr_pi_enable_store(struct config_item *item,
 	struct nvmet_subsys *subsys = to_subsys(item);
 	bool pi_enable;
 
-	if (strtobool(page, &pi_enable))
+	if (kstrtobool(page, &pi_enable))
 		return -EINVAL;
 
 	subsys->pi_support = pi_enable;
@@ -1395,7 +1396,7 @@ static ssize_t nvmet_referral_enable_store(struct config_item *item,
 	struct nvmet_port *port = to_nvmet_port(item);
 	bool enable;
 
-	if (strtobool(page, &enable))
+	if (kstrtobool(page, &enable))
 		goto inval;
 
 	if (enable)
-- 
2.34.1


