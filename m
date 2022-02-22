Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B2B0EC433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Feb 2022 08:55:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=1Cpc2TaQwTm8WwI0XSo0DDUvjCsIxu1tAURu3gJJFYI=; b=PlXPbNUeihsRtH2RFv07oPB3iq
	1n8tQG+sW0ZYZf6iceKXG1EvZt1ExejSDTzWdonDVl/0pttBqtOMgshVGe+9fTFP+F6riMBe38rJH
	2wM5uZsC/Nk/rMk00md65yliwlUW+EJ3vMAS1HGQwHceCl8X1nyGkw6L+i9ywDr76/+JR2yc1agDL
	awekOqNGtHczLLXnE68cw3zUDjVFWgT8Sm78AB+uoklAMDhCKJ5JWd0XFtrLfHG0T13E4ElsfiyFS
	7fhNuyvTin8IAcqMbeafHMcoafSlKNcWK7wt2ylVL+5iDwCVGUaWhlKhT/+XEr1ourmuUVVTJo3UA
	MacZOZ7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nMQxJ-008cbW-2Z; Tue, 22 Feb 2022 08:55:33 +0000
Received: from forward108p.mail.yandex.net ([2a02:6b8:0:1472:2741:0:8b7:116])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat
 Linux)) id 1nMQxE-008cZj-Oq
 for linux-nvme@lists.infradead.org; Tue, 22 Feb 2022 08:55:31 +0000
Received: from myt5-ec37e7b64129.qloud-c.yandex.net
 (myt5-ec37e7b64129.qloud-c.yandex.net [IPv6:2a02:6b8:c05:ab:0:640:ec37:e7b6])
 by forward108p.mail.yandex.net (Yandex) with ESMTP id CD32726770E2
 for <linux-nvme@lists.infradead.org>; Tue, 22 Feb 2022 11:55:24 +0300 (MSK)
Received: from myt5-01d0fbe499ab.qloud-c.yandex.net
 (myt5-01d0fbe499ab.qloud-c.yandex.net [2a02:6b8:c12:4619:0:640:1d0:fbe4])
 by myt5-ec37e7b64129.qloud-c.yandex.net (mxback/Yandex) with ESMTP id
 UQwyANnQji-tOdGNpoT; Tue, 22 Feb 2022 11:55:24 +0300
X-Yandex-Fwd: 2
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ya.ru; s=mail;
 t=1645520124; bh=1Cpc2TaQwTm8WwI0XSo0DDUvjCsIxu1tAURu3gJJFYI=;
 h=Date:Subject:To:From:Message-Id:Cc;
 b=pDWKnQOT11lryhXzuQVpzOy3pa/2GmzA9ZJW1yL58iHdNVNlQDKWVXVRnatkPKg8E
 +RCcQ9UoAe3A/vhaMNhpT4WkK7TcjhRzZGv54IA6F+qcMF9APe2hu0Uvii70znLigl
 nuvojzT7nh9NCCX/MtzaBO0qu3a823y7NXrccZH4=
Authentication-Results: myt5-ec37e7b64129.qloud-c.yandex.net;
 dkim=pass header.i=@ya.ru
Received: by myt5-01d0fbe499ab.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA
 id Yj8OwmDwng-tOHu4qiU; Tue, 22 Feb 2022 11:55:24 +0300
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (Client certificate not present)
From: Aleksandr Dyadyushkin <alextalker@ya.ru>
To: linux-nvme@lists.infradead.org
Cc: Aleksandr Dyadyushkin <alextalker@yandex.ru>,
 Aleksandr Dyadyushkin <alextalker@ya.ru>
Subject: [PATCH] nvmet: parametrize maximum number of ANA groups
Date: Tue, 22 Feb 2022 11:55:22 +0300
Message-Id: <20220222085522.296465-1-alextalker@ya.ru>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220222_005529_195204_C0B08EAA 
X-CRM114-Status: GOOD (  20.85  )
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

Allow the end user (i.e. the administrator) to set maximum number of ANA
groups (and thus ANAGRPMAX and NANAGRPID implicitly) via module
loading-time parameter, without a need to modify and rebuild source
code.

Most of all, this can be helpful for fancy namespace assignment schemes
(since maximum number of namespaces allowed by default is 1024 which is
8 times more than 128 for ANA groups) or mock-up configurations.

For backwards compatibility, default values are left as is.

While permitted values are choosen as high as possible for the current
code architecture, it is worth noting that allocation of
'nvmet_ana_group_enabled' might yield a failure during loading on
systems with high parameter value and low free memory.

In regard to performance, it might be argued that replacing constant
macros value with a parameter could affect compile-time optimizations of
the loops but such an issue would only affect
'nvmet_execute_get_log_page_ana' and 'nvmet_ports_make' functions at the
moment.

Signed-off-by: Aleksandr Dyadyushkin <alextalker@ya.ru>
---
 drivers/nvme/target/admin-cmd.c |  8 ++++----
 drivers/nvme/target/configfs.c  |  8 ++++----
 drivers/nvme/target/core.c      | 33 ++++++++++++++++++++++++++++++++-
 drivers/nvme/target/nvmet.h     |  4 +++-
 4 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 6fb24746de06..044f9372dafe 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -284,7 +284,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 		goto out;
 
 	down_read(&nvmet_ana_sem);
-	for (grpid = 1; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
+	for (grpid = 1; grpid <= nvmet_max_anagrps; grpid++) {
 		if (!nvmet_ana_group_enabled[grpid])
 			continue;
 		len = nvmet_format_ana_group(req, grpid, desc);
@@ -294,7 +294,7 @@ static void nvmet_execute_get_log_page_ana(struct nvmet_req *req)
 		offset += len;
 		ngrps++;
 	}
-	for ( ; grpid <= NVMET_MAX_ANAGRPS; grpid++) {
+	for ( ; grpid <= nvmet_max_anagrps; grpid++) {
 		if (nvmet_ana_group_enabled[grpid])
 			ngrps++;
 	}
@@ -467,8 +467,8 @@ static void nvmet_execute_identify_ctrl(struct nvmet_req *req)
 
 	id->anacap = (1 << 0) | (1 << 1) | (1 << 2) | (1 << 3) | (1 << 4);
 	id->anatt = 10; /* random value */
-	id->anagrpmax = cpu_to_le32(NVMET_MAX_ANAGRPS);
-	id->nanagrpid = cpu_to_le32(NVMET_MAX_ANAGRPS);
+	id->anagrpmax = cpu_to_le32(nvmet_max_anagrps);
+	id->nanagrpid = cpu_to_le32(nvmet_max_anagrps);
 
 	/*
 	 * Meh, we don't really support any power state.  Fake up the same
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 091a0ca16361..438566fe1308 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -498,7 +498,7 @@ static ssize_t nvmet_ns_ana_grpid_store(struct config_item *item,
 	if (ret)
 		return ret;
 
-	if (newgrpid < 1 || newgrpid > NVMET_MAX_ANAGRPS)
+	if (newgrpid < 1 || newgrpid > nvmet_max_anagrps)
 		return -EINVAL;
 
 	down_write(&nvmet_ana_sem);
@@ -1554,7 +1554,7 @@ static struct config_group *nvmet_ana_groups_make_group(
 		goto out;
 
 	ret = -EINVAL;
-	if (grpid <= 1 || grpid > NVMET_MAX_ANAGRPS)
+	if (grpid <= 1 || grpid > nvmet_max_anagrps)
 		goto out;
 
 	ret = -ENOMEM;
@@ -1637,14 +1637,14 @@ static struct config_group *nvmet_ports_make(struct config_group *group,
 	if (!port)
 		return ERR_PTR(-ENOMEM);
 
-	port->ana_state = kcalloc(NVMET_MAX_ANAGRPS + 1,
+	port->ana_state = kcalloc(nvmet_max_anagrps + 1,
 			sizeof(*port->ana_state), GFP_KERNEL);
 	if (!port->ana_state) {
 		kfree(port);
 		return ERR_PTR(-ENOMEM);
 	}
 
-	for (i = 1; i <= NVMET_MAX_ANAGRPS; i++) {
+	for (i = 1; i <= nvmet_max_anagrps; i++) {
 		if (i == NVMET_DEFAULT_ANA_GRPID)
 			port->ana_state[1] = NVME_ANA_OPTIMIZED;
 		else
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 5119c687de68..69eb9dbc81a1 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -15,6 +15,32 @@
 
 #include "nvmet.h"
 
+static int max_anagrps_set(const char *val, const struct kernel_param *kp);
+static const struct kernel_param_ops max_anagrps_ops = {
+	.set = max_anagrps_set,
+	.get = param_get_uint,
+};
+
+/* Account for 0h value */
+#define NVMET_ANAGRPS_MAX (NVME_NSID_ALL - 1)
+
+u32 nvmet_max_anagrps = NVMET_MAX_ANAGRPS;
+module_param_cb(max_anagrps, &max_anagrps_ops, &nvmet_max_anagrps, 0444);
+MODULE_PARM_DESC(max_anagrps, "Set maximum number of ANA groups per port (default: 128)");
+
+static int max_anagrps_set(const char *val, const struct kernel_param *kp) {
+	int ret;
+	u32 n;
+
+	ret = kstrtouint(val, 10, &n);
+	if (ret != 0)
+		return -EINVAL;
+	if (n == 0 || n > NVMET_ANAGRPS_MAX)
+		return -EINVAL;
+
+	return param_set_uint(val, kp);
+}
+
 struct workqueue_struct *buffered_io_wq;
 struct workqueue_struct *zbd_wq;
 static const struct nvmet_fabrics_ops *nvmet_transports[NVMF_TRTYPE_MAX];
@@ -38,7 +64,7 @@ static DEFINE_IDA(cntlid_ida);
  */
 DECLARE_RWSEM(nvmet_config_sem);
 
-u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
+u32 *nvmet_ana_group_enabled;
 u64 nvmet_ana_chgcnt;
 DECLARE_RWSEM(nvmet_ana_sem);
 
@@ -1608,6 +1634,10 @@ static int __init nvmet_init(void)
 {
 	int error;
 
+	nvmet_ana_group_enabled = kcalloc(nvmet_max_anagrps + 1,
+		sizeof(*nvmet_ana_group_enabled), GFP_KERNEL);
+	if (!nvmet_ana_group_enabled)
+		return -ENOMEM;
 	nvmet_ana_group_enabled[NVMET_DEFAULT_ANA_GRPID] = 1;
 
 	zbd_wq = alloc_workqueue("nvmet-zbd-wq", WQ_MEM_RECLAIM, 0);
@@ -1646,6 +1676,7 @@ static void __exit nvmet_exit(void)
 	ida_destroy(&cntlid_ida);
 	destroy_workqueue(buffered_io_wq);
 	destroy_workqueue(zbd_wq);
+	kfree(nvmet_ana_group_enabled);
 
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_entry) != 1024);
 	BUILD_BUG_ON(sizeof(struct nvmf_disc_rsp_page_hdr) != 1024);
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index af193423c10b..cbfe8de1bbc3 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -515,6 +515,8 @@ void nvmet_add_async_event(struct nvmet_ctrl *ctrl, u8 event_type,
 #define NVMET_MAX_ANAGRPS	128
 #define NVMET_DEFAULT_ANA_GRPID	1
 
+extern u32 nvmet_max_anagrps;
+
 #define NVMET_KAS		10
 #define NVMET_DISC_KATO_MS		120000
 
@@ -527,7 +529,7 @@ void nvmet_exit_discovery(void);
 extern struct nvmet_subsys *nvmet_disc_subsys;
 extern struct rw_semaphore nvmet_config_sem;
 
-extern u32 nvmet_ana_group_enabled[NVMET_MAX_ANAGRPS + 1];
+extern u32 *nvmet_ana_group_enabled;
 extern u64 nvmet_ana_chgcnt;
 extern struct rw_semaphore nvmet_ana_sem;
 
-- 
2.35.1


