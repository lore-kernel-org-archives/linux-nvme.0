Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9EF31C87FC9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:07:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5mFSqE+VpcrWCRhQNiEnoxCYEon9Gh4GOnyX2tGIasQ=; b=VXtK/REJhkdwuyOofSsfQH+5xk
	12o0twy198X9ZIHyutIXQ2OKhuxpq8wB90waz5DlNagBf7d8qFRhiwXPybES0RLfScEmxbacSizLy
	nGY9+x/jvdCHTIvIwCaucmKb+D1QrHRoxiyke+sLgOONks2/D94VCOM2XVueB5Tw7SszkhT7RMrD8
	7hjAVBx9ASMG4O83JwHQWJvnckYHSdjOzlUp6DfdQWsMQyo5jqzc47/DoU/+21nWWDiN9LQr+PeU6
	KEyhDVlnx7XswhNSGrd2Kul9Fq6xzM52IjBEI5W2XlThpUUCvcvUQHMp7l9nkR7nmwjZ/spiOXHD/
	xAY9B2xQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQh-0000000G5UJ-3bCZ;
	Tue, 29 Jul 2025 07:07:19 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQd-0000000G5Rf-1VYk
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:07:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0986244FC1;
	Tue, 29 Jul 2025 07:07:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DD85C4CEF5;
	Tue, 29 Jul 2025 07:07:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772834;
	bh=ik8PvWSi7XkFJiHbN8U4Yeq3/1Y0aR0fPaJMHIyW5Gw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=HJG7Xl6DuYBnhj94Oi/tL7FkkMuWWSrXRMTBmlWqlaoERwhMmmvO0m7EAELLYMK3Y
	 MWCa5R38679DJGLAPLElKgWjExAFxlCgjxbTl+M6iDumKuCCxLvzpJ32BxtcalHnjq
	 dna3/zu+kfzSJL09QhzLP5UIebPjC85k/sBoeUcsSPgM7gIlqjzcbH/PKinvhBLKQQ
	 1clOL6qxQh0N+gPxPCwZRySycv1rJJn4JEPUu/O6Nj75CgTaztZ8kCbJuS2jh963DV
	 GKmbDVJomJ2q853602/1TTy11TZA2diB4fHdRi/AMEXdUqZzQWQ9dfHDjKVROdLXPM
	 nG/AwTWPYDdOA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/6] nvme-bpf: eBPF struct_ops path selectors
Date: Tue, 29 Jul 2025 09:06:52 +0200
Message-ID: <20250729070653.125258-6-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729070653.125258-1-hare@kernel.org>
References: <20250729070653.125258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250729_000715_537527_1395FD5B 
X-CRM114-Status: GOOD (  28.02  )
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

From: Hannes Reinecke <hare@kernel.org>

Add support for eBPF struct_ops based path selectors. Due to eBPF limitations
we cannot pass in a 'struct nvme_ns' as argument nor return a 'struct nvme_ns'
from a function, so the eBPF path selectors use a 'struct nvme_bpf_iter'
to iterate over all paths in a struct nvme_ns_head.
That satifies the constrains of the eBPF verifier and allows us to provide
two helper functions 'nvme_bpf_first_path()' and 'nvme_bpf_next_path()'
to iterate over all paths in a namespace.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/Kconfig     |   9 +
 drivers/nvme/host/Makefile    |   1 +
 drivers/nvme/host/bpf.h       |  33 ++++
 drivers/nvme/host/bpf_ops.c   | 347 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c      |   3 +
 drivers/nvme/host/multipath.c |   9 +-
 drivers/nvme/host/nvme.h      |   6 +-
 include/linux/nvme-bpf.h      |  54 ++++++
 8 files changed, 460 insertions(+), 2 deletions(-)
 create mode 100644 drivers/nvme/host/bpf.h
 create mode 100644 drivers/nvme/host/bpf_ops.c
 create mode 100644 include/linux/nvme-bpf.h

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index 31974c7dd20c..7cc1f3898712 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -122,6 +122,15 @@ config NVME_HOST_AUTH
 
 	  If unsure, say N.
 
+config NVME_BPF
+	bool "NVMe multipath BPF path selector"
+	depends on NVME_MULTIPATH
+	depends on BPF_SYSCALL
+	help
+	  Provide support for eBPF multipath path selectors
+
+	  if unsure, say N.
+
 config NVME_APPLE
 	tristate "Apple ANS2 NVM Express host driver"
 	depends on OF && BLOCK
diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 6414ec968f99..f81d6349faf6 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -18,6 +18,7 @@ nvme-core-$(CONFIG_BLK_DEV_ZONED)	+= zns.o
 nvme-core-$(CONFIG_FAULT_INJECTION_DEBUG_FS)	+= fault_inject.o
 nvme-core-$(CONFIG_NVME_HWMON)		+= hwmon.o
 nvme-core-$(CONFIG_NVME_HOST_AUTH)	+= auth.o
+nvme-core-$(CONFIG_NVME_BPF)		+= bpf_ops.o
 
 nvme-y					+= pci.o
 
diff --git a/drivers/nvme/host/bpf.h b/drivers/nvme/host/bpf.h
new file mode 100644
index 000000000000..f819332d5293
--- /dev/null
+++ b/drivers/nvme/host/bpf.h
@@ -0,0 +1,33 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+#ifndef NVME_INT_BPF_HEADER
+#define NVME_INT_BPF_HEADER
+
+#ifdef CONFIG_NVME_BPF
+#include <linux/filter.h>
+#include <linux/nvme-bpf.h>
+
+static inline bool nvme_bpf_enabled(struct nvme_ns_head *head)
+{
+	return !!(srcu_dereference(head->bpf_ops, &head->srcu));
+}
+
+void nvme_bpf_detach(struct nvme_ns_head *head);
+struct nvme_ns *nvme_bpf_select_path(struct nvme_ns_head *head, sector_t sector);
+
+int __init nvme_bpf_struct_ops_init(void);
+
+#else
+
+static inline bool nvme_bpf_enabled(struct nvme_ns_head *head)
+{
+	return false;
+}
+
+static inline void nvme_bpf_detach(struct nvme_ns_head *head) {}
+static inline struct nvme_ns *nvme_bpf_select_path(struct nvme_ns_head *head, sector_t sector)
+{
+	return NULL;
+}
+
+#endif
+#endif
diff --git a/drivers/nvme/host/bpf_ops.c b/drivers/nvme/host/bpf_ops.c
new file mode 100644
index 000000000000..5413541f6f22
--- /dev/null
+++ b/drivers/nvme/host/bpf_ops.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+/* Copyright (c) 2025 Hannes Reinecke, SUSE */
+
+#include <linux/bpf_verifier.h>
+#include <linux/bpf.h>
+#include <linux/btf.h>
+#include "nvme.h"
+#include "bpf.h"
+
+static struct btf *nvme_bpf_ops_btf;
+static char nvme_bpf_ops_name[] = "nvme_bpf_ops";
+
+static int nvme_bpf_ops_init(struct btf *btf)
+{
+	nvme_bpf_ops_btf = btf;
+	return 0;
+}
+
+static bool nvme_bpf_ops_is_valid_access(int off, int size,
+					  enum bpf_access_type type,
+					  const struct bpf_prog *prog,
+					  struct bpf_insn_access_aux *info)
+{
+	return bpf_tracing_btf_ctx_access(off, size, type, prog, info);
+}
+
+BTF_ID_LIST(nvme_bpf_ops_args_ids)
+BTF_ID(struct, nvme_ns_head)
+BTF_ID(struct, nvme_ns)
+BTF_ID(struct, nvme_bpf_iter)
+
+static int nvme_bpf_ops_btf_struct_access(struct bpf_verifier_log *log,
+					  const struct bpf_reg_state *reg,
+					  int off, int size)
+{
+	const struct btf_type *nhit, *nit, *niter, *t;
+
+	nhit = btf_type_by_id(reg->btf, nvme_bpf_ops_args_ids[0]);
+	nit = btf_type_by_id(reg->btf, nvme_bpf_ops_args_ids[1]);
+	niter = btf_type_by_id(reg->btf, nvme_bpf_ops_args_ids[2]);
+
+	t = btf_type_by_id(reg->btf, reg->btf_id);
+	if (t != nhit && t != niter) {
+		bpf_log(log, "write access to struct %d is not supported\n", reg->btf_id);
+		return -EACCES;
+	}
+	if (t == niter) {
+		/* Allow writes to the 'head' element */
+		if (off >= offsetof(struct nvme_bpf_iter, head) &&
+		    off + size < offsetofend(struct nvme_bpf_iter, head))
+			return NOT_INIT;
+	} else {
+		/* Allow writes to the 'bpf_ops' element */
+		if (off >= offsetof(struct nvme_ns_head, bpf_ops) &&
+		    off + size < offsetofend(struct nvme_ns_head, bpf_ops)) {
+			return NOT_INIT;
+		}
+	}
+	bpf_log(log, "write access for struct %s at off %d with size %d\n",
+		nvme_bpf_ops_name, off, size);
+	return -EACCES;
+}
+
+static const struct bpf_verifier_ops nvme_bpf_verifier_ops = {
+	.get_func_proto = bpf_base_func_proto,
+	.is_valid_access = nvme_bpf_ops_is_valid_access,
+	.btf_struct_access = nvme_bpf_ops_btf_struct_access,
+};
+
+static int nvme_bpf_ops_check_member(const struct btf_type *t,
+				     const struct btf_member *member,
+				     const struct bpf_prog *prog)
+{
+	u32 moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct nvme_bpf_ops, select_path):
+		break;
+	default:
+		if (prog->sleepable)
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int nvme_bpf_ops_init_member(const struct btf_type *t,
+				    const struct btf_member *member,
+				    void *kdata, const void *udata)
+{
+	const struct nvme_bpf_ops *uops;
+	struct nvme_bpf_ops *kops;
+	u32 moff;
+
+	uops = (const struct nvme_bpf_ops *)udata;
+	kops = (struct nvme_bpf_ops *)kdata;
+
+	moff = __btf_member_bit_offset(t, member) / 8;
+
+	switch (moff) {
+	case offsetof(struct nvme_bpf_ops, subsysnqn):
+		memcpy(kops->subsysnqn, uops->subsysnqn,
+		       sizeof(kops->subsysnqn));
+		return 1;
+	case offsetof(struct nvme_bpf_ops, nsid):
+		kops->nsid = uops->nsid;
+		return 1;
+	case offsetof(struct nvme_bpf_ops, uuid):
+		if (uuid_is_null(&uops->uuid))
+			uuid_gen(&kops->uuid);
+		else
+			uuid_copy(&kops->uuid, &uops->uuid);
+		return 1;
+	}
+	return 0;
+}
+
+static int nvme_bpf_reg(void *kdata, struct bpf_link *link)
+{
+	struct nvme_bpf_ops *ops = kdata;
+	struct nvme_ns_head *head;
+	struct nvme_subsystem *subsys = NULL;
+
+	pr_debug("%s: register %s nsid %d\n",
+		 __func__, ops->subsysnqn, ops->nsid);
+
+	subsys = nvme_find_get_subsystem(ops->subsysnqn);
+	if (!subsys)
+		return -EINVAL;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(head, &subsys->nsheads, entry) {
+		if (head->ns_id != ops->nsid)
+			continue;
+		if (head->bpf_ops) {
+			pr_debug("%s: instance %d already attached\n",
+				 __func__, head->instance);
+			continue;
+		}
+		if (nvme_tryget_ns_head(head)) {
+			mutex_lock(&head->lock);
+			ops->head = head;
+			head->bpf_ops = ops;
+			mutex_unlock(&head->lock);
+			pr_debug("%s: attached to %d\n",
+				 __func__, head->instance);
+			synchronize_srcu(&head->srcu);
+			break;
+		}
+	}
+	mutex_unlock(&subsys->lock);
+	nvme_put_subsystem(subsys);
+
+	return 0;
+}
+
+static void nvme_bpf_unreg(void *kdata, struct bpf_link *link)
+{
+	struct nvme_bpf_ops *ops = kdata;
+	struct nvme_ns_head *head;
+
+	if (ops->head) {
+		head = ops->head;
+		pr_debug("%s: unregistered from %d\n",
+			 __func__, head->instance);
+		mutex_lock(&head->lock);
+		head->bpf_ops = NULL;
+		ops->head = NULL;
+		mutex_unlock(&head->lock);
+		nvme_put_ns_head(head);
+		synchronize_srcu(&head->srcu);
+	}
+}
+
+void nvme_bpf_detach(struct nvme_ns_head *head)
+{
+	struct nvme_bpf_ops *ops =
+		srcu_dereference(head->bpf_ops, &head->srcu);
+
+	if (ops) {
+		mutex_lock(&head->lock);
+		rcu_assign_pointer(head->bpf_ops, NULL);
+		list_del_init(&head->bpf_list);
+		mutex_unlock(&head->lock);
+		nvme_put_ns_head(head);
+	}
+}
+
+static int __nvme_bpf_select_path(struct nvme_bpf_iter *iter,
+				  sector_t sector)
+{
+	return -ENXIO;
+}
+
+static struct nvme_bpf_ops __bpf_nvme_bpf_ops = {
+	.uuid = {},
+	.subsysnqn = "",
+	.nsid = UINT_MAX,
+	.select_path = __nvme_bpf_select_path,
+	.head = NULL,
+};
+
+struct nvme_ns *nvme_bpf_select_path(struct nvme_ns_head *head,
+				     sector_t sector)
+{
+	struct nvme_ns *ns = NULL;
+	struct nvme_bpf_ops *ops =
+		srcu_dereference(head->bpf_ops, &head->srcu);
+	struct nvme_bpf_iter iter = {
+		.head = head,
+	};
+	s32 cntlid;
+
+	if (ops) {
+		cntlid = ops->select_path(&iter, sector);
+		if (cntlid < 0)
+			return ERR_PTR(cntlid);
+		if (iter.curr) {
+			ns = iter.curr;
+			if (ns->ctrl->cntlid == cntlid)
+				return ns;
+		}
+	}
+	return ERR_PTR(-ENXIO);
+}
+
+__bpf_kfunc_start_defs();
+
+/**
+ * nvme_bpf_first_path - select the first path from a nvme bpf path iterator
+ * @iter: nvme_bpf path iterator
+ *
+ * Initializes @iter with the first nvme namespace path (if present) and
+ * returns the controller id of the first nvme namespace path or
+ * -ENXIO if no namespace path is present.
+ */
+__bpf_kfunc int nvme_bpf_first_path(struct nvme_bpf_iter *iter)
+{
+	struct nvme_ns *ns;
+
+	if (!iter || !iter->head)
+		return -EINVAL;
+	if (!nvme_bpf_enabled(iter->head))
+		return -EPERM;
+
+	ns = list_first_or_null_rcu(&iter->head->list, struct nvme_ns, siblings);
+	iter->curr = ns;
+	iter->prev = NULL;
+	return ns ? ns->ctrl->cntlid : -ENXIO;
+}
+EXPORT_SYMBOL_GPL(nvme_bpf_first_path);
+
+/**
+ * nvme_bpf_next_path - select the next path from a nvme bpf path iterator
+ * @iter: nvme_bpf path iterator
+ *
+ * Moves @iter to the next namespace path in @curr, storing the previous namespace
+ * path in @prev. Returns the controller id of the current namespace path, -ENXIO
+ * if no current path is set, or -EAGAIN if no next namespace is found.
+ */
+__bpf_kfunc int nvme_bpf_next_path(struct nvme_bpf_iter *iter)
+{
+	struct nvme_ns *ns, *old;
+
+	if (!iter || !iter->head)
+		return -EINVAL;
+	if (!nvme_bpf_enabled(iter->head))
+		return -EPERM;
+	if (!iter->curr)
+		return -ENXIO;
+	old = iter->curr;
+	ns = list_next_or_null_rcu(&iter->head->list, &old->siblings, struct nvme_ns,
+				   siblings);
+	iter->prev = old;
+	iter->curr = ns;
+	return ns ? ns->ctrl->cntlid : -EAGAIN;
+}
+EXPORT_SYMBOL_GPL(nvme_bpf_next_path);
+
+/**
+ * nvme_bpf_count_paths - count the number of paths in a nvme bpf path iterator
+ * @iter: nvme_bpf namespace path iterator
+ *
+ * Returns number of paths in @iter
+ */
+__bpf_kfunc u32 nvme_bpf_count_paths(struct nvme_bpf_iter *iter)
+{
+	struct nvme_ns *ns;
+	u32 num = 0;
+
+	if (!iter || !iter->head)
+		return 0;
+	if (!nvme_bpf_enabled(iter->head))
+		return num;
+
+	ns = list_first_or_null_rcu(&iter->head->list, struct nvme_ns, siblings);
+	while (ns) {
+		num++;
+		ns = list_next_or_null_rcu(&iter->head->list, &ns->siblings, struct nvme_ns,
+					   siblings);
+	}
+	return num;
+}
+EXPORT_SYMBOL_GPL(nvme_bpf_count_paths);
+
+__bpf_kfunc_end_defs();
+
+BTF_KFUNCS_START(nvme_bpf_kfunc_set_ids)
+BTF_ID_FLAGS(func, nvme_bpf_first_path, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, nvme_bpf_next_path, KF_TRUSTED_ARGS)
+BTF_ID_FLAGS(func, nvme_bpf_count_paths, KF_TRUSTED_ARGS)
+BTF_KFUNCS_END(nvme_bpf_kfunc_set_ids)
+
+static const struct btf_kfunc_id_set nvme_bpf_kfunc_set = {
+	.owner = THIS_MODULE,
+	.set = &nvme_bpf_kfunc_set_ids,
+};
+
+static struct bpf_struct_ops bpf_nvme_bpf_ops = {
+	.verifier_ops = &nvme_bpf_verifier_ops,
+	.init = nvme_bpf_ops_init,
+	.check_member = nvme_bpf_ops_check_member,
+	.init_member = nvme_bpf_ops_init_member,
+	.reg = nvme_bpf_reg,
+	.unreg = nvme_bpf_unreg,
+	.name = nvme_bpf_ops_name,
+	.cfi_stubs = &__bpf_nvme_bpf_ops,
+	.owner = THIS_MODULE,
+};
+
+int __init nvme_bpf_struct_ops_init(void)
+{
+	int ret;
+
+	ret = register_btf_kfunc_id_set(BPF_PROG_TYPE_STRUCT_OPS,
+					&nvme_bpf_kfunc_set);
+	if (ret) {
+		pr_err("Failed to register nvme_bpf_kfunc_set, error %d\n", ret);
+		return ret;
+	}
+	ret = register_bpf_struct_ops(&bpf_nvme_bpf_ops, nvme_bpf_ops);
+	if (ret)
+		pr_err("Failed to register nvme_bpf_ops, error %d\n", ret);
+	else
+		pr_info("nvme_bpf_ops registered\n");
+	return ret;
+}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a2f3da453af4..e4f69b2f946b 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -27,6 +27,7 @@
 #include "nvme.h"
 #include "fabrics.h"
 #include <linux/nvme-auth.h>
+#include "bpf.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -5381,6 +5382,8 @@ static int __init nvme_core_init(void)
 	result = nvme_init_auth();
 	if (result)
 		goto destroy_ns_chr;
+	if (IS_ENABLED(CONFIG_NVME_BPF))
+		nvme_bpf_struct_ops_init();
 	return 0;
 
 destroy_ns_chr:
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index dee40bd73449..e2c6b13591c4 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -8,6 +8,7 @@
 #include <linux/vmalloc.h>
 #include <trace/events/block.h>
 #include "nvme.h"
+#include "bpf.h"
 
 bool multipath = true;
 static bool multipath_always_on;
@@ -462,12 +463,15 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 	else if (unlikely(!nvme_path_is_optimized(ns)))
 		ns = __nvme_find_path(head, node);
 	if (ns)
-		rcu_assign_pointer(head->current_path[node], found);
+		rcu_assign_pointer(head->current_path[node], ns);
 	return ns;
 }
 
 inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, sector_t sector)
 {
+	if (nvme_bpf_enabled(head))
+		return nvme_bpf_select_path(head, sector);
+
 	switch (READ_ONCE(head->subsys->iopolicy)) {
 	case NVME_IOPOLICY_QD:
 		return nvme_queue_depth_path(head);
@@ -693,6 +697,7 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 		kblockd_schedule_work(&head->requeue_work);
 
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
+		nvme_bpf_detach(head);
 		synchronize_srcu(&head->srcu);
 		del_gendisk(head->disk);
 	}
@@ -727,6 +732,8 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->requeue_work, nvme_requeue_work);
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
+	if (IS_ENABLED(CONFIG_NVME_BPF))
+		INIT_LIST_HEAD(&head->bpf_list);
 	head->delayed_removal_secs = 0;
 
 	/*
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 73b966a6653a..3498620d650b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -17,7 +17,7 @@
 #include <linux/wait.h>
 #include <linux/t10-pi.h>
 #include <linux/ratelimit_types.h>
-
+#include <linux/bpf.h>
 #include <trace/events/block.h>
 
 extern const struct pr_ops nvme_pr_ops;
@@ -499,6 +499,10 @@ struct nvme_ns_head {
 
 	u16			nr_plids;
 	u16			*plids;
+#ifdef CONFIG_NVME_BPF
+	struct list_head	bpf_list;
+	struct nvme_bpf_ops __rcu *bpf_ops;
+#endif
 #ifdef CONFIG_NVME_MULTIPATH
 	struct bio_list		requeue_list;
 	spinlock_t		requeue_lock;
diff --git a/include/linux/nvme-bpf.h b/include/linux/nvme-bpf.h
new file mode 100644
index 000000000000..687b96e101ef
--- /dev/null
+++ b/include/linux/nvme-bpf.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2025 Hannes Reinecke, SUSE Software Solutions
+ */
+
+#ifndef _NVME_BPF_H
+#define _NVME_BPF_H
+
+struct nvme_ns_head;
+struct nvme_ns;
+
+/**
+ * struct nvme_bpf_iter - Iterator for select_path BPF function
+ * @head: namespace head to iterate over
+ * @curr: current namespace path
+ * @prev: previous namespace path
+ */
+struct nvme_bpf_iter {
+	struct nvme_ns_head *head;
+	struct nvme_ns *curr;
+	struct nvme_ns *prev;
+};
+
+/**
+ * struct nvme_bpf_ops - A BPF struct_ops of callbacks allowing to implement
+ * 			an nvme bpf path selector
+ * @uuid: ops uuid
+ * @subsys_id: instance number of the subsystem to attach to
+ * @nsid: namespace ID within @subsys_id to attach to
+ * @select_path: callback for selecting the path for @sector
+ */
+struct nvme_bpf_ops {
+	/* UUID to distinguish different instances */
+	uuid_t			uuid;
+
+	/* Subsystem NQN */
+	char			subsysnqn[256];
+
+	/* Namespace ID number or -1 if valid for all namespace */
+	int		nsid;
+
+	/* Return the controller ID of the selected path or -1 if not found */
+	int		(*select_path)(struct nvme_bpf_iter *, sector_t);
+
+	/* private: don't show in doc, must be the last field */
+	struct nvme_ns_head *head;
+};
+
+int nvme_bpf_first_path(struct nvme_bpf_iter *iter);
+int nvme_bpf_next_path(struct nvme_bpf_iter *iter);
+u32 nvme_bpf_count_paths(struct nvme_bpf_iter *iter);
+
+#endif
+
-- 
2.43.0


