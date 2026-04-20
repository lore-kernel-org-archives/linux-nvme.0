Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71659F36C5E
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Apr 2026 11:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=gFcc+00KGPxkZ5T1k2AxPuqRjNKaQSNX3wG0LE/xYFw=; b=2RaxEqMibzC9zLYYgmHsESTSAd
	i11NmoHMmbVX5qQOTAR6IrOKRsQNscBDbt/kP8YYmXExMnKoM6KPVYmPFBE0pepzyULYVyULW35+w
	kLYlzHk7bnHzIGv9MfWflDnS1bLM6ezr5cq0z4iKn5h8dnGC9tpEc/3DnzhoIiqdNgmJBKjhW+YqV
	lrKhOfXCl3SCC095V9+C+xP8d6lziJnHrTX4ZKaPchO+9CKC86WKS/TYuZ3GNmPcib4b6asQ07sGh
	VSnnqoL05JTmnQhi77sRhJdjMR3cusaXpSGF+Bib2sw+Jexwpp0pCr/jcXs5qDLYToyhZ6gO03iJ0
	KFNLnPyQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnG6-00000006pTh-1gLN;
	Mon, 20 Apr 2026 11:57:46 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wEnG3-00000006pRp-0B3L
	for linux-nvme@lists.infradead.org;
	Mon, 20 Apr 2026 11:57:44 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 63JJueab3646691;
	Mon, 20 Apr 2026 11:57:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=gFcc+00KGPxkZ5T1k
	2AxPuqRjNKaQSNX3wG0LE/xYFw=; b=gnNAoR5OkLDmNaLJrlBqo981iePP54gY6
	ZItS7fszszCoOcv1GLnBFKmMJp+ABeXyRijGiHpGTXn5ttwpWiahOp+Wg5ECQPC4
	Mn7JN08umNfun27znpWaGCVCnKORO4K6HCIoWzt0hTfTL6ZUOKc6CIOuBEp/Hjc6
	iMmokm07UGFJuT0XWZFjcH5Bv9H7Y5Owp3rRotk36+gQmWkMLgObq9C4mvC8iRfI
	fPme++tGV2tW5FQm7O9GrDWwxrJBZMQAPAsTpfQVvAcXK1v51m3boqK2gE52bucf
	TXEXDNtS0VAxmKlfkiVOj7cuoU9YJOWq/1wfqSyUBLNDtH6Hg3YJA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4dm2k0pwtq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:38 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 63KBoJGZ028637;
	Mon, 20 Apr 2026 11:57:38 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4dmnsgvhky-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 Apr 2026 11:57:38 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 63KBvYvg37093712
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 20 Apr 2026 11:57:34 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 32A522004B;
	Mon, 20 Apr 2026 11:57:34 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5810A20040;
	Mon, 20 Apr 2026 11:57:32 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 20 Apr 2026 11:57:32 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RFC PATCH 4/4] nvme: expose queue information via debugfs
Date: Mon, 20 Apr 2026 17:19:36 +0530
Message-ID: <20260420115716.3071293-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260420115716.3071293-1-nilay@linux.ibm.com>
References: <20260420115716.3071293-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 71E4MpuQ7vmC1KWLP3WscHODREI3M4jE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNDIwMDExNSBTYWx0ZWRfX13UNK1DWHN3I
 JKQT9Dc1C505GEmusnFhU7nE5k2uU8zuTHUtTwfgDXFLfYXr5ucn2+sYx6KbeVjO7ZNZnghmemh
 A4FUI0FRWsLtwxaxmWplYgsXosS7onFchNLtDAqR8eQ8ix6W+zLf1rLzwd+NM5Em4+nsjCNLrwD
 2dnO2LIPT5vndxPWfzOSXKgczVbAxZrHN2BP2pFDaTtsY54LqgCkhoT9f9PJc0qWZjsRptNOJYS
 dNjvlf49JTtq9nJT3jsG600HRvuN/66uU2QBspuwTmcoL6qDlNbXxbz4CERWYoLYIhK1+wkXXSz
 X5sOY1QHxUgwbtHH+1C9dOVk/vleBUf3bbwrU5GHpUSyy/jufqtwJByPJIVrx6LClcpCc0JdEPL
 aRHayFLSI08D67tbowxozXd/z8aqHvPCOe7hPkOH4nzYRT0oCbC5eMCsQ6EpHEIJTdfjqfX3HGL
 X2BtSK+yuqn97w5UQbw==
X-Authority-Analysis: v=2.4 cv=PtujqQM3 c=1 sm=1 tr=0 ts=69e614b2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=A5OVakUREuEA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LWIoN9EnsF6OxIflJ4MA:9
X-Proofpoint-GUID: 71E4MpuQ7vmC1KWLP3WscHODREI3M4jE
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-04-20_02,2026-04-17_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 suspectscore=0 clxscore=1015 spamscore=0 impostorscore=0
 priorityscore=1501 bulkscore=0 adultscore=0 lowpriorityscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2604070000 definitions=main-2604200115
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260420_045743_303727_F367E4A8 
X-CRM114-Status: GOOD (  21.16  )
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
 drivers/nvme/host/core.c    |  3 +++
 drivers/nvme/host/debugfs.c | 53 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h    |  2 ++
 drivers/nvme/host/tcp.c     | 52 ++++++++++++++++++++++++++++++++++++
 4 files changed, 109 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 1e33af94c24b..1b0d13374d45 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4207,6 +4207,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
+	nvme_debugfs_register(ns->disk);
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -4285,6 +4287,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_mpath_remove_sysfs_link(ns);
 
+	nvme_debugfs_unregister(ns->disk);
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index ee86138487d0..68c40582fa97 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -22,6 +22,56 @@ struct nvme_debugfs_ctx {
 	struct nvme_debugfs_attr *attr;
 };
 
+static void *nvme_io_queue_info_start(struct seq_file *m, loff_t *pos)
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns *ns = ctx->data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	nvme_get_ctrl(ctrl);
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
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns *ns = ctx->data;
+	struct nvme_ctrl *ctrl = ns->ctrl;
+
+	nvme_put_ctrl(ctrl);
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
 static int nvme_debugfs_show(struct seq_file *m, void *v)
 {
 	struct nvme_debugfs_ctx *ctx = m->private;
@@ -90,7 +140,8 @@ static const struct file_operations nvme_debugfs_fops = {
 };
 
 static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
-	{},
+	{"io_queue_info", 0400, .seq_ops = &nvme_io_queue_info_seq_ops},
+	{}
 };
 
 static void nvme_debugfs_create_files(struct request_queue *q,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 2f3f1d2d19b9..d7ff82971136 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -650,6 +650,8 @@ struct nvme_ctrl_ops {
 	void (*print_device_info)(struct nvme_ctrl *ctrl);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
 	unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool is_admin);
+	int (*print_io_queue_info)(struct seq_file *m, struct nvme_ctrl *ctrl,
+			int qid);
 };
 
 /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9239495122fc..6d06e984de47 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2723,6 +2723,57 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
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
+	if (!qid || qid >= ctrl->queue_count  ||
+			!test_bit(NVME_TCP_Q_LIVE, &queue->flags))
+		return -EINVAL;
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
@@ -3023,6 +3074,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.get_address		= nvme_tcp_get_address,
 	.stop_ctrl		= nvme_tcp_stop_ctrl,
 	.get_virt_boundary	= nvmf_get_virt_boundary,
+	.print_io_queue_info	= nvme_tcp_print_io_queue_info,
 };
 
 static bool
-- 
2.53.0


