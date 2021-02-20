Return-Path: <SRS0=hrUZ=HW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F943C433DB
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:36:55 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0032D64EE2
	for <linux-nvme@archiver.kernel.org>; Sat, 20 Feb 2021 15:36:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0032D64EE2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=79sqKKJRn9xuF+Z9kUGePLS2pYStDFPoDG8SN8V38xU=; b=ZzMTRuGVqNO465R8Z5N0hsgf1i
	YcBsPJy6IvK/mEg86+kY0YKXhkx6vlxuWjH6aRJG60UXFW433Sn8R8qnCm1HbubkOlJx+ubaL0vHs
	+lTFGULV2o+kpkCiSgWdkIaqkCM+trcW9+vI/cbmbxhHKnfHxvovQ8CcGUK82i7Gccjh8fJTAsWyJ
	3Z6dmTZKN3s6cIHnyqkXh9ZDxL7Y++wTr7EXqNLvWWE5Eb0z2Y1T7ZcCMYv4eLCzSgcsjnuzKpzKa
	lMqwWeEMOwy79+T0/UumGlzGr8sLUAYu2ZsJ7u6dvj41RW8myYlo8CmdrBAkQSMbVjhmjeEkSIQv4
	nJTREh+Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1lDUJ6-0007Ld-PC; Sat, 20 Feb 2021 15:36:32 +0000
Received: from mail-pj1-x102e.google.com ([2607:f8b0:4864:20::102e])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1lDUJ3-0007LI-Ni
 for linux-nvme@lists.infradead.org; Sat, 20 Feb 2021 15:36:30 +0000
Received: by mail-pj1-x102e.google.com with SMTP id d2so6009706pjs.4
 for <linux-nvme@lists.infradead.org>; Sat, 20 Feb 2021 07:36:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/qqGzgHCp+TBa4uWqRB+FDzmKqzItBYg+7cs2+jQbNU=;
 b=nqwvrXR9lAxobF/U6BzdogdiYF5NvHKkNL3HfBa1372F4QxoesFBSiUQnryVvpnbls
 b1oHKOC+1a37Sq8HudQqAmrn74nmRWWJQnhI6INUy048YLeSn15aHFrc1MlC6fuWwFsn
 AaI4ZZNUSLZWFFvrN+Ad0syrBvJIVV1kmrcrzuFfPrOS4n4v7wP3E6iz2mGscSzSVMwI
 dC8EaixGyngJACjRzEihr9ewN0yeizaYYYk7lONOVT2fMt8hTes5c/B2BJUI6XkYpkj1
 HqrPqaKVyhCV/TL6RxQ42FtKgNVT3C4ec/cWVC1iBzIEuJin6sbKoqOjaFNP5wPqyJdR
 sIYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=/qqGzgHCp+TBa4uWqRB+FDzmKqzItBYg+7cs2+jQbNU=;
 b=ptf2IdFRRvUCqk5tnwZcgQ2fjchvnPM0rP/uKzhopkrVFGm3FUg2td9bPiol4Z7kkD
 FvF21gvEbJi5IMyOLgzv1YbicisYprEmYAe5ZeztDs6fnK7KA0qcjVQFGQgVOMxwZ5fl
 EkB1MQKRsQ4m5KqIw1tCnHiNI+ZVb4y8pB8MBydQ0E4BZPmsuIvuG024h3FYlnDGQe4Z
 UpkfMU4Wz8Db3M4ttu800k6k3XUb5FHj/te/RRblQuQ6e/gX+ZAqIR2tDTMyK/wd7Yp0
 rbnrbBfgUoNd42dI60PJT0/huuSUVVcB4LhUrYIn3+hdFosSlgt8sBvQdk2QsPYRjpFX
 bw+w==
X-Gm-Message-State: AOAM532jKTrnmncjB3ARO1heIUz+E76iETk5Cz2v6FDXbwCEs+0wrsQV
 M5Z1CnqcjUr87KUNo8Q/f5+xFd2vHUpS5w==
X-Google-Smtp-Source: ABdhPJxYT4VBdSb9LIRYbJTv0ABFRyvo6c5sFH2TogQC01z9QZGLEJrZdomDJwMn4W+mG7++NMFjdw==
X-Received: by 2002:a17:90b:ec5:: with SMTP id
 gz5mr14648145pjb.34.1613835387042; 
 Sat, 20 Feb 2021 07:36:27 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
 by smtp.gmail.com with ESMTPSA id j3sm12544329pgk.24.2021.02.20.07.36.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 20 Feb 2021 07:36:26 -0800 (PST)
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme: add support namespace management to sysfs
Date: Sun, 21 Feb 2021 00:36:10 +0900
Message-Id: <20210220153610.237288-1-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210220_103630_023453_2F244F4B 
X-CRM114-Status: GOOD (  24.64  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Minwoo Im <minwoo.im.dev@gmail.com>, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Namespaces are generally managed by scan_work.  If admin needs to attach
namespace to controller, admin command like `nvme-cli` should be issued
with rescanning controller.

If admin issues a Namespace Attachment command with detach option to a
namespace through IOCTL, kernel is not aware of it.  In this case, block
device for the namespace becomes meaningless, but still shown in the
kernel space as maintained.  After the rescanning the controller
manually, namespace node will be removed from the driver and user-space
will not be able to I/O to the namespace.

Add support for namespace management (attach/detach) to sysfs of
controller instance to make it easy to attach/detach namespaces with
kernel-aware rather than non-kernel-aware passthru via IOCTL.  Also, it
provides closer relationship between the device and kernel for the
namespace perspective (tightly coupled).

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 drivers/nvme/host/core.c | 189 +++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h     |  12 +++
 2 files changed, 201 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index d77f3f26d8d3..71dad1b5ffdc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -92,6 +92,9 @@ static struct class *nvme_subsys_class;
 static void nvme_put_subsystem(struct nvme_subsystem *subsys);
 static void nvme_remove_invalid_namespaces(struct nvme_ctrl *ctrl,
 					   unsigned nsid);
+static void nvme_ns_remove(struct nvme_ns *ns);
+static struct nvme_ns *nvme_find_get_ns_by_disk_name(struct nvme_ctrl *ctrl,
+						     const char *disk_name);
 
 /*
  * Prepare a queue for teardown.
@@ -3454,6 +3457,28 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+#ifdef CONFIG_NVME_MULTIPATH
+static ssize_t path_show(struct device *dev, struct device_attribute *attr,
+		char *buf)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	struct nvme_ns *ns;
+	int node = numa_node_id();
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = srcu_dereference(head->current_path[node], &head->srcu);
+	if (!ns) {
+		srcu_read_unlock(&head->srcu, srcu_idx);
+		return sprintf(buf, "none\n");
+	}
+
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	return sprintf(buf, "%s\n", ns->disk->disk_name);
+}
+static DEVICE_ATTR_RO(path);
+#endif
+
 static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
@@ -3463,6 +3488,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
+	&dev_attr_path.attr,
 #endif
 	NULL,
 };
@@ -3493,6 +3519,11 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!nvme_ctrl_use_ana(nvme_get_ns_from_dev(dev)->ctrl))
 			return 0;
 	}
+
+	if (a == &dev_attr_path.attr) {
+		if (dev_to_disk(dev)->fops == &nvme_bdev_ops)
+			return 0;
+	}
 #endif
 	return a->mode;
 }
@@ -3684,6 +3715,142 @@ static ssize_t nvme_ctrl_reconnect_delay_store(struct device *dev,
 static DEVICE_ATTR(reconnect_delay, S_IRUGO | S_IWUSR,
 	nvme_ctrl_reconnect_delay_show, nvme_ctrl_reconnect_delay_store);
 
+static int __nvme_ns_detach(struct nvme_ctrl *ctrl, unsigned int nsid)
+{
+	struct nvme_command c = { };
+	int err;
+	u16 *buf;
+
+	c.ns_attach.opcode = nvme_admin_ns_attach;
+	c.ns_attach.nsid = cpu_to_le32(nsid);
+	c.ns_attach.sel = cpu_to_le32(0x1);
+
+	buf = kmalloc(4096, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = cpu_to_le32(0x1);
+	buf[1] = cpu_to_le32(ctrl->cntlid);
+
+	err = nvme_submit_sync_cmd(ctrl->admin_q, &c, buf, 4096);
+	if (err) {
+		kfree(buf);
+		return err;
+	}
+
+	kfree(buf);
+	return 0;
+}
+
+static int nvme_ns_detach(struct nvme_ctrl *ctrl, struct nvme_ns *ns)
+{
+	int err;
+
+	blk_mq_quiesce_queue(ns->queue);
+
+	err = __nvme_ns_detach(ctrl, ns->head->ns_id);
+	if (err) {
+		blk_mq_unquiesce_queue(ns->queue);
+		return err;
+	}
+
+	nvme_set_queue_dying(ns);
+	nvme_ns_remove(ns);
+
+	return 0;
+}
+
+static int __nvme_ns_attach(struct nvme_ctrl *ctrl, unsigned int nsid)
+{
+	struct nvme_command c = { };
+	int err;
+	u16 *buf;
+
+	c.ns_attach.opcode = nvme_admin_ns_attach;
+	c.ns_attach.nsid = cpu_to_le32(nsid);
+	c.ns_attach.sel = cpu_to_le32(0x0);
+
+	buf = kmalloc(4096, GFP_KERNEL);
+	if (!buf)
+		return -ENOMEM;
+
+	buf[0] = cpu_to_le32(0x1);
+	buf[1] = cpu_to_le32(ctrl->cntlid);
+
+	err = nvme_submit_sync_cmd(ctrl->admin_q, &c, buf, 4096);
+	if (err) {
+		kfree(buf);
+		return err;
+	}
+
+	kfree(buf);
+	return 0;
+}
+
+static int nvme_ns_attach(struct nvme_ctrl *ctrl, unsigned int nsid, bool scan)
+{
+	int err;
+
+	if (!(ctrl->oacs & NVME_CTRL_OACS_NS_MANAGEMENT))
+		return -EOPNOTSUPP;
+
+	err = __nvme_ns_attach(ctrl, nsid);
+	if (err)
+		return err;
+
+	if (scan)
+		nvme_queue_scan(ctrl);
+
+	return 0;
+}
+
+static ssize_t detach_ns_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct nvme_ns *ns;
+	int err;
+
+	if (!(ctrl->oacs & NVME_CTRL_OACS_NS_MANAGEMENT))
+		return -EOPNOTSUPP;
+
+	ns = nvme_find_get_ns_by_disk_name(ctrl, buf);
+	if (!ns)
+		return -EINVAL;
+
+	err = nvme_ns_detach(ctrl, ns);
+	if (err) {
+		nvme_put_ns(ns);
+		return err;
+	}
+
+	nvme_put_ns(ns);
+	return count;
+}
+static DEVICE_ATTR_WO(detach_ns);
+
+static ssize_t attach_ns_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	unsigned int nsid;
+	int err;
+
+	/*
+	 * 'nsid' is device namespace id which is reported by NVMe controller.
+	 */
+	err = kstrtou32(buf, 10, &nsid);
+	if (err)
+		return err;
+
+	err = nvme_ns_attach(ctrl, nsid, true);
+	if (err)
+		return err;
+
+	return count;
+}
+static DEVICE_ATTR_WO(attach_ns);
+
 static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_reset_controller.attr,
 	&dev_attr_rescan_controller.attr,
@@ -3703,6 +3870,8 @@ static struct attribute *nvme_dev_attrs[] = {
 	&dev_attr_hostid.attr,
 	&dev_attr_ctrl_loss_tmo.attr,
 	&dev_attr_reconnect_delay.attr,
+	&dev_attr_detach_ns.attr,
+	&dev_attr_attach_ns.attr,
 	NULL
 };
 
@@ -3902,6 +4071,25 @@ struct nvme_ns *nvme_find_get_ns(struct nvme_ctrl *ctrl, unsigned nsid)
 }
 EXPORT_SYMBOL_NS_GPL(nvme_find_get_ns, NVME_TARGET_PASSTHRU);
 
+static struct nvme_ns *nvme_find_get_ns_by_disk_name(struct nvme_ctrl *ctrl,
+		const char *disk_name)
+{
+	struct nvme_ns *ns, *ret = NULL;
+
+	down_read(&ctrl->namespaces_rwsem);
+	list_for_each_entry(ns, &ctrl->namespaces, list) {
+		if (!strcmp(ns->disk->disk_name, disk_name)) {
+			if (!kref_get_unless_zero(&ns->kref))
+				continue;
+			ret = ns;
+			break;
+		}
+	}
+	up_read(&ctrl->namespaces_rwsem);
+
+	return ret;
+}
+
 static void nvme_alloc_ns(struct nvme_ctrl *ctrl, unsigned nsid,
 		struct nvme_ns_ids *ids)
 {
@@ -4751,6 +4939,7 @@ static inline void _nvme_check_size(void)
 	BUILD_BUG_ON(sizeof(struct nvme_smart_log) != 512);
 	BUILD_BUG_ON(sizeof(struct nvme_dbbuf) != 64);
 	BUILD_BUG_ON(sizeof(struct nvme_directive_cmd) != 64);
+	BUILD_BUG_ON(sizeof(struct nvme_ns_attach) != 64);
 }
 
 
diff --git a/include/linux/nvme.h b/include/linux/nvme.h
index b08787cd0881..bc6c2a162bbb 100644
--- a/include/linux/nvme.h
+++ b/include/linux/nvme.h
@@ -322,6 +322,7 @@ enum {
 	NVME_CTRL_ONCS_TIMESTAMP		= 1 << 6,
 	NVME_CTRL_VWC_PRESENT			= 1 << 0,
 	NVME_CTRL_OACS_SEC_SUPP                 = 1 << 0,
+	NVME_CTRL_OACS_NS_MANAGEMENT		= 1 << 3,
 	NVME_CTRL_OACS_DIRECTIVES		= 1 << 5,
 	NVME_CTRL_OACS_DBBUF_SUPP		= 1 << 8,
 	NVME_CTRL_LPA_CMD_EFFECTS_LOG		= 1 << 1,
@@ -1398,6 +1399,16 @@ struct streams_directive_params {
 	__u8	rsvd2[6];
 };
 
+struct nvme_ns_attach {
+	__u8			opcode;
+	__u8			flags;
+	__u16			command_id;
+	__le32			nsid;
+	__u32			rsvd2[8];
+	__le32			sel;
+	__u32			rsvd11[5];
+};
+
 struct nvme_command {
 	union {
 		struct nvme_common_command common;
@@ -1421,6 +1432,7 @@ struct nvme_command {
 		struct nvmf_property_get_command prop_get;
 		struct nvme_dbbuf dbbuf;
 		struct nvme_directive_cmd directive;
+		struct nvme_ns_attach ns_attach;
 	};
 };
 
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
