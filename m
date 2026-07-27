Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48AAFC531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 15:17:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2Q1W1L6YOHCAsJpGEz/+PtUNR5hYgPocfjM3AQzUa6g=; b=QX0FxELClZrZCPwU6nL8mhfFhI
	BAEE0jnZ1rCuwOzYzz9Yzh9lQTf1SM2lBkydYpLuvxx13FbBrqUQz2FAYZxwaqsuBhJ+DVaSmNeUc
	9cJsUg4IISqnzfxxUcj0PYxrmZ4pyZGS37e5gn7qJY6la5oxgYCi6bwHixb+Ix81ZODpG2/PF1aDE
	ZfXEVnjCvFoBvMgPJewBrOegWgY23iTIa+/fbIh7dAbajKHZTTZovQ1L6n19kHra9cpExOLLL0/Ee
	fMuKjgp/ZQBwoP3/0SJK9nRf2Z7anI1Qy/Fs6+TNTswF+sHkddOx4HPWbSBXfN/jyT0eF8sMcvoed
	+52q6C8g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN5V-0000000390m-3pnk;
	Mon, 27 Jul 2026 15:17:53 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN5T-000000038zX-1GPS
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 15:17:52 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnbZu2412218;
	Mon, 27 Jul 2026 15:17:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2Q1W1L6YOHCAsJpGE
	z/+PtUNR5hYgPocfjM3AQzUa6g=; b=asTRsl5piESZW+BwUkCPkiZC1yTb69AgN
	aAKTBF429lnN3kMrrIXyRXzPEMSd/4j2pWj5QkD3keoJhL4dpFTuwNlRCb5iy3k/
	YQ2DwCHx7HrbTJylqf+P+f3G/w/gXVVwiohFcEPqdU/cfOi9GoTGpM9jN0FXlUb3
	XMjtf/iEyKTTWcjbwQsQqV/sWc5K8q7TopPV6geZKjBt3FXOTkKae/bGyXIViAHL
	EQWTEY9dvXQl98GuKsBcU6Qo8JEZmXyPlyEDyiAo4FUbo2AayUp2dB2oUM4e/SlP
	c4t4D76E+CRbe2ZsZTBTuCHCqQ0zGqNSm8pd9cE5Bw//NWgnl3aNA==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuwcr9mx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:17:46 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFBTE6024441;
	Mon, 27 Jul 2026 15:17:45 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fn8yh5tdd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:17:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RFHfFt6619456
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:17:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 63CF2200E1;
	Mon, 27 Jul 2026 15:17:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3927C20085;
	Mon, 27 Jul 2026 15:17:39 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.97.190])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:17:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 4/4] nvme: expose queue information via debugfs
Date: Mon, 27 Jul 2026 20:46:47 +0530
Message-ID: <20260727151652.3660476-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727151652.3660476-1-nilay@linux.ibm.com>
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: 3v9530aby2rA_Acb_w24jPX1woywxrWJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX9DxWHLIthx1y
 H4glLZwQWgixFR3vNSZqyXhc2KAR/RO6h0tMq4F8ofSAMz12jixsMPdCB4ziwwk+22GSlgg0qIS
 rIXdFqySNld/AKARuemi18MKYryDJlo=
X-Authority-Analysis: v=2.4 cv=E/z9Y6dl c=1 sm=1 tr=0 ts=6a67769a cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=LWIoN9EnsF6OxIflJ4MA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX2S5KqFn9xY3s
 X4ySaSe/lvgE9/c0NQtWVJddoCZglhWLGmkVr3/j62R89lbCeQGYA++D7iti4VxyswPd/E/VQsR
 gRK3g7clMmQLh+10OqOqHqYRkstg44cT5MOJh5DmXHTg2gMT5Pd6+eskwkc/wNbpgoglSkYFA56
 PL02jpp3gdIMTWvbys2+tZwPnW/wt9zNJmrlRhsT7isZeKzCdrNVX2ZLl7git/iw86PeRSDGVrh
 Y7Kvn3Qv7AU8ArJWXvGFlgtuNN0LxHjMrSwC7poHjNH90mNrFnjWGefpVjQXMcUXSb1GZFel6j4
 gNCdw39/iuW+hBoXqwj+irVd2yAnw7/7wFrpyu3HDcJSYkc/0GoecjIipzAs3fdM9hJ07NtcjcA
 OXlkzCL++ltrfDq/YquPxHhzdtP8MPCkBpB/ycpx4mns145yRKmUktY5wAuiwDrtnErNhXVTFAl
 58cP5j7vLlC3ITtwMwQ==
X-Proofpoint-GUID: 3v9530aby2rA_Acb_w24jPX1woywxrWJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 priorityscore=1501 spamscore=0 clxscore=1015 phishscore=0
 lowpriorityscore=0 bulkscore=0 malwarescore=0 impostorscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607270144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_081751_457223_665DBC45 
X-CRM114-Status: GOOD (  22.54  )
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


