Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED632C531D0
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jul 2026 15:17:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lo0BQW/8zomkj5t1CI4rW+j4xR1OWoWhqjwG7/D3+DA=; b=YsX9bypE2Q4CVWoqLKPCZ9xUSV
	uhsEPSkpxUzpBQnwxjNcPpnYflVInNU+1Lw0587YALXuxV96TH1s/o2Fnhltoit8tcsCA+BCkhE+/
	x6WH26izdWegWrDgviJJhp/z2jmhzBgITWGa9MksVCLChUwb5cnkBuwG1Vq+9qIZGV1dJkPDV/q87
	CA4oiNtDAnPSd1JNmhRySENXqaar9+zofnokZweip1IKn6EGOmKXmKcrYe5ljPco1FJb6sisSdiP8
	i+HPLv/vu2rNaQrjdNH3V03vWwx3pV7ordViZZ43SMR48eNKaIntErj/UaiAYtIUoOUWaQy7/zXJt
	NL6T15WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN5L-000000038vg-2WfD;
	Mon, 27 Jul 2026 15:17:43 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1woN5J-000000038um-3Jf4
	for linux-nvme@lists.infradead.org;
	Mon, 27 Jul 2026 15:17:43 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66RDnnmW2299111;
	Mon, 27 Jul 2026 15:17:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=lo0BQW/8zomkj5t1C
	I4rW+j4xR1OWoWhqjwG7/D3+DA=; b=n2qLyVw0wfKl1WXoWTmJ1Zb7u2ldbtDhX
	6w3FQSnTQyIS164cOuSJKEP6yq/1PK93/gFI/yoSxiA9hh+rIItwsglCQY5qbdEV
	xj0uJr+k1ZvT7B1Zug4IYHJUiEFH6fxHqkVRLgRvFvCviZlcfBRaYbo3UR9A3zAt
	kro/jJb6RwyqnnlQ64vmI23PDWcavVjYbXE0Aq1llbZYBkH9mRh7fhND8Vl7k3pd
	zVtx2faM3E8eeBMAgnXCevQvqj74dT9JX/9/TLXt19GE9cU9gmTc+zndIoH3KEDH
	IwCtiy9wVCwbcI/ynUFQtAHzsOVK5DiyiWwRXhTKnl51nCZnDCpBQ==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fmuyj094p-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:17:36 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66RFBGQ5028392;
	Mon, 27 Jul 2026 15:17:35 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fn7fq61vm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Jul 2026 15:17:35 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66RFHWqS46989808
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Jul 2026 15:17:32 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 16E48200E0;
	Mon, 27 Jul 2026 15:17:32 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B289E20085;
	Mon, 27 Jul 2026 15:17:29 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.97.190])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Jul 2026 15:17:29 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: kbusch@kernel.org, hch@lst.de, hare@suse.de, sagi@grimberg.me,
        chaitanyak@nvidia.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v2 2/4] nvme-tcp: limit I/O queue count based on NIC queue count
Date: Mon, 27 Jul 2026 20:46:45 +0530
Message-ID: <20260727151652.3660476-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727151652.3660476-1-nilay@linux.ibm.com>
References: <20260727151652.3660476-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX28Ag3s7PvwUh
 ticIByCxGg/Ql76/JhuE5Y2oXf4TJhvifRxn1opZORyqaouxl5MGC1sRoPJeXL1e82E1TPAK2uF
 AMefX26Vg1niOzzlHbD7SXZ6fdXwZWI=
X-Proofpoint-GUID: zJEdlZ7wOyaC6p5xDOqlrebjc--JsSP7
X-Proofpoint-ORIG-GUID: zJEdlZ7wOyaC6p5xDOqlrebjc--JsSP7
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI3MDE0NCBTYWx0ZWRfX4tzbZeF6cYye
 AqzanPgMWfG6hQaYzGBPfuiKSHxweIYyZGcgskE87K7suL5TLcrU8DrF9krWWK2ZQnmGJMg30xD
 haHBiCfWAaukQzbHnsZ3T/pwcl3AEsVj2fRDt46awsVbQBySkR4A/TdCUZhmitZYBTwYw9yQkBb
 7vZLqLCghLQC6jI/cSu9/yK+Ngq0IBJHqJseqfPy/W20dd61Jpg9QInMMHWPNiWzPFFS1i9jLzF
 ZPZJqrTaIj9gVqucEdGQ4+c0k0NeQXr/UK/5GwSkpSsxqFGZyl5G8TJtgG0T3UzY4bl8nLdyaxp
 5WeNmbXirDF6n9e/akIEuJZk35ZkIRAASyZiIuJ3DOA+atyHj3a44FF7aN/VaU3e54Y/Z341Q5A
 Ehdl3sz0vFK4B6RKqaLVAHfdkCP5VLBADWwJsQcbsSolDx/lmrqqYkeZxeHw3SjBPsGq2hS6hzD
 fuufiaOFDU2hcE3hoAw==
X-Authority-Analysis: v=2.4 cv=X5Vi7mTe c=1 sm=1 tr=0 ts=6a677690 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=MwK5uCCrhwR5b2NhIngA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-27_04,2026-07-24_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 impostorscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 malwarescore=0 spamscore=0 suspectscore=0 bulkscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2607270144
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260727_081741_951217_CE1A34BE 
X-CRM114-Status: GOOD (  17.56  )
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

NVMe-TCP currently provisions I/O queues based primarily on the number
of online CPUs. On systems where the CPU count significantly exceeds the
number of NIC hardware queues, multiple NVMe-TCP I/O queues end up
sharing the same NIC TX/RX queues. This increases lock contention,
cacheline bouncing, and inter-processor interrupts (IPIs), reducing I/O
efficiency.

Limit the number of NVMe-TCP default I/O queues to the smaller of the
number of online CPUs and the number of NIC hardware queues. Aligning
the number of NVMe-TCP I/O queues with the NIC queue topology reduces
queue sharing, improves locality, and can improve throughput while
reducing tail latency.

The number of NVMe-TCP I/O queues is now limited to:

    min(num_online_cpus, num_nic_queues)

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/tcp.c | 61 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index ba5c7b3e2a7c..a2110287099e 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -1774,6 +1774,50 @@ static int nvme_tcp_start_tls(struct nvme_ctrl *nctrl,
 	return ret;
 }
 
+static struct net_device *nvme_tcp_get_netdev(struct nvme_ctrl *ctrl,
+		netdevice_tracker *tracker, gfp_t gfp)
+{
+	struct net_device *dev = NULL;
+
+	if (ctrl->opts->mask & NVMF_OPT_HOST_IFACE)
+		dev = netdev_get_by_name(&init_net, ctrl->opts->host_iface,
+				tracker, gfp);
+	else {
+		struct nvme_tcp_ctrl *tctrl = to_tcp_ctrl(ctrl);
+		struct sockaddr_storage *src = NULL, *dest = NULL;
+
+		if (ctrl->opts->mask & NVMF_OPT_HOST_TRADDR)
+			src = &tctrl->src_addr;
+
+		dest = &tctrl->addr;
+
+		dev = netdev_get_by_addr(&init_net, src, dest, tracker, gfp);
+	}
+	return dev;
+}
+
+/*
+ * Returns number of active NIC queues (min of TX/RX), or 0 if device cannot
+ * be determined.
+ */
+static int nvme_tcp_get_netdev_current_queue_count(struct nvme_ctrl *ctrl)
+{
+	struct net_device *dev;
+	int tx_queues, rx_queues;
+	netdevice_tracker tracker;
+
+	dev = nvme_tcp_get_netdev(ctrl, &tracker, GFP_KERNEL);
+	if (!dev)
+		return 0;
+
+	tx_queues = dev->real_num_tx_queues;
+	rx_queues = dev->real_num_rx_queues;
+
+	netdev_put(dev, &tracker);
+
+	return min(tx_queues, rx_queues);
+}
+
 static int nvme_tcp_alloc_queue(struct nvme_ctrl *nctrl, int qid,
 				key_serial_t pskid)
 {
@@ -2165,6 +2209,23 @@ static int nvme_tcp_alloc_io_queues(struct nvme_ctrl *ctrl)
 	unsigned int nr_io_queues;
 	int ret;
 
+	if (!(ctrl->opts->mask & NVMF_OPT_NR_IO_QUEUES)) {
+		int nr_hw_queues;
+
+		nr_hw_queues = nvme_tcp_get_netdev_current_queue_count(ctrl);
+		if (nr_hw_queues <= 0)
+			goto init_queue;
+
+		ctrl->opts->nr_io_queues = min(nr_hw_queues, num_online_cpus());
+
+		if (ctrl->opts->nr_io_queues < num_online_cpus())
+			dev_info(ctrl->device,
+				"limiting I/O queues to %u (NIC queues %d, CPUs %u)\n",
+				ctrl->opts->nr_io_queues, nr_hw_queues,
+				num_online_cpus());
+	}
+
+init_queue:
 	nr_io_queues = nvmf_nr_io_queues(ctrl->opts);
 	ret = nvme_set_queue_count(ctrl, &nr_io_queues);
 	if (ret)
-- 
2.53.0


