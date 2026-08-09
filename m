Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7344FC5AC80
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=CKcfyuPVo/l059eiZ1NstZp0/9MuMHOgQP6VrGJIe08=; b=oM9QP/IH9rNHpsX4F4k55649JG
	0wmlke2h5+fFgd7BTF9iJwv0siJBl5q9rjiP/+C3/VE3LQ40kMpzQkCkTJmQhfESpmQNl1p7JT0AY
	XZzVKCDslrCzAYaEK9ltRRiibOLXImNJUSU7/5c2jo2Wc3L7162bvM2602qBjCwEBRnRRu4MHrGpx
	VGeGUYrzGUaBJY9NF2xA6bxIqMAYTXpqGxoEqsPMnCXCOcRFlz50fjck8gfg8CHl54l6rSiolC5+m
	94OeaSfRU+wT2QhB4FMnWz9dC9AmvKdZylg6+GvfjHJ65c7bTR8Hk7Yb+E14BbomqWgNgcHrmZFmO
	EkiQAXDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sv-0000000AAjj-34J7;
	Sun, 09 Aug 2026 10:09:13 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Ss-0000000AAi1-2MRy
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:12 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67991SBZ699509;
	Sun, 9 Aug 2026 10:09:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=CKcfyu
	PVo/l059eiZ1NstZp0/9MuMHOgQP6VrGJIe08=; b=JZt2qH+JFNez5S7oAUogXe
	MLaDNsp+97djDp/i/o1UGXziY55YZGjLf+6UCZ1OjD+s9yrNN6gDko62QWvYZam5
	TH5Me4P3CKLAdX91cCJ1JY47j3XgXufW00fou/NhBzlJ0dX5b18ZRe5zwhUSERy1
	R8lEK8QA4tUTbzIXyW/4iwsoO4l+fIoDuhwZmbkI5abGHPF1cStkbiK0K8+QsYNK
	9YjqkDkBced9y4HWlawE+Z/zxqK8XfLMKWxz/OBjQoqeICh+p+3tNmLHzV6BYbku
	hrNukwcPorwPPv693TSaBSaJ/IWc16ODZdeqCxxa9G34oCJKwW/dKs0zbCeIke8w
	==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvjykvs9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:04 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799uFcv019067;
	Sun, 9 Aug 2026 10:09:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfsjh1dt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:03 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A8xcT49283380
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:08:59 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5433B20043;
	Sun,  9 Aug 2026 10:08:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 157EF20040;
	Sun,  9 Aug 2026 10:08:56 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:08:55 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 4/9] nvme-multipath: add support for latency I/O policy
Date: Sun,  9 Aug 2026 15:37:59 +0530
Message-ID: <20260809100825.2014133-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfXxg/Y1m8Q6o/k
 dO1VzFRHFFS8wDRMT3aLYJgiFvgj4HqExT1bl1CkpC5gHlCvhX0S2XQySMfuwcF6xd4R/C7mV4d
 aOikgR70XNXyCEy04E141T476eAWcU7tI6QwfYM7rlDt7noxn2c3ZWUavynMebrhr6U5qMlHbZS
 IEcktm/g8nBZFaqoxibmnNmzE3FLsXiszRL+AYArKfUnH5twA7N+1q3OrJEw41ig+ege1CtFKAc
 4j1kbjPaL0FogQfhJjUAi9fCUXVULpGUnsr5Zg2JhJcc3AuB4WH9ZoHylc/JkRB03pxhkDGozwl
 pr8hxs+qc6Hn2wg8eLbBT8b/J7fNp1rHAsz4bGaf+FbKNPUDTN/7Og27eU+3hcgl9uqNqoYHp6H
 9QIaz3SRuQdmVMx1idpC6jTovd2LALgne93UrvMYoU6pLYa2++ejyfglIUVQ16b23qC7MT5rhPl
 qLA4mgmmGPmgR09d6OA==
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfXzvxPbt+GxJwO
 JiBHPlgRKkI2V+w/YhO1dYF9g85ViCsKnOnPW3agLsd56I9+H5/mPG16DvcPX53sdWOMI/2Td9W
 Z7v1soTW9ZJI/Uk76gNI9FWu2AnQiVw=
X-Authority-Analysis: v=2.4 cv=RqD16imK c=1 sm=1 tr=0 ts=6a7851c1 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=AUKdOY64q48C9BMfvZIA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-GUID: bbk1Ba_jaJOua6qNnY2MYTteTHMdCtak
X-Proofpoint-ORIG-GUID: IH1e9C8J4cnhakhLEZ1bGxW1NY0801qQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 priorityscore=1501 suspectscore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 bulkscore=0 malwarescore=0 impostorscore=0
 spamscore=0 classifier=typeunknown authscore=0 authtc= authcc= route=outbound
 adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030910_631068_B4E75B36 
X-CRM114-Status: GOOD (  32.31  )
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

This commit introduces a new I/O policy named "latency". Users can
configure it by writing "latency" to "/sys/class/nvme-subsystem/nvme-
subsystemX/iopolicy"

The "latency" policy dynamically distributes I/O based on measured I/O
completion latency. The main idea is to calculate latency for each path,
derive a weight, and then proportionally forward I/O according to those
weights.

To ensure scalability, path latency is measured per-CPU. Each CPU
maintains its own statistics, and I/O forwarding uses these per-CPU
values. Every ~15 seconds, a simple average latency of per-CPU batched
samples are computed and fed into an Exponentially Weighted Moving
Average (EWMA):

avg_latency = div_u64(batch, batch_count);
new_ewma_latency = (prev_ewma_latency * (WEIGHT-1) + avg_latency)/WEIGHT

With WEIGHT = 8, this assigns 7/8 (~87.5%) weight to the previous
latency value and 1/8 (~12.5%) to the most recent latency. This
smoothing reduces jitter, adapts quickly to changing conditions,
avoids storing historical samples, and works well for both low and
high I/O rates. Path weights are then derived from the smoothed (EWMA)
latency as follows (example with two paths A and B):

	path_A_score = NSEC_PER_SEC / path_A_ewma_latency
	path_B_score = NSEC_PER_SEC / path_B_ewma_latency
	total_score  = path_A_score + path_B_score

	path_A_weight = (path_A_score * 64) / total_score
	path_B_weight = (path_B_score * 64) / total_score

where:
  - path_X_ewma_latency is the smoothed latency of a path in nanoseconds
  - NSEC_PER_SEC is used as a scaling factor since valid latencies
	are < 1 second
  - weights are normalized to a 0–64 scale across all paths.

Path credits are refilled based on this weight, with one credit
consumed per I/O. When all credits are consumed, the credits are
refilled again based on the current weight. This ensures that I/O is
distributed across paths proportionally to their calculated weight.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  15 +-
 drivers/nvme/host/multipath.c | 444 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  52 +++-
 3 files changed, 496 insertions(+), 15 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..542e2ee036cc 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -690,6 +690,9 @@ static void nvme_free_ns_head(struct kref *ref)
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head->plids);
+#ifdef CONFIG_NVME_MULTIPATH
+	free_percpu(head->latency_path);
+#endif
 	kfree(head);
 }
 
@@ -707,6 +710,7 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	nvme_free_ns_stat(ns);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -4220,6 +4224,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_init_ns_head(ns, info))
 		goto out_cleanup_disk;
 
+	if (nvme_alloc_ns_stat(ns))
+		goto out_unlink_ns;
+
 	/*
 	 * If multipathing is enabled, the device name for all disks and not
 	 * just those that represent shared namespaces needs to be based on the
@@ -4244,7 +4251,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	}
 
 	if (nvme_update_ns_info(ns, info))
-		goto out_unlink_ns;
+		goto out_free_ns_stat;
 
 	mutex_lock(&ctrl->namespaces_lock);
 	/*
@@ -4253,7 +4260,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	 */
 	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
 		mutex_unlock(&ctrl->namespaces_lock);
-		goto out_unlink_ns;
+		goto out_free_ns_stat;
 	}
 	blk_queue_rq_timeout(ns->queue, ctrl->io_timeout);
 	nvme_ns_add_to_ctrl_list(ns);
@@ -4278,6 +4285,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	list_del_rcu(&ns->list);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
+out_free_ns_stat:
+	nvme_free_ns_stat(ns);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -4317,7 +4326,7 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	/*
 	 * Ensure that !NVME_NS_READY is seen by other threads to prevent
-	 * this ns going back into current_path.
+	 * this ns going back into current_path/latency_path.
 	 */
 	synchronize_srcu(&ns->head->srcu);
 
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 8c20ff516e61..8086530b5350 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -6,6 +6,9 @@
 #include <linux/backing-dev.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
+#include <linux/blk-mq.h>
+#include <linux/math64.h>
+#include <linux/rculist.h>
 #include <trace/events/block.h>
 #include "nvme.h"
 
@@ -66,9 +69,10 @@ MODULE_PARM_DESC(multipath_always_on,
 	"create multipath node always except for private namespace with non-unique nsid; note that this also implicitly enables native multipath support");
 
 static const char *nvme_iopolicy_names[] = {
-	[NVME_IOPOLICY_NUMA]	= "numa",
-	[NVME_IOPOLICY_RR]	= "round-robin",
-	[NVME_IOPOLICY_QD]      = "queue-depth",
+	[NVME_IOPOLICY_NUMA]	 = "numa",
+	[NVME_IOPOLICY_RR]	 = "round-robin",
+	[NVME_IOPOLICY_QD]       = "queue-depth",
+	[NVME_IOPOLICY_LATENCY]  = "latency",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -107,7 +111,7 @@ static int nvme_get_iopolicy(char *buf, const struct kernel_param *kp)
 module_param_call(iopolicy, nvme_set_iopolicy, nvme_get_iopolicy,
 	&iopolicy, 0644);
 MODULE_PARM_DESC(iopolicy,
-	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
+	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth' or 'latency'");
 
 void nvme_mpath_default_iopolicy(struct nvme_subsystem *subsys)
 {
@@ -199,6 +203,203 @@ void nvme_mpath_start_request(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
+static void nvme_mpath_weight_work(struct work_struct *weight_work)
+{
+	int cpu, srcu_idx;
+	u32 weight;
+	struct nvme_ns *ns;
+	struct nvme_path_lat_stat *stat;
+	struct nvme_path_lat_work *work = container_of(weight_work,
+			struct nvme_path_lat_work, weight_work);
+	struct nvme_ns_head *head = work->ns->head;
+	int op_type = work->op_type;
+	u64 total_score = 0;
+
+	cpu = get_cpu();
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+			srcu_read_lock_held(&head->srcu)) {
+
+		stat = &this_cpu_ptr(ns->path_lat)[op_type].stat;
+		if (!READ_ONCE(stat->slat_ns)) {
+			stat->score = 0;
+			continue;
+		}
+		/*
+		 * Compute the path score as the inverse of smoothed
+		 * latency, scaled by NSEC_PER_SEC. Floating point
+		 * math is unavailable in the kernel, so fixed-point
+		 * scaling is used instead. NSEC_PER_SEC is chosen
+		 * because valid latencies are always < 1 second; longer
+		 * latencies are ignored.
+		 */
+		stat->score = div_u64(NSEC_PER_SEC, READ_ONCE(stat->slat_ns));
+
+		/* Compute total score. */
+		total_score += stat->score;
+	}
+
+	if (!total_score)
+		goto out;
+
+	/*
+	 * After computing the total slatency, we derive per-path weight
+	 * (normalized to the range 0–64). The weight represents the
+	 * relative share of I/O the path should receive.
+	 *
+	 *   - lower smoothed latency -> higher weight
+	 *   - higher smoothed slatency -> lower weight
+	 *
+	 * Next, while forwarding I/O, we assign "credits" to each path
+	 * based on its weight (please also refer nvme_latency_path()):
+	 *   - Initially, credits = weight.
+	 *   - Each time an I/O is dispatched on a path, its credits are
+	 *     decremented proportionally.
+	 *   - When a path runs out of credits, it becomes temporarily
+	 *     ineligible until credit is refilled.
+	 *
+	 * I/O distribution is therefore governed by available credits,
+	 * ensuring that over time the proportion of I/O sent to each
+	 * path matches its weight (and thus its performance).
+	 */
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+			srcu_read_lock_held(&head->srcu)) {
+
+		stat = &this_cpu_ptr(ns->path_lat)[op_type].stat;
+		weight = div_u64(stat->score * 64, total_score);
+
+		/*
+		 * Ensure the path weight never drops below 1. A weight
+		 * of 0 is used only for newly added paths. During
+		 * bootstrap, a few I/Os are sent to such paths to
+		 * establish an initial weight. Enforcing a minimum
+		 * weight of 1 guarantees that no path is forgotten and
+		 * that each path is probed at least occasionally.
+		 */
+		if (!weight)
+			weight = 1;
+
+		WRITE_ONCE(stat->weight, weight);
+	}
+out:
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	put_cpu();
+}
+
+/*
+ * Formula to calculate the EWMA (Exponentially Weighted Moving Average):
+ * ewma = (old_ewma * (EWMA_SHIFT - 1) + (EWMA_SHIFT)) / EWMA_SHIFT
+ * For instance, with EWMA_SHIFT = 3, this assigns 7/8 (~87.5 %) weight to
+ * the existing/old ewma and 1/8 (~12.5%) weight to the new sample.
+ */
+static inline u64 calc_ewma_update(u64 old, u64 new)
+{
+	return (old * ((1 << NVME_DEFAULT_LATENCY_EWMA_SHIFT) - 1)
+			+ new) >> NVME_DEFAULT_LATENCY_EWMA_SHIFT;
+}
+
+static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
+{
+	int cpu;
+	unsigned int op_type;
+	struct nvme_path_lat *path_lat;
+	struct nvme_path_lat_stat *stat;
+	u64 now, latency, slat_ns, avg_lat_ns;
+	struct nvme_ns_head *head = ns->head;
+
+	if (list_is_singular(&head->list))
+		return;
+
+	now = ktime_get_ns();
+	latency = now >= rq->io_start_time_ns ? now - rq->io_start_time_ns : 0;
+	if (!latency)
+		return;
+
+	/*
+	 * As completion code path is serialized(i.e. no same completion queue
+	 * update code could run simultaneously on multiple cpu) we can safely
+	 * access per cpu nvme path stat here from another cpu (in case the
+	 * completion cpu is different from submission cpu).
+	 * The only field which could be accessed simultaneously here is the
+	 * path ->weight which may be accessed by this function as well as I/O
+	 * submission path during path selection logic and we protect ->weight
+	 * using READ_ONCE/WRITE_ONCE. Yes this may not be 100% accurate but
+	 * we also don't need to be so accurate here as the path credit would
+	 * be anyways refilled, based on path weight, once path consumes all
+	 * its credits. And we limit path weight/credit max up to 64. Please
+	 * also refer nvme_latency_path().
+	 */
+	cpu = blk_mq_rq_cpu(rq);
+	op_type = nvme_data_dir(rq);
+	path_lat = &per_cpu_ptr(ns->path_lat, cpu)[op_type];
+	stat = &path_lat->stat;
+
+	/*
+	 * If latency > ~1s then ignore this sample to prevent EWMA from being
+	 * skewed by pathological outliers (multi-second waits, controller
+	 * timeouts etc.). This keeps path scores representative of normal
+	 * performance and avoids instability from rare spikes. If such high
+	 * latency is real, ANA state reporting or keep-alive error counters
+	 * will mark the path unhealthy and remove it from the head node list,
+	 * so we safely skip such sample here.
+	 */
+	if (unlikely(latency > NSEC_PER_SEC)) {
+		stat->nr_ignored++;
+		dev_warn_ratelimited(ns->ctrl->device,
+			"ignoring sample with >1s latency (possible controller stall or timeout)\n");
+		return;
+	}
+
+	/*
+	 * Accumulate latency samples and increment the batch count for each
+	 * ~15 second interval. When the interval expires, compute the simple
+	 * average latency over that window, then update the smoothed (EWMA)
+	 * latency. The path weight is recalculated based on this smoothed
+	 * latency.
+	 */
+	stat->batch += latency;
+	stat->batch_count++;
+	stat->nr_samples++;
+
+	if (now > stat->last_batch_ts && ((now - stat->last_batch_ts) >=
+			NVME_DEFAULT_LATENCY_BATCH_TIMEOUT)) {
+
+		/*
+		 * Find simple average latency for the last epoch (~15 sec
+		 * interval).
+		 */
+		avg_lat_ns = div_u64(stat->batch, stat->batch_count);
+		stat->last_batch_ts = now;
+
+		/*
+		 * Calculate smooth/EWMA (Exponentially Weighted Moving Average)
+		 * latency. EWMA is preferred over simple average latency
+		 * because it smooths naturally, reduces jitter from sudden
+		 * spikes, and adapts faster to changing conditions. It also
+		 * avoids storing historical samples, and works well for both
+		 * slow and fast I/O rates.
+		 * Formula:
+		 * slat_ns = (prev_slat_ns * (WEIGHT - 1) + (latency)) / WEIGHT
+		 * With WEIGHT = 8, this assigns 7/8 (~87.5 %) weight to the
+		 * existing latency and 1/8 (~12.5%) weight to the new latency.
+		 */
+		if (unlikely(!stat->slat_ns))
+			WRITE_ONCE(stat->slat_ns, avg_lat_ns);
+		else {
+			slat_ns = calc_ewma_update(stat->slat_ns, avg_lat_ns);
+			WRITE_ONCE(stat->slat_ns, slat_ns);
+		}
+
+		stat->batch = stat->batch_count = 0;
+
+		/*
+		 * Defer calculation of the path weight in per-cpu workqueue.
+		 */
+		schedule_work_on(cpu, &path_lat->work.weight_work);
+	}
+}
+
 void nvme_mpath_end_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
@@ -206,6 +407,15 @@ void nvme_mpath_end_request(struct request *rq)
 	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
 		atomic_dec_if_positive(&ns->ctrl->nr_active);
 
+	if (test_bit(NVME_NS_PATH_STAT, &ns->flags)) {
+		int srcu_idx;
+
+		srcu_idx = srcu_read_lock(&ns->head->srcu);
+		if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
+			nvme_mpath_add_sample(rq, ns);
+		srcu_read_unlock(&ns->head->srcu, srcu_idx);
+	}
+
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
@@ -239,6 +449,78 @@ static const char *nvme_ana_state_names[] = {
 	[NVME_ANA_CHANGE]		= "change",
 };
 
+static void nvme_reset_ns_latency_stat(struct nvme_ns *ns)
+{
+	int i, cpu;
+	struct nvme_path_lat_stat *stat;
+
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			stat = &per_cpu_ptr(ns->path_lat, cpu)[i].stat;
+			memset(stat, 0, sizeof(struct nvme_path_lat_stat));
+		}
+	}
+}
+
+void nvme_cancel_ns_latency_weight_work(struct nvme_ns *ns)
+{
+	int i, cpu;
+	struct nvme_path_lat *path_lat;
+
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			path_lat = &per_cpu_ptr(ns->path_lat, cpu)[i];
+			cancel_work_sync(&path_lat->work.weight_work);
+		}
+	}
+}
+
+static bool nvme_enable_ns_latency_sampling(struct nvme_ns *ns)
+{
+	struct nvme_ns_head *head = ns->head;
+
+	if (!head->disk ||
+		READ_ONCE(head->subsys->iopolicy) != NVME_IOPOLICY_LATENCY)
+		return false;
+
+	if (test_and_set_bit(NVME_NS_PATH_STAT, &ns->flags))
+		return false;
+
+	blk_queue_flag_set(QUEUE_FLAG_SAME_FORCE, ns->queue);
+	blk_stat_enable_accounting(ns->queue);
+	return true;
+}
+
+static bool nvme_disable_ns_latency_sampling(struct nvme_ns *ns)
+{
+	int cpu;
+	struct nvme_ns_head *head = ns->head;
+	bool changed = false;
+
+	if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
+		return false;
+
+	for_each_possible_cpu(cpu) {
+		if (ns == READ_ONCE(*per_cpu_ptr(head->latency_path, cpu))) {
+			WRITE_ONCE(*per_cpu_ptr(head->latency_path, cpu), NULL);
+			changed = true;
+		}
+	}
+
+	blk_stat_disable_accounting(ns->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
+
+	/*
+	 * Ensure that we wait until completion side samplings (if any sneaked
+	 * in after we clear NVME_NS_PATH_STAT) are all scheduled before we
+	 * start cancelling those.
+	 */
+	synchronize_srcu(&head->srcu);
+	nvme_cancel_ns_latency_weight_work(ns);
+	nvme_reset_ns_latency_stat(ns);
+	return changed;
+}
+
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
@@ -251,6 +533,10 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 			changed = true;
 		}
 	}
+
+	if (nvme_disable_ns_latency_sampling(ns))
+		changed = true;
+
 	return changed;
 }
 
@@ -268,6 +554,45 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
+int nvme_alloc_ns_stat(struct nvme_ns *ns)
+{
+	int i, cpu;
+	struct nvme_path_lat_work *work;
+	gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
+
+	if (!ns->head->disk)
+		return 0;
+
+	ns->path_lat = __alloc_percpu_gfp(NVME_NUM_STAT_GROUPS *
+				sizeof(struct nvme_path_lat),
+				__alignof__(struct nvme_path_lat), gfp);
+	if (!ns->path_lat)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			work = &per_cpu_ptr(ns->path_lat, cpu)[i].work;
+			work->ns = ns;
+			work->op_type = i;
+			INIT_WORK(&work->weight_work, nvme_mpath_weight_work);
+		}
+	}
+
+	return 0;
+}
+
+static void nvme_mpath_set_ctrl_paths(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				srcu_read_lock_held(&ctrl->srcu))
+		nvme_enable_ns_latency_sampling(ns);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
+}
+
 void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
 {
 	sector_t capacity = get_capacity(head->disk);
@@ -280,6 +605,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns_head *head)
 				 srcu_read_lock_held(&head->srcu)) {
 		if (capacity != get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
+
+		nvme_reset_ns_latency_stat(ns);
 	}
 	srcu_read_unlock(&head->srcu, srcu_idx);
 
@@ -404,6 +731,92 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 	return found;
 }
 
+static inline bool nvme_state_is_live(enum nvme_ana_state state)
+{
+	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
+}
+
+static struct nvme_ns *nvme_latency_path(struct nvme_ns_head *head,
+		unsigned int op_type)
+{
+	struct nvme_ns *ns, *start, *found = NULL;
+	struct nvme_path_lat_stat *stat;
+	u32 weight;
+	int cpu;
+
+	cpu = get_cpu();
+	ns = READ_ONCE(*this_cpu_ptr(head->latency_path));
+	if (unlikely(!ns)) {
+		ns = list_first_or_null_rcu(&head->list,
+				struct nvme_ns, siblings);
+		if (unlikely(!ns))
+			goto out;
+	}
+found_ns:
+	start = ns;
+	while (nvme_path_is_disabled(ns) ||
+			!nvme_state_is_live(ns->ana_state)) {
+		ns = list_next_entry_circular(ns, &head->list, siblings);
+
+		/*
+		 * If we iterate through all paths in the list but find each
+		 * path in list is either disabled or dead then bail out.
+		 */
+		if (ns == start)
+			goto out;
+	}
+
+	stat = &this_cpu_ptr(ns->path_lat)[op_type].stat;
+
+	/*
+	 * When the head path-list is singular we don't calculate the
+	 * only path weight for optimization as we don't need to forward
+	 * I/O to more than one path. The another possibility is when the
+	 * path is newly added, we don't know its weight. So we go round
+	 * -robin for each such path and forward I/O to it.Once we start
+	 * getting response for such I/Os, the path weight calculation
+	 * would kick in and then we start using path credit for
+	 * forwarding I/O.
+	 */
+	weight = READ_ONCE(stat->weight);
+	if (!weight) {
+		found = ns;
+		goto out;
+	}
+
+	/*
+	 * To keep path selection logic simple, we don't distinguish
+	 * between ANA optimized and non-optimized states. The non-
+	 * optimized path is expected to have a lower weight, and
+	 * therefore fewer credits. As a result, only a small number of
+	 * I/Os will be forwarded to paths in the non-optimized state.
+	 */
+	if (stat->credit > 0) {
+		--stat->credit;
+		found = ns;
+		goto out;
+	} else {
+		/*
+		 * Refill credit from path weight and move to next path. The
+		 * refilled credit of the current path will be used next when
+		 * all remainng paths exhaust its credits.
+		 */
+		weight = READ_ONCE(stat->weight);
+		stat->credit = weight;
+		ns = list_next_entry_circular(ns, &head->list, siblings);
+		if (likely(ns))
+			goto found_ns;
+	}
+out:
+	if (found) {
+		stat->sel++;
+		WRITE_ONCE(*this_cpu_ptr(head->latency_path), found);
+	}
+
+	put_cpu();
+	return found;
+}
+
 static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
@@ -464,6 +877,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
 		unsigned int op_type)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_LATENCY:
+		return nvme_latency_path(head, op_type);
 	case NVME_IOPOLICY_QD:
 		return nvme_queue_depth_path(head);
 	case NVME_IOPOLICY_RR:
@@ -754,6 +1169,10 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!nvme_is_unique_nsid(ctrl, head))
 		return 0;
 
+	head->latency_path = alloc_percpu_gfp(struct nvme_ns*, GFP_KERNEL);
+	if (!head->latency_path)
+		return -ENOMEM;
+
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
@@ -762,8 +1181,10 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		lim.features |= BLK_FEAT_ZONED;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
-	if (IS_ERR(head->disk))
+	if (IS_ERR(head->disk)) {
+		free_percpu(head->latency_path);
 		return PTR_ERR(head->disk);
+	}
 	head->disk->fops = &nvme_ns_head_ops;
 	head->disk->private_data = head;
 
@@ -819,6 +1240,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	}
 	mutex_unlock(&head->lock);
 
+	mutex_lock(&nvme_subsystems_lock);
+	nvme_enable_ns_latency_sampling(ns);
+	mutex_unlock(&nvme_subsystems_lock);
+
 	synchronize_srcu(&head->srcu);
 	kblockd_schedule_work(&head->requeue_work);
 }
@@ -867,11 +1292,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
 	return 0;
 }
 
-static inline bool nvme_state_is_live(enum nvme_ana_state state)
-{
-	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
-}
-
 static void nvme_update_ns_ana_state(struct nvme_ana_group_desc *desc,
 		struct nvme_ns *ns)
 {
@@ -1049,10 +1469,12 @@ static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
 
 	WRITE_ONCE(subsys->iopolicy, iopolicy);
 
-	/* iopolicy changes clear the mpath by design */
+	/* iopolicy changes clear/reset the mpath by design */
 	mutex_lock(&nvme_subsystems_lock);
 	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
 		nvme_mpath_clear_ctrl_paths(ctrl);
+	list_for_each_entry(ctrl, &subsys->ctrls, subsys_entry)
+		nvme_mpath_set_ctrl_paths(ctrl);
 	mutex_unlock(&nvme_subsystems_lock);
 
 	pr_notice("subsysnqn %s iopolicy changed from %s to %s\n",
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 8a9ec502912d..3c82f67f8926 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -28,7 +28,9 @@ extern unsigned int nvme_io_timeout;
 extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
-#define NVME_DEFAULT_KATO	5
+#define NVME_DEFAULT_KATO			5
+#define NVME_DEFAULT_LATENCY_EWMA_SHIFT		3
+#define NVME_DEFAULT_LATENCY_BATCH_TIMEOUT	(15 * NSEC_PER_SEC)
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0
@@ -483,6 +485,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_LATENCY,
 };
 
 struct nvme_subsystem {
@@ -527,6 +530,30 @@ enum nvme_stat_group {
 	NVME_NUM_STAT_GROUPS
 };
 
+struct nvme_path_lat_stat {
+	u64 nr_samples;		/* total num of samples processed */
+	u64 nr_ignored;		/* num. of samples ignored */
+	u64 slat_ns;		/* smoothed (ewma) latency in nanoseconds */
+	u64 score;		/* score used for weight calculation */
+	u64 last_batch_ts;	/* timestamp when last time avg. latency is calculated */
+	u64 sel;		/* num of times this path is selcted for I/O */
+	u64 batch;		/* accumulated latency sum for current window */
+	u32 batch_count;	/* num of samples accumulated in current window */
+	u32 weight;		/* path weight */
+	u32 credit;		/* path credit for I/O forwarding */
+};
+
+struct nvme_path_lat_work {
+	struct nvme_ns *ns;		/* owning namespace */
+	struct work_struct weight_work;	/* deferred work for weight calculation */
+	int op_type;			/* op type : READ/WRITE/OTHER */
+};
+
+struct nvme_path_lat {
+	struct nvme_path_lat_stat stat;	/* path statistics */
+	struct nvme_path_lat_work work;	/* background worker context */
+};
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -578,6 +605,8 @@ struct nvme_ns_head {
 	unsigned int		delayed_removal_secs;
 	atomic_long_t		io_requeue_no_usable_path_count;
 	atomic_long_t		io_fail_no_available_path_count;
+	struct nvme_ns * __percpu	*latency_path;
+
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 #define NVME_NSHEAD_CDEV_LIVE		2
@@ -606,6 +635,7 @@ struct nvme_ns {
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
 	atomic_long_t failover;
+	struct nvme_path_lat __percpu *path_lat;
 #endif
 	atomic_long_t retries;
 	atomic_long_t errors;
@@ -620,6 +650,7 @@ struct nvme_ns {
 #define NVME_NS_READY			4
 #define NVME_NS_SYSFS_ATTR_LINK	5
 #define NVME_NS_CDEV_LIVE		6
+#define NVME_NS_PATH_STAT		7
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -1100,6 +1131,8 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+int nvme_alloc_ns_stat(struct nvme_ns *ns);
+void nvme_cancel_ns_latency_weight_work(struct nvme_ns *ns);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -1130,6 +1163,13 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
 		return true;
 	return false;
 }
+static inline void nvme_free_ns_stat(struct nvme_ns *ns)
+{
+	if (!ns->head->disk)
+		return;
+
+	free_percpu(ns->path_lat);
+}
 #else
 #define multipath false
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
@@ -1221,6 +1261,16 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
 {
 	return false;
 }
+static inline void nvme_cancel_ns_latency_weight_work(struct nvme_ns *ns)
+{
+}
+static inline int nvme_alloc_ns_stat(struct nvme_ns *ns)
+{
+	return 0;
+}
+static inline void nvme_free_ns_stat(struct nvme_ns *ns)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
-- 
2.53.0


