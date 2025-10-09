Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9AB6ECCD187
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 10:06:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dLPZc8yMrLZb4IzLAOtF+ql5OI/1mvgg5GnCJEEQuRU=; b=t4OeFtYQzs8GAw6yvUVItubcj/
	tAEkcQwEdk1W/0rEiJxgoT6BzLcPndzECXxl/w5Gi/InN25iBoUeV7dqJLejRbAA7JMmJnQ5lJ8vZ
	3OcAlSeX1Z2SrnIh/LdYRB4q3aYfHmO6W1hkkzYGFQ0mRe52kRQ393T813W/IL4ACf5Zq/QFW/gaW
	vySTFE5oWbITxlx5ZXwzjBarivDjXj8T8jq6ddGjjDWA1CyfrQekklsrO1UooLvdVTjf34900ydUj
	L5J8Z56T/V4LQbZf5byahXDTac9nWurEu0XC3jwj2BoQQEMK1q22xt1HB2+PMjsGIR4gZg+O4QuNJ
	C0sx84Dw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXd-00000005jf6-0Fd4;
	Thu, 09 Oct 2025 10:06:33 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXa-00000005jce-1235
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 10:06:31 +0000
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 59961112030914;
	Thu, 9 Oct 2025 10:06:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=dLPZc8yMrLZb4IzLA
	OtF+ql5OI/1mvgg5GnCJEEQuRU=; b=aPU1D9KRTUXEtaVva+6wQFavnC0UeD+1M
	p9NDXb7paNVTvaPoeeMscJnUfYuOzug7lpNdG8EM4T5/22iViIeNbp2C0uiS6xm1
	ErOJL9iYW5xQYsQCKq7man6V4DiekRzy3M7R5CMpPpeYoSk1neoglvWE5UkLJ5i6
	yutlyVtiQ81Ve4FpLBfzdLG6p4DgmTsMyS7qCH0m8D+RD2hZ2ngx5nFGVIgglooT
	BsYdmk93v4i5aqZnMsTHmI3PppPBLais086Z5xD8LXArI3Dh7edZujRkmadbgLRK
	GqDbEWOMgLjCLKEK7hvZ37evf20LjvCQ/rXmkTYp1PeHmHk1jy2Rw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv81m0q6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:27 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998EkTS026009;
	Thu, 9 Oct 2025 10:06:26 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamkwvx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:24 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599A6NSM52822416
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 10:06:23 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3DBAC20087;
	Thu,  9 Oct 2025 10:06:23 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C4DFA2008B;
	Thu,  9 Oct 2025 10:06:21 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.200])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 10:06:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCHv2 4/4] nvme-multipath: add debugfs attribute for adaptive I/O policy stat
Date: Thu,  9 Oct 2025 15:35:26 +0530
Message-ID: <20251009100608.1699550-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009100608.1699550-1-nilay@linux.ibm.com>
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: Jkp4dKEP6lN5D-WetdIwV3g4T8xqXORM
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfX+nnXC2bwvqOG
 22eY0GotSqDh/SBxC+aMvXb8LQiclNA+d6P660q9skZE8Ke5OFtOP20pzO74lZEkJkCBCYPk6+6
 d7Ureur/q6B5AXdb9IQr0EGMEh6xp3jvfK1XsEW5Y7NEwmgFwm3o9WXEf4pKDABKb8vXYy0+uPO
 UpekMyzqCiEpoHEjBq4coSlwcRMbiqeMqfmQSQSsicvpXPykn439kanUcd+Iq4Ep+I0KcgFFA1c
 nFbYwSrnhUPBMKNavwWF2taFuWrEw1O9Co10wuEF3vxIiHs2EeIdunyIyF0sIV9LIf5gOoFlhJj
 3UAA8Et0z30JE3VZ/owQc/v1X/1RuMLzB/CrwQ8guh5WynDVMfIDxVwPj01uWnEZkPLII4JoPFH
 PZ26QGseWCSwZiyWJBKuhT/kO5XCBw==
X-Authority-Analysis: v=2.4 cv=cKntc1eN c=1 sm=1 tr=0 ts=68e78923 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=l3ZHCC8oVEID0PFdAmIA:9
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: Jkp4dKEP6lN5D-WetdIwV3g4T8xqXORM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 impostorscore=0 adultscore=0 lowpriorityscore=0 malwarescore=0
 suspectscore=0 bulkscore=0 phishscore=0 spamscore=0 priorityscore=1501
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_030630_410487_6534937D 
X-CRM114-Status: GOOD (  17.67  )
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

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |   3 +
 drivers/nvme/host/debugfs.c   | 117 ++++++++++++++++++++++++++++++++++
 drivers/nvme/host/multipath.c |   2 +
 3 files changed, 122 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c7f21823c137..5db716186ec0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -4184,6 +4184,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
+	nvme_debugfs_register(ns->disk);
+
 	if (!nvme_ns_head_multipath(ns->head))
 		nvme_add_ns_cdev(ns);
 
@@ -4271,6 +4273,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	nvme_mpath_remove_sysfs_link(ns);
 
+	nvme_debugfs_unregister(ns->disk);
 	del_gendisk(ns->disk);
 
 	mutex_lock(&ns->ctrl->namespaces_lock);
diff --git a/drivers/nvme/host/debugfs.c b/drivers/nvme/host/debugfs.c
index 5c441779554f..2e7ebb0199bf 100644
--- a/drivers/nvme/host/debugfs.c
+++ b/drivers/nvme/host/debugfs.c
@@ -89,12 +89,129 @@ static const struct file_operations nvme_debugfs_fops = {
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
+	int cpu, rw;
+	struct nvme_path_stat *stat;
+	struct nvme_ns *ns = v;
+
+	seq_printf(m, "%s:\n", ns->disk->disk_name);
+	for_each_online_cpu(cpu) {
+		seq_printf(m, "cpu %d : ", cpu);
+		for (rw = 0; rw < 2; rw++) {
+			stat = &per_cpu_ptr(ns->info, cpu)[rw].stat;
+			seq_printf(m, "%u %llu %llu %llu %llu %llu ",
+				stat->weight, stat->score,
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
+	int rw, cpu;
+	u32 ncpu[2] = {0};
+	struct nvme_path_stat *stat;
+
+	for_each_online_cpu(cpu) {
+		for (rw = 0; rw < 2; rw++) {
+			stat = &per_cpu_ptr(ns->info, cpu)[rw].stat;
+			if (stat->weight) {
+				batch[rw].weight += stat->weight;
+				batch[rw].sel += stat->sel;
+				batch[rw].nr_samples += stat->nr_samples;
+				batch[rw].nr_ignored += stat->nr_ignored;
+				ncpu[rw]++;
+			}
+		}
+	}
+
+	for (rw = 0; rw < 2; rw++) {
+		if (!ncpu[rw])
+			continue;
+		batch[rw].weight = DIV_U64_ROUND_CLOSEST(batch[rw].weight,
+				ncpu[rw]);
+	}
+#endif
+}
+static int nvme_ns_adp_stat_show(void *data, struct seq_file *m)
+{
+	struct nvme_path_stat stat[2] = {0};
+	struct nvme_ns *ns = (struct nvme_ns *)data;
+
+	adp_stat_read_all(ns, stat);
+	seq_printf(m, "%u %llu %llu %llu %u %llu %llu %llu\n",
+		stat[READ].weight,
+		stat[READ].sel,
+		stat[READ].nr_samples,
+		stat[READ].nr_ignored,
+		stat[WRITE].weight,
+		stat[WRITE].sel,
+		stat[WRITE].nr_samples,
+		stat[WRITE].nr_ignored);
+	return 0;
+}
+
 static const struct nvme_debugfs_attr nvme_ns_debugfs_attrs[] = {
+	{"adaptive_stat", 0400, nvme_ns_adp_stat_show},
 	{},
 };
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9ecdaca5e9a0..26495696e24e 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1059,6 +1059,7 @@ static void nvme_remove_head(struct nvme_ns_head *head)
 
 		nvme_cdev_del(&head->cdev, &head->cdev_device);
 		synchronize_srcu(&head->srcu);
+		nvme_debugfs_unregister(head->disk);
 		del_gendisk(head->disk);
 	}
 	nvme_put_ns_head(head);
@@ -1162,6 +1163,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 		}
 		nvme_add_ns_head_cdev(head);
 		kblockd_schedule_work(&head->partition_scan_work);
+		nvme_debugfs_register(head->disk);
 	}
 
 	nvme_mpath_add_sysfs_link(ns->head);
-- 
2.51.0


