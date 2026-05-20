Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2492CD4F3D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:21:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fjn0pwccByfut4Y9PbdpPLLJHdV/9JUxvDMrorakGjo=; b=c6ZCnr4LwyYoD2WNtp3zY3pTcp
	pr8ACRqSgAikUc1f80dg/3ONJldWDscvnT3drbLX53q78PGf3ieQHWzkIvCkKoJyvfxny1+SnS1a0
	LyUTjnLpAbW3W82HotrII3/hIF8MqrDWP/sO4iwq7j1mvQumu0N0fxa5mm8NtTT3g0rD+jk7/SZ2L
	klcm4/n3WCJAmv6Dq8DmEHQsUEpCBXZmuwUD2WxmDYeNONs835wudqrZXDuWC9obUqZ0jVqEmmm+r
	sxLb96TWIoO9cxEnwsGDErwSubjGlOf4IJm7gRyDwuMuOPvRKOhAsEt5L9ekr6NHC+ut3i15YSxxY
	7SrLi0UQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYK-00000005QI9-1vI3;
	Wed, 20 May 2026 18:21:56 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYG-00000005QFF-24oI
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:21:54 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K859kp2166376;
	Wed, 20 May 2026 18:21:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fjn0pwccByfut4Y9P
	bdpPLLJHdV/9JUxvDMrorakGjo=; b=NOuSDABn88zJzSoJSgtWsJL+xXr5oq6kq
	zGB4dgschUJnujLMbKqwRO8c9BE3H3jcj6hpU2K8YQGzyiSBUg8JhvU/G1/LQfsU
	jASCp6a45jPIkLJ5u4ZkqdF7ezQEl1j24/JKJzCAy8XQfpNsv1inI2VuwZZzm0sE
	vPdb/gQbJrlaFohh2uW5t4H+xndhs65i8iSNthRaiG/XBggfoYf8r2ygob9+cLoe
	s0EJAGpqE76cyfNS18dTGdht83B6ATI/bZk8+hrGWy3mA53f9P/JcvsESxWTKn36
	66PcWhszLWfsh5PI5CAuMbx/+r7V/N/A+/eg5WT9fd9L+2N8Hxj4w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h753c7n-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:47 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI95pF021471;
	Wed, 20 May 2026 18:21:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8s9g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:46 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KILitU40042808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:21:44 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AA4032004B;
	Wed, 20 May 2026 18:21:44 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB0C820040;
	Wed, 20 May 2026 18:21:39 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:21:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 4/8] nvme: add generic debugfs support
Date: Wed, 20 May 2026 23:51:00 +0530
Message-ID: <20260520182112.863076-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
References: <20260520182112.863076-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=ffCdDUQF c=1 sm=1 tr=0 ts=6a0dfbbb cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=RurgEnbhPsFkkpbWVXEA:9
X-Proofpoint-ORIG-GUID: 0n_84U9IVvHiJo2B4T_Aa1nLro7A3MRP
X-Proofpoint-GUID: TuHZSaa2VUA_gS363ukp44MgG2aLMtjN
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfX2Yzdqbl9H/bK
 ejvSwlWlRfLcyKtGlLrOi+r26LURa7MKNwGyHjVc2ux4cRZFYzbD4f6/ZaEIOZB3xVsatRe8zaG
 ZOZxeIj0VePr+lfV6s8gCjNeAqbBd8v+vxiWqd4x+thq/WUBAHTwhQuyJDjQLUr0HDINt4rVQYS
 je+D4+JrrqDvOVSB4+lORO4/UWqsOj42hjHb+q4Q4/6GFab5tEaVDcdmS7kXS2EnrpTQFmyXq0w
 SokL9xyqnVLGLkfuo92BLenfWMcQ6D8s79KdrjoOXF2PWdVeoQygJ1ESHfTZevWr9PZSv66ihxC
 NdOdu8XmxNwdMZHf3OfGiwv9s4fNg0Wf+mwCua43o3f1rtAvteqZVFVwEm9RgCTU1X4tAzhChIA
 ktcbNnVPJOJV3Av8JtnLJpM7oRl9ewWTnKykTpYPCc1IvUhpJY/PLTrljbNs26fxsSEIyjow7/b
 pngynrLd/B4PKGltvNA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 phishscore=0 suspectscore=0 adultscore=0
 clxscore=1015 impostorscore=0 lowpriorityscore=0 bulkscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_112153_332528_C8AC777B 
X-CRM114-Status: GOOD (  22.98  )
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
index 82db59927556..ca2be0472e3f 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4224,6 +4224,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
+	nvme_debugfs_register(ns->disk);
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -4307,6 +4309,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
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
index e1089a75a6fe..541d12b73b74 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1078,6 +1078,7 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
+		nvme_debugfs_unregister(head->disk);
 		del_gendisk(head->disk);
 	}
 	nvme_put_ns_head(head);
@@ -1187,6 +1188,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		}
 		nvme_add_ns_head_cdev(head);
 		queue_work(nvme_wq, &head->partition_scan_work);
+		nvme_debugfs_register(head->disk);
 	}
 
 	nvme_mpath_add_sysfs_link(ns->head);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 22e54c74c1a6..7ee9689ce07e 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1067,6 +1067,16 @@ static inline int nvme_data_dir(const enum req_op op)
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
2.53.0


