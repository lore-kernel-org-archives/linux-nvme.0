Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AFC1C5CFDB
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:36:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=v3tXdQKXimk2oBlK8QjWF1xEpd36Y6CFE+jEBRb6bcc=; b=gKhUv5FyomkNI6ldYoUHMWmamc
	a5aTCaIbmbCgY8Xsuol8BgZFvvitOhBD0uu6dcIBZNeEWgHgClMEroAsozouE3EL/lWyxc2PAyMiW
	8UCoAPExHQ6jG6R/hcQvKTuCMOC9Dzp4NkzwVvXOpLmm9CmOZ83mr9snhyuEjg7Qv05E6S7KB+bKn
	pe2UKzzKeXYzPl7eOvO3KuxeNKmavfnVDJaENlIMqVRkSqlrKm1I5bsO3hdE/lJ3VzXJUBXGFiVpP
	1A+UUEedAZ9RqQaL5eBnBtMvU74DxE5o4XfkM0BDJaAvVh7ClsCObrDCdFQrHTTerYpqNJurZEl+3
	qFLa1Eew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIJ4-0000000400w-3VC9;
	Sat, 15 Aug 2026 17:36:30 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIJ1-00000003zy7-0cAd
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:36:28 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGVoFm218713;
	Sat, 15 Aug 2026 17:36:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=v3tXdQKXimk2oBlK8
	QjWF1xEpd36Y6CFE+jEBRb6bcc=; b=jGDigpXZPIB5xWIVSq65YNdbmtpYNywPd
	4MvcAoVTrJCBB9Q3KBk0hEKU5+FBXxmOZtewKVh8KsRAVsLZ5NkcI99BJgYgQd/t
	g5RqyUTFbTNKXOfUh/BMxodDnoTLQGnNhGAuznyvgL8HRpHpXwrkfUhVz5W/sfhG
	eMrBdE2fUCEZM2rHsTvQSZEf2Cw3YGR55IUheg7X6+CLI5x3fw/HRuaFMk/Hhw3Y
	FXQUmhE+eYgAO+PPkQC81DywoG71+MZCt9h1oFY+zn1LI5bkZGGtCUXua02CdRnc
	or3HU5z7wul6ToiKRdyW10PnbfmSytZ8Fy2s3NJ8aeyp4A0RumN8g==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2dhkjgfv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:36:20 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQICE026220;
	Sat, 15 Aug 2026 17:36:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfskc11h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:36:19 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHaHpr40894836
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:36:17 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B458120040;
	Sat, 15 Aug 2026 17:36:17 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B113C20043;
	Sat, 15 Aug 2026 17:36:12 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:36:12 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 09/10] nvme-multipath: add debugfs attribute latency_stat
Date: Sat, 15 Aug 2026 23:04:31 +0530
Message-ID: <20260815173502.1185929-10-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX8L/ZIc/1Lx3p
 G+Rd7GyI5+P4hTy0WBJef5JfmsK4A63xNTV6id4G66UEpEBdBfLXwArrqLiWpSAIcj6TEJipG6u
 x6HYrk742euUawNly7eNdGfhQZncWQX7S+kVMwIiJrsTvw4U5QomkA/6YH8CcHFi9cNTDjNAg9F
 yQBI7pQbZjA4x1idE/ziRFqEgcc+qQmxYisxiW7eAkUT4Z4dIOMZX6Bj/UCHA1UCANW2mALPmnv
 bJ2aAafmijY33QlkM+Bur/2br60hvcAF4WkRK/hAyJ7SKx8buAt+hIsLO5puW65mtXUY5R3d9Dh
 K5/VihtYRLOzixpGeFHl9STbNhzYEllVx4p1B72CW9vVQZgTH0qpoj//kEU1XnNeypQbqMB/xMW
 XQxr2kQslGG9Pus4Sy8Xaf7P4k586EMB6YLBRr0KuArgN5oAes+ugdjvuUEMxzocwpL+l1SzJXq
 G6S9G2jZ7eBX7xPNuQA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX9jCeKKJbNQPz
 STaWdNr1xT3EzElclpfwFuO6/H+qQCBX8GZwQao8GzDr62Q/eYEN3d1nz07GyQ9HMlFPTH+8Gs2
 RW2l1aSryJsQu3XZb3gSzI3rDmn2zJY=
X-Authority-Analysis: v=2.4 cv=JKkLdcKb c=1 sm=1 tr=0 ts=6a80a395 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=6jSwP_Ep0sLyt9EEqmkA:9
X-Proofpoint-ORIG-GUID: N7ZrCGRdof_YL0KLP1mZbXwYrz8LcbLV
X-Proofpoint-GUID: mi7uKPt-r_rE55RWqYhQCdCsbLqcp_iJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 bulkscore=0 malwarescore=0 priorityscore=1501
 lowpriorityscore=0 clxscore=1015 adultscore=0 impostorscore=0 spamscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103627_325721_A9591753 
X-CRM114-Status: GOOD (  16.63  )
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

This commit introduces a new debugfs attribute, "latency_stat", under
both per-path and head debugfs directories (defined under /sys/kernel/
debug/block/). This attribute provides visibility into the internal
state of the latency I/O policy to aid in debugging and performance
analysis.

For per-path entries, "latency_stat" reports the corresponding path
statistics such as I/O weight, selection count, processed samples, and
ignored samples.

For head entries, it reports per-CPU statistics for each reachable path,
including I/O weight, path score, smoothed (EWMA) latency, selection
count, processed samples, and ignored samples.

These additions enhance observability of the I/O path selection behavior
and help diagnose imbalance or instability in multipath performance.

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/debugfs.c | 123 ++++++++++++++++++++++++++++++++++++
 1 file changed, 123 insertions(+)

diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index b8850d37edce..b3496951f0b1 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -184,6 +184,125 @@ static ssize_t nvme_latency_batch_timeout_store(void *data,
 	WRITE_ONCE(head->latency_batch_timeout, res * NSEC_PER_SEC);
 	return count;
 }
+
+#define TO_CTX(m)       ((struct nvme_debugfs_ctx *)m->private)
+#define TO_NS_HEAD(m)   ((struct nvme_ns_head *)(TO_CTX(m)->data))
+
+static void *nvme_mpath_latency_stat_start(struct seq_file *m, loff_t *pos)
+	__acquires_shared(&TO_NS_HEAD(m)->srcu)
+{
+	struct nvme_ns *ns;
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns_head *head = ctx->data;
+	loff_t n = *pos;
+
+	/* Remember srcu index, so we can unlock later. */
+	ctx->srcu_idx = srcu_read_lock(&head->srcu);
+	ns = list_first_or_null_rcu(&head->list, struct nvme_ns, siblings);
+
+	while (n && ns) {
+		ns = list_next_or_null_rcu(&head->list, &ns->siblings,
+				struct nvme_ns, siblings);
+		n--;
+	}
+
+	return ns;
+}
+
+static void *nvme_mpath_latency_stat_next(struct seq_file *m, void *v,
+		loff_t *pos)
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
+static void nvme_mpath_latency_stat_stop(struct seq_file *m, void *v)
+	__releases_shared(&TO_NS_HEAD(m)->srcu)
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns_head *head = ctx->data;
+
+	srcu_read_unlock(&head->srcu, ctx->srcu_idx);
+}
+
+static int nvme_mpath_latency_stat_show(struct seq_file *m, void *v)
+{
+	int i, cpu;
+	struct nvme_path_lat_stat *stat;
+	struct nvme_ns *ns = v;
+
+	seq_printf(m, "%s:\n", ns->disk->disk_name);
+	for_each_online_cpu(cpu) {
+		seq_printf(m, "cpu %d : ", cpu);
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			stat = &per_cpu_ptr(ns->path_lat, cpu)[i].stat;
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
+static const struct seq_operations nvme_mpath_latency_stat_seq_ops = {
+	.start = nvme_mpath_latency_stat_start,
+	.next  = nvme_mpath_latency_stat_next,
+	.stop  = nvme_mpath_latency_stat_stop,
+	.show  = nvme_mpath_latency_stat_show
+};
+
+static void nvme_latency_stat_read_all(struct nvme_ns *ns,
+		struct nvme_path_lat_stat *batch)
+{
+	int i, cpu;
+	u32 ncpu[NVME_NUM_STAT_GROUPS] = {0};
+	struct nvme_path_lat_stat *stat;
+
+	for_each_online_cpu(cpu) {
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			stat = &per_cpu_ptr(ns->path_lat, cpu)[i].stat;
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
+static int nvme_ns_latency_stat_show(void *data, struct seq_file *m)
+{
+	int i;
+	struct nvme_path_lat_stat stat[NVME_NUM_STAT_GROUPS] = {0};
+	struct nvme_ns *ns = (struct nvme_ns *)data;
+
+	if (!ns->head->disk)
+		return 0;
+
+	nvme_latency_stat_read_all(ns, stat);
+	for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+		seq_printf(m, "%u %llu %llu %llu ",
+			stat[i].weight, stat[i].sel,
+			stat[i].nr_samples, stat[i].nr_ignored);
+	}
+	return 0;
+}
 #endif
 
 static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
@@ -192,11 +311,15 @@ static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
 			nvme_latency_ewma_shift_store},
 	{"latency_batch_timeout", 0600, nvme_latency_batch_timeout_show,
 			nvme_latency_batch_timeout_store},
+	{"latency_stat", 0400, .seq_ops = &nvme_mpath_latency_stat_seq_ops},
 #endif
 	{},
 };
 
 static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
+#ifdef CONFIG_NVME_MULTIPATH
+	{"latency_stat", 0400, nvme_ns_latency_stat_show},
+#endif
 	{},
 };
 
-- 
2.53.0


