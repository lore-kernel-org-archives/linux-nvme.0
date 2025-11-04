Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE0CACCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dvpLjOA+iA1Oe1owL0KbF86ewopuGYT1CazuHhRnFi0=; b=mgqutrbsqf7wPogFUyNZHcKSft
	3f2yPbuQr5/YGmHju/41QOGaoXJk7ZY9JDke1/vc6ytrvrWFSzolf0gYeTSmqaVim/RCXbjv6JATM
	Zfs9yfV/0I7ZPJHoxaaD/A5iGuI0zKbMK0ZJTCUe53bHfVeByAXAOcmEK/HpWgREi3cxBEBjEV3Pf
	4N403E3QobkUIEqlMHbO2TJbd4DAtJ15+HW8eWPXqJDPd8KiVLJw3/Q1EW+do8DqOMEmJiNa5ZXbR
	zycmMflFhNUrZjwCNzQCtdStyxABqIsMStVg7yp4O4LMI7lDlnl8N8/jnJy494aq09Uf8v3Xj4TJj
	xajWwlLg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEY5-0000000Bdyl-1P2K;
	Tue, 04 Nov 2025 10:46:01 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEY2-0000000BduO-0TCJ
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:45:59 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A45vSI7002663;
	Tue, 4 Nov 2025 10:45:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dvpLjOA+iA1Oe1owL
	0KbF86ewopuGYT1CazuHhRnFi0=; b=N5cMrUmVipv//bpkd5nVBDoL5/hyjccck
	MLwc6RppmcCpQwKXE+QXP4qVB7Pn0xlaJVW2Q65YQgKA6DImDuAU92wlOfFMihum
	r9p+XRKfCMfeiXiKAMc63JTMyzIxYjBXLQFwQ0egzspVX18p6+BEQxvRvkAQZaG5
	BTrOaRu5W4W25c+rIU2OoDP8M3ICv+Sy8Hrsq2Fv2UgtcKBP8s7gI514gOBhGkWe
	XQmKg58UFy5tSAGkW7gAJ3rJPoN92jF302q8aVj/P5QoBLpwBCXE7HqLHi0WDxxk
	nkesNkJlotkeioknwoI5jtEQYs169BQeRec39fMB1Iu/gGIJ9fx9w==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a57mr3hre-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:54 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4AM4Z1027371;
	Tue, 4 Nov 2025 10:45:53 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwyaq18-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:53 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A4Ajo2s53608908
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 10:45:51 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CD41A20040;
	Tue,  4 Nov 2025 10:45:50 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 00C8820043;
	Tue,  4 Nov 2025 10:45:49 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 10:45:48 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv4 6/6] nvme-multipath: add debugfs attribute adaptive_stat
Date: Tue,  4 Nov 2025 16:15:21 +0530
Message-ID: <20251104104533.138481-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104104533.138481-1-nilay@linux.ibm.com>
References: <20251104104533.138481-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: TcmjDPy3kpGRRX0Ghx9hWtE0laz6Dj97
X-Authority-Analysis: v=2.4 cv=MKhtWcZl c=1 sm=1 tr=0 ts=6909d962 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GMZBDc3o4BUkPsUqmQYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: TcmjDPy3kpGRRX0Ghx9hWtE0laz6Dj97
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAwMSBTYWx0ZWRfX1AYdE0/cIKms
 MMVSdnLapgU4cszSNMcKICqFm0o/BUgBstKrygaj6/j387iGEZAelw820GaNgxPAH/9PVtv0gR0
 VuJ7Be/GmRHHOlXyHDvXhVgyAx9pArjV46pJRvEIA4FPZNipWLqg3+CX0gkZptkY41aTP63bHmO
 33tqR8brbjXSuD1rsgDU1UhcVji5hAf8WFMv5jLVz8GL1b3+6vUdjVibxHW4qmklXrDUOHiyrV9
 nwbazHZGdVd+NQbYj+12DOG1ekyj7ieERY/cs4HgKyWHr972xVsOhBZVrUZI4eNvCbqBLUDLotj
 hX2CY6S0pKVoR7B0oPAbs4WfFSRteKg1bB28bENDw+S8T08pRQobbfj6pfj74BMUb26ap0wUf4s
 Lez7avNfZ3fS29Nimwye/tIuUhPorg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 suspectscore=0 bulkscore=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 malwarescore=0 adultscore=0 phishscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010001
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_024558_270380_2BBE2D54 
X-CRM114-Status: GOOD (  18.05  )
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

This commit introduces a new debugfs attribute, "adaptive_stat", under
both per-path and head debugfs directories (defined under /sys/kernel/
debug/block/). This attribute provides visibility into the internal
state of the adaptive I/O policy to aid in debugging and performance
analysis.

For per-path entries, "adaptive_stat" reports the corresponding path
statistics such as I/O weight, selection count, processed samples, and
ignored samples.

For head entries, it reports per-CPU statistics for each reachable path,
including I/O weight, path score, smoothed (EWMA) latency, selection
count, processed samples, and ignored samples.

These additions enhance observability of the adaptive I/O path selection
behavior and help diagnose imbalance or instability in multipath
performance.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/debugfs.c | 113 ++++++++++++++++++++++++++++++++++++
 1 file changed, 113 insertions(+)

diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index e382fa411b13..28de4a8e2333 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -182,6 +182,115 @@ static ssize_t nvme_adp_weight_timeout_store(void *data,
 	WRITE_ONCE(head->adp_weight_timeout, res * NSEC_PER_SEC);
 	return count;
 }
+
+static void *nvme_mpath_adp_stat_start(struct seq_file *m, loff_t *pos)
+{
+	struct nvme_ns *ns;
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns_head *head = ctx->data;
+
+	/* Remember srcu index, so we can unlock later. */
+	ctx->srcu_idx = srcu_read_lock(&head->srcu);
+	ns = list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
+
+	while (*pos && ns) {
+		ns = list_next_or_null_rcu(&head->list, &ns->siblings,
+				struct nvme_ns, siblings);
+		(*pos)--;
+	}
+
+	return ns;
+}
+
+static void *nvme_mpath_adp_stat_next(struct seq_file *m, void *v, loff_t *pos)
+{
+	struct nvme_ns *ns = v;
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns_head *head = ctx->data;
+
+	(*pos)++;
+
+	return list_next_or_null_rcu(&head->list, &ns->siblings,
+			struct nvme_ns, siblings);
+}
+
+static void nvme_mpath_adp_stat_stop(struct seq_file *m, void *v)
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns_head *head = ctx->data;
+	int srcu_idx = ctx->srcu_idx;
+
+	srcu_read_unlock(&head->srcu, srcu_idx);
+}
+
+static int nvme_mpath_adp_stat_show(struct seq_file *m, void *v)
+{
+	int i, cpu;
+	struct nvme_path_stat *stat;
+	struct nvme_ns *ns = v;
+
+	seq_printf(m, "%s:\n", ns->disk->disk_name);
+	for_each_online_cpu(cpu) {
+		seq_printf(m, "cpu %d : ", cpu);
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			stat = &per_cpu_ptr(ns->info, cpu)[i].stat;
+			seq_printf(m, "%u %u %llu %llu %llu %llu %llu ",
+				stat->weight, stat->credit, stat->score,
+				stat->slat_ns, stat->sel,
+				stat->nr_samples, stat->nr_ignored);
+		}
+		seq_putc(m, '\n');
+	}
+	return 0;
+}
+
+static const struct seq_operations nvme_mpath_adp_stat_seq_ops = {
+	.start = nvme_mpath_adp_stat_start,
+	.next  = nvme_mpath_adp_stat_next,
+	.stop  = nvme_mpath_adp_stat_stop,
+	.show  = nvme_mpath_adp_stat_show
+};
+
+static void adp_stat_read_all(struct nvme_ns *ns, struct nvme_path_stat *batch)
+{
+	int i, cpu;
+	u32 ncpu[NVME_NUM_STAT_GROUPS] = {0};
+	struct nvme_path_stat *stat;
+
+	for_each_online_cpu(cpu) {
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			stat = &per_cpu_ptr(ns->info, cpu)[i].stat;
+			batch[i].sel += stat->sel;
+			batch[i].nr_samples += stat->nr_samples;
+			batch[i].nr_ignored += stat->nr_ignored;
+			batch[i].weight += stat->weight;
+			if (stat->weight)
+				ncpu[i]++;
+		}
+	}
+
+	for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+		if (!ncpu[i])
+			continue;
+		batch[i].weight = DIV_U64_ROUND_CLOSEST(batch[i].weight,
+				ncpu[i]);
+	}
+}
+
+static int nvme_ns_adp_stat_show(void *data, struct seq_file *m)
+{
+	int i;
+	struct nvme_path_stat stat[NVME_NUM_STAT_GROUPS] = {0};
+	struct nvme_ns *ns = (struct nvme_ns *)data;
+
+	adp_stat_read_all(ns, stat);
+	for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+		seq_printf(m, "%u %llu %llu %llu ",
+			stat[i].weight, stat[i].sel,
+			stat[i].nr_samples, stat[i].nr_ignored);
+	}
+	return 0;
+}
 #endif
 
 static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
@@ -190,11 +299,15 @@ static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
 			nvme_adp_ewma_shift_store},
 	{"adaptive_weight_timeout", 0600, nvme_adp_weight_timeout_show,
 			nvme_adp_weight_timeout_store},
+	{"adaptive_stat", 0400, .seq_ops = &nvme_mpath_adp_stat_seq_ops},
 #endif
 	{},
 };
 
 static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
+#ifdef CONFIG_NVME_MULTIPATH
+	{"adaptive_stat", 0400, nvme_ns_adp_stat_show},
+#endif
 	{},
 };
 
-- 
2.51.0


