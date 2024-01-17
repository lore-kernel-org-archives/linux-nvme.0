Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA3C9C47258
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jan 2024 08:21:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qOTmJhPF8g4C6uiHF6766ZcK54aGVAH8+9jmKW4DquU=; b=2QsZspQ4uiAYUd+5jYIWUzMAr3
	wsFNaIxk3sMsAFbPNHK1ds/jaW/fMCzrnH3it4B08W4gjZ1vBVhvdVLK2NZczfGMQnNozwDRz5gPX
	1v8vCX9HVyq5CNA/yEiEf81olaXIwY/2LvUPrVyaNFreDl2Owkz7qnwiZwFaWQsAZFxD4C1aHanW4
	/7jZu7GB0glwVPE/WKs8/6hQ46CY2zk81RBu+MtAqeA+Hsfy4822TVifj/FCt5zUk87uLEv00+eac
	bOY4TxnwKRQD7tQHhDEVDnBcLoi886Jq3SeRkuUHQtkZGbFq2018ZheFfB+9mrivh3q7tIkvwE2n2
	VeFflsjg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ1At-00ErII-28;
	Wed, 17 Jan 2024 08:21:27 +0000
Received: from out30-131.freemail.mail.aliyun.com ([115.124.30.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rQ1An-00ErFy-02
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jan 2024 08:21:25 +0000
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045176;MF=kanie@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0W-oiT2t_1705479672;
Received: from localhost(mailfrom:kanie@linux.alibaba.com fp:SMTPD_---0W-oiT2t_1705479672)
          by smtp.aliyun-inc.com;
          Wed, 17 Jan 2024 16:21:17 +0800
From: Guixin Liu <kanie@linux.alibaba.com>
To: sagi@grimberg.me,
	hch@lst.de,
	kch@nvidia.com,
	kbusch@kernel.org
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH V3 1/2] nvmet: support reservation feature
Date: Wed, 17 Jan 2024 16:21:07 +0800
Message-ID: <20240117082108.101836-2-kanie@linux.alibaba.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240117082108.101836-1-kanie@linux.alibaba.com>
References: <20240117082108.101836-1-kanie@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240117_002121_569641_BF8A6A92 
X-CRM114-Status: GOOD (  21.41  )
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

This patch implements the reservation feature, includes:
1. reservation register(register, unregister and replace).
2. reservation acquire(acquire, preempt, preempt and abort).
3. reservation release(release and clear).
4. reservation report.

And also make reservation configurable, one can set ns to support
reservation before enable ns. The default of resv_enable is false.

Signed-off-by: Guixin Liu <kanie@linux.alibaba.com>
---
 drivers/nvme/target/Makefile    |   2 +-
 drivers/nvme/target/admin-cmd.c |  14 +-
 drivers/nvme/target/configfs.c  |  27 +
 drivers/nvme/target/core.c      |  49 +-
 drivers/nvme/target/nvmet.h     |  33 ++
 drivers/nvme/target/pr.c        | 979 ++++++++++++++++++++++++++++++++
 include/linux/nvme.h            |  48 ++
 7 files changed, 1145 insertions(+), 7 deletions(-)
 create mode 100644 drivers/nvme/target/pr.c

diff --git a/drivers/nvme/target/Makefile b/drivers/nvme/target/Makefile
index c66820102493..f9bfc904a5b3 100644
--- a/drivers/nvme/target/Makefile
+++ b/drivers/nvme/target/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_TARGET_FCLOOP)	+= nvme-fcloop.o
 obj-$(CONFIG_NVME_TARGET_TCP)		+= nvmet-tcp.o
 
 nvmet-y		+= core.o configfs.o admin-cmd.o fabrics-cmd.o \
-			discovery.o io-cmd-file.o io-cmd-bdev.o
+			discovery.o io-cmd-file.o io-cmd-bdev.o pr.o
 nvmet-$(CONFIG_NVME_TARGET_PASSTHRU)	+= passthru.o
 nvmet-$(CONFIG_BLK_DEV_ZONED)		+= zns.o
 nvmet-$(CONFIG_NVME_TARGET_AUTH)	+= fabrics-cmd-auth.o auth.o
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 39cb570f833d..791bc7e740c0 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -176,6 +176,10 @@ static void nvmet_get_cmd_effects_nvm(struct nvme_effects_log *log)
 	log->iocs[nvme_cmd_read] =
 	log->iocs[nvme_cmd_flush] =
 	log->iocs[nvme_cmd_dsm]	=
+	log->iocs[nvme_cmd_resv_acquire] =
+	log->iocs[nvme_cmd_resv_register] =
+	log->iocs[nvme_cmd_resv_release] =
+	log->iocs[nvme_cmd_resv_report] =
 		cpu_to_le32(NVME_CMD_EFFECTS_CSUPP);
 	log->iocs[nvme_cmd_write] =
 	log->iocs[nvme_cmd_write_zeroes] =
@@ -340,6 +344,8 @@ static void nvmet_execute_get_log_page(struct nvmet_req *req)
 		return nvmet_execute_get_log_cmd_effects_ns(req);
 	case NVME_LOG_ANA:
 		return nvmet_execute_get_log_page_ana(req);
+	case NVME_LOG_RESERVATION:
+		return nvmet_execute_get_log_page_resv(req);
 	}
 	pr_debug("unhandled lid %d on qid %d\n",
 	       req->cmd->get_log_page.lid, req->sq->qid);
@@ -550,7 +556,13 @@ static void nvmet_execute_identify_ns(struct nvmet_req *req)
 	 */
 	id->nmic = NVME_NS_NMIC_SHARED;
 	id->anagrpid = cpu_to_le32(req->ns->anagrpid);
-
+	id->rescap = NVME_PR_SUPPORT_WRITE_EXCLUSIVE |
+		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS |
+		     NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY |
+		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY |
+		     NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS |
+		     NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS |
+		     NVME_PR_SUPPORT_IEKEY_VER_1_3_DEF;
 	memcpy(&id->nguid, &req->ns->nguid, sizeof(id->nguid));
 
 	id->lbaf[0].ds = req->ns->blksize_shift;
diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index d937fe05129e..1ac4802ec818 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -714,6 +714,32 @@ static ssize_t nvmet_ns_revalidate_size_store(struct config_item *item,
 
 CONFIGFS_ATTR_WO(nvmet_ns_, revalidate_size);
 
+static ssize_t nvmet_ns_resv_enable_show(struct config_item *item, char *page)
+{
+	return sprintf(page, "%d\n", to_nvmet_ns(item)->pr.enable);
+}
+
+static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
+					const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (kstrtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("the ns:%d is already enabled.\n", ns->nsid);
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+	ns->pr.enable = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+CONFIGFS_ATTR(nvmet_ns_, resv_enable);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -722,6 +748,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_enable,
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_revalidate_size,
+	&nvmet_ns_attr_resv_enable,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
diff --git a/drivers/nvme/target/core.c b/drivers/nvme/target/core.c
index 3935165048e7..a5019881d60b 100644
--- a/drivers/nvme/target/core.c
+++ b/drivers/nvme/target/core.c
@@ -591,6 +591,8 @@ int nvmet_ns_enable(struct nvmet_ns *ns)
 	if (ns->nsid > subsys->max_nsid)
 		subsys->max_nsid = ns->nsid;
 
+	nvmet_pr_init_ns(ns);
+
 	ret = xa_insert(&subsys->namespaces, ns->nsid, ns, GFP_KERNEL);
 	if (ret)
 		goto out_restore_subsys_maxnsid;
@@ -651,6 +653,7 @@ void nvmet_ns_disable(struct nvmet_ns *ns)
 
 	subsys->nr_namespaces--;
 	nvmet_ns_changed(subsys, ns->nsid);
+	nvmet_pr_exit_ns(ns);
 	nvmet_ns_dev_disable(ns);
 out_unlock:
 	mutex_unlock(&subsys->lock);
@@ -904,18 +907,34 @@ static u16 nvmet_parse_io_cmd(struct nvmet_req *req)
 		return ret;
 	}
 
+	if (req->ns->pr.enable) {
+		ret = nvmet_parse_pr_cmd(req);
+		if (!ret)
+			return ret;
+	}
+
 	switch (req->ns->csi) {
 	case NVME_CSI_NVM:
 		if (req->ns->file)
-			return nvmet_file_parse_io_cmd(req);
-		return nvmet_bdev_parse_io_cmd(req);
+			ret = nvmet_file_parse_io_cmd(req);
+		else
+			ret = nvmet_bdev_parse_io_cmd(req);
+		break;
 	case NVME_CSI_ZNS:
 		if (IS_ENABLED(CONFIG_BLK_DEV_ZONED))
-			return nvmet_bdev_zns_parse_io_cmd(req);
-		return NVME_SC_INVALID_IO_CMD_SET;
+			ret = nvmet_bdev_zns_parse_io_cmd(req);
+		else
+			ret = NVME_SC_INVALID_IO_CMD_SET;
+		break;
 	default:
-		return NVME_SC_INVALID_IO_CMD_SET;
+		ret = NVME_SC_INVALID_IO_CMD_SET;
 	}
+	if (ret)
+		return ret;
+
+	if (req->ns->pr.enable)
+		ret = nvmet_pr_check_cmd_access(req);
+	return ret;
 }
 
 bool nvmet_req_init(struct nvmet_req *req, struct nvmet_cq *cq,
@@ -1231,6 +1250,21 @@ static void nvmet_init_cap(struct nvmet_ctrl *ctrl)
 		nvmet_passthrough_override_cap(ctrl);
 }
 
+bool nvmet_is_host_still_connected(uuid_t *hostid, struct nvmet_subsys *subsys)
+{
+	struct nvmet_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (uuid_equal(hostid, &ctrl->hostid)) {
+			mutex_unlock(&subsys->lock);
+			return true;
+		}
+	}
+	mutex_unlock(&subsys->lock);
+	return false;
+}
+
 struct nvmet_ctrl *nvmet_ctrl_find_get(const char *subsysnqn,
 				       const char *hostnqn, u16 cntlid,
 				       struct nvmet_req *req)
@@ -1450,6 +1484,10 @@ u16 nvmet_alloc_ctrl(const char *subsysnqn, const char *hostnqn,
 	ctrl->err_counter = 0;
 	spin_lock_init(&ctrl->error_lock);
 
+	ctrl->resv_log_counter = 0;
+	mutex_init(&ctrl->resv_log_lock);
+	INIT_LIST_HEAD(&ctrl->resv_log_list);
+
 	nvmet_start_keep_alive_timer(ctrl);
 
 	mutex_lock(&subsys->lock);
@@ -1488,6 +1526,7 @@ static void nvmet_ctrl_free(struct kref *ref)
 	cancel_work_sync(&ctrl->fatal_err_work);
 
 	nvmet_destroy_auth(ctrl);
+	nvmet_ctrl_destroy_pr(ctrl);
 
 	ida_free(&cntlid_ida, ctrl->cntlid);
 
diff --git a/drivers/nvme/target/nvmet.h b/drivers/nvme/target/nvmet.h
index 6c8acebe1a1a..4c98a63319c0 100644
--- a/drivers/nvme/target/nvmet.h
+++ b/drivers/nvme/target/nvmet.h
@@ -56,6 +56,22 @@
 #define IPO_IATTR_CONNECT_SQE(x)	\
 	(cpu_to_le32(offsetof(struct nvmf_connect_command, x)))
 
+struct nvmet_pr_registrant {
+	u64			rkey;
+	uuid_t			hostid;
+	enum nvme_pr_type	rtype;
+	struct list_head	entry;
+	struct rcu_head		rcu;
+};
+
+struct nvmet_pr {
+	bool			enable;
+	atomic64_t		generation;
+	struct nvmet_pr_registrant __rcu *holder;
+	struct mutex		pr_lock;
+	struct list_head	registrant_list;
+};
+
 struct nvmet_ns {
 	struct percpu_ref	ref;
 	struct bdev_handle	*bdev_handle;
@@ -85,6 +101,7 @@ struct nvmet_ns {
 	int			pi_type;
 	int			metadata_size;
 	u8			csi;
+	struct nvmet_pr		pr;
 };
 
 static inline struct nvmet_ns *to_nvmet_ns(struct config_item *item)
@@ -190,6 +207,11 @@ static inline bool nvmet_port_secure_channel_required(struct nvmet_port *port)
     return nvmet_port_disc_addr_treq_secure_channel(port) == NVMF_TREQ_REQUIRED;
 }
 
+struct nvmet_pr_log_entry {
+	struct nvme_pr_log log;
+	struct list_head entry;
+};
+
 struct nvmet_ctrl {
 	struct nvmet_subsys	*subsys;
 	struct nvmet_sq		**sqs;
@@ -243,6 +265,9 @@ struct nvmet_ctrl {
 	u8			*dh_key;
 	size_t			dh_keysize;
 #endif
+	struct mutex		resv_log_lock;
+	u64			resv_log_counter;
+	struct list_head	resv_log_list;
 };
 
 struct nvmet_subsys {
@@ -750,4 +775,12 @@ static inline bool nvmet_has_auth(struct nvmet_ctrl *ctrl)
 static inline const char *nvmet_dhchap_dhgroup_name(u8 dhgid) { return NULL; }
 #endif
 
+void nvmet_pr_init_ns(struct nvmet_ns *ns);
+u16 nvmet_parse_pr_cmd(struct nvmet_req *req);
+u16 nvmet_pr_check_cmd_access(struct nvmet_req *req);
+void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl);
+void nvmet_pr_exit_ns(struct nvmet_ns *ns);
+bool nvmet_is_host_still_connected(uuid_t *hostid, struct nvmet_subsys *subsys);
+void nvmet_execute_get_log_page_resv(struct nvmet_req *req);
+
 #endif /* _NVMET_H */
diff --git a/drivers/nvme/target/pr.c b/drivers/nvme/target/pr.c
new file mode 100644
index 000000000000..1a741e617cd3
--- /dev/null
+++ b/drivers/nvme/target/pr.c
@@ -0,0 +1,979 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVMe over Fabrics Persist Reservation.
+ * Copyright (c) 2024 Guixin Liu, Alibaba Group.
+ * All rights reserved.
+ */
+#include "nvmet.h"
+#include <linux/slab.h>
+#include <asm/unaligned.h>
+
+#define NVMET_PR_MAX_LOG_QUEUE_SIZE 128
+
+struct nvmet_pr_register_data {
+	__le64	crkey;
+	__le64	nrkey;
+};
+
+struct nvmet_pr_acquire_data {
+	__le64	crkey;
+	__le64	prkey;
+};
+
+struct nvmet_pr_release_data {
+	__le64	crkey;
+};
+
+static inline struct nvmet_ns *nvmet_pr_to_ns(struct nvmet_pr *pr)
+{
+	return container_of(pr, struct nvmet_ns, pr);
+}
+
+static u16 nvmet_pr_validate_rtype(u8 rtype)
+{
+	if (rtype < NVME_PR_WRITE_EXCLUSIVE ||
+	    rtype > NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
+		return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+
+	return NVME_SC_SUCCESS;
+}
+
+static u16 nvmet_pr_set_rtype_and_holder(struct nvmet_pr *pr, u8 rtype,
+					 struct nvmet_pr_registrant *reg)
+{
+	u16 status;
+
+	status = nvmet_pr_validate_rtype(rtype);
+	if (!status) {
+		reg->rtype = rtype;
+		rcu_assign_pointer(pr->holder, reg);
+	}
+	return status;
+}
+
+static inline void nvmet_pr_inc_generation(struct nvmet_pr *pr)
+{
+	atomic64_inc(&pr->generation);
+	if (atomic64_read(&pr->generation) > U32_MAX)
+		atomic64_set(&pr->generation, 0);
+}
+
+static struct nvmet_pr_registrant *nvmet_pr_find_registrant_by_hostid(
+						struct nvmet_pr *pr,
+						uuid_t *hostid)
+{
+	struct nvmet_pr_registrant *reg;
+
+	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
+		if (uuid_equal(&reg->hostid, hostid))
+			return reg;
+	}
+	return NULL;
+}
+
+static u16 nvmet_pr_register_check_rkey(struct nvmet_req *req,
+					struct nvmet_pr_register_data *d)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *reg;
+
+	reg = nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid);
+	if (!reg || reg->rkey == le64_to_cpu(d->nrkey))
+		return NVME_SC_SUCCESS;
+
+	return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+}
+
+static u16 nvmet_pr_register(struct nvmet_req *req,
+			     struct nvmet_pr_register_data *d)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *reg;
+	u16 status;
+
+	status = nvmet_pr_register_check_rkey(req, d);
+	if (status)
+		return status;
+
+	reg = kmalloc(sizeof(*reg), GFP_KERNEL);
+	if (!reg)
+		return NVME_SC_INTERNAL;
+
+	memset(reg, 0, sizeof(*reg));
+	INIT_LIST_HEAD(&reg->entry);
+	reg->rkey = le64_to_cpu(d->nrkey);
+	uuid_copy(&reg->hostid, &ctrl->hostid);
+
+	mutex_lock(&pr->pr_lock);
+	list_add_tail_rcu(&reg->entry, &pr->registrant_list);
+	mutex_unlock(&pr->pr_lock);
+	return NVME_SC_SUCCESS;
+}
+
+void nvmet_execute_get_log_page_resv(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr_log_entry *log_entry;
+	u16 status = NVME_SC_SUCCESS;
+	struct nvme_pr_log *log;
+
+	mutex_lock(&ctrl->resv_log_lock);
+	log_entry = list_first_entry_or_null(&ctrl->resv_log_list,
+				     struct nvmet_pr_log_entry, entry);
+	if (!log_entry)
+		goto out;
+
+	list_del(&log_entry->entry);
+	log = &log_entry->log;
+	log->nr_pages = min(list_count_nodes(&ctrl->resv_log_list), 255);
+	status = nvmet_copy_to_sgl(req, 0, log, sizeof(*log));
+	kfree(log_entry);
+out:
+	mutex_unlock(&ctrl->resv_log_lock);
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_pr_add_resv_log(struct nvmet_ctrl *ctrl, u8 log_type, u32 nsid)
+{
+	struct nvmet_pr_log_entry *log_entry;
+	struct nvme_pr_log *log;
+
+	mutex_lock(&ctrl->resv_log_lock);
+	ctrl->resv_log_counter++;
+	if (ctrl->resv_log_counter == U64_MAX)
+		ctrl->resv_log_counter = 1;
+	if (list_count_nodes(&ctrl->resv_log_list) >= NVMET_PR_MAX_LOG_QUEUE_SIZE)
+		goto inc_latest_count;
+
+	log_entry = kmalloc(sizeof(*log_entry), GFP_ATOMIC);
+	if (!log_entry)
+		goto inc_latest_count;
+
+	log = &log_entry->log;
+	log->count = cpu_to_le64(ctrl->resv_log_counter);
+	log->type = log_type;
+	log->nsid = cpu_to_le32(nsid);
+
+	list_add_tail(&log_entry->entry, &ctrl->resv_log_list);
+	goto unlock;
+
+inc_latest_count:
+	pr_warn("a reservation log lost, cntlid:%d, log_type:%d, nsid:%d\n",
+		ctrl->cntlid, log_type, nsid);
+	log_entry = list_last_entry(&ctrl->resv_log_list,
+				    struct nvmet_pr_log_entry, entry);
+	if (log_entry)
+		log_entry->log.count =
+			cpu_to_le64(le64_to_cpu(log_entry->log.count) + 1);
+unlock:
+	mutex_unlock(&ctrl->resv_log_lock);
+}
+
+static void nvmet_pr_send_resv_released(struct nvmet_pr *pr, uuid_t *hostid)
+{
+	struct nvmet_ns *ns = nvmet_pr_to_ns(pr);
+	struct nvmet_subsys *subsys = ns->subsys;
+	struct nvmet_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (!uuid_equal(&ctrl->hostid, hostid) &&
+		    nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid)) {
+			nvmet_pr_add_resv_log(ctrl,
+					      NVME_PR_LOG_RESERVATION_RELEASED,
+					      ns->nsid);
+			nvmet_add_async_event(ctrl, NVME_AER_CSS,
+					      NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
+					      NVME_LOG_RESERVATION);
+		}
+	}
+	mutex_unlock(&subsys->lock);
+}
+
+static void nvmet_pr_send_event_by_hostid(struct nvmet_pr *pr, uuid_t *hostid,
+					  u8 log_type)
+{
+	struct nvmet_ns *ns = nvmet_pr_to_ns(pr);
+	struct nvmet_subsys *subsys = ns->subsys;
+	struct nvmet_ctrl *ctrl;
+
+	mutex_lock(&subsys->lock);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (uuid_equal(hostid, &ctrl->hostid)) {
+			nvmet_pr_add_resv_log(ctrl, log_type, ns->nsid);
+			nvmet_add_async_event(ctrl, NVME_AER_CSS,
+					      NVME_AEN_RESV_LOG_PAGE_AVALIABLE,
+					      NVME_LOG_RESERVATION);
+		}
+	}
+	mutex_unlock(&subsys->lock);
+}
+
+static void nvmet_pr_send_resv_preempted(struct nvmet_pr *pr, uuid_t *hostid)
+{
+	nvmet_pr_send_event_by_hostid(pr, hostid,
+				      NVME_PR_LOG_RESERVATOPM_PREEMPTED);
+}
+
+static void nvmet_pr_send_registration_preempted(struct nvmet_pr *pr,
+						 uuid_t *hostid)
+{
+	nvmet_pr_send_event_by_hostid(pr, hostid,
+				      NVME_PR_LOG_REGISTRATION_PREEMPTED);
+}
+
+static void __nvmet_pr_unregister_one(struct nvmet_pr *pr,
+				      struct nvmet_pr_registrant *reg)
+{
+	struct nvmet_pr_registrant *first_reg;
+	struct nvmet_pr_registrant *holder;
+	u8 original_rtype;
+
+	list_del_rcu(&reg->entry);
+
+	holder = rcu_dereference_protected(pr->holder,
+					   lockdep_is_held(&pr->pr_lock));
+	if (reg != holder)
+		goto out;
+
+	original_rtype = holder->rtype;
+	if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
+	    original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
+		first_reg = list_first_entry_or_null(&pr->registrant_list,
+					struct nvmet_pr_registrant, entry);
+		if (first_reg)
+			first_reg->rtype = original_rtype;
+		rcu_assign_pointer(pr->holder, first_reg);
+		goto out;
+	}
+
+	rcu_assign_pointer(pr->holder, NULL);
+
+	if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY ||
+	    original_rtype == NVME_PR_WRITE_EXCLUSIVE_REG_ONLY)
+		nvmet_pr_send_resv_released(pr, &reg->hostid);
+
+out:
+	kfree_rcu(reg, rcu);
+}
+
+static u16 nvmet_pr_unregister(struct nvmet_req *req,
+			       struct nvmet_pr_register_data *d,
+			       bool ignore_key)
+{
+	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *tmp;
+
+	mutex_lock(&pr->pr_lock);
+	list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
+		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
+			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey)) {
+				status = NVME_SC_SUCCESS;
+				__nvmet_pr_unregister_one(pr, reg);
+			}
+			break;
+		}
+	}
+	mutex_unlock(&pr->pr_lock);
+
+	return status;
+}
+
+static u16 __nvmet_pr_do_replace(struct nvmet_pr *pr,
+				 struct nvmet_pr_registrant *reg,
+				 u64 nrkey)
+{
+	struct nvmet_pr_registrant *holder;
+	struct nvmet_pr_registrant *new;
+
+	holder = rcu_dereference_protected(pr->holder,
+					   lockdep_is_held(&pr->pr_lock));
+	if (reg != holder) {
+		reg->rkey = nrkey;
+		return NVME_SC_SUCCESS;
+	}
+
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
+	if (!new)
+		return NVME_SC_INTERNAL;
+	memcpy(new, reg, sizeof(*new));
+	new->rkey = nrkey;
+	list_del_rcu(&reg->entry);
+	list_add_rcu(&new->entry, &pr->registrant_list);
+	rcu_assign_pointer(pr->holder, new);
+	kfree_rcu(reg, rcu);
+	return NVME_SC_SUCCESS;
+}
+
+static u16 nvmet_pr_replace(struct nvmet_req *req,
+			    struct nvmet_pr_register_data *d,
+			    bool ignore_key)
+{
+	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *reg;
+
+	mutex_lock(&pr->pr_lock);
+	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
+		if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
+			if (ignore_key || reg->rkey == le64_to_cpu(d->crkey)) {
+				reg->rkey = le64_to_cpu(d->nrkey);
+				status = __nvmet_pr_do_replace(pr, reg,
+							le64_to_cpu(d->nrkey));
+			}
+			break;
+		}
+	}
+	mutex_unlock(&pr->pr_lock);
+	return status;
+}
+
+static void nvmet_execute_pr_register(struct nvmet_req *req)
+{
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
+	bool ignore_key = (bool)((cdw10 >> 3) & 1); /* Ignore existing key, bit 03 */
+	struct nvmet_pr_register_data *d;
+	u8 reg_act = cdw10 & 0x07; /* Reservation Register Action, bit 02:00 */
+	u16 status;
+
+	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
+	if (status)
+		goto free_data;
+
+	switch (reg_act) {
+	case NVME_PR_REGISTER_ACT_REG:
+		status = nvmet_pr_register(req, d);
+		break;
+	case NVME_PR_REGISTER_ACT_UNREG:
+		status = nvmet_pr_unregister(req, d, ignore_key);
+		break;
+	case NVME_PR_REGISTER_ACT_REPLACE:
+		status = nvmet_pr_replace(req, d, ignore_key);
+		break;
+	default:
+		req->error_loc = offsetof(struct nvme_common_command,
+						cdw10);
+		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		break;
+	}
+free_data:
+	kfree(d);
+out:
+	if (!status)
+		nvmet_pr_inc_generation(&req->ns->pr);
+	nvmet_req_complete(req, status);
+}
+
+static u16 nvmet_pr_acquire(struct nvmet_req *req,
+			    struct nvmet_pr_registrant *reg,
+			    u8 rtype)
+{
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *holder;
+
+	holder = rcu_dereference_protected(pr->holder,
+					   lockdep_is_held(&pr->pr_lock));
+	if (holder && reg != holder)
+		return  NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+	if (holder && reg == holder) {
+		if (holder->rtype == rtype)
+			return NVME_SC_SUCCESS;
+		return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+	}
+
+	return nvmet_pr_set_rtype_and_holder(pr, rtype, reg);
+}
+
+static u16 nvmet_pr_unreg_by_prkey(struct nvmet_pr *pr, u64 prkey,
+				   uuid_t *send_hostid)
+{
+	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *tmp;
+
+	list_for_each_entry_safe(reg, tmp,
+				 &pr->registrant_list, entry) {
+		if (reg->rkey == prkey) {
+			status = NVME_SC_SUCCESS;
+			if (!uuid_equal(&reg->hostid, send_hostid))
+				nvmet_pr_send_registration_preempted(pr,
+								&reg->hostid);
+			__nvmet_pr_unregister_one(pr, reg);
+		}
+	}
+	return status;
+}
+
+static u16 nvmet_pr_unreg_by_prkey_except_hostid(struct nvmet_pr *pr, u64 prkey,
+						 uuid_t *send_hostid)
+{
+	u16 status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *tmp;
+
+	list_for_each_entry_safe(reg, tmp,
+				 &pr->registrant_list, entry) {
+		if (reg->rkey == prkey &&
+		    !uuid_equal(&reg->hostid, send_hostid)) {
+			status = NVME_SC_SUCCESS;
+			nvmet_pr_send_registration_preempted(pr, &reg->hostid);
+			__nvmet_pr_unregister_one(pr, reg);
+		}
+	}
+	return status;
+}
+
+static void nvmet_pr_unreg_except_hostid(struct nvmet_pr *pr,
+					 uuid_t *send_hostid)
+{
+	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *tmp;
+
+	list_for_each_entry_safe(reg, tmp,
+				 &pr->registrant_list, entry) {
+		if (!uuid_equal(&reg->hostid, send_hostid)) {
+			nvmet_pr_send_registration_preempted(pr, &reg->hostid);
+			__nvmet_pr_unregister_one(pr, reg);
+		}
+	}
+}
+
+static u16 nvmet_pr_create_new_resv(struct nvmet_pr *pr,
+				    u8 original_rtype,
+				    u8 new_rtype,
+				    struct nvmet_pr_registrant *reg)
+{
+	u16 status;
+
+	status = nvmet_pr_set_rtype_and_holder(pr, new_rtype, reg);
+	if (!status && original_rtype != new_rtype)
+		nvmet_pr_send_resv_released(pr, &reg->hostid);
+	return status;
+}
+
+static u16 nvmet_pr_update_holder_rtype(struct nvmet_pr *pr,
+					struct nvmet_pr_registrant *holder,
+					u8 rtype)
+{
+	u16 status;
+	struct nvmet_pr_registrant *new;
+
+	status = nvmet_pr_validate_rtype(rtype);
+	if (status)
+		return status;
+
+	new = kmalloc(sizeof(*new), GFP_ATOMIC);
+	if (!new)
+		return NVME_SC_INTERNAL;
+
+	list_del_rcu(&holder->entry);
+	memcpy(new, holder, sizeof(*new));
+	new->rtype = rtype;
+	list_add_tail_rcu(&new->entry, &pr->registrant_list);
+	rcu_assign_pointer(pr->holder, new);
+	kfree_rcu(holder, rcu);
+	return NVME_SC_SUCCESS;
+}
+
+static u16 nvmet_pr_preempt(struct nvmet_req *req,
+			    struct nvmet_pr_registrant *reg,
+			    u8 rtype,
+			    struct nvmet_pr_acquire_data *d)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *holder;
+	enum nvme_pr_type original_rtype;
+	u16 status;
+
+	holder = rcu_dereference_protected(pr->holder,
+					   lockdep_is_held(&pr->pr_lock));
+	if (!holder)
+		return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
+					       &ctrl->hostid);
+
+	original_rtype = holder->rtype;
+	if (original_rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
+	    original_rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS) {
+		if (!le64_to_cpu(d->prkey)) {
+			nvmet_pr_unreg_except_hostid(pr, &ctrl->hostid);
+			return nvmet_pr_create_new_resv(pr, original_rtype,
+							rtype, reg);
+		}
+		return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
+					       &ctrl->hostid);
+	}
+
+	if (holder == reg) {
+		status = nvmet_pr_update_holder_rtype(pr, holder, rtype);
+		if (status)
+			return status;
+		if (original_rtype != rtype)
+			nvmet_pr_send_resv_released(pr, &reg->hostid);
+		return status;
+	}
+
+	if (le64_to_cpu(d->prkey) == holder->rkey) {
+		status = nvmet_pr_unreg_by_prkey_except_hostid(pr,
+							le64_to_cpu(d->prkey),
+							&ctrl->hostid);
+		if (status)
+			return status;
+		return nvmet_pr_create_new_resv(pr, original_rtype, rtype, reg);
+	}
+
+	if (le64_to_cpu(d->prkey))
+		return nvmet_pr_unreg_by_prkey(pr, le64_to_cpu(d->prkey),
+					       &ctrl->hostid);
+	return NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+}
+
+static u16 __nvmet_execute_pr_acquire(struct nvmet_req *req,
+				      struct nvmet_pr_registrant *reg,
+				      u8 acquire_act,
+				      u8 rtype,
+				      struct nvmet_pr_acquire_data *d)
+{
+	u16 status;
+
+	switch (acquire_act) {
+	case NVME_PR_ACQUIRE_ACT_ACQUIRE:
+		status = nvmet_pr_acquire(req, reg, rtype);
+		goto out;
+	case NVME_PR_ACQUIRE_ACT_PREEMPT:
+		status = nvmet_pr_preempt(req, reg, rtype, d);
+		goto inc_gen;
+	case NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT:
+		status = nvmet_pr_preempt(req, reg, rtype, d);
+		goto inc_gen;
+	default:
+		req->error_loc = offsetof(struct nvme_common_command,
+						cdw10);
+		status = NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+		goto out;
+	}
+inc_gen:
+	if (!status)
+		nvmet_pr_inc_generation(&req->ns->pr);
+out:
+	return status;
+}
+
+static void nvmet_execute_pr_acquire(struct nvmet_req *req)
+{
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
+	bool ignore_key = (bool)((cdw10 >> 3) & 1); /* Ignore existing key, bit 03 */
+	u8 rtype = (u8)((cdw10 >> 8) & 0xff); /* Reservation type, bit 15:08 */
+	u8 acquire_act = cdw10 & 0x07; /* Reservation acquire action, bit 02:00 */
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr_acquire_data *d = NULL;
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *reg;
+	u16 status = NVME_SC_SUCCESS;
+
+	if (ignore_key) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
+	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
+	if (status)
+		goto free_data;
+
+	status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+	mutex_lock(&pr->pr_lock);
+	list_for_each_entry_rcu(reg, &pr->registrant_list, entry) {
+		if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
+		    reg->rkey == le64_to_cpu(d->crkey)) {
+			status = __nvmet_execute_pr_acquire(req, reg,
+							    acquire_act,
+							    rtype, d);
+			break;
+		}
+	}
+	mutex_unlock(&pr->pr_lock);
+
+free_data:
+	kfree(d);
+out:
+	nvmet_req_complete(req, status);
+}
+
+static u16 nvmet_pr_release(struct nvmet_req *req,
+			    struct nvmet_pr_registrant *reg,
+			    u8 rtype)
+{
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *holder;
+	u8 original_rtype;
+
+	holder = rcu_dereference_protected(pr->holder,
+					   lockdep_is_held(&pr->pr_lock));
+	if (!holder || reg != holder)
+		return NVME_SC_SUCCESS;
+
+	original_rtype = holder->rtype;
+	if (original_rtype != rtype)
+		return NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+
+	rcu_assign_pointer(pr->holder, NULL);
+
+	if (original_rtype != NVME_PR_WRITE_EXCLUSIVE &&
+	    original_rtype != NVME_PR_EXCLUSIVE_ACCESS)
+		nvmet_pr_send_resv_released(pr, &reg->hostid);
+
+	return NVME_SC_SUCCESS;
+}
+
+static void nvmet_pr_clear(struct nvmet_req *req)
+{
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *tmp;
+
+	list_for_each_entry_safe(reg, tmp, &pr->registrant_list, entry) {
+		list_del_rcu(&reg->entry);
+		if (!uuid_equal(&req->sq->ctrl->hostid, &reg->hostid))
+			nvmet_pr_send_resv_preempted(pr, &reg->hostid);
+		kfree_rcu(reg, rcu);
+	}
+	rcu_assign_pointer(pr->holder, NULL);
+
+	nvmet_pr_inc_generation(&req->ns->pr);
+}
+
+static u16 __nvmet_execute_pr_release(struct nvmet_req *req,
+				      struct nvmet_pr_registrant *reg,
+				      u8 release_act, u8 rtype)
+{
+	switch (release_act) {
+	case NVME_PR_RELEASE_ACT_RELEASE:
+		return nvmet_pr_release(req, reg, rtype);
+	case NVME_PR_RELEASE_ACT_CLEAR:
+		nvmet_pr_clear(req);
+		return NVME_SC_SUCCESS;
+	default:
+		req->error_loc = offsetof(struct nvme_common_command,
+					  cdw10);
+		return NVME_SC_INVALID_OPCODE | NVME_SC_DNR;
+	}
+}
+
+static void nvmet_execute_pr_release(struct nvmet_req *req)
+{
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
+	bool ignore_key = (bool)((cdw10 >> 3) & 1); /* Ignore existing key, bit 03 */
+	u8 rtype = (u8)((cdw10 >> 8) & 0xff); /* Reservation type, bit 15:08 */
+	u8 release_act = cdw10 & 0x07; /* Reservation release action, bit 02:00 */
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_release_data *d;
+	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *tmp;
+	u16 status;
+
+	if (ignore_key) {
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
+	d = kmalloc(sizeof(*d), GFP_KERNEL);
+	if (!d) {
+		status = NVME_SC_INTERNAL;
+		goto out;
+	}
+
+	status = nvmet_copy_from_sgl(req, 0, d, sizeof(*d));
+	if (status)
+		goto free_data;
+
+	status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+	mutex_lock(&pr->pr_lock);
+	list_for_each_entry_safe(reg, tmp,
+				 &pr->registrant_list, entry) {
+		if (uuid_equal(&reg->hostid, &ctrl->hostid) &&
+		    reg->rkey == le64_to_cpu(d->crkey)) {
+			status = __nvmet_execute_pr_release(req, reg,
+							    release_act, rtype);
+			break;
+		}
+	}
+	mutex_unlock(&pr->pr_lock);
+free_data:
+	kfree(d);
+out:
+	nvmet_req_complete(req, status);
+}
+
+static void nvmet_execute_pr_report(struct nvmet_req *req)
+{
+	u32 cdw11 = le32_to_cpu(req->cmd->common.cdw11);
+	u32 cdw10 = le32_to_cpu(req->cmd->common.cdw10);
+	u32 num_bytes = 4 * (cdw10 + 1); /* cdw10 is number of dwords */
+	u8 eds = cdw11 & 1; /* Extended data structure, bit 00 */
+	struct nvmet_subsys *subsys = req->sq->ctrl->subsys;
+	struct nvme_registered_ctrl_ext *ctrl_data;
+	struct nvme_reservation_status_ext *data;
+	struct nvmet_pr *pr = &req->ns->pr;
+	struct nvmet_pr_registrant *holder;
+	struct nvmet_pr_registrant *reg;
+	struct nvmet_ctrl *ctrl;
+	u16 num_ctrls = 0;
+	u16 status;
+	u8 rtype;
+
+	/* nvmet hostid(uuid_t) is 128 bit. */
+	if (!eds) {
+		req->error_loc = offsetof(struct nvme_common_command,
+					  cdw11);
+		status = NVME_SC_HOST_ID_INCONSIST | NVME_SC_DNR;
+		goto out;
+	}
+
+	if (num_bytes < sizeof(struct nvme_reservation_status_ext)) {
+		req->error_loc = offsetof(struct nvme_common_command,
+					  cdw10);
+		status = NVME_SC_INVALID_FIELD | NVME_SC_DNR;
+		goto out;
+	}
+
+	mutex_lock(&subsys->lock);
+	rcu_read_lock();
+	holder = rcu_dereference(pr->holder);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if (nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
+			num_ctrls++;
+	}
+
+	num_bytes = min(num_bytes,
+			sizeof(struct nvme_reservation_status_ext) +
+			sizeof(struct nvme_registered_ctrl_ext) * num_ctrls);
+
+	data = kmalloc(num_bytes, GFP_ATOMIC);
+	if (!data) {
+		status = NVME_SC_INTERNAL;
+		goto out_unlock;
+	}
+	memset(data, 0, num_bytes);
+	data->gen = cpu_to_le32((u32)atomic64_read(&pr->generation));
+	rtype = holder ? holder->rtype : 0;
+	data->rtype = rtype;
+	put_unaligned_le16(num_ctrls, data->regctl);
+	data->ptpls = 0;
+	ctrl_data = data->regctl_eds;
+
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry) {
+		if ((void *)ctrl_data >= (void *)(data + num_bytes))
+			break;
+		reg = nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid);
+		if (!reg)
+			continue;
+		ctrl_data->cntlid = cpu_to_le16(ctrl->cntlid);
+		if (rtype == NVME_PR_WRITE_EXCLUSIVE_ALL_REGS ||
+		    rtype == NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS)
+			ctrl_data->rcsts = 1;
+		if (holder &&
+		    uuid_equal(&ctrl->hostid, &holder->hostid))
+			ctrl_data->rcsts = 1;
+		uuid_copy((uuid_t *)&ctrl_data->hostid, &ctrl->hostid);
+		ctrl_data->rkey = cpu_to_le64(reg->rkey);
+		ctrl_data++;
+	}
+	status = nvmet_copy_to_sgl(req, 0, data, num_bytes);
+out_unlock:
+	rcu_read_unlock();
+	mutex_unlock(&subsys->lock);
+out:
+	nvmet_req_complete(req, status);
+}
+
+u16 nvmet_parse_pr_cmd(struct nvmet_req *req)
+{
+	struct nvme_command *cmd = req->cmd;
+
+	switch (cmd->common.opcode) {
+	case nvme_cmd_resv_register:
+		req->execute = nvmet_execute_pr_register;
+		break;
+	case nvme_cmd_resv_acquire:
+		req->execute = nvmet_execute_pr_acquire;
+		break;
+	case nvme_cmd_resv_release:
+		req->execute = nvmet_execute_pr_release;
+		break;
+	case nvme_cmd_resv_report:
+		req->execute = nvmet_execute_pr_report;
+		break;
+	default:
+		return 1;
+	}
+	return NVME_SC_SUCCESS;
+}
+
+static bool nvmet_is_req_write_cmd_group(struct nvmet_req *req)
+{
+	u8 opcode = req->cmd->common.opcode;
+
+	if (req->sq->qid) {
+		switch (opcode) {
+		case nvme_cmd_flush:
+		case nvme_cmd_write:
+		case nvme_cmd_write_zeroes:
+		case nvme_cmd_dsm:
+		case nvme_cmd_zone_append:
+		case nvme_cmd_zone_mgmt_send:
+			return true;
+		default:
+			return false;
+		}
+	}
+	return false;
+}
+
+static bool nvmet_is_req_read_cmd_group(struct nvmet_req *req)
+{
+	u8 opcode = req->cmd->common.opcode;
+
+	if (req->sq->qid) {
+		switch (opcode) {
+		case nvme_cmd_read:
+		case nvme_cmd_zone_mgmt_recv:
+			return true;
+		default:
+			return false;
+		}
+	}
+	return false;
+}
+
+u16 nvmet_pr_check_cmd_access(struct nvmet_req *req)
+{
+	struct nvmet_ctrl *ctrl = req->sq->ctrl;
+	struct nvmet_pr_registrant *holder;
+	struct nvmet_ns *ns = req->ns;
+	struct nvmet_pr *pr = &ns->pr;
+	u16 status = NVME_SC_SUCCESS;
+
+	rcu_read_lock();
+	holder = rcu_dereference(pr->holder);
+	if (!holder)
+		goto unlock;
+	if (uuid_equal(&ctrl->hostid, &holder->hostid))
+		goto unlock;
+
+	/*
+	 * The Reservation command group is checked in executing,
+	 * allow it here.
+	 */
+	switch (holder->rtype) {
+	case NVME_PR_WRITE_EXCLUSIVE:
+		if (nvmet_is_req_write_cmd_group(req))
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		break;
+	case NVME_PR_EXCLUSIVE_ACCESS:
+		if (nvmet_is_req_read_cmd_group(req) ||
+		    nvmet_is_req_write_cmd_group(req))
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		break;
+	case NVME_PR_WRITE_EXCLUSIVE_REG_ONLY:
+	case NVME_PR_WRITE_EXCLUSIVE_ALL_REGS:
+		if ((nvmet_is_req_write_cmd_group(req)) &&
+		    !nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		break;
+	case NVME_PR_EXCLUSIVE_ACCESS_REG_ONLY:
+	case NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS:
+		if ((nvmet_is_req_read_cmd_group(req) ||
+		    nvmet_is_req_write_cmd_group(req)) &&
+		    !nvmet_pr_find_registrant_by_hostid(pr, &ctrl->hostid))
+			status = NVME_SC_RESERVATION_CONFLICT | NVME_SC_DNR;
+		break;
+	default:
+		pr_warn("the reservation type is set wrong, type:%d\n",
+			holder->rtype);
+		break;
+	}
+
+unlock:
+	rcu_read_unlock();
+	if (status)
+		req->error_loc = offsetof(struct nvme_common_command, opcode);
+	return status;
+}
+
+void nvmet_ctrl_destroy_pr(struct nvmet_ctrl *ctrl)
+{
+	struct nvmet_pr_log_entry *tmp_log_entry;
+	struct nvmet_pr_log_entry *log_entry;
+	struct nvmet_pr_registrant *reg;
+	struct nvmet_pr_registrant *tmp;
+	struct nvmet_ns *ns;
+	unsigned long idx;
+
+	mutex_lock(&ctrl->resv_log_lock);
+	list_for_each_entry_safe(log_entry, tmp_log_entry,
+				 &ctrl->resv_log_list, entry) {
+		list_del(&log_entry->entry);
+		kfree(log_entry);
+	}
+	mutex_unlock(&ctrl->resv_log_lock);
+
+	mutex_destroy(&ctrl->resv_log_lock);
+
+	if (nvmet_is_host_still_connected(&ctrl->hostid, ctrl->subsys))
+		return;
+
+	xa_for_each(&ctrl->subsys->namespaces, idx, ns) {
+		mutex_lock(&ns->pr.pr_lock);
+		list_for_each_entry_safe(reg, tmp,
+					 &ns->pr.registrant_list, entry) {
+			if (uuid_equal(&reg->hostid, &ctrl->hostid)) {
+				__nvmet_pr_unregister_one(&ns->pr, reg);
+				break;
+			}
+		}
+		mutex_unlock(&ns->pr.pr_lock);
+	}
+}
+
+void nvmet_pr_exit_ns(struct nvmet_ns *ns)
+{
+	struct nvmet_pr_registrant *tmp_reg;
+	struct nvmet_pr_registrant *tmp;
+	struct nvmet_pr *pr = &ns->pr;
+
+	mutex_lock(&pr->pr_lock);
+	list_for_each_entry_safe(tmp_reg, tmp, &pr->registrant_list, entry) {
+		list_del_rcu(&tmp_reg->entry);
+		kfree_rcu(tmp_reg, rcu);
+	}
+	mutex_unlock(&pr->pr_lock);
+
+	mutex_destroy(&pr->pr_lock);
+}
+
+void nvmet_pr_init_ns(struct nvmet_ns *ns)
+{
+	ns->pr.holder = NULL;
+	atomic64_set(&ns->pr.generation, 0);
+	mutex_init(&ns->pr.pr_lock);
+	INIT_LIST_HEAD(&ns->pr.registrant_list);
+}
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index 44325c068b6a..67a8c9fd1956 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -746,6 +746,26 @@ enum {
 	NVME_AEN_CFG_DISC_CHANGE	= 1 << NVME_AEN_BIT_DISC_CHANGE,
 };
 
+enum {
+	NVME_AEN_RESV_LOG_PAGE_AVALIABLE	= 0x00,
+};
+
+enum {
+	NVME_PR_LOG_EMPTY_LOG_PAGE			= 0x00,
+	NVME_PR_LOG_REGISTRATION_PREEMPTED		= 0x01,
+	NVME_PR_LOG_RESERVATION_RELEASED		= 0x02,
+	NVME_PR_LOG_RESERVATOPM_PREEMPTED		= 0x03,
+};
+
+struct nvme_pr_log {
+	__le64			count;
+	__u8			type;
+	__u8			nr_pages;
+	__u8			rsvd1[2];
+	__le32			nsid;
+	__u8			rsvd2[48];
+};
+
 struct nvme_lba_range_type {
 	__u8			type;
 	__u8			attributes;
@@ -766,6 +786,17 @@ enum {
 	NVME_LBART_ATTRIB_HIDE	= 1 << 1,
 };
 
+enum nvme_pr_capabilities {
+	NVME_PR_SUPPORT_PTPL				= 1,
+	NVME_PR_SUPPORT_WRITE_EXCLUSIVE			= 1 << 1,
+	NVME_PR_SUPPORT_EXCLUSIVE_ACCESS		= 1 << 2,
+	NVME_PR_SUPPORT_WRITE_EXCLUSIVE_REG_ONLY	= 1 << 3,
+	NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_REG_ONLY	= 1 << 4,
+	NVME_PR_SUPPORT_WRITE_EXCLUSIVE_ALL_REGS	= 1 << 5,
+	NVME_PR_SUPPORT_EXCLUSIVE_ACCESS_ALL_REGS	= 1 << 6,
+	NVME_PR_SUPPORT_IEKEY_VER_1_3_DEF		= 1 << 7,
+};
+
 enum nvme_pr_type {
 	NVME_PR_WRITE_EXCLUSIVE			= 1,
 	NVME_PR_EXCLUSIVE_ACCESS		= 2,
@@ -775,6 +806,23 @@ enum nvme_pr_type {
 	NVME_PR_EXCLUSIVE_ACCESS_ALL_REGS	= 6,
 };
 
+enum nvme_pr_register_action {
+	NVME_PR_REGISTER_ACT_REG		= 0,
+	NVME_PR_REGISTER_ACT_UNREG		= 1,
+	NVME_PR_REGISTER_ACT_REPLACE		= 1 << 1,
+};
+
+enum nvme_pr_acquire_action {
+	NVME_PR_ACQUIRE_ACT_ACQUIRE		= 0,
+	NVME_PR_ACQUIRE_ACT_PREEMPT		= 1,
+	NVME_PR_ACQUIRE_ACT_PREEMPT_AND_ABORT	= 1 << 1,
+};
+
+enum nvme_pr_release_action {
+	NVME_PR_RELEASE_ACT_RELEASE		= 0,
+	NVME_PR_RELEASE_ACT_CLEAR		= 1,
+};
+
 enum nvme_eds {
 	NVME_EXTENDED_DATA_STRUCT	= 0x1,
 };
-- 
2.43.0


