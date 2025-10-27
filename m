Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37D35CCF9EA
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Oct 2025 09:30:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBrhSOjfbB8zkgf/ZgL5l39njYe4TdoAKaIRHkOALIQ=; b=KQAmhthuNRbxq4DLlv+uY0Q+dO
	nFrRmNn3yQ2zGk9NZdr8WQMD4Ln87u1LLEHO50seeF+sryjVL3cWbryVo9whvlnQxnE/vxa7rnpwT
	LJWIwkTDSPWDcfndxgHWMM4tXkjshvCilhEpfzUYle/amPYjfq/RR3IXMR1aRx6nLozWSpJXPsbgd
	WtgtGlbyGL0Y3MGDzW5jAKpfx3pWv27ZBXGXdfeHj/lV3YA5pcEkQuomKweqi8MlkUt0gbL40fTbt
	nTKJj8YEYs69tSAS/Vyo98xdU3wOMqQUfbclAnm6t0IOocztnQGLEOJ5crmaWrUdhG97H+vuOr0IO
	b4x2IswA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYe-0000000DXCn-2jGu;
	Mon, 27 Oct 2025 09:30:32 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vDJYc-0000000DXAU-3NCt
	for linux-nvme@lists.infradead.org;
	Mon, 27 Oct 2025 09:30:32 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59R99hQ3023004;
	Mon, 27 Oct 2025 09:30:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UBrhSOjfbB8zkgf/Z
	gL5l39njYe4TdoAKaIRHkOALIQ=; b=HEAYXhe83LehRRuheG36qadX7BIhb/9dt
	caXY798hgqhcFbLrsj/tQA6pHHqm9IiowjNBxTZWyUV6XFUqV2cgkj+Bwsv/YF96
	Leenzfw8OH17lkj8LGm8mh1J3/4x/5UTbgnSgU95mCWF7IDj7HiUY1OSAl8vomNH
	CQx7SYMVlgiiQsc+ICSQ5aNr6TXqkxlGGRARwBdLCk7V71GIs11yieFiyNvm5d8m
	6pZYMAy4ceMtbgBbyFsJk40aprJd1estr91rs0G7v/R+fc6FFY+2NBd/SEQj5EgU
	6JK1KGmv63B8ObTXF10LhqmCqoCBmv6sPd93OKAcrI8tAPpoljBDg==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a0myrx2a9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:26 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 59R70aJ9022896;
	Mon, 27 Oct 2025 09:30:25 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a198xcwqx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 27 Oct 2025 09:30:25 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 59R9UNLG42795462
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 27 Oct 2025 09:30:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 48F722004B;
	Mon, 27 Oct 2025 09:30:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 832CF20040;
	Mon, 27 Oct 2025 09:30:19 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.ibm.com.com (unknown [9.61.186.32])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 27 Oct 2025 09:30:19 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv3 6/6] nvme-multipath: add debugfs attribute for adaptive I/O policy stat
Date: Mon, 27 Oct 2025 14:59:40 +0530
Message-ID: <20251027092949.961287-7-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251027092949.961287-1-nilay@linux.ibm.com>
References: <20251027092949.961287-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: UFr4oX28ARxvZf2hrtQf6EDiH44EAqdn
X-Authority-Analysis: v=2.4 cv=ct2WUl4i c=1 sm=1 tr=0 ts=68ff3bb2 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=x6icFKpwvdMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=VnNF1IyMAAAA:8
 a=St0ON_hCzbhJ978PwVUA:9 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDI1MDAxMCBTYWx0ZWRfX95fAZ4Uiu4NE
 oXNNu8v8Eg25QGz9dchVLysk1Bn7stzsG9jiEuensSGfcLv3hd8KxONB1SphWX1doNJyoRPHU+X
 ygs2QxjWuUdhIGKHcKOoJjRv53EHfvoks7fRUJ6cVtIvQ9fWTGbve/zHEyCyTcK+3PAsf5di2Y4
 pLIigMSsfFAS5ZUQso5C7ZtUnSln3kNRGV1aoc/SnAKNYFZb36NNorfi/FNrsHXfB5hJGNNEN/v
 xFL0OAboA+MoJ/g98wZaCui9awu6kb+H3E9nx4d8VMikVm6J8CrhDQCf7CmdwT0P8ToqYd2nFzd
 CsYEHZ1QxDu4tOxb9WiDWLKGI1+JrSbH6uomPqv4n/RonOYe/NkSI1EeX0rGFWoS9AgX6I/xLfg
 P0jgnt3aRc0F3fvN1fUc8Uz3LJIrXQ==
X-Proofpoint-GUID: UFr4oX28ARxvZf2hrtQf6EDiH44EAqdn
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-27_04,2025-10-22_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 phishscore=0 lowpriorityscore=0 impostorscore=0 malwarescore=0
 spamscore=0 adultscore=0 priorityscore=1501 clxscore=1015 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510250010
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251027_023030_968387_64C63C8A 
X-CRM114-Status: GOOD (  17.95  )
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
 drivers/nvme/host/core.c      |   3 +
 drivers/nvme/host/debugfs.c   | 114 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |   2 +
 3 files changed, 119 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f48c6bc25055..f9da74387329 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4198,6 +4198,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
+	nvme_debugfs_register(ns->disk);
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -4287,6 +4289,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_mpath_remove_sysfs_link(ns);
 
+	nvme_debugfs_unregister(ns->disk);
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index 5c441779554f..8256c30fe8ec 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -89,12 +89,126 @@ static const struct file_operations nvme_debugfs_fops = {
 	.release = nvme_debugfs_release,
 };
 
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
+#ifdef CONFIG_NVME_MULTIPATH
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
+#endif
+	return 0;
+}
+
+static const struct seq_operations nvme_mpath_adp_stat_seq_ops = {
+	.start = nvme_mpath_adp_stat_start,
+	.next  = nvme_mpath_adp_stat_next,
+	.stop  = nvme_mpath_adp_stat_stop,
+	.show  = nvme_mpath_adp_stat_show
+};
 
 static const struct nvme_debugfs_attr nvme_mpath_debugfs_attrs[] = {
+	{"adaptive_stat", 0400, .seq_ops = &nvme_mpath_adp_stat_seq_ops},
 	{},
 };
 
+static void adp_stat_read_all(struct nvme_ns *ns, struct nvme_path_stat *batch)
+{
+#ifdef CONFIG_NVME_MULTIPATH
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
+#endif
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
+
 static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
+	{"adaptive_stat", 0400, nvme_ns_adp_stat_show},
 	{},
 };
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index d4df01511ee9..391e1e0835e1 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1088,6 +1088,7 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
+		nvme_debugfs_unregister(head->disk);
 		del_gendisk(head->disk);
 	}
 	nvme_put_ns_head(head);
@@ -1191,6 +1192,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		}
 		nvme_add_ns_head_cdev(head);
 		kblockd_schedule_work(&head->partition_scan_work);
+		nvme_debugfs_register(head->disk);
 	}
 
 	nvme_mpath_add_sysfs_link(ns->head);
-- 
2.51.0


