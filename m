Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 36A71CCFA0D
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 10:34:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dF9AB2hHwwy3EWP2w3CZaHyaORf+Miu82PxVJshLJGw=; b=xbr3iWOGkJONqDqPd6EdcucCbY
	2Sk0m/ecNs43dXOZZCA5YR31tG66GgDO31gEKQ6NjFywF6fH+vqF/eQBei1bfkUzamOmJ84DJ/mVW
	85sfWLr/0Y1jVTv25Ob56OH5gML7oSR5rbm+Q2+DnK2U7mYp1EelQvRJTDpDQ4JqhBIkIM8JJ8JPf
	y3UDSYidyXd4fPhERP7ZPE0HFbtKPOCVDCF41txsKtLlICsZYWXys5huox6ki6z4KArERBOLUkbWF
	OmT+5fNFBxlIWxh03QT1JzQ6YnqmynNhMaQ5Dz/XyG6/FnpyAgSXy38AWd27ez9dMlOJ4sTCw1lhE
	yHffREhw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaq9-0000000DTgr-2B6m;
	Wed, 05 Nov 2025 10:34:09 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaq6-0000000DTf5-2k5R
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 10:34:07 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A55R8tF021943;
	Wed, 5 Nov 2025 10:34:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dF9AB2hHwwy3EWP2w
	3CZaHyaORf+Miu82PxVJshLJGw=; b=itjMWuF1bkIdzOZEsujmPcZoLfbXsW/x4
	JQvcF5Ldsb1zQJHKXdQcyRNx0FZdZ2o9JMBr8xPIA7fXofXrX5ASFiEJZa6hkPTe
	qekX+81ZfqxnO060SHRDg8JmCXhPY3Cf4qbKJSNPD9cGEzDNDqPuWD36BIGpJqop
	VasLVOhH1OoIulW41e8//uZ0hY4Z7lSkvmi+K3bbgAJVQ4uKcCIWMmgUBceU413x
	MwIbSy4tgKbPdL/I11/cb3d94cs3+BDX8rI8R40AwYH+minc40wZJQV2gUmdmKeT
	lf6Utaqp0qNGthc2rXOB/B2Q/R4WwlqOtpl5erLPs39K7oz3th53w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v20aap-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:02 +0000 (GMT)
Received: from m0360072.ppops.net (m0360072.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5AY1mx020495;
	Wed, 5 Nov 2025 10:34:01 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59v20aam-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:01 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A57tnfS009855;
	Wed, 5 Nov 2025 10:34:01 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5x1kfg6w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:01 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5AXw9H55837062
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 10:33:58 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B78C22004D;
	Wed,  5 Nov 2025 10:33:58 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ABB4120043;
	Wed,  5 Nov 2025 10:33:56 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 10:33:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, kanie@linux.alibaba.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 3/7] nvme: add generic debugfs support
Date: Wed,  5 Nov 2025 16:03:22 +0530
Message-ID: <20251105103347.86059-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105103347.86059-1-nilay@linux.ibm.com>
References: <20251105103347.86059-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: CpC0rOF2OFRHOV9r2A6VC01xdcxiuucG
X-Proofpoint-ORIG-GUID: A3I3py6FtrJgelHWW6j_xm4CiVD9Du8O
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfXxxprNFdvnzRY
 eHgXEVt1zKVVf1t+zIpJmqME1TZjZ5g4AAphwgrmcfvSDXZmdLIgXMX4TJhfTLelf2qLitvzSJM
 XUetCTUTInsYJSDNQIJaalfEsi3u+y8LiKIL93AUEmrWMyx9xxdreEC4jhdAsUtbdM/+O9q7MFg
 ul1e4NA/5cOFgU5F6WdQBm6JSt4grisMBMepV8mrkrjakUcaAhtGftlyX0lf/1uNonpPrmqsYnt
 QGn1cCB4zwvqX7EfrvPV1w5rpdFLrrQYNgzmCBB7LrQ2uYtjGYoFtfzkg7vSpWMcXoFK92ZUloz
 uuAbI62+rUEaI9nbyKJ+da0Lv/fT++l0YPsrfSRb/9c90CWGNC80A3wOuNfuouqTphSEPdIHWFf
 BOwaGHoNwJOPyNh1fzbmUMRbpFLbdg==
X-Authority-Analysis: v=2.4 cv=H8HWAuYi c=1 sm=1 tr=0 ts=690b281a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=RurgEnbhPsFkkpbWVXEA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501 adultscore=0
 impostorscore=0 clxscore=1015 bulkscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_023406_824692_B01D3082 
X-CRM114-Status: GOOD (  24.20  )
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

Add generic infrastructure for creating and managing debugfs files in
the NVMe module. This introduces helper APIs that allow NVMe drivers to
register and unregister debugfs entries, along with a reusable attribute
structure for defining new debugfs files.

The implementation uses seq_file interfaces to safely expose per-NS and
per-NS-head statistics, while supporting both simple show callbacks and
full seq_operations.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/Makefile    |   2 +-
 drivers/nvme/host/core.c      |   3 +
 drivers/nvme/host/debugfs.c   | 138 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |   2 +
 drivers/nvme/host/nvme.h      |  10 +++
 5 files changed, 154 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/debugfs.c

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 6414ec968f99..7962dfc3b2ad 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
 
-nvme-core-y				+= core.o ioctl.o sysfs.o pr.o
+nvme-core-y				+= core.o ioctl.o sysfs.o pr.o debugfs.o
 nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 47f375c63d2d..c15dfcaf3de2 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4187,6 +4187,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
+	nvme_debugfs_register(ns->disk);
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -4276,6 +4278,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_mpath_remove_sysfs_link(ns);
 
+	nvme_debugfs_unregister(ns->disk);
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
new file mode 100644
index 000000000000..6bb57c4b5c3b
--- /dev/null
+++ b/drivers/nvme/host/debugfs.c
@@ -0,0 +1,138 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2025 IBM Corporation
+ *	Nilay Shroff <nilay@linux.ibm.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+
+#include "nvme.h"
+
+struct nvme_debugfs_attr {
+	const char *name;
+	umode_t mode;
+	int (*show)(void *data, struct seq_file *m);
+	ssize_t (*write)(void *data, const char __user *buf, size_t count,
+			loff_t *ppos);
+	const struct seq_operations *seq_ops;
+};
+
+struct nvme_debugfs_ctx {
+	void *data;
+	struct nvme_debugfs_attr *attr;
+	int srcu_idx;
+};
+
+static int nvme_debugfs_show(struct seq_file *m, void *v)
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	void *data = ctx->data;
+	struct nvme_debugfs_attr *attr = ctx->attr;
+
+	return attr->show(data, m);
+}
+
+static int nvme_debugfs_open(struct inode *inode, struct file *file)
+{
+	void *data = inode->i_private;
+	struct nvme_debugfs_attr *attr = debugfs_get_aux(file);
+	struct nvme_debugfs_ctx *ctx;
+	struct seq_file *m;
+	int ret;
+
+	ctx = kzalloc(sizeof(*ctx), GFP_KERNEL);
+	if (WARN_ON_ONCE(!ctx))
+		return -ENOMEM;
+
+	ctx->data = data;
+	ctx->attr = attr;
+
+	if (attr->seq_ops) {
+		ret = seq_open(file, attr->seq_ops);
+		if (ret) {
+			kfree(ctx);
+			return ret;
+		}
+		m = file->private_data;
+		m->private = ctx;
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(!attr->show)) {
+		kfree(ctx);
+		return -EPERM;
+	}
+
+	return single_open(file, nvme_debugfs_show, ctx);
+}
+
+static ssize_t nvme_debugfs_write(struct file *file, const char __user *buf,
+			size_t count, loff_t *ppos)
+{
+	struct seq_file *m = file->private_data;
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_debugfs_attr *attr = ctx->attr;
+
+	if (!attr->write)
+		return -EPERM;
+
+	return attr->write(ctx->data, buf, count, ppos);
+}
+
+static int nvme_debugfs_release(struct inode *inode, struct file *file)
+{
+	struct seq_file *m = file->private_data;
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_debugfs_attr *attr = ctx->attr;
+	int ret;
+
+	if (attr->seq_ops)
+		ret = seq_release(inode, file);
+	else
+		ret = single_release(inode, file);
+
+	kfree(ctx);
+	return ret;
+}
+
+static const struct file_operations nvme_debugfs_fops = {
+	.owner   = THIS_MODULE,
+	.open    = nvme_debugfs_open,
+	.read    = seq_read,
+	.write   = nvme_debugfs_write,
+	.llseek  = seq_lseek,
+	.release = nvme_debugfs_release,
+};
+
+
+static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
+	{},
+};
+
+static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
+	{},
+};
+
+static void nvme_debugfs_create_files(struct request_queue *q,
+		const struct nvme_debugfs_attr *attr, void *data)
+{
+	if (WARN_ON_ONCE(!q->debugfs_dir))
+		return;
+
+	for (; attr->name; attr++)
+		debugfs_create_file_aux(attr->name, attr->mode, q->debugfs_dir,
+				data, (void *)attr, &nvme_debugfs_fops);
+}
+
+void nvme_debugfs_register(struct gendisk *disk)
+{
+	const struct nvme_debugfs_attr *attr;
+
+	if (nvme_disk_is_ns_head(disk))
+		attr = nvme_mpath_debugfs_attrs;
+	else
+		attr = nvme_ns_debugfs_attrs;
+
+	nvme_debugfs_create_files(disk->queue, attr, disk->private_data);
+}
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 55dc28375662..047dd9da9cbf 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1086,6 +1086,7 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
+		nvme_debugfs_unregister(head->disk);
 		del_gendisk(head->disk);
 	}
 	nvme_put_ns_head(head);
@@ -1192,6 +1193,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		}
 		nvme_add_ns_head_cdev(head);
 		kblockd_schedule_work(&head->partition_scan_work);
+		nvme_debugfs_register(head->disk);
 	}
 
 	nvme_mpath_add_sysfs_link(ns->head);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 715c7053054c..1c1ec2a7f9ad 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1000,6 +1000,16 @@ static inline int nvme_data_dir(const enum req_op op)
 		return NVME_STAT_OTHER;
 }
 
+void nvme_debugfs_register(struct gendisk *disk);
+static inline void nvme_debugfs_unregister(struct gendisk *disk)
+{
+	/*
+	 * Nothing to do for now. When the request queue is unregistered,
+	 * all files under q->debugfs_dir are recursively deleted.
+	 * This is just a placeholder; the compiler will optimize it out.
+	 */
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
-- 
2.51.0


