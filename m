Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02B7ACDB46F
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jun 2026 10:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2fE4KwJwvNZ+Bt/82tv48rMTHzXlu891NcFOzAYBSng=; b=ioXBKApbEsAWGN0Jq+tQUQK2ue
	UKay2aImYdmULjS3rf3i8qA19lMOUMlZXvP4GUcGkNFDBWrTWOqSS/3fmYw+WrcKwp9lh11I19K3W
	atjrh2yS6VAsX8fkY4Xc3AX4O8PnC1kxYye/QlgK6huYf/LQhS0Vg7YomUSYrOHHNlNnP0KNs2DxS
	sAbjrMZjIQnYsowwN61QqWyOmFiKtjQSIHn6Ht4Ilq+JeJuOaiMhR/wQQEdH9Yes1Mk4RqfSDs7dV
	7pcGFw1s+qxv0lf2hRvqfpIgscG5WCZLdkR2Im1Cg+JKOBS6mYn+RoXLWL/SKK+MGodcF7xmaLpiU
	TYySi3vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbc8s-00000004qsQ-1MIc;
	Mon, 22 Jun 2026 10:44:38 +0000
Received: from out30-101.freemail.mail.aliyun.com ([115.124.30.101])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wbc8q-00000004qrQ-0SLo
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jun 2026 10:44:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782125074; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=2fE4KwJwvNZ+Bt/82tv48rMTHzXlu891NcFOzAYBSng=;
	b=XnQuvdDD0heDfDQ41hkMq370GLMqGuD6Qe7SzdsJRPP5qautcPKEOwyohpc+MshL/beEa78nuF8TLqVNM1bCvTVfoTXp2SaTzoAPiLHc54Ai7n3KO5IUiuNt89/1e1Pf36exQj+oMUuAfhuyS0E3Z11Sc5Uva06BU8HstqWSnrE=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R771e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0X5LvmB3_1782125065;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0X5LvmB3_1782125065 cluster:ay36)
          by smtp.aliyun-inc.com;
          Mon, 22 Jun 2026 18:44:31 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Hannes Reinecke <hare@suse.com>
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH 1/2] nvmet: add namespace-level debugfs directory
Date: Mon, 22 Jun 2026 18:44:17 +0800
Message-ID: <20260622104418.2070277-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.7
In-Reply-To: <20260622104418.2070277-1-kanie@linux.alibaba.com>
References: <20260622104418.2070277-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260622_034436_502633_C05BF309 
X-CRM114-Status: GOOD (  12.60  )
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

Add per-namespace debugfs directory support under the subsystem debugfs
directory. Each enabled namespace gets a ns<nsid>/ directory created
during nvmet_ns_enable() and removed during nvmet_ns_disable().

This provides the infrastructure for exposing namespace-specific debug
information in subsequent patches.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/core.c    |  2 ++
 drivers/nvme/target/debugfs.c | 21 +++++++++++++++++++++
 drivers/nvme/target/debugfs.h |  5 +++++
 drivers/nvme/target/nvmet.h   |  3 +++
 4 files changed, 31 insertions(+)

diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 62dd59b9aa4f..9752913e05c6 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -616,6 +616,7 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	nvmet_ns_changed(subsys, ns->nsid);
 	ns->enabled = true;
 	xa_set_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
+	nvmet_debugfs_ns_setup(ns);
 	ret = 0;
 out_unlock:
 	mutex_unlock(&subsys->lock);
@@ -642,6 +643,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 
 	ns->enabled = false;
 	xa_clear_mark(&subsys->namespaces, ns->nsid, NVMET_NS_ENABLED);
+	nvmet_debugfs_ns_free(ns);
 
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		pci_dev_put(radix_tree_delete(&ctrl->p2p_ns_map, ns->nsid));
diff --git a/drivers/nvme/target/debugfs.c b/drivers/nvme/target/debugfs.c
index 5dcbd5aa86e1..e6f51eb59010 100644
--- a/drivers/nvme/target/debugfs.c
+++ b/drivers/nvme/target/debugfs.c
@@ -153,6 +153,27 @@ static int nvmet_ctrl_tls_concat_show(struct seq_file *m, void *p)
 NVMET_DEBUGFS_ATTR(nvmet_ctrl_tls_concat);
 #endif
 
+void nvmet_debugfs_ns_setup(struct nvmet_ns *ns)
+{
+	char name[16];
+	struct dentry *parent = ns->subsys->debugfs_dir;
+
+	if (!parent)
+		return;
+	snprintf(name, sizeof(name), "ns%u", ns->nsid);
+	ns->debugfs_dir = debugfs_create_dir(name, parent);
+	if (IS_ERR(ns->debugfs_dir)) {
+		ns->debugfs_dir = NULL;
+		return;
+	}
+}
+
+void nvmet_debugfs_ns_free(struct nvmet_ns *ns)
+{
+	debugfs_remove_recursive(ns->debugfs_dir);
+	ns->debugfs_dir = NULL;
+}
+
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 {
 	char name[32];
diff --git a/drivers/nvme/target/debugfs.h b/drivers/nvme/target/debugfs.h
index cfb8bbf6a297..b559d254fc2a 100644
--- a/drivers/nvme/target/debugfs.h
+++ b/drivers/nvme/target/debugfs.h
@@ -14,6 +14,8 @@ int nvmet_debugfs_subsys_setup(struct nvmet_subsys *subsys);
 void nvmet_debugfs_subsys_free(struct nvmet_subsys *subsys);
 int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl);
 void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl);
+void nvmet_debugfs_ns_setup(struct nvmet_ns *ns);
+void nvmet_debugfs_ns_free(struct nvmet_ns *ns);
 
 int __init nvmet_init_debugfs(void);
 void nvmet_exit_debugfs(void);
@@ -30,6 +32,9 @@ static inline int nvmet_debugfs_ctrl_setup(struct nvmet_ctrl *ctrl)
 }
 static inline void nvmet_debugfs_ctrl_free(struct nvmet_ctrl *ctrl) {}
 
+static inline void nvmet_debugfs_ns_setup(struct nvmet_ns *ns) {}
+static inline void nvmet_debugfs_ns_free(struct nvmet_ns *ns) {}
+
 static inline int __init nvmet_init_debugfs(void)
 {
     return 0;
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 3305a88684ec..142a78d9160f 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -128,6 +128,9 @@ struct nvmet_ns {
 	u8			csi;
 	struct nvmet_pr		pr;
 	struct xarray		pr_per_ctrl_refs;
+#ifdef CONFIG_NVME_TARGET_DEBUGFS
+	struct dentry		*debugfs_dir;
+#endif
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
-- 
2.43.7


