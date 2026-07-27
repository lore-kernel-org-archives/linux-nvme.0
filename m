Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D623C531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 15:17:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fTjgA/m4QpVivZiMoQzC1lgl6oU+D76RO43IbLRSvdk=; b=q9QDIUzaSOVuVVgzl1j4xP3tG1
	2QpKhKOPH0cWeMKcXCcIb4bXbCkqEJNf/SyfWbuvmERyH0KrhqK0OAOdcms3wco070i09EPxFN7XI
	Tu9ufUTUsxn6NmJ+FQfvihTrm0vpt2lM6PiaV8Pgty/VzPiFOt99FepuMvR3Qgatw7ImNCRxfzl17
	VXkGUcScCtA6m2T2TA6b1uR2okK6oU1V8EAqQDda8nw7ajjY5LGxq7ZGS79QHwS/UCoLIxnc5r+qj
	/obFYAp6MIUAPnB9sDTGxSje2Vp186YSBUQDgu/iXuH4rIoZ5AJUdQNg5HnXwdyFg8QtYQlt6pp+8
	BHA3p6Dg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN5R-000000038yr-3GS4;
	Mon, 27 Jul 2026 15:17:49 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN5N-000000038wk-2ryn
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 15:17:49 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDncLD2412244;
	Mon, 27 Jul 2026 15:17:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=fTjgA/m4QpVivZiMo
	QzC1lgl6oU+D76RO43IbLRSvdk=; b=ajt0PGkAIUlxcrmEtu+epbU4jq9tmikYG
	Cf+BHWA0jFXKDgNlspGFDtagM/QFnm3lRyGU9vgkxQ3NmDSLNW02/G3iK/z6U4ID
	gA9rBZDZM6fLGjJyWjQRo9UXK+BhwkTEruEjx8UUnYk6AXXh3oOkrZZAVDaHjDoe
	tnI3S9uoy9DDgOlMxgnbuTiihpndWnF8dKPPIEs+czMGURuNN+oaL7vaNSBuEbuT
	0ZE+y4/ps+6+9b5ZbUUCl6vBFFzJrw9DkZltBAlSOATNLUfutZKeU5EQjqnqh8iI
	cZi+GA5gGfVEiaJML87em7lbvs9JWk4ZmOO3akGPHDQi1KiLusc5A==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcr9mn-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:17:41 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFBJK0023999;
	Mon, 27 Jul 2026 15:17:41 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn7uvx0qj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:17:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RFHbHM46268760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:17:37 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F35D200E0;
	Mon, 27 Jul 2026 15:17:37 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 121DF20085;
	Mon, 27 Jul 2026 15:17:35 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.97.190])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:17:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 3/4] nvme: add debugfs helpers for NVMe drivers
Date: Mon, 27 Jul 2026 20:46:46 +0530
Message-ID: <20260727151652.3660476-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727151652.3660476-1-nilay@linux.ibm.com>
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: QvqZetiMv4gNDrP1FfQFjfvaFzITibBM
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX+CwwQNxtVFSu
 q9BV4nymGWP2kmVXy6iAygrNxtE+n8Q1jHAKvNpXOvQQbUK8RxHIDtHwmzr8BwToNYEJ/H1a90/
 CljSxHDA0tBkzybQ2pz6Z1APyNyZpQI=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a677695 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=ooCht5J9LIHKhMPangUA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX27asNkHRrSIi
 /I5WbetvcgLLcTqRbrc2t2z8rGn/VgNcWvak+hiVjXhZXY/oUQhd7/U8mEfY/98dubQxLe5lLCk
 oiBigD33q5lYLDczaGSaaACIQpHXzACN/WyfyKEsyXY4eTnika6Qixd96QoQKky/D8e8B8Fsxtl
 iAKjm++VAcRlImCDlOtpiSl3FsgcjkCG+/Pj9PROW3rW7HtjT/IHr34NPkVwTOWlWukE5imgC8w
 t/1fVvzPSZ3hBvK60nmPYXtSGBldViBdqa5W4TtjbTrqlcKc5Tav8YxbcIEcOoubSRfw48Y1XtJ
 4hV8gLkT8EfTpAzQg3OW2r+gBD75WhtFa63PlWCaM0PS9bhDdlASfZdVfMUoEIB5YX3Ra9ACprG
 wDAakVvAepoBrdC8JcWxo0J6wHqYV8Ue928QPhrfGZ57AirgzTscKbRc211M5tvFHcGDq/vd5ye
 NnP589x5Azn0vNQpTig==
X-Proofpoint-GUID: QvqZetiMv4gNDrP1FfQFjfvaFzITibBM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_081745_840480_7691FF65 
X-CRM114-Status: GOOD (  24.55  )
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
 drivers/nvme/host/debugfs.c | 129 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  10 +++
 3 files changed, 140 insertions(+), 1 deletion(-)
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
index 000000000000..b4802ea3bd48
--- /dev/null
+++ b/drivers/nvme/host/debugfs.c
@@ -0,0 +1,129 @@
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
+	bool (*get)(void *data);
+	void (*put)(void *data);
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
+	if (attr->get && !attr->get(data))
+		return -ENODEV;
+
+	ctx = kzalloc_obj(*ctx);
+	if (WARN_ON_ONCE(!ctx)) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	ctx->data = data;
+	ctx->attr = attr;
+
+	if (attr->seq_ops) {
+		ret = seq_open(file, attr->seq_ops);
+		if (ret)
+			goto out_free;
+
+		m = file->private_data;
+		m->private = ctx;
+		return ret;
+	}
+
+	if (WARN_ON_ONCE(!attr->show)) {
+		ret = -EPERM;
+		goto out_free;
+	}
+
+	ret = single_open(file, nvme_debugfs_show, ctx);
+	if (!ret)
+		return ret;
+
+out_free:
+	kfree(ctx);
+out:
+	if (attr->put)
+		attr->put(data);
+	return ret;
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
+	if (attr->put)
+		attr->put(ctx->data);
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
index 824651cc898d..72f9d9c668a1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -474,6 +474,16 @@ struct nvme_ctrl {
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


