Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CEFABC531FF
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Jul 2026 11:49:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sjk6amyEBjrYxLjeZ1QDRsyaaTyipDxO0LX58dfiMoY=; b=cgbECvfivHqISwwGD3se90564W
	VPc+AArfXXcvOik6y0v+6p+1pSOYgpIt18hSZ1jU7h1khFDcto6bbxdiGWEog+eU0fb5gXYWrOlmF
	QSYPhPzdmIMObTBmB2/Jpm/Mx9d97wsKVeuA+G3XNHaas8eWVW05QytpLMLDQ9cLMp1YEU/45PpJW
	GGqrwqkuzGtSzr5sHkE71fj2rdmafF7ekVyyeP07ivabDjreLe4xBdxPhA9P9uMuMDjehBEZp3Kq+
	b/DZLP1VzzZl4HmpIpmp+orX5MoiylT9/hgaZRhnkjRo16p6K++nNH6VyGcp9lIzkQKkD/2oQDDBT
	tzeHY/Mg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoX-0000000GF9r-0thj;
	Fri, 24 Jul 2026 11:11:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wnDoU-0000000GF7E-0BdB
	for linux-nvme@lists.infradead.org;
	Fri, 24 Jul 2026 11:11:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 4DBC460A5F;
	Fri, 24 Jul 2026 11:11:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 82DB8C4FF6C;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1784891492;
	bh=ctGGpbIzK8JbaKPapPs/06WW7DP5TK3ylIpHn8zRy8E=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ow945mIo7qPG3DwG9fWGlk0w901LUpGkzW9JgDexi/1K3PYgEC/atYyLxyU85+VSY
	 ZTMTFH58BEnf/NBS+zR0rr92b3aTFx4LtTCMHRCtwzdgmurlzcQ2MlrFNGzrk5wbet
	 esZf8TQ9nk77V2ZlCd0voM/kkyOSLR1QzcSASUu3d/dgUeJ2VFXeJeuuFmCXXh9hq8
	 60298jIjPkwHt61PHWWsaKBzt5jhoWqadUSE6luQW7LXr9uqgPiJ0CqWva06myDEww
	 r55L4qmF6m4lbpAUdj9byzatHAtAnZO8M10O36XkxE841jkN3ICogNRVgWPGlCMa0E
	 JyVrLIvHOIKKg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B39AC531F9;
	Fri, 24 Jul 2026 11:11:32 +0000 (UTC)
From: Joel Granados <joel.granados@kernel.org>
Date: Fri, 24 Jul 2026 13:10:58 +0200
Subject: [PATCH RFC v2 04/14] nvme: Add CDQ to xarray and define delete
 path
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260724-jag-cdq-lkml-v2-4-659a7449e849@kernel.org>
References: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
In-Reply-To: <20260724-jag-cdq-lkml-v2-0-659a7449e849@kernel.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Chaitanya Kulkarni <chaitanyak@nvidia.com>, Jason Gunthorpe <jgg@ziepe.ca>
Cc: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Joel Granados <joel.granados@kernel.org>
X-Mailer: b4 0.14.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6664;
 i=joel.granados@kernel.org; h=from:subject:message-id;
 bh=ctGGpbIzK8JbaKPapPs/06WW7DP5TK3ylIpHn8zRy8E=;
 b=owJ4nAHtARL+kA0DAAoBupfNUreWQU8ByyZiAGpjSFt/XNfgWgLFYWMGHMQdodhVUC5mgZPEg
 hYvs+KyEnN0J4kBswQAAQoAHRYhBK5HCVcl5jElzssnkLqXzVK3lkFPBQJqY0hbAAoJELqXzVK3
 lkFP09sL/j2jHWSsx+FLMji4B3z+ehsawvgMK2OqHJf/zTD9Mk6USJqqnhYbgCu41vLgxuRV3vT
 kPnuyJPp/uc41jYAc1FDH05H8uEQ9IE6kAzD0p+FLAnUFNU25brWYJqed1tfVl4/HhH0RhL6qUm
 pvjFTMTswpQev/aM/vb54A5h88pdALYJy03BEuHDdJCmXHVxSOOfjSPg+jHiQDF8bGN8OImy1tq
 sALsxUC9Nn9k3sq8UcTKHTQvMeYBGFakrCk3SXSoiJCXWdv4dcK9lgUy5AExU6KZucyEIvt2bSk
 VqSRHrhlW8f1wQL1NspkmG2q1Jfy0//scfvJmHHkxl5+F54DXVy90qXFSPU7pHL1lKyCz4aQT0s
 o5kvLlSXQ9nWn/W/LK3nAH/8LjV3ciEGZLnN2wle5aAuCaLFUrODr5qYAeboSrSrdTug4cgQZCf
 4NgLJ9QdJ3FVVICdq2MmL8qIXan46M43iq0WMcpZZxTUaGysOhrgeQTUYGoDWlhW5OnnBOJvPL7
 OM=
X-Developer-Key: i=joel.granados@kernel.org; a=openpgp;
 fpr=F1F8E46D30F0F6C4A45FF4465895FAAC338C6E77
X-Endpoint-Received: by B4 Relay for joel.granados@kernel.org/default with
 auth_id=239
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

Add Controller managed CDQs to a new xarray in nvme_ctrl indexed by the
CDQ id returned by the controller. The new cdqs xarray will house
pointers to the struct cdq_nvme_queue which contains individual CDQ
metadata. Start it off with id and ctrl back pointer; it will grow as
features get added.

Commands on the delete path:
1. Individual -vs- "All" CDQ delete:
  - The individual delete path is taken when there is a specific command
    from user space to "delete" one CDQ
  - The "all" delete is taken on contrller reset
2. Separation between host and controller delete:
  - Controller delete takes care of sending and forwarding the result of
    the nvme CDQ delete command
  - Host delete memory on the host side

The separation between host and controller delete is important in
nvme_disable_ctrl as the host should delete the memory but expect the
controller to follow NVMe protocol and remove the CDQ on its side.

Note that there is no way of adding a CDQ just yet. This commit focuses
on the delete path and leaves room for handling the creation in
subsequent commits.

Signed-off-by: Joel Granados <joel.granados@kernel.org>
---
 drivers/nvme/host/Makefile |  2 +-
 drivers/nvme/host/cdq.c    | 62 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/cdq.h    | 20 +++++++++++++++
 drivers/nvme/host/core.c   | 15 ++++++++++-
 drivers/nvme/host/nvme.h   |  1 +
 5 files changed, 98 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 6414ec968f99ae69f991cbd61e7ad79554e5041f..cd895082e259a9b0673c7400f6ba62401f95767f 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
 
-nvme-core-y				+= core.o ioctl.o sysfs.o pr.o
+nvme-core-y				+= core.o ioctl.o sysfs.o pr.o cdq.o
 nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
diff --git a/drivers/nvme/host/cdq.c b/drivers/nvme/host/cdq.c
new file mode 100644
index 0000000000000000000000000000000000000000..0e9ac88a054f6630c1eea73ae4140f124b6bb31f
--- /dev/null
+++ b/drivers/nvme/host/cdq.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe Controller Data Queue (CDQ) support.
+ */
+
+#include "nvme.h"
+#include "cdq.h"
+
+static int nvme_submit_delete_cdq_cmd(const struct cdq_nvme_queue *cdq)
+{
+	struct nvme_command c = {
+		.cdq.opcode = nvme_admin_cdq,
+		.cdq.sel = NVME_CDQ_CMD_MGMT_DELETE,
+		.cdq.dw11.cdqid = cpu_to_le16(cdq->id)
+	};
+
+	return __nvme_submit_sync_cmd(cdq->ctrl->admin_q, &c, NULL, NULL, 0, NVME_QID_ANY, 0);
+}
+
+/* Sends a CDQ delete NVMe cmd */
+static void nvme_delete_cdq_ctrl(struct cdq_nvme_queue *cdq)
+{
+	if (nvme_submit_delete_cdq_cmd(cdq))
+		WARN_ONCE(1, "Failed delete CDQ (id: %d)", cdq->id);
+}
+
+/* Does NOT send a CDQ delete NVMe cmd */
+static void nvme_delete_cdq_host(struct cdq_nvme_queue *cdq)
+{
+	u16 cdq_id = cdq->id;
+	struct nvme_ctrl *ctrl = cdq->ctrl;
+
+	xa_erase(&ctrl->cdqs, cdq_id);
+}
+
+void nvme_delete_cdq(struct cdq_nvme_queue *cdq)
+{
+	nvme_delete_cdq_ctrl(cdq);
+	nvme_delete_cdq_host(cdq);
+}
+EXPORT_SYMBOL_GPL(nvme_delete_cdq);
+
+/* Will NOT send a CDQ delete NVMe cmd. */
+void nvme_delete_cdqs_host(struct nvme_ctrl *ctrl)
+{
+	struct cdq_nvme_queue *cdq;
+	unsigned long i;
+
+	xa_for_each(&ctrl->cdqs, i, cdq)
+		nvme_delete_cdq_host(cdq);
+}
+
+/* Final teardown at device->release: free all CDQs and destroy the xarray. */
+void nvme_free_cdqs(struct nvme_ctrl *ctrl)
+{
+	/*
+	 * Delete host side CDQ only. NOT sending delete cmd as
+	 * Ctrl should delete on disable.
+	 */
+	nvme_delete_cdqs_host(ctrl);
+	xa_destroy(&ctrl->cdqs);
+}
diff --git a/drivers/nvme/host/cdq.h b/drivers/nvme/host/cdq.h
new file mode 100644
index 0000000000000000000000000000000000000000..4378f97553ce2e649d8998eb168f82039dc762b1
--- /dev/null
+++ b/drivers/nvme/host/cdq.h
@@ -0,0 +1,20 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * NVMe Controller Data Queue (CDQ) support.
+ */
+
+#ifndef _NVME_CDQ_H
+#define _NVME_CDQ_H
+
+#include "nvme.h"
+
+struct cdq_nvme_queue {
+	u16 id;
+	struct nvme_ctrl *ctrl;
+};
+
+void nvme_delete_cdq(struct cdq_nvme_queue *cdq);
+void nvme_delete_cdqs_host(struct nvme_ctrl *ctrl);
+void nvme_free_cdqs(struct nvme_ctrl *ctrl);
+
+#endif /* _NVME_CDQ_H */
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d11858300ad43f3e229eab7f2dd77563075b801e..fbaa2e065ab846e4700cddd7ae9f30a52e8a2cd9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -25,6 +25,7 @@
 #include <linux/unaligned.h>
 
 #include "nvme.h"
+#include "cdq.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
 
@@ -2665,9 +2666,19 @@ int nvme_disable_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 	}
 	if (ctrl->quirks & NVME_QUIRK_DELAY_BEFORE_CHK_RDY)
 		msleep(NVME_QUIRK_DELAY_AMOUNT);
-	return nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
+	ret =  nvme_wait_ready(ctrl, NVME_CSTS_RDY, 0,
 			       (NVME_CAP_TIMEOUT(ctrl->cap) + 1) / 2, "reset");
+	if (ret)
+		return ret;
+
+	/*
+	 * Delete host side CDQ only. Purposefully NOT sending delete cmd.
+	 * Ctrl should delete on disable.
+	 */
+	nvme_delete_cdqs_host(ctrl);
+	return ret;
 }
+
 EXPORT_SYMBOL_GPL(nvme_disable_ctrl);
 
 int nvme_enable_ctrl(struct nvme_ctrl *ctrl)
@@ -5074,6 +5085,7 @@ static void nvme_free_ctrl(struct device *dev)
 	if (!subsys || ctrl->instance != subsys->instance)
 		ida_free(&nvme_instance_ida, ctrl->instance);
 	nvme_free_cels(ctrl);
+	nvme_free_cdqs(ctrl);
 	nvme_mpath_uninit(ctrl);
 	cleanup_srcu_struct(&ctrl->srcu);
 	nvme_auth_stop(ctrl);
@@ -5120,6 +5132,7 @@ int nvme_init_ctrl(struct nvme_ctrl *ctrl, struct device *dev,
 	mutex_init(&ctrl->scan_lock);
 	INIT_LIST_HEAD(&ctrl->namespaces);
 	xa_init(&ctrl->cels);
+	xa_init(&ctrl->cdqs);
 	ctrl->dev = dev;
 	ctrl->ops = ops;
 	ctrl->quirks = quirks;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 654e5c1b64956c877ff845f0b1f7ee2fa0852b64..7b9d1781816c4bad719584c3d4b4f9fdf7b4e3dc 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -466,6 +466,7 @@ struct nvme_ctrl {
 	enum nvme_dctype dctype;
 
 	u16			awupf; /* 0's based value. */
+	struct xarray cdqs;
 };
 
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)

-- 
2.50.1



