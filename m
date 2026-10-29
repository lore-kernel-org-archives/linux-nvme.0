Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B4355606A31C
	for <linux-nvme@archiver.kernel.org>; Thu, 29 Oct 2026 12:29:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=2XsCkrqw;
	dkim=pass (1024-bit key, unprotected) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.a=rsa-sha256 header.s=default header.b=xLue2LY0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=43uTmQ+B8QLqO8ST+Em+1VIgFsTcWfswLZhXEE7IaUg=; b=2XsCkrqwbr5azb
	BhH/ODWIbvbRXYRKQaMDIyn9pUujquXPC35zne9EPvhc9BqktH4n0J533ujgIVNPw1rEGTCMlpmHe
	hcrdwX5yQuHbq9YR93w32wdQGuAWkdkgacaUXE75ZqBVICSPaS2Qa7RQiWrJCzXUbWYIpnyowGmKK
	YpLbSEU3wTQm5/hr3MVTzxNYYBHqsXjBeXxkU09R/a5KVmdFtf/vKZ2uYAJH4oRjtI67oPKWcZGWO
	BqcSe/1uIx36l0njc+1M5Zz/sjxOl3XZXSv0gSO0VcpA+ilslI7xVcvgkMgwtXJJ/QkHm4JRV04jJ
	nRHEMD2EHCT71eb9mfkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFu-000000099HO-1BRj;
	Thu, 29 Oct 2026 12:29:18 +0000
Received: from out30-113.freemail.mail.aliyun.com ([115.124.30.113])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xMPFq-000000099E0-2omP
	for linux-nvme@lists.infradead.org;
	Thu, 29 Oct 2026 12:29:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1793276952; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=43uTmQ+B8QLqO8ST+Em+1VIgFsTcWfswLZhXEE7IaUg=;
	b=xLue2LY02us3U8i6Bj2VEBpDrgJ5R0wiZEKYIgerr+staZIrRcDEr7q2cgBIZlbVNnBsr6mxvoFbeUSdxHIOkujbvNK3FugtfZojd0NnirkkYYGbv7FGnkTpTc2LHCpHnxS35kuynrs6to5ZRB+6yGMd5N34H9yEHCue7HsjH3U=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R401e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=8;SR=0;TI=SMTPD_---0XDjWnu-_1793276951;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0XDjWnu-_1793276951 cluster:ay36)
          by smtp.aliyun-inc.com;
          Thu, 29 Oct 2026 20:29:12 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Nilay Shroff <nilay@linux.ibm.com>,
	Daniel Wagner <dwagner@suse.de>,
	Hannes Reinecke <hare@suse.de>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 04/12] nvmet: add per-namespace FDP bridge state and configuration
Date: Thu, 29 Oct 2026 20:28:25 +0800
Message-ID: <20261029122833.284572-5-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20261029122833.284572-1-kanie@linux.alibaba.com>
References: <20261029122833.284572-1-kanie@linux.alibaba.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261029_052915_067678_8631FA48 
X-CRM114-Status: GOOD (  27.99  )
X-Spam-Score: -17.6 (-----------------)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-26.4 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/Kconfig    | 14 +++++++
 drivers/nvme/target/Makefile   |  1 +
 drivers/nvme/target/configfs.c | 32 ++++++++++++++++
 drivers/nvme/target/core.c     | 16 +++++++-
 drivers/nvme/target/fdp.c      | 67 ++++++++++++++++++++++++++++++++++
 drivers/nvme/target/nvmet.h    | 36 ++++++++++++++++++
 6 files changed, 165 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/target/fdp.c

diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 69bde270115e..974878e345cb 100644
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
index ed8522911d1f..94814e015c2f 100644
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
index b03b5d1c2dc3..732fce67c594 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -827,6 +827,35 @@ static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_ns_, resv_enable);
 
+#ifdef CONFIG_NVME_TARGET_FDP
+static ssize_t nvmet_ns_fdp_enable_show(struct config_item *item,
+					char *page)
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
@@ -836,6 +865,9 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
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
index 07a74c2e1f58..14e2a908857c 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -622,19 +622,29 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
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
 	xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
 	nvmet_debugfs_ns_setup(ns);
 	set_bit(NVMET_NS_IO_LIVE, &ns->flags);
+	if (nvmet_fdp_enabled(ns))
+		subsys->nr_ns_fdp_enabled++;
 	ret = 0;
 out_unlock:
 	mutex_unlock(&subsys->lock);
 	return ret;
+out_fdp_exit:
+	nvmet_fdp_exit_ns(ns);
 out_pr_exit:
 	if (ns->pr.enable)
 		nvmet_pr_exit_ns(ns);
@@ -680,10 +690,14 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 	if (ns->pr.enable)
 		nvmet_pr_exit_ns(ns);
 
+	nvmet_fdp_exit_ns(ns);
+
 	mutex_lock(&subsys->lock);
 	nvmet_ns_changed(subsys, ns->nsid);
 	nvmet_ns_dev_disable(ns);
 	ns->enabled = false;
+	if (nvmet_fdp_enabled(ns))
+		subsys->nr_ns_fdp_enabled--;
 	mutex_unlock(&subsys->lock);
 }
 
diff --git a/drivers/nvme/target/fdp.c b/drivers/nvme/target/fdp.c
new file mode 100644
index 000000000000..761b9029ce25
--- /dev/null
+++ b/drivers/nvme/target/fdp.c
@@ -0,0 +1,67 @@
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
index 162e2fdd848e..81defb4abfdd 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -97,6 +97,17 @@ struct nvmet_pr_per_ctrl_ref {
 	uuid_t			hostid;
 };
 
+struct nvmet_fdp {
+	bool			enable;
+	u16			nruh;
+	u64			runs;
+	u8			ruht[U8_MAX];
+	struct request_queue	*backend_q;
+	struct nvme_ctrl	*backend_ctrl;
+	u32			backend_nsid;
+	u16			backend_endgid;
+};
+
 struct nvmet_ns {
 	struct percpu_ref	ref;
 	struct file		*bdev_file;
@@ -130,6 +141,9 @@ struct nvmet_ns {
 	u8			csi;
 	struct nvmet_pr		pr;
 	struct xarray		pr_per_ctrl_refs;
+#ifdef CONFIG_NVME_TARGET_FDP
+	struct nvmet_fdp	fdp;
+#endif
 #ifdef CONFIG_NVME_TARGET_DEBUGFS
 	struct dentry		*debugfs_dir;
 #endif
@@ -356,6 +370,7 @@ struct nvmet_subsys {
 	char			*model_number;
 	u32			ieee_oui;
 	char			*firmware_rev;
+	unsigned int		nr_ns_fdp_enabled;
 
 #ifdef CONFIG_NVME_TARGET_PASSTHRU
 	struct nvme_ctrl	*passthru_ctrl;
@@ -982,6 +997,27 @@ static inline void nvmet_pr_put_ns_pc_ref(struct nvmet_pr_per_ctrl_ref *pc_ref)
 	percpu_ref_put(&pc_ref->ref);
 }
 
+#ifdef CONFIG_NVME_TARGET_FDP
+static inline bool nvmet_fdp_enabled(struct nvmet_ns *ns)
+{
+	return ns->fdp.enable;
+}
+int nvmet_fdp_init_ns(struct nvmet_ns *ns);
+void nvmet_fdp_exit_ns(struct nvmet_ns *ns);
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
+#endif
+
 /*
  * Data for the get_feature() and set_feature() operations of PCI target
  * controllers.
-- 
2.43.7


