Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBE4BCA9EDC
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Oct 2026 02:21:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L0NQW/+JgmrKldhRH+qPjFNYPK3paf+0jRS8bkc56Jw=; b=k1tXVfSe9NrQ8mafWt0KiWx9zf
	cs7o43+Yl+n5KOvj96VjMWmTsc4eAmrsDBNcIuOjRG8Kv45OF73l9atWpVlLBzglmxvkLPuV3WGTF
	Oo57TnUKD+1gzSVVVCwm0krFkfujhAA7zHWTQN+frjZjr5OAhGm+6ekxlBZlWSetv/b43sOmbugJa
	VLj8OZRkSy6g6F+J+IMGCw7CWHECzkGzsYo8FWHMFeX84hpE4VxEmXjPAqOe7XrYG+j0Pifs58MhI
	fJZOkxAoJr79QtprHj5bP5QX+M7+KqYkiOziJEW5waxwxRKFPq8S73CPKiIftLr1lDE6CpJ3UoRp7
	/TJv2z1A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8z-0000000BmZw-1khA;
	Tue, 13 Oct 2026 02:21:33 +0000
Received: from out30-97.freemail.mail.aliyun.com ([115.124.30.97])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1xGS8q-0000000BmSd-1Ku5
	for linux-nvme@lists.infradead.org;
	Tue, 13 Oct 2026 02:21:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1791858081; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=L0NQW/+JgmrKldhRH+qPjFNYPK3paf+0jRS8bkc56Jw=;
	b=YPpiEiN8Y3Z5qeyd6QX0dULN5ECE6NUx/GRrk5EOeTNYuid8GqEYg/2+SsDXu4IkMSWWNk6I2te08F6fukJa8PDA82hPyqGA2Nh6X28sw1wQAeGW33pSt1hc8jUuQLa6FaShDrftdYDu9b1rnlRneLzLdx/tzqvC5XtOGmeHzXE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033045098064;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=9;SR=0;TI=SMTPD_---0XCk3N1P_1791858079;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XCk3N1P_1791858079 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 13 Oct 2026 10:21:19 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 04/11] nvmet: add per-namespace FDP bridge state and configuration
Date: Tue, 13 Oct 2026 10:21:02 +0800
Message-ID: <20261013022109.1507911-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261013022109.1507911-1-kanie@linux.alibaba.com>
References: <20261013022109.1507911-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261012_192124_802486_16C33BF4 
X-CRM114-Status: GOOD (  28.07  )
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

Flexible Data Placement lets a host direct writes into reclaim units
through placement identifiers, so that data with different lifetimes
stays separated in the media.  It is defined in the NVMe base
specification and therefore applies to fabrics as well; a storage
system that exposes its local FDP-capable NVMe devices to remote
hosts over NVMe-oF currently has no way to pass that capability
through: nvmet neither advertises FDP nor forwards any FDP command.

Introduce the per-namespace FDP state that the following bridge
patches build on.  A namespace opts in through a new fdp_enable
configfs attribute, settable only while the namespace is disabled,
like resv_enable.  When the namespace is enabled, the FDP
configuration is snapshotted from the block device write stream
limits of the backing device: the number of reclaim unit handles and
the reclaim unit nominal size, together with the queues of the
backing NVMe namespace, which the FDP command forwarding needs.

The bridge lives behind its own NVME_TARGET_FDP Kconfig option, which
depends on NVME_CORE like the passthru support does: it reads the
host driver internals behind the block device operations pointer to
recognize an NVMe backing device and to reach its controller.  The
plain NVMe target keeps no dependency on the NVMe host driver.

The NVMe host driver is the only one that reports write streams
today, so the enable is rejected when the backing device is not an
NVMe namespace.  The snapshot is constrained to what the bridge can
serve: the namespace identifier has to fit the 16 bit Endurance
Group Identifier it is reported as, and the number of reclaim unit
handles is limited to the 8 bit write stream identifiers of the
block layer.

Assisted-by: LLM
Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/Kconfig    | 14 ++++++
 drivers/nvme/target/Makefile   |  1 +
 drivers/nvme/target/configfs.c | 31 +++++++++++++
 drivers/nvme/target/core.c     | 12 ++++-
 drivers/nvme/target/fdp.c      | 85 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    | 37 +++++++++++++++
 6 files changed, 179 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/target/fdp.c

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 69bde270115e2..974878e345cb5 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -26,6 +26,20 @@ config NVME_TARGET_DEBUGFS
 
 	  If unsure, say N.
 
+config NVME_TARGET_FDP
+	bool "NVMe Target Flexible Data Placement bridge support"
+	depends on NVME_TARGET
+	depends on NVME_CORE=y || NVME_CORE=NVME_TARGET
+	help
+	  This enables the target side bridge for the Flexible Data
+	  Placement (FDP) capability: namespaces backed by an FDP capable
+	  NVMe namespace advertise the capability to hosts over NVMe-oF,
+	  translate the placement identifiers of write commands to
+	  backing write streams, and forward the FDP management commands
+	  and log pages to the backing controller.
+
+	  If unsure, say N.
+
 config NVME_TARGET_PASSTHRU
 	bool "NVMe Target Passthrough support"
 	depends on NVME_TARGET
diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index ed8522911d1f7..94814e015c2f5 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -13,6 +13,7 @@ obj-$(CONFIG_NVME_TARGET_PCI_EPF)	+= nvmet-pci-epf.o
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
 			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
 nvmet-$(CONFIG_NVME_TARGET_DEBUGFS)	+= debugfs.o
+nvmet-$(CONFIG_NVME_TARGET_FDP)		+= fdp.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
 nvmet-$(CONFIG_NVME_TARGET_AUTH)	+= fabrics-cmd-auth.o auth.o
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 413ee2d16d29c..a31a41afd736a 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -824,6 +824,34 @@ static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_ns_, resv_enable);
 
+#ifdef CONFIG_NVME_TARGET_FDP
+static ssize_t nvmet_ns_fdp_enable_show(struct config_item *item, char *page)
+{
+	return sysfs_emit(page, "%d\n", nvmet_fdp_enabled(to_nvmet_ns(item)));
+}
+
+static ssize_t nvmet_ns_fdp_enable_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (kstrtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("the ns:%u is already enabled.\n", ns->nsid);
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+	ns->fdp.enable = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+CONFIGFS_ATTR(nvmet_ns_, fdp_enable);
+#endif
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -833,6 +861,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_revalidate_size,
 	&nvmet_ns_attr_resv_enable,
+#ifdef CONFIG_NVME_TARGET_FDP
+	&nvmet_ns_attr_fdp_enable,
+#endif
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index d74c01c98f194..4a6444fdfb2f8 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -610,9 +610,15 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 			goto out_dev_put;
 	}
 
+	if (nvmet_fdp_enabled(ns)) {
+		ret = nvmet_fdp_init_ns(ns);
+		if (ret)
+			goto out_pr_exit;
+	}
+
 	ret = percpu_ref_init(&ns->ref, nvmet_destroy_namespace, 0, GFP_KERNEL);
 	if (ret)
-		goto out_pr_exit;
+		goto out_fdp_exit;
 
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
@@ -622,6 +628,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
+out_fdp_exit:
+	nvmet_fdp_exit_ns(ns);
 out_pr_exit:
 	if (ns->pr.enable)
 		nvmet_pr_exit_ns(ns);
@@ -667,6 +675,8 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	if (ns->pr.enable)
 		nvmet_pr_exit_ns(ns);
 
+	nvmet_fdp_exit_ns(ns);
+
 	mutex_lock(&subsys->lock);
 	nvmet_ns_changed(subsys, ns->nsid);
 	nvmet_ns_dev_disable(ns);
diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
new file mode 100644
index 0000000000000..17949e3665293
--- /dev/null
+++ b/drivers/nvme/target/fdp.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe over Fabrics Flexible Data Placement bridge.
+ *
+ * Copyright (c) 2026 Guixin Liu, Alibaba Group.
+ * All rights reserved.
+ */
+#define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
+#include <linux/blkdev.h>
+#include <linux/nvme.h>
+
+#include "../host/nvme.h"
+#include "nvmet.h"
+
+bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys)
+{
+	struct nvmet_ns *ns;
+	unsigned long idx;
+	bool ret = false;
+
+	mutex_lock(&subsys->lock);
+	nvmet_for_each_enabled_ns(&subsys->namespaces, idx, ns) {
+		if (nvmet_fdp_enabled(ns)) {
+			ret = true;
+			break;
+		}
+	}
+	mutex_unlock(&subsys->lock);
+
+	return ret;
+}
+
+int nvmet_fdp_init_ns(struct nvmet_ns *ns)
+{
+	struct block_device *bdev = ns->bdev;
+	struct nvme_ns *backend_ns;
+
+	if (!bdev) {
+		pr_err("the ns:%u has no block device for FDP\n", ns->nsid);
+		return -EINVAL;
+	}
+
+	/* the endgid equals the nsid, which is 16 bit on the wire */
+	if (ns->nsid > U16_MAX) {
+		pr_err("the ns:%u cannot fit an endurance group identifier\n",
+		       ns->nsid);
+		return -EINVAL;
+	}
+
+	ns->fdp.nruh = bdev_max_write_streams(bdev);
+	if (!ns->fdp.nruh || ns->fdp.nruh > U8_MAX) {
+		pr_err("the ns:%u has no usable backing write streams: %u\n",
+		       ns->nsid, ns->fdp.nruh);
+		return -EINVAL;
+	}
+
+	ns->fdp.runs = bdev_write_stream_granularity(bdev);
+	if (!ns->fdp.runs) {
+		pr_err("the ns:%u has no backing write streams\n", ns->nsid);
+		return -EINVAL;
+	}
+
+	/*
+	 * The NVMe host driver is the only one that reports write streams
+	 * today, so an FDP backing device is an NVMe namespace and the
+	 * bridge needs its controller to forward the FDP commands to.
+	 */
+	if (bdev->bd_disk->fops != &nvme_bdev_ops) {
+		pr_err("the ns:%u has no NVMe backing device for FDP\n",
+		       ns->nsid);
+		return -EINVAL;
+	}
+
+	backend_ns = bdev->bd_disk->private_data;
+	ns->fdp.backend_q = backend_ns->queue;
+	ns->fdp.backend_ctrl = backend_ns->ctrl;
+
+	return 0;
+}
+
+void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
+{
+	ns->fdp.backend_q = NULL;
+	ns->fdp.backend_ctrl = NULL;
+}
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index e362d7913a380..07880db4468ad 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -97,6 +97,14 @@ struct nvmet_pr_per_ctrl_ref {
 	uuid_t			hostid;
 };
 
+struct nvmet_fdp {
+	bool			enable;
+	u16			nruh;
+	u64			runs;
+	struct request_queue	*backend_q;
+	struct nvme_ctrl	*backend_ctrl;
+};
+
 struct nvmet_ns {
 	struct percpu_ref	ref;
 	struct file		*bdev_file;
@@ -128,6 +136,9 @@ struct nvmet_ns {
 	u8			csi;
 	struct nvmet_pr		pr;
 	struct xarray		pr_per_ctrl_refs;
+#ifdef CONFIG_NVME_TARGET_FDP
+	struct nvmet_fdp	fdp;
+#endif
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
@@ -978,6 +989,32 @@ static inline void nvmet_pr_put_ns_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
 	percpu_ref_put(&pc_ref->ref);
 }
 
+#ifdef CONFIG_NVME_TARGET_FDP
+static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
+{
+	return ns->fdp.enable;
+}
+int nvmet_fdp_init_ns(struct nvmet_ns *ns);
+void nvmet_fdp_exit_ns(struct nvmet_ns *ns);
+bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys);
+#else
+static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
+{
+	return false;
+}
+static inline int nvmet_fdp_init_ns(struct nvmet_ns *ns)
+{
+	return -EINVAL;
+}
+static inline void nvmet_fdp_exit_ns(struct nvmet_ns *ns)
+{
+}
+static inline bool nvmet_fdp_subsys_configured(struct nvmet_subsys *subsys)
+{
+	return false;
+}
+#endif
+
 /*
  * Data for the get_feature() and set_feature() operations of PCI target
  * controllers.
-- 
2.43.7


