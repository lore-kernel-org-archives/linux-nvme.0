Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D7662CCD18A
	for <linux-nvme@archiver.kernel.org>; Thu,  9 Oct 2025 10:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=F1pCNq2kB6HuHdN/iqblOrPAg3hMG5s2kaGhuCnkdz4=; b=F/b+vatOuM5ULVgzb3FTNwEA//
	iab/Q4K2Hnyx3c9DMt0brZ+x8Yu4a8ltxXV3UREb4X8Cf8VTBr0lF2wAyJodXoJNcn6JMg30Auhh0
	/7p/Igk4YrZi/dB8DxJiu+2pDYCp58ki1kJ34ApJmX8QK9n7HW8sFoP542u93ytCzxn9G6UGtA0Qc
	FpA52GnWxhPBC0TbaJOWtFUZf2tBTGA0luMVnRDiZA8FLNYsKi/EpJDAH5hz+1gBcrdoyty/NVyZ5
	bNG7A8g0SbUWcJlek6FPpMgbftlQ4daQFlPrnHfkLtaKLDsjn65XeJRasWe+zXtOAv5NUn+hpWJUW
	GW+O0hOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXY-00000005jbl-3MgR;
	Thu, 09 Oct 2025 10:06:28 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v6nXV-00000005jaI-44jD
	for linux-nvme@lists.infradead.org;
	Thu, 09 Oct 2025 10:06:27 +0000
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5995wK8T014540;
	Thu, 9 Oct 2025 10:06:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=F1pCNq
	2kB6HuHdN/iqblOrPAg3hMG5s2kaGhuCnkdz4=; b=BT8qkJTxIclBf5vyb6Gktu
	LKIHrKf7G4G8YIgfdGWJYMpZtRPxkoq8/jEPnThlHz8yPWqY5mhyykF97ZACSPs1
	x1BhOk6FwBiBGwqcIEWokMzdnMZUE8Lhczm3UYw9hmkAMOL8hKE6IKQgt6IuxXii
	xKp8KW6LmmfwHtfcFyyNHHM4svazzPhr7Oy/z5i4IrjixdCg+7hq1WUOkaig23SI
	vA+kAXHQSz/w+9V64styp74ID7C3qGX+SfHaBgyYR235OBSPbmoJBQFaxA+of1pH
	WzKBAcSh7CnT4JddcMXgz/ZDlpfp6dlNeFCA1k58ui5W2e26iVN1pVxiE5pe+LFg
	==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 49nv84m1sq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:21 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5998KSmO012972;
	Thu, 9 Oct 2025 10:06:20 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 49nvamuww0-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 09 Oct 2025 10:06:20 +0000
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 599A6JbY50594086
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Oct 2025 10:06:19 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E2A1520088;
	Thu,  9 Oct 2025 10:06:18 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E73EA20087;
	Thu,  9 Oct 2025 10:06:14 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.200])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  9 Oct 2025 10:06:14 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, axboe@kernel.dk,
        dwagner@suse.de, gjoyce@ibm.com
Subject: [RFC PATCHv2 2/4] nvme-multipath: add support for adaptive I/O policy
Date: Thu,  9 Oct 2025 15:35:24 +0530
Message-ID: <20251009100608.1699550-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251009100608.1699550-1-nilay@linux.ibm.com>
References: <20251009100608.1699550-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=HKPO14tv c=1 sm=1 tr=0 ts=68e7891d cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=IkcTkHD0fZMA:10 a=x6icFKpwvdMA:10 a=VnNF1IyMAAAA:8 a=j7rYpJuoH502Fa49vkkA:9
 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-GUID: rpYD2qyXvDXLYzQaDb_4b0NjKPQ9bI3r
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMDA4MDEyMSBTYWx0ZWRfXzIvRKwKIVAGc
 dV2y7gkUUel3HJg0rka4q/30MF11AUuRfCyIh+CgtZMaHXNZwv8yI12hvY4QmXiKpwuGIRtmtof
 GntYtt7eoDJyFDMO5CI4ZyzROf08PWH8BiOYXMtpUmh8+YLTxJ/xTJWMd7EcCvqlUhTbrWvdSPf
 qzSupgJOWrb903BbktAfyY8R4nVtQ/FqqE2FD6rJzEt9zARjDC19dfRzDdfWi97r+d3yE4XR2hw
 A/iUYjG5+xZ7VMoZ/gxABxWzaIPBpmidVs3rD8c/Umom2FbRRzZ9nj6pAhn4kxNq7QGoJBCXev8
 yHuYWjmQD2yEHWsaY/LRs7/u7yoCen+Qgh8qvutL3fd5C7onfCnfJtSNqZqytBHqaUsQ8qWYqrM
 CabM85QFrPNAIrlDCxfLOupZNyR90Q==
X-Proofpoint-ORIG-GUID: rpYD2qyXvDXLYzQaDb_4b0NjKPQ9bI3r
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1117,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-10-09_03,2025-10-06_01,2025-03-28_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 lowpriorityscore=0 bulkscore=0 spamscore=0
 adultscore=0 clxscore=1015 phishscore=0 priorityscore=1501 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2510020000 definitions=main-2510080121
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251009_030626_169085_9A54CAE6 
X-CRM114-Status: GOOD (  35.14  )
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

This commit introduces a new I/O policy named "adaptive". Users can
configure it by writing "adaptive" to "/sys/class/nvme-subsystem/nvme-
subsystemX/iopolicy"

The adaptive policy dynamically distributes I/O based on measured
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

    path_A_weight = (path_A_score * 100) / total_score
    path_B_weight = (path_B_score * 100) / total_score

where:
  - path_X_ewma_latency is the smoothed latency of a path in nanoseconds
  - NSEC_PER_SEC is used as a scaling factor since valid latencies
    are < 1 second
  - weights are normalized to a 0–100 scale across all paths.

Path credits are refilled based on this weight, with one credit
consumed per I/O. When all credits are consumed, the credits are
refilled again based on the current weight. This ensures that I/O is
distributed across paths proportionally to their calculated weight.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  10 +-
 drivers/nvme/host/ioctl.c     |   7 +-
 drivers/nvme/host/multipath.c | 397 ++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  44 +++-
 drivers/nvme/host/pr.c        |   6 +-
 drivers/nvme/host/sysfs.c     |   2 +-
 6 files changed, 444 insertions(+), 22 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de73..c7f21823c137 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -689,6 +689,7 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	nvme_free_ns_stat(ns);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -4137,6 +4138,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_init_ns_head(ns, info))
 		goto out_cleanup_disk;
 
+	if (nvme_alloc_ns_stat(ns))
+		goto out_unlink_ns;
+
 	/*
 	 * If multipathing is enabled, the device name for all disks and not
 	 * just those that represent shared namespaces needs to be based on the
@@ -4161,7 +4165,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	}
 
 	if (nvme_update_ns_info(ns, info))
-		goto out_unlink_ns;
+		goto out_free_ns_stat;
 
 	mutex_lock(&ctrl->namespaces_lock);
 	/*
@@ -4170,7 +4174,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	 */
 	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
 		mutex_unlock(&ctrl->namespaces_lock);
-		goto out_unlink_ns;
+		goto out_free_ns_stat;
 	}
 	nvme_ns_add_to_ctrl_list(ns);
 	mutex_unlock(&ctrl->namespaces_lock);
@@ -4201,6 +4205,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	list_del_rcu(&ns->list);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
+out_free_ns_stat:
+	nvme_free_ns_stat(ns);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c212fa952c0f..69d2f72d0e86 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -711,7 +711,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 		flags |= NVME_IOCTL_PARTITION;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, open_for_write ? WRITE : READ);
 	if (!ns)
 		goto out_unlock;
 
@@ -742,7 +742,7 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, open_for_write ? WRITE : READ);
 	if (!ns)
 		goto out_unlock;
 
@@ -762,7 +762,8 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
+	struct nvme_ns *ns = nvme_find_path(head,
+			ioucmd->file->f_mode & FMODE_WRITE ? WRITE : READ);
 	int ret = -EINVAL;
 
 	if (ns)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 3da980dc60d9..9ecdaca5e9a0 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -6,6 +6,8 @@
 #include <linux/backing-dev.h>
 #include <linux/moduleparam.h>
 #include <linux/vmalloc.h>
+#include <linux/blk-mq.h>
+#include <linux/math64.h>
 #include <trace/events/block.h>
 #include "nvme.h"
 
@@ -66,9 +68,10 @@ MODULE_PARM_DESC(multipath_always_on,
 	"create multipath node always except for private namespace with non-unique nsid; note that this also implicitly enables native multipath support");
 
 static const char *nvme_iopolicy_names[] = {
-	[NVME_IOPOLICY_NUMA]	= "numa",
-	[NVME_IOPOLICY_RR]	= "round-robin",
-	[NVME_IOPOLICY_QD]      = "queue-depth",
+	[NVME_IOPOLICY_NUMA]	 = "numa",
+	[NVME_IOPOLICY_RR]	 = "round-robin",
+	[NVME_IOPOLICY_QD]       = "queue-depth",
+	[NVME_IOPOLICY_ADAPTIVE] = "adaptive",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -83,6 +86,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_RR;
 	else if (!strncmp(val, "queue-depth", 11))
 		iopolicy = NVME_IOPOLICY_QD;
+	else if (!strncmp(val, "adaptive", 8))
+		iopolicy = NVME_IOPOLICY_ADAPTIVE;
 	else
 		return -EINVAL;
 
@@ -196,6 +201,221 @@ void nvme_mpath_start_request(struct request *rq)
 }
 EXPORT_SYMBOL_GPL(nvme_mpath_start_request);
 
+static void nvme_mpath_weight_work(struct work_struct *weight_work)
+{
+	int cpu, srcu_idx;
+	u32 weight;
+	struct nvme_ns *ns;
+	struct nvme_path_stat *stat;
+	struct nvme_path_work *work = container_of(weight_work,
+			struct nvme_path_work, weight_work);
+	struct nvme_ns_head *head = work->ns->head;
+	int rw = work->rw;
+	u64 total_score = 0;
+
+	cpu = get_cpu();
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+			srcu_read_lock_held(&head->srcu)) {
+
+		stat = &this_cpu_ptr(ns->info)[rw].stat;
+		if (!READ_ONCE(stat->slat_ns))
+			continue;
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
+	 * (normalized to the range 0–100). The weight represents the
+	 * relative share of I/O the path should receive.
+	 *
+	 *   - lower smoothed latency -> higher weight
+	 *   - higher smoothed slatency -> lower weight
+	 *
+	 * Next, while forwarding I/O, we assign "credits" to each path
+	 * based on its weight (please also refer nvme_adaptive_path()):
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
+		stat = &this_cpu_ptr(ns->info)[rw].stat;
+		weight = div_u64(stat->score * 100, total_score);
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
+		stat->score = 0;
+	}
+out:
+	srcu_read_unlock(&head->srcu, srcu_idx);
+	put_cpu();
+}
+
+#define NVME_EWMA_SHIFT	3
+static inline u64 ewma_update(u64 old, u64 new)
+{
+	return (old * ((1 << NVME_EWMA_SHIFT) - 1) + new) >> NVME_EWMA_SHIFT;
+}
+
+static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
+{
+	int cpu;
+	unsigned int rw;
+	struct nvme_path_info *info;
+	struct nvme_path_stat *stat;
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
+	 * its credits. And we limit path weight/credit max up to 100. Please
+	 * also refer nvme_adaptive_path().
+	 */
+	cpu = blk_mq_rq_cpu(rq);
+	rw = rq_data_dir(rq);
+	info = &per_cpu_ptr(ns->info, cpu)[rw];
+	stat = &info->stat;
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
+	if (now > stat->last_weight_ts &&
+			(now - stat->last_weight_ts) >= 15 * NSEC_PER_SEC) {
+
+		stat->last_weight_ts = now;
+
+		/*
+		 * Find simple average latency for the last epoch (~15 sec
+		 * interval).
+		 */
+		avg_lat_ns = div_u64(stat->batch, stat->batch_count);
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
+			slat_ns = ewma_update(stat->slat_ns, avg_lat_ns);
+			WRITE_ONCE(stat->slat_ns, slat_ns);
+		}
+
+		stat->batch = stat->batch_count = 0;
+
+		/*
+		 * Defer calculation of the path weight in per-cpu workqueue.
+		 */
+		schedule_work_on(cpu, &info->work.weight_work);
+	}
+}
+
+int nvme_alloc_ns_stat(struct nvme_ns *ns)
+{
+	int rw, cpu;
+	struct nvme_path_work *work;
+	gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
+
+	if (!ns->head->disk)
+		return 0;
+
+	ns->info = __alloc_percpu_gfp(2 * sizeof(struct nvme_path_info),
+			__alignof__(struct nvme_path_info), gfp);
+	if (!ns->info)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		for (rw = 0; rw < 2; rw++) {
+			work = &per_cpu_ptr(ns->info, cpu)[rw].work;
+			work->ns = ns;
+			work->rw = rw;
+			INIT_WORK(&work->weight_work, nvme_mpath_weight_work);
+		}
+	}
+
+	return 0;
+}
+
 void nvme_mpath_end_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
@@ -203,6 +423,9 @@ void nvme_mpath_end_request(struct request *rq)
 	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
 		atomic_dec_if_positive(&ns->ctrl->nr_active);
 
+	if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
+		nvme_mpath_add_sample(rq, ns);
+
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
@@ -236,6 +459,54 @@ static const char *nvme_ana_state_names[] = {
 	[NVME_ANA_CHANGE]		= "change",
 };
 
+static void nvme_mpath_reset_current_stat(struct nvme_ns *ns)
+{
+	int rw, cpu;
+	struct nvme_path_stat *stat;
+
+	for_each_possible_cpu(cpu) {
+		for (rw = 0; rw < 2; rw++) {
+			stat = &per_cpu_ptr(ns->info, cpu)[rw].stat;
+			memset(stat, 0, sizeof(struct nvme_path_stat));
+		}
+	}
+}
+
+static bool nvme_mpath_set_current_adaptive_path(struct nvme_ns *ns)
+{
+	struct nvme_ns_head *head = ns->head;
+
+	if (!head->disk || head->subsys->iopolicy != NVME_IOPOLICY_ADAPTIVE)
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
+static bool nvme_mpath_clear_current_adaptive_path(struct nvme_ns *ns)
+{
+	int rw, cpu;
+	struct nvme_path_info *info;
+
+	if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
+		return false;
+
+	blk_stat_disable_accounting(ns->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
+	for_each_online_cpu(cpu) {
+		for (rw = 0; rw < 2; rw++) {
+			info = &per_cpu_ptr(ns->info, cpu)[rw];
+			cancel_work_sync(&info->work.weight_work);
+		}
+	}
+	nvme_mpath_reset_current_stat(ns);
+	return true;
+}
+
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
@@ -251,6 +522,8 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 			changed = true;
 		}
 	}
+	if (nvme_mpath_clear_current_adaptive_path(ns))
+		changed = true;
 out:
 	return changed;
 }
@@ -269,6 +542,18 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
+static void nvme_mpath_set_ctrl_paths(struct nvme_ctrl *ctrl)
+{
+	struct nvme_ns *ns;
+	int srcu_idx;
+
+	srcu_idx = srcu_read_lock(&ctrl->srcu);
+	list_for_each_entry_srcu(ns, &ctrl->namespaces, list,
+				srcu_read_lock_held(&ctrl->srcu))
+		nvme_mpath_set_current_adaptive_path(ns);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
+}
+
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
@@ -281,6 +566,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 				 srcu_read_lock_held(&head->srcu)) {
 		if (capacity != get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
+
+		nvme_mpath_reset_current_stat(ns);
 	}
 	srcu_read_unlock(&head->srcu, srcu_idx);
 
@@ -405,6 +692,86 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 	return found;
 }
 
+static inline bool nvme_state_is_live(enum nvme_ana_state state)
+{
+	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
+}
+
+static struct nvme_ns *nvme_adaptive_path(struct nvme_ns_head *head,
+		unsigned int rw)
+{
+	struct nvme_ns *ns, *found = NULL;
+	struct nvme_path_stat *stat;
+	u32 weight;
+	int refill = 0;
+
+	get_cpu();
+retry:
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+			srcu_read_lock_held(&head->srcu)) {
+
+		if (nvme_path_is_disabled(ns) ||
+				!nvme_state_is_live(ns->ana_state))
+			continue;
+
+		stat = &this_cpu_ptr(ns->info)[rw].stat;
+
+		/*
+		 * When the head path-list is singular we don't calculate the
+		 * only path weight for optimization as we don't need to forward
+		 * I/O to more than one path. The another possibility is whenthe
+		 * path is newly added, we don't know its weight. So we go round
+		 * -robin for each such path and forward I/O to it.Once we start
+		 * getting response for such I/Os, the path weight calculation
+		 * would kick in and then we start using path credit for
+		 * forwarding I/O.
+		 */
+		weight = READ_ONCE(stat->weight);
+		if (unlikely(!weight)) {
+			found = ns;
+			goto out;
+		}
+
+		/*
+		 * To keep path selection logic simple, we don't distinguish
+		 * between ANA optimized and non-optimized states. The non-
+		 * optimized path is expected to have a lower weight, and
+		 * therefore fewer credits. As a result, only a small number of
+		 * I/Os will be forwarded to paths in the non-optimized state.
+		 */
+		if (stat->credit > 0) {
+			--stat->credit;
+			found = ns;
+			goto out;
+		}
+	}
+
+	if (!found && !list_empty(&head->list)) {
+		/*
+		 * Refill credits and retry.
+		 */
+		list_for_each_entry_srcu(ns, &head->list, siblings,
+				srcu_read_lock_held(&head->srcu)) {
+			if (nvme_path_is_disabled(ns) ||
+					!nvme_state_is_live(ns->ana_state))
+				continue;
+
+			stat = &this_cpu_ptr(ns->info)[rw].stat;
+			weight = READ_ONCE(stat->weight);
+			stat->credit = weight;
+			refill = 1;
+		}
+		if (refill)
+			goto retry;
+	}
+out:
+	if (found)
+		stat->sel++;
+
+	put_cpu();
+	return found;
+}
+
 static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
@@ -461,9 +828,12 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 	return ns;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
+		unsigned int rw)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_ADAPTIVE:
+		return nvme_adaptive_path(head, rw);
 	case NVME_IOPOLICY_QD:
 		return nvme_queue_depth_path(head);
 	case NVME_IOPOLICY_RR:
@@ -523,7 +893,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, bio_data_dir(bio));
 	if (likely(ns)) {
 		bio_set_dev(bio, ns->disk->part0);
 		bio->bi_opf |= REQ_NVME_MPATH;
@@ -565,7 +935,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, READ);
 	if (ns)
 		ret = nvme_ns_get_unique_id(ns, id, type);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -581,7 +951,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, READ);
 	if (ns)
 		ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -807,6 +1177,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	}
 	mutex_unlock(&head->lock);
 
+	mutex_lock(&nvme_subsystems_lock);
+	nvme_mpath_set_current_adaptive_path(ns);
+	mutex_unlock(&nvme_subsystems_lock);
+
 	synchronize_srcu(&head->srcu);
 	kblockd_schedule_work(&head->requeue_work);
 }
@@ -855,11 +1229,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
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
@@ -1037,10 +1406,12 @@ static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
 
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
index 102fae6a231c..bc87dd80de62 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -421,6 +421,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_ADAPTIVE,
 };
 
 struct nvme_subsystem {
@@ -459,6 +460,30 @@ struct nvme_ns_ids {
 	u8	csi;
 };
 
+struct nvme_path_stat {
+	u64 nr_samples;		/* total num of samples processed */
+	u64 nr_ignored;		/* num. of samples ignored */
+	u64 slat_ns;		/* smoothed (ewma) latency in nanoseconds */
+	u64 score;		/* score used for weight calculation */
+	u64 last_weight_ts;	/* timestamp of the last weight calculation */
+	u64 sel;		/* num of times this path is selcted for I/O */
+	u64 batch;		/* accumulated latency sum for current window */
+	u32 batch_count;	/* num of samples accumulated in current window */
+	u32 weight;		/* path weight */
+	u32 credit;		/* path credit for I/O forwarding */
+};
+
+struct nvme_path_work {
+	struct nvme_ns *ns;		/* owning namespace */
+	struct work_struct weight_work;	/* deferred work for weight calculation */
+	int rw;				/* op type : READ or WRITE */
+};
+
+struct nvme_path_info {
+	struct nvme_path_stat stat;	/* path statistics */
+	struct nvme_path_work work;	/* background worker context */
+};
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -534,6 +559,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	struct nvme_path_info __percpu *info;
 #endif
 	struct list_head siblings;
 	struct kref kref;
@@ -545,6 +571,7 @@ struct nvme_ns {
 #define NVME_NS_FORCE_RO		3
 #define NVME_NS_READY			4
 #define NVME_NS_SYSFS_ATTR_LINK	5
+#define NVME_NS_PATH_STAT		6
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -949,7 +976,7 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
 extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
-struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
+struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int rw);
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
@@ -978,6 +1005,7 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+int nvme_alloc_ns_stat(struct nvme_ns *ns);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -1005,6 +1033,13 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
 		return true;
 	return false;
 }
+static inline void nvme_free_ns_stat(struct nvme_ns *ns)
+{
+	if (!ns->head->disk)
+		return;
+
+	free_percpu(ns->info);
+}
 #else
 #define multipath false
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
@@ -1096,6 +1131,13 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
 {
 	return false;
 }
+static inline int nvme_alloc_ns_stat(struct nvme_ns *ns)
+{
+	return 0;
+}
+static inline void nvme_free_ns_stat(struct nvme_ns *ns)
+{
+}
 #endif /* CONFIG_NVME_MULTIPATH */
 
 int nvme_ns_get_unique_id(struct nvme_ns *ns, u8 id[16],
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca6a74607b13..9f23793dc12f 100644
--- a/drivers/nvme/host/pr.c
+++ b/drivers/nvme/host/pr.c
@@ -53,10 +53,12 @@ static int nvme_send_ns_head_pr_command(struct block_device *bdev,
 		struct nvme_command *c, void *data, unsigned int data_len)
 {
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
-	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
+	int srcu_idx;
+	struct nvme_ns *ns;
 	int ret = -EWOULDBLOCK;
 
+	srcu_idx = srcu_read_lock(&head->srcu);
+	ns = nvme_find_path(head, nvme_is_write(c) ? WRITE : READ);
 	if (ns) {
 		c->common.nsid = cpu_to_le32(ns->head->ns_id);
 		ret = nvme_submit_sync_cmd(ns->queue, c, data, data_len);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..4f9607e9698a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -194,7 +194,7 @@ static int ns_head_update_nuse(struct nvme_ns_head *head)
 		return 0;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, READ);
 	if (!ns)
 		goto out_unlock;
 
-- 
2.51.0


