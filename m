Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EEDFC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 08:54:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=LpjGE5tDX4C27tL4gevTiKfug/67pKaBAEmk8mxP8j4=; b=qkYyNkGHlX2puhMBm3ITEX7Ju4
	YWrGWfXQlZsRGibCDr2doEim4y3l5sCSffVrAWiO70XByDzH+jbBUwKWnLMYkP4H9CWKTAVJoaPDe
	eBAQ7gHGfOiafGGtbJhg12cR9GlIfwep+rA2Pjspd5RbjvznZW8ryTs2etEvUlUGTHtgtb4qN7GtA
	YmAvvlJu01/2KUJtFFwD41jNyPLspgiIUV88wrtsDC0jXjyOVCkQQVPpLNZPpE9mA4ZN+IMx7WlHX
	rGoc+aWJMcBUcAodC/368ZwVl6leLyPSlRcLWXC4eD8KB0f6XMoyCx0VpWi8+xd4DQfOgUVvp0vl9
	87i/qNHw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMQwM-008cK1-30; Tue, 22 Feb 2022 08:54:34 +0000
Received: from forward105o.mail.yandex.net ([37.140.190.183])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nMQwH-008cHJ-Io
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 08:54:32 +0000
Received: from iva4-25ea1f41b2ae.qloud-c.yandex.net
 (iva4-25ea1f41b2ae.qloud-c.yandex.net
 [IPv6:2a02:6b8:c0c:89f:0:640:25ea:1f41])
 by forward105o.mail.yandex.net (Yandex) with ESMTP id E3DC34C2E55
 for <linux-nvme@lists.infradead.org>; Tue, 22 Feb 2022 11:54:20 +0300 (MSK)
Received: from iva2-0a73a57cc944.qloud-c.yandex.net
 (iva2-0a73a57cc944.qloud-c.yandex.net [2a02:6b8:c0c:6985:0:640:a73:a57c])
 by iva4-25ea1f41b2ae.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 XTs56AyuAc-sKcGEFle; Tue, 22 Feb 2022 11:54:20 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1645520060; bh=LpjGE5tDX4C27tL4gevTiKfug/67pKaBAEmk8mxP8j4=;
 h=Date:Subject:To:From:Message-Id:Cc;
 b=XtoPX5YlYFXH2Gr8lfZ8rtus3ZXQU8H0J6hPKAjY3a17ZzS9+6zUKYhWC+YSIOAeH
 MTk5fiBrVCACD0dRjedLyg9u49joRsk60eowVt2DP1l/kgkgjwCziHmnYUfzCDa5yy
 sDD49nwz4SH3uUTk2eB0uDH9w5OUmCyH5GXdX4kI=
Authentication-Results: iva4-25ea1f41b2ae.qloud-c.yandex.net;
 dkim=pass header.i=@ya.ru
Received: by iva2-0a73a57cc944.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id UkMdXyyQn9-sKHCMF2m; Tue, 22 Feb 2022 11:54:20 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Aleksandr Dyadyushkin <alextalker@ya.ru>
To: linux-nvme@lists.infradead.org
Cc: Aleksandr Dyadyushkin <alextalker@yandex.ru>,
 Aleksandr Dyadyushkin <alextalker@ya.ru>
Subject: [PATCH] nvmet: parametrize maximum number of namespaces
Date: Tue, 22 Feb 2022 11:54:15 +0300
Message-Id: <20220222085415.292729-1-alextalker@ya.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_005430_173477_63AAEB93 
X-CRM114-Status: GOOD (  15.35  )
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

From: Aleksandr Dyadyushkin <alextalker@yandex.ru>

Allow the end user (i.e. the administrator) to set maximum number of
namespaces (and thus NN and MNAN implicitly) via module loading-time
parameter, without a need to modify and rebuild source code.

Most of all this can be helpful for mock-up configurations and possibly
really sparse NSID assignments.

For backwards compatibility, default values are left as is.

While permitted values are choosen as high as possible for the current
code architecture and standard limitations, it is worth noting that
allocations at 'nvmet_execute_get_log_page_ana' might yield a failure in
runtime on systems with high parameter value and low free memory.

Signed-off-by: Aleksandr Dyadyushkin <alextalker@ya.ru>
---
 drivers/nvme/target/admin-cmd.c |  6 +++---
 drivers/nvme/target/core.c      | 28 +++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     |  2 ++
 3 files changed, 32 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..940297233986 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -278,7 +278,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 	u16 status;
 
 	status = NVME_SC_INTERNAL;
-	desc = kmalloc(struct_size(desc, nsids, NVMET_MAX_NAMESPACES),
+	desc = kmalloc(struct_size(desc, nsids, nvmet_max_namespaces),
 		       GFP_KERNEL);
 	if (!desc)
 		goto out;
@@ -428,8 +428,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 	/* no enforcement soft-limit for maxcmd - pick arbitrary high value */
 	id->maxcmd = cpu_to_le16(NVMET_MAX_CMD);
 
-	id->nn = cpu_to_le32(NVMET_MAX_NAMESPACES);
-	id->mnan = cpu_to_le32(NVMET_MAX_NAMESPACES);
+	id->nn = cpu_to_le32(nvmet_max_namespaces);
+	id->mnan = cpu_to_le32(nvmet_max_namespaces);
 	id->oncs = cpu_to_le16(NVME_CTRL_ONCS_DSM |
 			NVME_CTRL_ONCS_WRITE_ZEROES);
 
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..1b925b40074d 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,32 @@
 
 #include "nvmet.h"
 
+static int max_namespaces_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops max_namespaces_ops = {
+	.set = max_namespaces_set,
+	.get = param_get_uint,
+};
+
+/* Account for 0h NSID */
+#define NVMET_NSID_MAX (NVME_NSID_ALL - 1)
+
+u32 nvmet_max_namespaces = NVMET_MAX_NAMESPACES;
+module_param_cb(max_namespaces, &max_namespaces_ops, &nvmet_max_namespaces, 0444);
+MODULE_PARM_DESC(max_namespaces, "Set maximum number of namespaces per subsystem (default: 1024)");
+
+static int max_namespaces_set(const char *val, const struct kernel_param *kp) {
+	int ret;
+	u32 n;
+
+	ret = kstrtouint(val, 10, &n);
+	if (ret != 0)
+		return -EINVAL;
+	if (n == 0 || n >= NVMET_NSID_MAX)
+		return -EINVAL;
+
+	return param_set_uint(val, kp);
+}
+
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
@@ -562,7 +588,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 		goto out_unlock;
 
 	ret = -EMFILE;
-	if (subsys->nr_namespaces == NVMET_MAX_NAMESPACES)
+	if (subsys->nr_namespaces == nvmet_max_namespaces)
 		goto out_unlock;
 
 	ret = nvmet_bdev_ns_enable(ns);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index af193423c10b..ed4873963cc3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -506,6 +506,8 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
  */
 #define NVMET_MAX_NAMESPACES	1024
 
+extern u32 nvmet_max_namespaces;
+
 /*
  * 0 is not a valid ANA group ID, so we start numbering at 1.
  *
-- 
2.35.1


