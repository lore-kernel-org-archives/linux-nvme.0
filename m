Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4DC54CCA470
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 10:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nuq+1Hvfa5MtbONzTLChy/ocq/CCZXoBWDC0Lt4TBf0=; b=hGzr/7i+/g4BRgCSpUXDGQdRC1
	XCJbNhOc6VpHBjYHTZTDKlsCAMi/JkuBrewhiSscVohyWgSjgTimBGvGv7BuhOVD1SH1yEga07845
	rakpJBKlT53nW83A4OT7VKgvbwhyu/qd6exfou3pK8sXH6MbJx0PDsxKEbSf+imiHo5Pm1KiIWsRZ
	0dQixbXa9xagTy/yPRcRV5aGJI+vAn3cCaCAMLqDOElvaTTwZ28J4FBDF7kXQ2VwYH341onGKegGJ
	U7QS1BTOgiKzOD3QcfOahx0PdpNiH2KaaUyBaY4Ycl2kVJptKu32OyGxvA/dPcYfs5o8T7zsnDneC
	KjNnD64Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXZ-00000005jcf-391S;
	Thu, 09 Oct 2025 10:06:29 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXX-00000005jaq-0PeF
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 10:06:28 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5995V2Ep006912;
	Thu, 9 Oct 2025 10:06:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=nuq+1Hvfa5MtbONzT
	LChy/ocq/CCZXoBWDC0Lt4TBf0=; b=P2SJ/DYQqjcIixXVVShbAIp35B3LZ8XBy
	prfWVRP25m9646uM6CuzRF3vFG9A2W721gSDDu0+Uws7u3xima4aPdg4g2OSDPxx
	MPx5Q91Dd6jtFtD60Qsnh6IxZgZeuGS8crzwtAJ6+Ee8G3t72MJDo95C2mV+/s5s
	jkATXm6OXxijO+Cndj+N9gQqULkKPFXIg4I9UsVWoTHu34gBeof+iEeJ2Dx1T+sQ
	16nQfhvAsU81tQ2bcDUvytTIuQxvPMlRLrwE/YevEm3zMvROjKIETIp2Xp3q8Tna
	ECJbM3QHDi71xMlM+5f9DWn0Z6pz1Vvuo4cFURbodlras9mICbB8g==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv804430-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:24 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998K7DH012997;
	Thu, 9 Oct 2025 10:06:23 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamuwwf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:23 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599A6LtY55640360
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 10:06:21 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 131192008A;
	Thu,  9 Oct 2025 10:06:21 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 50DDF20087;
	Thu,  9 Oct 2025 10:06:19 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.200])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 10:06:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCHv2 3/4] nvme: add generic debugfs support
Date: Thu,  9 Oct 2025 15:35:25 +0530
Message-ID: <20251009100608.1699550-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009100608.1699550-1-nilay@linux.ibm.com>
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=NsDcssdJ c=1 sm=1 tr=0 ts=68e78920 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=ooCht5J9LIHKhMPangUA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: D4D9FFiCAQxP8-IKCtfzTyF8EQ-iIzWr
X-Proofpoint-ORIG-GUID: D4D9FFiCAQxP8-IKCtfzTyF8EQ-iIzWr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX9G1Ghol8X49A
 BNdIJQx8IgrsYdt01r8JY069viiNtba+d+ChA0Fe917WZrNL0K7wfUOkd3SZ2xVm0CqUM2qRmfq
 GUBL1bFj1fT+YEPmZpLPQbhJ2jmo1xqdZ90u6Vp57gwCFov4Cq8kMgwJGqhdWOjoFsSgR2cSZw2
 owPhoyyJi2WAv7kl6rgzZ7F6QT+TevWlAlpDjxZpLGUeNPe7sL50k5KPhFWcV7YuHzzqzSTq56R
 dxelpfQb3/4Rs4YWmizuhVZREy9+Ji69/tLP5QlzViQD7jfBknOXqrEZrDEvGfHwihRsKUZTeQO
 fxaJtsutKMYOAWlXswkRzSEX+Hk020Ur/I0LzHRyn2LDh+HYnvQI7Kmv4+CYsnYULyxEJAgDXdt
 6mHE9493okom5XWGv/7+RPTbqfECBA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 impostorscore=0 adultscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510020000
 definitions=main-2510080121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_030627_151732_C308A26A 
X-CRM114-Status: GOOD (  21.90  )
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

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/Makefile  |   2 +-
 drivers/nvme/host/debugfs.c | 122 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  10 +++
 3 files changed, 133 insertions(+), 1 deletion(-)
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
index bc87dd80de62..fae8e0b34915 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -977,6 +977,16 @@ extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
 struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int rw);
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


