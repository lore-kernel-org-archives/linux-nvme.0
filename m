Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CE61AC5AC80
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+NklwBIfXTQup6477zKjqdWatNMNeGXYRI9Kn5dKBJM=; b=MrwNse2UoNhcCpHXgT1kNyo3oY
	1ii0pd1O5k1sZLMc/XKU+jq1wm/rvWYV15e74iIHIDS1jye/w6oB2wfyVJa10FcotPedkcRbOJGyl
	8CsIvtpUdY87jitugz/MCgj1jT751fo/XVU45XDPErslRWPZv6kMSTLszPjFafZQKIWrNWg1s7TnZ
	XzZGevMzLSDEgm+p/sy3E54/uzhUv/Pj7pPTVb0ONCpfnAWczp1X7bHJQAXWvyFnXFhDwNRgZVzLt
	/fzxuG7V5G5KYbKA+HgBetfTyL8yqe3x+ybLsMgRtkNnh7DatqI4nPgkzL30QMfwKoCc2NmnI9LeW
	Sh7kqDdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0T8-0000000AAwp-0Aed;
	Sun, 09 Aug 2026 10:09:26 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0T3-0000000AAqc-3DxM
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:23 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 679921B62474579;
	Sun, 9 Aug 2026 10:09:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+NklwBIfXTQup6477
	zKjqdWatNMNeGXYRI9Kn5dKBJM=; b=EWycS35jhpoPfaQeVfDwBGCIhDFI83Q5R
	ZsRwdtYVwJl7jdMCfPdtt8Qj/aHebMfrq7rI1Tw7xEMCjOGhA20T/gpGvwMCoszw
	Io5EUPbxfkH0mPgbCA1C+XfP30IY2umxHkyBwcW0cwC7NQBVv9YkYAwt4hvv18Xc
	6sb46BRY7GPkgpr5KwxEX4KEMbe7qz/Jnu7DySGADdpSZwymN+9Jm7vXgLq24PLF
	7XAj+gEJut7NloPpPJG0hLn//v5bch7yL4FU51Oh8GNbAa2dvA7n1po0VvxhDIaR
	Ko3/I5xFa3e9O2MKfELfgfK8ujgjQpcpMVlbM3gFQYE7RcFPBA7uQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvp2kmkg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:16 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799v2Om011716;
	Sun, 9 Aug 2026 10:09:16 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fxh0g0v15-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:15 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A9CSL34079134
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:09:12 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 686D220043;
	Sun,  9 Aug 2026 10:09:12 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9031920040;
	Sun,  9 Aug 2026 10:09:09 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:09:09 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 8/9] nvme-multipath: add debugfs attribute latency_stat
Date: Sun,  9 Aug 2026 15:38:03 +0530
Message-ID: <20260809100825.2014133-9-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=AMtp2X5w c=1 sm=1 tr=0 ts=6a7851cd cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=6jSwP_Ep0sLyt9EEqmkA:9
X-Proofpoint-GUID: HNyQyu6I761t5mK2VzAjfk8i02Onh-mc
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX0NCUY0zZo3Go
 /BcG2h6xuD9kSnbAPPTKJ7t5uUsgO9NcxNIHda8hN3jCsk92B6eHQu5QNfFxLyGGuOcxU1lUSXp
 7EZ02v4JZWnkyx99GoaO67Pe72mK8RJUR89WbOxXnp0Xv/rfzhpUE2izWMvvFJ+TqDPnBuN3I9q
 4UuOttWyhF+RRzzCezR6anYONIBmdFisif9grh3VHIbWxMMGAmiAoeQp065r61B88VXnJMXStqe
 SpaEqZqTh51+SNL5AnyDjBRkXasfmkUN416ns1icqDqppKA+YcSA8K07sPukORmMidO+PdH39kh
 a05VKB+7zH/9ahPK7LJhzk5QS5IWQwNWbva3cIKoIiECYVlgxTku4hB/UuYUIxQhubTu+5MF48A
 Ok6A15nhMoeisQEGuqPCf4lxtqrAjznXQTYmLxYKynncy1fOOhMLhubgNMUt2m50Qgc/L+p3RlM
 ojWtRuMLQdaVfPGZWgg==
X-Proofpoint-ORIG-GUID: 3SAQ0UW3EV8U55j0mkxsB82j1KsW_1UJ
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX/JEmisJeMVXQ
 QObJXLTO7s1+JUb2L3XofWwLdh1P355s79xdPIcOoZCSJrSJxThIkSdnedSAkwPSKnw+U+YCbsu
 jQLGizVJa5nMGRaHqlSUwnqp4bWEtkM=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 lowpriorityscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 phishscore=0 spamscore=0 bulkscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030921_925070_7DD624DD 
X-CRM114-Status: GOOD (  17.71  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/debugfs.c | 124 ++++++++++++++++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index 63b0ad5d105b..b4bc7c710050 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -181,6 +181,126 @@ static ssize_t nvme_latency_batch_timeout_store(void *data,
 	WRITE_ONCE(head->latency_batch_timeout, res * NSEC_PER_SEC);
 	return count;
 }
+
+static void *nvme_mpath_latency_stat_start(struct seq_file *m, loff_t *pos)
+{
+	struct nvme_ns *ns;
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns_head *head = ctx->data;
+
+	if (!head->disk)
+		return NULL;
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
+{
+	struct nvme_debugfs_ctx *ctx = m->private;
+	struct nvme_ns_head *head = ctx->data;
+	int srcu_idx = ctx->srcu_idx;
+
+	if (!head->disk)
+		return;
+
+	srcu_read_unlock(&head->srcu, srcu_idx);
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
@@ -189,11 +309,15 @@ static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
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


