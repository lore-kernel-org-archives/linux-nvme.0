Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56096CCF9E0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 09:30:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Txh8JqvyC3msMe5nwXVRj3TtyV8wMvl+EURYZkSUNyE=; b=NCG0VUvopf2cxBEO1RZVTw0DI2
	CsLRkdfroc1Od/hld1ggvpLIBYntJ1YMGy787zw5BY9jTImn4Yk0frNLPtxrxoRjGmtswe38Z8eMS
	gMYsUaXwBRyHWLRRR5gMzgHbR1w0z09rFWmVZoyEEL+F0PvQynESEN4R7B5YwCplQdvv1MUxoF/Uu
	Gl7G6kvi1nkNJ8tURmHnZdnrV4uEfNUDt1I1QyuY7E31MQrN/IQ9FHYQIG+OHspv9XD6dOyfdHPFT
	t/9Mhig+sdaloXq13Vb6mRYExmf/sZpvO82AonwDgyJCUDJS167YXvpuyhLRJfVkppfPiFITqYjkk
	fbteY5hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYb-0000000DX9t-3GMr;
	Mon, 27 Oct 2025 09:30:29 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYZ-0000000DX8B-1T5d
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 09:30:28 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59R9OJmM027578;
	Mon, 27 Oct 2025 09:30:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Txh8JqvyC3msMe5nw
	XVRj3TtyV8wMvl+EURYZkSUNyE=; b=UW4Io97L6KJriy2inRntk4HFM90b/Qsa9
	r9eu962KPveaEYTaZfbx71C1vLnV4padUMpOkDs7iK316XPEcaxDIQp0kUsDLTnU
	ypVb21cjOHFgcxEjjLr7SIo8vn44r6eIyiYt9PcVHR97LJr8M187fpG6lGN6kOk/
	6x8Q7IXqLV9VqqlfD6xeAGSHjEnWKjH/9Qoz0glysPGpf9B+DSapVSlWxGKZpLnL
	TfQ5JttIyGVzlzuLkbob/wYfw4B+Kep2imISMllADm+NqEwqhky1NgDf2S8SOMZW
	mukRg4WHxcoIad2tDeSrC8b4mBIQrFuWo0eCckxtgVFfA+cNb+IVQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0p28x28d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:21 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R8CZb5009400;
	Mon, 27 Oct 2025 09:30:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4a1b3hvm3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R9UI1w56230318
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 09:30:18 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C2CE520043;
	Mon, 27 Oct 2025 09:30:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id ECE3220040;
	Mon, 27 Oct 2025 09:30:14 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 09:30:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv3 5/6] nvme: add generic debugfs support
Date: Mon, 27 Oct 2025 14:59:39 +0530
Message-ID: <20251027092949.961287-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027092949.961287-1-nilay@linux.ibm.com>
References: <20251027092949.961287-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxOSBTYWx0ZWRfX5kg8AHWP95K9
 K7puQwvEvxTCABbLR+1EznIV+KRQaXhYXB7Qfu9f/MeRH+G6UPlzA/hqS6XBIX87Gq3JHQI4mDX
 SGc5t6uPAQq49IKrSc0UH7Vy6gED5YMADL7V4uBP4E2ajIrziwVRWZOW/rnKUM17whhHBtcy2yU
 /Ou5fo1njve3E7MepJZUF5Q+P3Ev1Wo9Imz2JDte2BKcI7GEwzP+SF2BL1GdaGkkuIimc2x2/X8
 nXxlytOTlJmkroZ0DGp17O6AKQ+HNx8Gw1Q6gyzOc2g/RAuSu3GFGtb5DQQpHO05qW2O5BmEFQX
 8JVPx28qjLUjNyredAyVslBIEdn3OVLihwgkx4pKdk5pqEvOxAMLNu4OduvX8PsL0WL8mNQ4zQL
 71/rceDUw8wBF4WqXdMaLvBz3iygmA==
X-Proofpoint-GUID: dTlbvGYVybihhZXpebtoKLitszT6vlB9
X-Authority-Analysis: v=2.4 cv=V8ZwEOni c=1 sm=1 tr=0 ts=68ff3bad cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=eKE__Qlmx2A1X5IvaHYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: dTlbvGYVybihhZXpebtoKLitszT6vlB9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 adultscore=0 bulkscore=0 spamscore=0 clxscore=1015 suspectscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510250019
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_023027_411366_139137FE 
X-CRM114-Status: GOOD (  22.33  )
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
 drivers/nvme/host/Makefile  |   2 +-
 drivers/nvme/host/debugfs.c | 122 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  11 ++++
 3 files changed, 134 insertions(+), 1 deletion(-)
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
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
new file mode 100644
index 000000000000..5c441779554f
--- /dev/null
+++ b/drivers/nvme/host/debugfs.c
@@ -0,0 +1,122 @@
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
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2e58d4d6902a..d049b62b71d2 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -988,6 +988,7 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
 extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
+
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int op_type);
 static inline int nvme_data_dir(const enum req_op op)
 {
@@ -999,6 +1000,16 @@ static inline int nvme_data_dir(const enum req_op op)
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


