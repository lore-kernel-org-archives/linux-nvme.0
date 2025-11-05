Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5858BCCF9F8
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Nov 2025 10:34:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dvpLjOA+iA1Oe1owL0KbF86ewopuGYT1CazuHhRnFi0=; b=Tmth0M5mqGv+JR/7pwLN/9xHLT
	7ZJbJwNBQl6O88DLEPou//+PK0I2/LHs3XhCwcRdnmF2iMClRiFyon0toI5fxWz9kpW42sI+Z4W2t
	YgpB0V7N4L5vwCxocwguJkcaTjG4qfY4Cn40O/FxY3GjcAvaI5cmNk0mrHXoAdmvkVJtqIk/wShL4
	8CGqYxLlG3SLypOT65iLNLLEjyPycdw0WSihchMCreHXahcXaqiquWIiqQJRGFZK+eNEiVHAXRQzT
	UscVpD35liEz5YcUXIdy9HEFGgMsx/a87leRIOeobKq0ZtcJ8M/waO+GdsMs1JTL0DnREFK/QZZE5
	MbZHF+Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaqN-0000000DTnc-0foW;
	Wed, 05 Nov 2025 10:34:23 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGaqL-0000000DTlx-1d8b
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Nov 2025 10:34:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=dvpLjOA+iA1Oe1owL0KbF86ewopuGYT1CazuHhRnFi0=; b=oZDlS+qb2cStLw35W3ykOj9pBf
	6jPHlYiGVHaJSQdjK5PR0HTxVRlB2D7bV66JU2KlrUAKQsDmaJfh3Tq/HW7Nscq6m81kMqK/CHMpq
	IksAxuvkMj5Lw5zBWn3UMRLBujx0jBdFfrPSOwV8vSNIjfq292D7Mp6y11K37u23gcxLGcvNNiVH3
	eD3l7mV5BAlPzZUaq3vfVHiHAmBf0f4lfLuUHaCqOSD619lqrczgtQuVSo3hgNv+JL9a3n1ojR7FJ
	BEJJIoCvL3ZsZRxjfnNWbZ9XhutKa4Zfi1TR7D3Q9QUqtNuulNPg92UjJn4GmQYqDY94wmx7jczfh
	VxUtJkXw==;
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by desiato.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGZyb-00000001rXi-07Mx
	for linux-nvme@lists.infradead.org;
	Wed, 05 Nov 2025 09:38:51 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A57EOO2010786;
	Wed, 5 Nov 2025 10:34:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dvpLjOA+iA1Oe1owL
	0KbF86ewopuGYT1CazuHhRnFi0=; b=ThqMvlOAr6SHoOpF42t4LV+gz6f6CBtXO
	lUyXOXjH12Gzgy11FW7ujWXDPr+PN8QPYPIJ6gcYAD8+LDlVEusTVbmcXJ6HttV3
	jsDVIuntblRLKVBv1vUJKONZR8TncdmjvHGavX3sRaxZErG2+uPku7Vk7K/UCAG/
	qDvvjILoatrDRkBU28qi2+IWTLxVa51oUo15PBiW8HMDC5eKPns1bjSjPJtmI0tG
	X8BThKyPoRpfhY2ToKkt/gxDXq5YyZ7u4OkulExcI9k5UokXi1impkwOmFI0OMcU
	XO1qsLuG1XxymP8PEzGbriHXPRvkjTFK07ByL8QKqfmpiRbCl12yQ==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc0nsc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:10 +0000 (GMT)
Received: from m0356517.ppops.net (m0356517.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 5A5AOpaC018873;
	Wed, 5 Nov 2025 10:34:09 GMT
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59xc0ns9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:09 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A57EaDA027408;
	Wed, 5 Nov 2025 10:34:08 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwyfp3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 05 Nov 2025 10:34:08 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A5AY6sI31261164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 5 Nov 2025 10:34:06 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 69BD22004B;
	Wed,  5 Nov 2025 10:34:06 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4692A20043;
	Wed,  5 Nov 2025 10:34:04 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed,  5 Nov 2025 10:34:04 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, kanie@linux.alibaba.com,
        gjoyce@ibm.com
Subject: [RFC PATCHv5 6/7] nvme-multipath: add debugfs attribute adaptive_stat
Date: Wed,  5 Nov 2025 16:03:25 +0530
Message-ID: <20251105103347.86059-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251105103347.86059-1-nilay@linux.ibm.com>
References: <20251105103347.86059-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX+EeCFTRDhGcp
 n++lBlBMYYphrAAk12WeQnl2x6V/Y52/Ksm+TwnrrK+1iRzZJUTY9DQva3V1qvH49p1S55fWCvT
 qTKgiO/GvLzxFOrJ/9MaxW8IdKqtlVKhufP0g+2WMpt6QN+ZxCeD9SvyEKyIRLYDgiB45mcgXmr
 Jg6ZCTvoulnLv6pXPEeebaP71B3EMUHsWfBuTQZ93FyI0PSrrPLLdJnXE4uia97x0AJG3D3aoi+
 rYYqmyfI8olRJFEg27kTmCKziqtaeRoGs/fTiQ9Rm9sIjgkkmyuPe8D9/B/ces6Qx5MeiJkcE4y
 Y4HMgrm/ednIe7ok7GKl16Csj9GfsOjaCdUN5+hgaDVGfN+nIBQpvdTVVszYzvWdl43Xxt8dP2K
 6oH/QQm4i9NPPEiKuievUw4gsCCNUw==
X-Proofpoint-GUID: 4vQD1DqEafrdvyEoLX1AEuGWAJIuLDbS
X-Authority-Analysis: v=2.4 cv=OdCVzxTY c=1 sm=1 tr=0 ts=690b2822 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=GMZBDc3o4BUkPsUqmQYA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-ORIG-GUID: T1xR4mjBwFWIFEw5CQF4-QNE8jBwkalt
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-05_04,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 adultscore=0 spamscore=0 suspectscore=0 impostorscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 phishscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510240000 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251105_093849_514842_88B172BE 
X-CRM114-Status: GOOD (  17.30  )
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


