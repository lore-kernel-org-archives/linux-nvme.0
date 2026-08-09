Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A58DBC5AD68
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9l6tYGo5YuHVDiSYYjeQM+q1CoB1R0XKXA8OIxEil5o=; b=cTMYinVMLa1aJ9SlAULMBBv3CC
	S0CFgSfiIjOBGOotVi0L0uSQvrPlE47AleBzvAkBqVGFCqo6g/FybMPP429ET3KJZwFg4vQuJzQ5E
	7sUuOuyTRfEQvPB0qUoDIQ1ZhHCsMlZPYVqgHtjvetoVVZU5uchnkKSffa29gZT6gl3D4mnszDZLV
	tcH2MPoiwTnGQTnas81EeWs+BvIYweE4OGac9aVn3NG7+tRVVxUsVmey9hAgh3Y1N2r4DTsvnwTaX
	bKt+cA3cJxz7fskCMd+TPA/KPfUJJ8LJ6C777vMtD4pfElXvsWOimiMzKs/itd9GnpXZ10mQ+wTmM
	cLR9QD9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sx-0000000AAlc-19nO;
	Sun, 09 Aug 2026 10:09:15 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Su-0000000AAj0-2sfx
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:13 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67991ahs699800;
	Sun, 9 Aug 2026 10:09:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=9l6tYGo5YuHVDiSYY
	jeQM+q1CoB1R0XKXA8OIxEil5o=; b=ZpoekoznIGud6qWw9vkZDrSHEWHo9BawQ
	Ahz92NbxzLgxccfDy/eFC+HYFQY50gKPAHkj2RmxM9P5R18dnft1gQMY0buLFZJs
	Nqidk+l+prwSDlTZ5CWnaVSHysQ6WsJsHhB16+nhkptRaR9imlOiFsO7v21W9hw8
	VLib/CJg4eVhRETSzTy5Bpcra3OwqU7UONGUDMyHDbvf8/z+GRjzNtKBZFhuhMxF
	Uw64BERHM1M7N+XW1u6S31QJZBx+9CTHN8lBtSwx/bNHCL5t5atLIqvnrVUVn+dW
	BKoVLV7J+ZN+oxqyoMMfxQndZCblhcL+p2gbOB3+X4O2Xm67VYkfA==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjykvsd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:07 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799uIbI010891;
	Sun, 9 Aug 2026 10:09:06 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g0v12-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:06 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A92ws39977264
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:09:02 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A44020043;
	Sun,  9 Aug 2026 10:09:02 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B10C320040;
	Sun,  9 Aug 2026 10:08:59 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:08:59 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 5/9] nvme: add generic debugfs support
Date: Sun,  9 Aug 2026 15:38:00 +0530
Message-ID: <20260809100825.2014133-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX47SHYBb8VY1u
 lXXdAuNzy7YuiOoJ0blkzi6w1g9RdbHW/FplDG7zwDwGxD6fn59wEO/epkE1jXf1xIpKa2fpEzA
 edI+h24wuBzFjjsEDOKFbZbDpLCFhxB+dL0/HBkzdyS4pjntanugR8jBQOnzQs6cD8gHJrkQKH5
 HEuCIPbmkZqvWsiQkOBifMnjTQSj88uq1ff8qo+tN5t1TcpUpKwfo4KyvcBrJ3GSSnobHehnZpU
 cZC2d53JUZmpL3yb27qhTOuX6wDYZA7jQ2iLbdfFykWKI7zQVUbv0ThVaVW8lHyAudxDyCz1Va/
 5wVGPkzCZAwYgc+wQ/WJk2Hrlbuj+klQSxeLcjqkLdixkc6KHvS4wNl+esLlxMmhUmPVwutC/+D
 mHwJiTPRZo/Cm5yx+Yk5ta29l24pthEQco+YoA6nN/k4ow8gLE/0kCGXuIM+unShciq/Sj7kcR9
 JAZ51Wa+Ceyi5AQxMXQ==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfXz9m3D+UMfR5s
 PQZvaIqKC9sPymhAnilwkSd1d+9Kp2Vv33IAVsx6Fi8SU+w0BBsHnY4pXAvphgFc0dcjPcWDmm4
 nRs3w7Ps/zu6hd7JpH3X6xvCbNke3nI=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7851c3 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=RurgEnbhPsFkkpbWVXEA:9
X-Proofpoint-GUID: FO3RmoOTMQwTCuCpcj9SFlzdEzKIfeST
X-Proofpoint-ORIG-GUID: scehNtehX0CCcwhMdJdO-ewD_Xh6Mvn-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1011 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030912_738069_8A4181CE 
X-CRM114-Status: GOOD (  22.76  )
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
index 542e2ee036cc..21ed0ba9ac49 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4271,6 +4271,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
+	nvme_debugfs_register(ns->disk);
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -4353,6 +4355,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_mpath_remove_sysfs_link(ns);
 
+	nvme_debugfs_unregister(ns->disk);
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
new file mode 100644
index 000000000000..26a50566e4a1
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
+	ctx = kzalloc_obj(struct nvme_debugfs_ctx);
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
index 8086530b5350..b893df83d821 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1116,6 +1116,7 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 		if (test_and_clear_bit(NVME_NSHEAD_CDEV_LIVE, &head->flags))
 			nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
+		nvme_debugfs_unregister(head->disk);
 		del_gendisk(head->disk);
 	}
 	nvme_put_ns_head(head);
@@ -1225,6 +1226,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		}
 		nvme_add_ns_head_cdev(head);
 		queue_work(nvme_wq, &head->partition_scan_work);
+		nvme_debugfs_register(head->disk);
 	}
 
 	nvme_mpath_add_sysfs_link(ns->head);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 3c82f67f8926..cd0d4565ebeb 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1103,6 +1103,16 @@ static inline int nvme_data_dir(struct request *req)
 	return __nvme_data_dir(req_op(req));
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
2.53.0


