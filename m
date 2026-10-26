Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3E0B606A31A
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 12:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=f02Evv6+;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=WpEC3R8W
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=UL447PZaRxaW5cNcX4526NWnaaQ5aSFAUE8MmwQG9Ak=; b=f02Evv6+IG4bnJ
	H6Xc7GLbVzutLr73XzG/lr4h+ZiaFU68v/QsqZ0qtCG6ava8Y21M9YgTFSOGxqCDOlaH9wrT4xkPA
	S7F1tunlzbIlFFVgCnqy1Fn8EYpnYlJDh3I8FwhPpsDEUW1pNtWyRq5Cw6fqKxOdAoI/Xf2hkAYO5
	AWDjBnDG2MC9MpwVHOQkmmJI4CSuO9wqHQ5NsJW9xybKJA32U3yW7jgDh8wBhU1UWD9rcCfUIpya9
	7SvHRWucEhhlkpNvNXoRqd3hL7cs04MLdEhbZHAh6GD9aQYE40IflzBrUX37UsBrlZy7czpdht2+j
	l9eNrtvvQ5x+A+6+xlsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJuU-00000002Vrp-1rDp;
	Mon, 26 Oct 2026 12:34:42 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJuR-00000002Vr1-3qrb
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 12:34:41 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEGAa3336096;
	Mon, 26 Oct 2026 12:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UL447PZaRxaW5cNcX
	4526NWnaaQ5aSFAUE8MmwQG9Ak=; b=WpEC3R8WixL+p3DdVfVmPXI8f3ajb2+j3
	C0xwUKgkYomO2gLIMWjVlshr6RfRtsZhlsXqzoAWhW55bHZMU6q+vrRTk/9TT+G6
	9eTEsw/fb2BVq9WWHb2NygSCSv2bY7gGIP3FnpRuvzfdXUU4ApYXJybfEhoqKozm
	0iWF+WzOFtP5qyOG6/YXA3ny8vNIefIWZsxKG3y7TNVpAoKyzLDDOA1sS3JENvhA
	CB71R9xlcib8emEeIycy4odJrvz+Idgz5vEQOvvm/pA2ZanzofvELg3KBCK8eghh
	mmjqIR9TPHCvZPXSsmmiERYH6hFKHTvoaT7htuXkUIBJZrBYdEdFQ==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmd6suyr-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:34:24 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBJxUo2442825;
	Mon, 26 Oct 2026 12:34:23 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh7cvdxmd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:34:23 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QCYLD539256332
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 12:34:21 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 518282004B;
	Mon, 26 Oct 2026 12:34:21 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8622020040;
	Mon, 26 Oct 2026 12:34:17 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.162.42])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 12:34:17 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, dwagner@suse.de, hch@lst.de, hare@suse.de,
        sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 1/2] nvme: add debugfs helpers for NVMe drivers
Date: Mon, 26 Oct 2026 18:03:22 +0530
Message-ID: <20261026123411.1988949-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026123411.1988949-4-nilay@linux.ibm.com>
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=ZYOIpcVA c=1 sm=1 tr=0 ts=6adf48d0 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=eKE__Qlmx2A1X5IvaHYA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfXz21+U8SiwgHY
 Or5dZvGef7s19Rm6D1DPhFyaSxSt4s5IY29sMceLEMTbakzdpawU6aopqvm5YIGJwTb7AGRukKc
 1+UmjH+Qxx7SDZTbf2yRX7geocvD6+nN9vkvdIcEyEFSoM9Hhm6/6voRIxg8oswv5BOD4vgveZg
 3dHANCmUha/kDc8/VbNTqR8pIJ7x4xfteaCCQGvkxblWQYV+mr66EVs2FCwFSpVscy03kJ8+0vx
 M4bsGlsO7zrTw3FTmeWILKm0s9ySF/q3Iqeyw18u/QFAs43rDewkFESGt2IyLruNnOPWMKjlAaD
 XOpPlJKIUnZagKEZZeE49HnKli6V7vzTYdCHM/VKiSnNFogynQiyDuLw9P8qFVhGuNDmph23es3
 1eQK7yGkXeNbd69tTSAxjNROepwRdS/WRyMTbSQEx3OS1UgM6xERjYHCVxrx6zbwXoIlehSBj49
 hvz4K/595pwkYhgqVoA==
X-Proofpoint-GUID: L4dKqbFprUoF5KAuiqFyOxuyy0iIBXr6
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX/8g8g02Gfx1r
 /EaomRLeaQqvf34z5bbWvO+G0jioM/h1NSRyDAYtOWZd4yzoUacNbb3uMRMNPBaAh1SnGOarpD3
 GIg0vLC8DvFRtqvVwnXe9O58VXqLUcw=
X-Proofpoint-ORIG-GUID: L4dKqbFprUoF5KAuiqFyOxuyy0iIBXr6
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 priorityscore=1501 suspectscore=0 phishscore=0 clxscore=1015
 bulkscore=0 malwarescore=0 lowpriorityscore=0 spamscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_053439_995459_143E24B9 
X-CRM114-Status: GOOD (  24.37  )
X-Spam-Score: -2.6 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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
 drivers/nvme/host/debugfs.c | 133 ++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h    |  10 +++
 3 files changed, 144 insertions(+), 1 deletion(-)
 create mode 100644 drivers/nvme/host/debugfs.c

diff --git a/drivers/nvme/host/Makefile b/drivers/nvme/host/Makefile
index 67563a69f7dc..314d3439406b 100644
--- a/drivers/nvme/host/Makefile
+++ b/drivers/nvme/host/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_NVME_FC)			+= nvme-fc.o
 obj-$(CONFIG_NVME_TCP)			+= nvme-tcp.o
 obj-$(CONFIG_NVME_APPLE)		+= nvme-apple.o
 
-nvme-core-y				+= core.o ioctl.o sysfs.o pr.o
+nvme-core-y				+= core.o ioctl.o sysfs.o pr.o debugfs.o
 nvme-core-$(CONFIG_NVME_VERBOSE_ERRORS)	+= constants.o
 nvme-core-$(CONFIG_TRACING)		+= trace.o
 nvme-core-$(CONFIG_NVME_MULTIPATH)	+= multipath.o
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
new file mode 100644
index 000000000000..798fec4730f0
--- /dev/null
+++ b/drivers/nvme/host/debugfs.c
@@ -0,0 +1,133 @@
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
+	bool (*is_visible)(void *data);
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
+	if (!ctx) {
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
+static const struct nvme_debugfs_attr nvme_debugfs_attrs[] = {
+	{},
+};
+
+static void nvme_debugfs_create_files(struct request_queue *q,
+		const struct nvme_debugfs_attr *attr, void *data)
+{
+	if (WARN_ON_ONCE(!q->debugfs_dir))
+		return;
+
+	for (; attr->name; attr++) {
+		if (attr->is_visible && !attr->is_visible(data))
+			continue;
+		debugfs_create_file_aux(attr->name, attr->mode, q->debugfs_dir,
+				data, (void *)attr, &nvme_debugfs_fops);
+	}
+}
+
+void nvme_debugfs_register(struct gendisk *disk)
+{
+	nvme_debugfs_create_files(disk->queue, nvme_debugfs_attrs,
+			disk->private_data);
+}
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index a8ef62b8e34b..db2ab1469fd0 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -483,6 +483,16 @@ struct nvme_ctrl {
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


