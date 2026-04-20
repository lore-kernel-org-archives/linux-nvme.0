Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31E57F36C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 11:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kIVQ3/NFM7DNKMlHSaTNIuSDA768DpYu/8ddkvZDQjE=; b=1LVZCNhsmfKVyQFucYCjnw8l4C
	iMLs/2PK7TGsU5VZ1jO/e9pXXJGnOUAO1wouD+g0dCtB8KPYIYLDB4+8CY2ajAfMScS3KtQ2dWuI5
	/M7k41/8X6it0T1olZUS0yrCPILX83SL7mfIcPwi4WZ71f98hq9ugQAFNI96DqXlDLbkcpaWZx7iH
	GvVE/vRvasXB7c0zD+94JQvOdOwiNItk0hJoYBk8yzWGUW6nfrr9WAK/vRkEbqHSX7gZrDZ/sLt4p
	tNrxpiC4yeu+zMmrC/IklTsMELppi5YUVi/Y0c3AVgwKavCWjA0eiAzJl1rLH7U4X74Ng/p2L7Jkr
	CAiknyvw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnGA-00000006pVx-3j5R;
	Mon, 20 Apr 2026 11:57:51 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnG7-00000006pUO-3t1b
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 11:57:49 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JKrvCh3465485;
	Mon, 20 Apr 2026 11:57:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=kIVQ3/NFM7DNKMlHS
	aTNIuSDA768DpYu/8ddkvZDQjE=; b=MHtHoOBRlVubISMAnsUGp/7e8zePz4MdF
	FBYM9En7UlotB6Ja3VEa7QK6632S8p1Ng0HyIfLloSXrz73C1YFEvI5RALi7OIgV
	lY6ZVpqrHJAFQuU0OirQWixgirAiqHep6yAyKw28bPLmio9A+Q9ROq022bpNlyKR
	z5/vER3rDPIIs8hA7Kob+9tAAcr2d43yM2WHR2nneoALQST+2d5pB97zsm3ksza2
	W+iWBu1Fe4FACmTeU7dr0Rg8sNARXvREMYgh36nIrcILbEfAImkts3/UcFu1PYW9
	gER1VrKqCDX/gUbMoQC8KooR3TBsJ9221juHFVRVt3F2Anl5yG8WQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2h9excy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:35 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KBoHx4005344;
	Mon, 20 Apr 2026 11:57:34 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4dmm9pvr8v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KBvVlC43843876
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 11:57:31 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 57F7C20040;
	Mon, 20 Apr 2026 11:57:31 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 6EC1B20049;
	Mon, 20 Apr 2026 11:57:29 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 11:57:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RFC PATCH 3/4] nvme: add debugfs helpers for NVMe drivers
Date: Mon, 20 Apr 2026 17:19:35 +0530
Message-ID: <20260420115716.3071293-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420115716.3071293-1-nilay@linux.ibm.com>
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: z2fSNsD3N_Kmsg2Bq18TYlToYqHXcky8
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfXyb9pB+t++O/A
 5E3KuVxAUF1yocppg4SZ+HIqmY56GMdzREY/1rluwWc/vEn+9Fa2jTxa5d1fz8VKfEWL770TcFh
 sakBek+A1ma7Q2PuzY/n2YcSYu/hLxdpOs9dhLpwBtzaCMYtEMaVIvvxYJ0htGxH2Cc19X0LyUL
 sqVRKvbpkdc5aAjAFh9U1eEF78pZjC+qz0AoTlHT1O4Ye7wOaVtbrnJc8qsVLcHfuGke2w6SnT6
 okMiDYYel/T7n1PWTPFDKxny4CsS/F79mIrkHvaDIfVJ8tfHyAve/UFLwq+ahtDAebY1Gz2tDuX
 fTRMtVe4qh0XQQrGcPeekYtnGxUG0u1z/ee5+yHrDCSYMrqBrMlydcQqqf8hCsgwAFyRBMVYZ/A
 Je6yWvJPKyk4c+fc3ttd5ENOTxXoWdyZXn5jc4BLlWHR5zXMJt9MmUwF4btAtIIP5zBuswS4VSf
 4Os5KsJ/qaN3CwbrWkA==
X-Authority-Analysis: v=2.4 cv=XLYAjwhE c=1 sm=1 tr=0 ts=69e614af cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=ooCht5J9LIHKhMPangUA:9
X-Proofpoint-GUID: z2fSNsD3N_Kmsg2Bq18TYlToYqHXcky8
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 impostorscore=0 spamscore=0 adultscore=0
 priorityscore=1501 phishscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2604070000
 definitions=main-2604200115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_045748_085888_2473C83E 
X-CRM114-Status: GOOD (  22.65  )
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

Introduce helper APIs that allow NVMe drivers to register and unregister
debugfs entries, along with a reusable attribute structure for defining
new debugfs files.

The implementation uses seq_file interfaces to safely expose per-
namespace or per-path statistics, while supporting both simple show
callbacks and full seq_operations.

This will be used by subsequent patches to expose NVMe-TCP queue
and flow information for tuning NVMe TCP I/O workqueue and network stack
components.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/Makefile  |   2 +-
 drivers/nvme/host/debugfs.c | 111 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  10 ++++
 3 files changed, 122 insertions(+), 1 deletion(-)
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
index 000000000000..ee86138487d0
--- /dev/null
+++ b/drivers/nvme/host/debugfs.c
@@ -0,0 +1,111 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2026 IBM Corporation
+ *	Nilay Shroff <nilay@linux.ibm.com>
+ */
+
+#include <linux/debugfs.h>
+#include <linux/seq_file.h>
+#include <linux/slab.h>
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
+	ctx = kzalloc_obj(*ctx);
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
+	nvme_debugfs_create_files(disk->queue, nvme_ns_debugfs_attrs,
+			disk->private_data);
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..2f3f1d2d19b9 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -468,6 +468,16 @@ struct nvme_ctrl {
 	u16			awupf; /* 0's based value. */
 };
 
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
 static inline enum nvme_ctrl_state nvme_ctrl_state(struct nvme_ctrl *ctrl)
 {
 	return READ_ONCE(ctrl->state);
-- 
2.53.0


