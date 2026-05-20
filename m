Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1ED0BCD4F3D
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:21:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2N7v4VRtTmNCiQbG+s57JbsW7u0NSjqJOje4yTqbIns=; b=K2n+KP7Vmqhd+yaUrU7sVbKXaK
	8VzoJ3yTzzGNnAqVXHOhv0ONrpjIwoeemfY6p5ofFDnbSqlYgAEztm930y5SFSY/FgeveQvyJWe/x
	f/2MtjVWDt0rT6+wCTRLtDCh/lDcZJGhNAszB8xhCv0Y9sjfKwD7HRqsDjizK08rDc8OKsr1m4loC
	zLfjAcsYHXWFWShAQp8G3EfTjtr/ItRUqa8AyYb6fMlSQWwXvDJxrSiKa1IxbDP8NTMulVGtTA+Zg
	8wfOLE41fN6KCpaJmUfpJ67e5VnCGVFa1ZCiCNi6dMhkESwg/84c1o6TgjpBSFUVFy99jMsCc1Ma/
	9rB6d8vg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYE-00000005QEL-1sdu;
	Wed, 20 May 2026 18:21:50 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlYB-00000005QCu-2dj2
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:21:49 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64K7e9mb883231;
	Wed, 20 May 2026 18:21:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=2N7v4V
	RtTmNCiQbG+s57JbsW7u0NSjqJOje4yTqbIns=; b=JqtbhhEJERaUKrNcHuq1l+
	hD0M5fR6GPXNSGYQO3QucHm0rGKJgb0PA6pRpZ642bor+99J8cqIoq8edoBKz8op
	aD8aZ4vxoOQw66TkG1NxBQ91Ah9JrWR3gqd0MZ+LQ07i2X4WKTsYrMO3hOyRepZk
	blr0nU0IoI0lIf4HXm6HCyO/u99MMZ6e8Ne99MRP4L/iw5SxiATAAPm4PQcFhO8X
	iO1iAQ4a778o78RYNgw4R0cCfZ/15osiyesFmkDTjIS7E57O+L7XcUpp1gGbRJtT
	B/e4wZ1EOGdpfkU7ayPkpepIGsz/tlKZsG0aFXWOM0uOm3mZDcVIOT/xcYE4QpjA
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mubqv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:41 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI95tG021462;
	Wed, 20 May 2026 18:21:40 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e72wq8s98-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:40 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KILd1N14614936
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:21:39 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0187E2004D;
	Wed, 20 May 2026 18:21:39 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A53AE20040;
	Wed, 20 May 2026 18:21:33 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:21:33 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 3/8] nvme-multipath: add support for latency I/O policy
Date: Wed, 20 May 2026 23:50:59 +0530
Message-ID: <20260520182112.863076-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
References: <20260520182112.863076-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: wLOZMzLmYCXNsHoJntmoP0nmOeSlnLyR
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0dfbb6 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=RnoormkPH1_aCDwRdu11:22 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8
 a=BNzpp2B0GvAl3dTWBCEA:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
X-Proofpoint-ORIG-GUID: aYatB0eiWSDidV8-_sJE-G29_TYdNkGo
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfX7AYcyU1gf/cc
 99qHihnpA3ypRXsyedo7q6+QahWzBJZWPHb9My7TIOewnzITVBl/2j9u49C7dwYOSG3maMYyP5R
 +Q78iGsoUepIfsz2venXbrVxcKxd/Ujmz5qvsMJD7xUKo6SHlsHomHnq31suODYzqYTnzkBkNUv
 uh4U/6XbTrLvjR/Z9wPFGHSxajqqPt92iI9jAbla4PEdj9415jTjEK7um/+ebrGGAYdx8X04JUZ
 DF1+ZJujjVqSHY9t6aTGMg+jAYj6cTw3Q271LR7mxlLKSyL+n6rnEy4LPQVJ0OTgCd4CjXGtOHI
 MjcW5xbf4xIjr126vt3/o7cvxIid7nFsLhN+G0bbVu7e8Ho6gTqENbpR78vzoEjzTGOy4nRlgE+
 +0PV0VaR77ZscudbYW9STldJaLSkKd3w8GI5jNoskIDWUsN5WEOUCVbuzVgOmd7WyHYCZRsuXX8
 q1v4kmm3Q7oviED+ZqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1015 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_112147_693582_7B128B93 
X-CRM114-Status: GOOD (  33.56  )
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
 drivers/nvme/host/core.c      |  18 +-
 drivers/nvme/host/multipath.c | 430 +++++++++++++++++++++++++++++++++-
 drivers/nvme/host/nvme.h      |  53 ++++-
 3 files changed, 487 insertions(+), 14 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c3032d6ad6b1..82db59927556 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -677,6 +677,9 @@ static void nvme_free_ns_head(struct kref *ref)
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head->plids);
+#ifdef CONFIG_NVME_MULTIPATH
+	free_percpu(head->latency_path);
+#endif
 	kfree(head);
 }
 
@@ -694,6 +697,7 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	nvme_free_ns_stat(ns);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -4174,6 +4178,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_init_ns_head(ns, info))
 		goto out_cleanup_disk;
 
+	if (nvme_alloc_ns_stat(ns))
+		goto out_unlink_ns;
+
 	/*
 	 * If multipathing is enabled, the device name for all disks and not
 	 * just those that represent shared namespaces needs to be based on the
@@ -4198,7 +4205,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	}
 
 	if (nvme_update_ns_info(ns, info))
-		goto out_unlink_ns;
+		goto out_free_ns_stat;
 
 	mutex_lock(&ctrl->namespaces_lock);
 	/*
@@ -4207,7 +4214,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	 */
 	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
 		mutex_unlock(&ctrl->namespaces_lock);
-		goto out_unlink_ns;
+		goto out_free_ns_stat;
 	}
 	nvme_ns_add_to_ctrl_list(ns);
 	mutex_unlock(&ctrl->namespaces_lock);
@@ -4231,6 +4238,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	list_del_rcu(&ns->list);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
+out_free_ns_stat:
+	nvme_free_ns_stat(ns);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -4270,10 +4279,13 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 
 	/*
 	 * Ensure that !NVME_NS_READY is seen by other threads to prevent
-	 * this ns going back into current_path.
+	 * this ns going back into current_path/latency_path.
 	 */
 	synchronize_srcu(&ns->head->srcu);
 
+	if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
+		nvme_cancel_ns_latency_weight_work(ns);
+
 	/* wait for concurrent submissions */
 	if (nvme_mpath_clear_current_path(ns))
 		synchronize_srcu(&ns->head->srcu);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 90f449780e72..e1089a75a6fe 100644
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
@@ -83,6 +87,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_RR;
 	else if (!strncmp(val, "queue-depth", 11))
 		iopolicy = NVME_IOPOLICY_QD;
+	else if (!strncmp(val, "latency", 7))
+		iopolicy = NVME_IOPOLICY_LATENCY;
 	else
 		return -EINVAL;
 
@@ -185,6 +191,203 @@ void nvme_mpath_start_request(struct request *rq)
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
+	op_type = nvme_data_dir(req_op(rq));
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
@@ -192,6 +395,9 @@ void nvme_mpath_end_request(struct request *rq)
 	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
 		atomic_dec_if_positive(&ns->ctrl->nr_active);
 
+	if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
+		nvme_mpath_add_sample(rq, ns);
+
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
@@ -225,6 +431,70 @@ static const char *nvme_ana_state_names[] = {
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
+	for_each_online_cpu(cpu) {
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
+	nvme_reset_ns_latency_stat(ns);
+	return changed;
+}
+
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
@@ -237,6 +507,10 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 			changed = true;
 		}
 	}
+
+	if (nvme_disable_ns_latency_sampling(ns))
+		changed = true;
+
 	return changed;
 }
 
@@ -254,6 +528,45 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
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
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
@@ -266,6 +579,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 				 srcu_read_lock_held(&head->srcu)) {
 		if (capacity != get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
+
+		nvme_reset_ns_latency_stat(ns);
 	}
 	srcu_read_unlock(&head->srcu, srcu_idx);
 
@@ -390,6 +705,92 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
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
@@ -450,6 +851,8 @@ inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
 		unsigned int op_type)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_LATENCY:
+		return nvme_latency_path(head, op_type);
 	case NVME_IOPOLICY_QD:
 		return nvme_queue_depth_path(head);
 	case NVME_IOPOLICY_RR:
@@ -728,6 +1131,10 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	if (!nvme_is_unique_nsid(ctrl, head))
 		return 0;
 
+	head->latency_path = alloc_percpu_gfp(struct nvme_ns*, GFP_KERNEL);
+	if (!head->latency_path)
+		return -ENOMEM;
+
 	blk_set_stacking_limits(&lim);
 	lim.dma_alignment = 3;
 	lim.features |= BLK_FEAT_IO_STAT | BLK_FEAT_NOWAIT |
@@ -736,8 +1143,10 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 		lim.features |= BLK_FEAT_ZONED;
 
 	head->disk = blk_alloc_disk(&lim, ctrl->numa_node);
-	if (IS_ERR(head->disk))
+	if (IS_ERR(head->disk)) {
+		free_percpu(head->latency_path);
 		return PTR_ERR(head->disk);
+	}
 	head->disk->fops = &nvme_ns_head_ops;
 	head->disk->private_data = head;
 
@@ -793,6 +1202,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	}
 	mutex_unlock(&head->lock);
 
+	mutex_lock(&nvme_subsystems_lock);
+	nvme_enable_ns_latency_sampling(ns);
+	mutex_unlock(&nvme_subsystems_lock);
+
 	synchronize_srcu(&head->srcu);
 	kblockd_schedule_work(&head->requeue_work);
 }
@@ -841,11 +1254,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
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
@@ -1023,10 +1431,12 @@ static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
 
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
index 39e986e5f184..22e54c74c1a6 100644
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
@@ -477,6 +479,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_LATENCY,
 };
 
 struct nvme_subsystem {
@@ -521,6 +524,30 @@ enum nvme_stat_group {
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
@@ -570,6 +597,9 @@ struct nvme_ns_head {
 	unsigned long		flags;
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
+
+	struct nvme_ns * __percpu	*latency_path;
+
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -596,6 +626,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	struct nvme_path_lat __percpu *path_lat;
 #endif
 	struct list_head siblings;
 	struct kref kref;
@@ -607,6 +638,7 @@ struct nvme_ns {
 #define NVME_NS_FORCE_RO		3
 #define NVME_NS_READY			4
 #define NVME_NS_SYSFS_ATTR_LINK	5
+#define NVME_NS_PATH_STAT		6
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -1063,6 +1095,8 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+int nvme_alloc_ns_stat(struct nvme_ns *ns);
+void nvme_cancel_ns_latency_weight_work(struct nvme_ns *ns);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -1090,6 +1124,13 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
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
@@ -1181,6 +1222,16 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
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


