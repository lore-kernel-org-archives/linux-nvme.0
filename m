Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D23606A31B
	for <linux-nvme@archiver.kernel.org>; Mon, 26 Oct 2026 12:34:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=mXZmHc6V;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=aBP15kfQ
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=458YXaipmUPCkSgXpI1P1gVozEsoGlLTT1eCAf59Q1M=; b=mXZmHc6VFl3TGo
	HwuYUDRdmhn1Q4YTxr8dAUDvuxh7A12hRYxaaCDeW2WIRKPNNnW5HoIm4ViWYm2JVGkOAQkjQdT4t
	ML/ye4Cu1ecIxO2QT+MpqDIkgO/Eq7P+WjPImwZ+YUqmPS+NkRGAnzr5N7PmhtqN4xRp7RYT7yst+
	M28x2+ohUBRMVLVlMsrazya6tbyL3c6Bv1iEHhJDk4Z/sqmRQq7wOxWg2AkZWz3nCfO/nNwiqUXkk
	fMH6V4pwNlS2bRdoR5M0JJWg3XcB08DcyCCKBCpngnf4ZHE5Y2VRl9p9ozMA9k7/eGCoEiil571pM
	b/69FsMUwCcMQ7B//w6g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJuN-00000002Vpc-0yIq;
	Mon, 26 Oct 2026 12:34:35 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xLJuL-00000002VpG-1oWM
	for linux-nvme@lists.infradead.org;
	Mon, 26 Oct 2026 12:34:34 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69QBEsqi3273471;
	Mon, 26 Oct 2026 12:34:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=458YXaipmUPCkSgXp
	I1P1gVozEsoGlLTT1eCAf59Q1M=; b=aBP15kfQ/YGgKt41Ztnrs6pWXjb5MGLof
	n8JozNhvv5HSs8Yr0dQCDCRzNeireG1E6gREoFcAsWjeZICHVdA9SFA+FUk5CRCf
	jH9eDwjbqXy70PEOTQYNwhLPXNgOype83Ns/MxYsACmwn2UJkrhg8APvuAh6khiW
	70rL9vGnhhstWSXgfu6RjCWxBqcDrUDroTprQ2lPkalOHwTD+z5xAqR2eg5+k8+4
	oBkh4TvvVwoPujGX4kGNVHZhr3YTpOc8xa7cFRbxLVlmvc1jJQFcDk+t4qiAJfb+
	All52XoiNbJGZYki9/T6aDUY9vZeoNw4dvzIrEjwt3B+cK2xRZNHw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgj3m2217-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:34:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69QB5JKw2503060;
	Mon, 26 Oct 2026 12:34:27 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4hh9py5jr3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 12:34:27 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QCYPb030802654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 12:34:26 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD49520040;
	Mon, 26 Oct 2026 12:34:25 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 10E622004F;
	Mon, 26 Oct 2026 12:34:22 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.162.42])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 12:34:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, dwagner@suse.de, hch@lst.de, hare@suse.de,
        sagi@grimberg.me, chaitanyak@nvidia.com, gjoyce@linux.ibm.com
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH v3 2/2] nvme: expose queue information via debugfs
Date: Mon, 26 Oct 2026 18:03:23 +0530
Message-ID: <20261026123411.1988949-6-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261026123411.1988949-4-nilay@linux.ibm.com>
References: <20261026123411.1988949-4-nilay@linux.ibm.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfXxk7cfxQrNpgD
 UjyILmZmJevGjVob1vrMgvGGvM3c+x3nMauFytCfhNI3PZgVmCr9m6NQQp+F5mtpQ5ccIs8vTui
 7jsgRuprEHGHiWg2Ogg1QaS+mnN2WL8=
X-Proofpoint-ORIG-GUID: VhnrlzulQM6D1Y0A5CMZZJcZ1h1BZRfr
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0OCBTYWx0ZWRfX8HQBniHq8Upv
 0ZLnB8D79xn72GMuFFVgKlZFm7LCL0HmN4TFZFm+Uj4WnEKZP2fdlY9Ov9sxxtA78uQMIz6qnj2
 eeWoOgoXQ/euh14ro6O0V0ZtqKJFa7uuxR084VXU6U1csi9DMHDFdguoGkTw6wbJ7u6gK8ae8Wt
 W/+WUqHQtYLX20/alo4HL+REFvP3WxWYWSQlB7uta6EyYVRFYOqOPfa8BClT0/dezxoBAQ+SyW3
 8EbqqpSQ52xANWBDAXaXObm1+D2w7pR/TFDWbeu6YFgX6z0Wwp+lmnxEHzwkxKJB6ihySMa7Z/z
 mQqFqWPDI1KUpv32tlefqeK16dkneRmVymu9VgaTexZq4qGUtoPGXqWstmghbqGCNziRA1FhYA6
 iDYF+bfZa6sWl9bXwmb6tzhf4MvSfxMkBwVXlAfxgD7AYRl7Ky1ojbLlXPDajTCl3VLwoShM2d6
 jxaQumYIv+phazY8GZg==
X-Authority-Analysis: v=2.4 cv=G7uJgNk5 c=1 sm=1 tr=0 ts=6adf48d4 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=LWIoN9EnsF6OxIflJ4MA:9
X-Proofpoint-GUID: VhnrlzulQM6D1Y0A5CMZZJcZ1h1BZRfr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_02,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 suspectscore=0 clxscore=1015
 phishscore=0 spamscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2610190000 definitions=main-2610260048
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261026_053433_611397_B7E6C26A 
X-CRM114-Status: GOOD (  22.58  )
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

Add a new debugfs attribute "io_queue_info" to expose per-queue
information for NVMe controllers. For NVMe-TCP, this includes the
CPU handling each I/O queue and the associated TCP flow (source and
destination address/port).

This information can be useful for understanding and tuning the
interaction between NVMe-TCP I/O queues and network stack components,
such as IRQ affinity, RPS/RFS, XPS, or NIC flow steering (ntuple).

The data is exported using seq_file interfaces to allow iteration
over all controller queues.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c    |  3 ++
 drivers/nvme/host/debugfs.c | 76 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h    |  2 +
 drivers/nvme/host/tcp.c     | 54 ++++++++++++++++++++++++++
 4 files changed, 134 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 531f9bb14bab..15334521c314 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4316,6 +4316,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
+	nvme_debugfs_register(ns->disk);
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -4399,6 +4401,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_mpath_remove_sysfs_link(ns);
 
+	nvme_debugfs_unregister(ns->disk);
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index 798fec4730f0..8ea0413f7b75 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -25,6 +25,61 @@ struct nvme_debugfs_ctx {
 	struct nvme_debugfs_attr *attr;
 };
 
+static void *nvme_io_queue_info_start(struct seq_file *m, loff_t *pos)
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns *ns = ctx->data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	/*
+	 * IO queues starts at offset 1.
+	 */
+	return (++*pos < ctrl->queue_count) ? pos : NULL;
+}
+
+static void *nvme_io_queue_info_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns *ns = ctx->data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	return (++*pos < ctrl->queue_count) ? pos : NULL;
+}
+
+static void nvme_io_queue_info_stop(struct seq_file *m, void *v)
+{
+	/* nothing to be done */
+}
+
+static int nvme_io_queue_info_show(struct seq_file *m, void *v)
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns *ns = ctx->data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (ctrl->ops->print_io_queue_info)
+		return ctrl->ops->print_io_queue_info(m, ctrl, *(loff_t *)v);
+
+	return 0;
+}
+
+const struct seq_operations nvme_io_queue_info_seq_ops = {
+	.start = nvme_io_queue_info_start,
+	.next = nvme_io_queue_info_next,
+	.stop = nvme_io_queue_info_stop,
+	.show = nvme_io_queue_info_show
+};
+
+static bool nvme_debugfs_get_ns(void *data)
+{
+	return nvme_get_ns(data);
+}
+
+static void nvme_debugfs_put_ns(void *data)
+{
+	nvme_put_ns(data);
+}
+
 static int nvme_debugfs_show(struct seq_file *m, void *v)
 {
 	struct nvme_debugfs_ctx *ctx = m->private;
@@ -100,6 +155,17 @@ static int nvme_debugfs_release(struct inode *inode, struct file *file)
 	return ret;
 }
 
+static bool nvme_debugfs_io_queue_info_visible(void *data)
+{
+	struct nvme_ns *ns = data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	if (ctrl->ops->print_io_queue_info)
+		return true;
+
+	return false;
+}
+
 static const struct file_operations nvme_debugfs_fops = {
 	.owner   = THIS_MODULE,
 	.open    = nvme_debugfs_open,
@@ -109,7 +175,15 @@ static const struct file_operations nvme_debugfs_fops = {
 };
 
 static const struct nvme_debugfs_attr nvme_debugfs_attrs[] = {
-	{},
+	{
+		.name		= "io_queue_info",
+		.mode		= 0400,
+		.seq_ops	= &nvme_io_queue_info_seq_ops,
+		.get		= nvme_debugfs_get_ns,
+		.put		= nvme_debugfs_put_ns,
+		.is_visible	= nvme_debugfs_io_queue_info_visible,
+	},
+	{}
 };
 
 static void nvme_debugfs_create_files(struct request_queue *q,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index db2ab1469fd0..48995bc6669c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -679,6 +679,8 @@ struct nvme_ctrl_ops {
 	void (*print_device_info)(struct nvme_ctrl *ctrl);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
 	unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool is_admin);
+	int (*print_io_queue_info)(struct seq_file *m, struct nvme_ctrl *ctrl,
+			int qid);
 };
 
 /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index f876375dffd2..2cb697d33c02 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2701,6 +2701,59 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
 	kfree(ctrl);
 }
 
+static int nvme_tcp_print_io_queue_info(struct seq_file *m,
+		struct nvme_ctrl *ctrl, int qid)
+{
+	int cpu;
+	struct sockaddr_storage src, dst;
+	struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
+	struct nvme_tcp_queue *queue = &tctrl->queues[qid];
+	int ret = -EINVAL;
+
+	if (!qid || qid >= ctrl->queue_count)
+		return -EINVAL;
+
+	if (!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		return 0;
+
+	mutex_lock(&queue->queue_lock);
+	if (!queue->sock)
+		goto unlock;
+
+	ret = kernel_getsockname(queue->sock, (struct sockaddr *)&src);
+	if (ret <= 0)
+		goto unlock;
+
+	ret = kernel_getpeername(queue->sock, (struct sockaddr *)&dst);
+	if (ret <= 0)
+		goto unlock;
+
+	cpu = (queue->io_cpu == WORK_CPU_UNBOUND) ? -1 : queue->io_cpu;
+
+	if (src.ss_family == AF_INET) {
+		struct sockaddr_in *sip = (struct sockaddr_in *)&src;
+		struct sockaddr_in *dip = (struct sockaddr_in *)&dst;
+
+		seq_printf(m, "qid=%d cpu=%d src_ip=%pI4 src_port=%u dst_ip=%pI4 dst_port=%u\n",
+				qid, cpu,
+				&sip->sin_addr.s_addr, ntohs(sip->sin_port),
+				&dip->sin_addr.s_addr, ntohs(dip->sin_port));
+		ret = 0;
+	} else if (src.ss_family == AF_INET6) {
+		struct sockaddr_in6 *sip6 = (struct sockaddr_in6 *)&src;
+		struct sockaddr_in6 *dip6 = (struct sockaddr_in6 *)&dst;
+
+		seq_printf(m, "qid=%d cpu=%d src_ip=%pI6c src_port=%u dst_ip=%pI6c dst_port=%u\n",
+				qid, cpu,
+				&sip6->sin6_addr, ntohs(sip6->sin6_port),
+				&dip6->sin6_addr, ntohs(dip6->sin6_port));
+		ret = 0;
+	}
+unlock:
+	mutex_unlock(&queue->queue_lock);
+	return ret;
+}
+
 static void nvme_tcp_set_sg_null(struct nvme_command *c)
 {
 	struct nvme_sgl_desc *sg = &c->common.dptr.sgl;
@@ -3002,6 +3055,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.get_address		= nvme_tcp_get_address,
 	.stop_ctrl		= nvme_tcp_stop_ctrl,
 	.get_virt_boundary	= nvmf_get_virt_boundary,
+	.print_io_queue_info	= nvme_tcp_print_io_queue_info,
 };
 
 static bool
-- 
2.53.0


