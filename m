Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6A1C55167
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Jul 2026 07:40:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Q1W1L6YOHCAsJpGEz/+PtUNR5hYgPocfjM3AQzUa6g=; b=RUx2WMtuZXEDku3uZ5b2z7Zfke
	3SILjfCoy5+sKYs8kIehU8wTN0Lsg/byzpNXU4Mldz3y3Rjm4kZoqihQuicvFMaXNpP4P57HAYLCI
	bVntuPVwOgTxjC9j+IdN1QGM/3jyz5luy8pW6pIA60kZPwHxwi2TF70v+OrPST1rwXR/XvcWdVVZ+
	1kXSZJ2kc3wcYP2gd9cqwNebP98VJo13ByqBiOLyOpWtnta6600MehpG0Uf1+pxM6H0QeNJPTE6mO
	2dQo5XufYK7ikJh8XfbH4ZisdA1kHZ7uTPsCy9m3SP9OdlqSq/8Nhm9a9J/25dnvl9rNPmNdH3cTJ
	RJ8XOBIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wphqk-0000000BykU-2pUz;
	Fri, 31 Jul 2026 07:40:10 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wphqg-0000000ByiO-33Nu
	for linux-nvme@lists.infradead.org;
	Fri, 31 Jul 2026 07:40:09 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66V5Iia2855565;
	Fri, 31 Jul 2026 07:40:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2Q1W1L6YOHCAsJpGE
	z/+PtUNR5hYgPocfjM3AQzUa6g=; b=Rzay8pSZ/8fUL+7ch0Hkf3LddqpfbVCIj
	bGUMqX6yzf/tuFFGYp8R8RzS7hLQ1rk+xWjYmOCstLPWMJKWT+SAe8NqCAwu363y
	t3sIfEIfa4Lc/5jnYZhTxeDTSDxhsc1IUzJ3PyvU6nPU8uKSDNQclqi32z8xq0ng
	mSjz79h6+a9GvN0KtUsYhIvi6VsBHUAQU1cfDu2T5Z3z9rbZExfuJO6IVmimrXOZ
	P5DTxkMNuGzIP88epRuw2o5apcVhJNBHX1BFFZmi79aP8yTi/vDzsrQ2YR1ya4i7
	3ixcuwYd7tLnZcgccqca65fsr8FRE+qOqcAvIQ8LJB6hh09YX7KEA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmv0p2vuh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:40:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66V7QJMi021514;
	Fri, 31 Jul 2026 07:40:00 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8fkf0jy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 31 Jul 2026 07:40:00 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66V7duK630998992
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 31 Jul 2026 07:39:56 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2173820043;
	Fri, 31 Jul 2026 07:39:56 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BF3D720040;
	Fri, 31 Jul 2026 07:39:52 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.125.83])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 31 Jul 2026 07:39:52 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com, kuba@kernel.org,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        horms@kernel.org
Cc: linux-nvme@lists.infradead.org, netdev@vger.kernel.org,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [RESEND PATCH v2 4/4] nvme: expose queue information via debugfs
Date: Fri, 31 Jul 2026 13:09:08 +0530
Message-ID: <20260731073918.614014-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731073918.614014-1-nilay@linux.ibm.com>
References: <20260731073918.614014-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX4HtJuoicjy9z
 JIA73GdJUVQoxgIVoZRUZmbH/CxWozPIXmDGQvmD/+T8CrO1wttF4KhPIDu5K+dW4b6VukiPq/9
 bSnpUndDosw8ftGo5W/0mKdid+oEzYU=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzMxMDA1MCBTYWx0ZWRfX/pq+t8B4/hKH
 7I/DJTvuS4ayvVSY9kz4sHM/mcYmIvqJYi1CN7zvCe3ZNwbZRes6w2CgV4WTAs/Kk9rYNjQpamL
 q0hiHzz6y6vlkXWJ3Hp/MEAB8wRR0q+rH2EtHLm+BEo1VoojTLaSXHfS87+3S+LnvQpNUX13g0n
 wrgo2lWvPDaWpFv6gZ7TnD/XNfPyIEVqOGXo5cgyOkkKD094Owrhqdc68QNSi99OqDNw9CchsFX
 rObXp5rO5fpGN43jiBBvrKlmLuvtiX9CE1hRjjF876bFsa3Zs71Gi+tA6vLSTa2QmMLy51e+oMQ
 4vbun+48/fcWbWn+RtvgcWZp5/qL9h5pat2HLvEKlBbdO3h9Qn2cYUhVDADaiLEG0KSf9TFRm50
 gpGno7CaQThMh4lv+ACrd1TBE5PV3nWFIftcfJLykyo+ecJwfYsU1skyqgTpFLTrtc5/vkZ98qE
 U9i2ij/k7W7SeInMPIA==
X-Authority-Analysis: v=2.4 cv=b5WCJNGx c=1 sm=1 tr=0 ts=6a6c5151 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=LWIoN9EnsF6OxIflJ4MA:9
X-Proofpoint-GUID: hwzmbAy2EvZUu42IE_X8TbrFfzqeqMYY
X-Proofpoint-ORIG-GUID: R2CT-wKH-A9tUPm6yhLoGQSJ4yQW8pjC
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-31_02,2026-07-30_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 spamscore=0 adultscore=0 malwarescore=0 impostorscore=0
 bulkscore=0 phishscore=0 suspectscore=0 clxscore=1015 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607310050
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260731_004008_272269_94761449 
X-CRM114-Status: GOOD (  22.64  )
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
 drivers/nvme/host/core.c    |  3 ++
 drivers/nvme/host/debugfs.c | 64 ++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h    |  2 ++
 drivers/nvme/host/tcp.c     | 54 +++++++++++++++++++++++++++++++
 4 files changed, 122 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..50e81892a9d6 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4264,6 +4264,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
+	nvme_debugfs_register(ns->disk);
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -4344,6 +4346,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_mpath_remove_sysfs_link(ns);
 
+	nvme_debugfs_unregister(ns->disk);
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index b4802ea3bd48..6146f33bc586 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -24,6 +24,61 @@ struct nvme_debugfs_ctx {
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
@@ -108,7 +163,14 @@ static const struct file_operations nvme_debugfs_fops = {
 };
 
 static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
-	{},
+	{
+		.name    = "io_queue_info",
+		.mode    = 0400,
+		.seq_ops = &nvme_io_queue_info_seq_ops,
+		.get     = nvme_debugfs_get_ns,
+		.put     = nvme_debugfs_put_ns
+	},
+	{}
 };
 
 static void nvme_debugfs_create_files(struct request_queue *q,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 72f9d9c668a1..430971c56406 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -663,6 +663,8 @@ struct nvme_ctrl_ops {
 	void (*print_device_info)(struct nvme_ctrl *ctrl);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
 	unsigned long (*get_virt_boundary)(struct nvme_ctrl *ctrl, bool is_admin);
+	int (*print_io_queue_info)(struct seq_file *m, struct nvme_ctrl *ctrl,
+			int qid);
 };
 
 /*
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a2110287099e..e98f025ce99f 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2651,6 +2651,59 @@ static void nvme_tcp_free_ctrl(struct nvme_ctrl *nctrl)
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
@@ -2951,6 +3004,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.get_address		= nvme_tcp_get_address,
 	.stop_ctrl		= nvme_tcp_stop_ctrl,
 	.get_virt_boundary	= nvmf_get_virt_boundary,
+	.print_io_queue_info	= nvme_tcp_print_io_queue_info,
 };
 
 static bool
-- 
2.53.0


