Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AFAECCD5BA4
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:22:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+NklwBIfXTQup6477zKjqdWatNMNeGXYRI9Kn5dKBJM=; b=yfLRegq0Y/GrzJwr1ibdMO88TL
	HeXWl6mAZfMw7aN3nt7mI8wii8FB4HDD0QNQqEEsNpYUamY51czWtQKkgoEOvxFconN4vTSrsVSzF
	e7Z/cDyojFxyZqGYcV/T/4FxF5L43tQVojUD4odDD0JukokZKC+7yxfRNyIOwnaoQKsx+lBCD+311
	npGumRx12/NdDFUxfmyJ3LONbST9iNa86vlm52rscH85tP9h3p7PY6oFVtyfCvJ7sQHbn7Na+XBkH
	BblaVdc7GQDDGhevoO0yabth2dXWVyRHzS3i1vzkNQfRSKkKKiXOOtTBBckAHDRdD9cgztlpjsa+s
	NXXRmtqA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYY-00000005QTs-45Gh;
	Wed, 20 May 2026 18:22:10 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYW-00000005QRm-3bLv
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:22:10 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KB72Ea069465;
	Wed, 20 May 2026 18:22:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=+NklwBIfXTQup6477
	zKjqdWatNMNeGXYRI9Kn5dKBJM=; b=agEPdNtIUyT62BykqjKof5IXpWXPAPq3G
	dDH8bfO6rqFRZUGiR+af0SnM6oAuu4ugd+KYvzIBTYAb+bHZ8qUY1ZcKw9oqozv8
	rkEY8HAOzj4vcsqlVuOElJvYT3eX0yXlpyyQVceKZCxz8s7+lGq5AxbqUOmov4YS
	sebe7JdFhO1JkCVblOXC45Fq7GlgAMJsxVfYAlP8RwCb1VvSuNcDnnhs129trL4p
	nzMHxbnObZbTZ3+ibrMtdLchXLdl4Sq0rOa6nN+WlyIrNgNRlQlXdxy+CXVViq0a
	1o3FlYobR+G2faO4rAsRQiPLuaxSd+865QQv790rsVxiJGkIhwo8w==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mubsb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:22:04 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI96rN021479;
	Wed, 20 May 2026 18:22:03 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8sa9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:22:03 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KIM1OZ45941174
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:22:01 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 90DB320043;
	Wed, 20 May 2026 18:22:01 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A38F20040;
	Wed, 20 May 2026 18:21:56 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:21:56 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 7/8] nvme-multipath: add debugfs attribute latency_stat
Date: Wed, 20 May 2026 23:51:03 +0530
Message-ID: <20260520182112.863076-8-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
References: <20260520182112.863076-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: FaJ_hQOwuhy1WdaGGHMceNiH9J8b2Y0q
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0dfbcc cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=6jSwP_Ep0sLyt9EEqmkA:9
X-Proofpoint-ORIG-GUID: k02hDphfl6obWNKO5y4sRIeXGy718kB2
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfX35qpsbb5uocI
 QmnBI/F3zEIZUXCkClhS0f25ZbtEymLkdS2pYBb1UCiQBpPTp53hPGDiHAsA6r9kS2JuTbGCpWj
 XsRlGtAfoLw1wr8TQoxJ8B6plJ60npXPq9OuG8SI8Ck8FyxCvnPdEuhSnxVqX7wu6Cq1oArQ1SI
 f76FZA0YHNmINVKZGsNRR0w7IPSx4KDRJ2X80P5shliu8amQMrEqsMMlfQ9PoPM+eMdqzYm6lbr
 EAWdgpjFaBksXmn+T40J9ZWIv4RM+Uw6E3QHEb2DqdYDHCTY9LWLM2Wi9C+5ni0RQ/7ETifLc4B
 lgnX8309MUoCBMuDkvtnoL2e/nj4nf2g0Yr8aQnADEaSPBkjWuYNgyJWqAvrD6NLli92Ala5f/d
 bl5YueQPiz9bP5JnawHYKXqXZd9WNpk3TDmvMmuwiagD3TcUt8g+9f1bPCV3TIpGJQIksSh4B7H
 0TDkn2vkhHFClweAWbg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_112208_913698_5154C249 
X-CRM114-Status: GOOD (  17.27  )
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


