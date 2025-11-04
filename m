Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5717CCFA05
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 10:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=H3T+XSOHOe//ZnwlulUZu8cUKt4om2T5jUK9Ak88hYg=; b=0JmNHFABkNtNXrc6TaGQCu8y6R
	WouND25QcdKTOxDLd5vQt5b+B0aeZupewS42JXSDHi4tYH3ZfA0WFHGbca5m7Dyakz1Lj1jjGTXxb
	Mae/uiWSk8Ilwm0WWlaN6EIferRg+3LBQJTgNRvfj6wmyBKj7MUFZjUUTUh5bVBGN/rqZVA5dEpYy
	zMr2hNi0/k61sFt/Jyqq9kO3TnbGmlFuyIDvd8d6ynFh4OsDSRX/O2NaKJ1RDZcRD9AisG2iYP/DU
	q2vXb+Q3OWqsS9BP3Y3xliyCxq5cmfUKdSZ/HZJMiBHR4QyKG0e5HiIHwM+UHdNB7XDL/4O+SRfAQ
	8djCFd4Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEXy-0000000BdrF-3M2p;
	Tue, 04 Nov 2025 10:45:54 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGEXv-0000000BdoX-2VL8
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 10:45:53 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 5A42Nbr7024476;
	Tue, 4 Nov 2025 10:45:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=pp1; bh=H3T+XS
	OHOe//ZnwlulUZu8cUKt4om2T5jUK9Ak88hYg=; b=HfE7NJamo8KoaDa4h7Juwt
	UZOk5caY4gos0pF60dv6CkqPyHQ/XsEa8n5imjhrKu8RL2MivtWWKTl7xN7hFXqR
	lYTxhts6L/I6O1fRpz8msIKQsWm0gpSKl9BkadL01fGSDqOvIbPLFHTzWltn7Dzi
	CkF7j2AJng1Pays3+b7LcevB6WS9vXRasA8hpBfVgY7NW086xmMZSCc0cFIHvj2V
	c4MP8VsyVJQKsKAzpgroNUOg7PnBhImAcBNiTVz6upINcHhea2midQOGeRlDHHO6
	FKgltoW9SxE6hFrvsiMZdk6snso1lllYRDf8nBkEguv7kAEhwVZH1cff5PoR6emg
	==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4a59vubd46-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:45 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 5A4A7oDc027394;
	Tue, 4 Nov 2025 10:45:44 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4a5vwyaq0y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 04 Nov 2025 10:45:43 +0000
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 5A4AjfMw16187760
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 4 Nov 2025 10:45:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9A7D420040;
	Tue,  4 Nov 2025 10:45:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8DE262004B;
	Tue,  4 Nov 2025 10:45:39 +0000 (GMT)
Received: from li-c9696b4c-3419-11b2-a85c-f9edc3bf8a84.in.ibm.com (unknown [9.109.198.245])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue,  4 Nov 2025 10:45:39 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, hch@lst.de, kbusch@kernel.org, sagi@grimberg.me,
        dwagner@suse.de, axboe@kernel.dk, gjoyce@ibm.com
Subject: [RFC PATCHv4 2/6] nvme-multipath: add support for adaptive I/O policy
Date: Tue,  4 Nov 2025 16:15:17 +0530
Message-ID: <20251104104533.138481-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104104533.138481-1-nilay@linux.ibm.com>
References: <20251104104533.138481-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: OjL-7KhqCMROZHqBTZsWm-Mj2hwgmPLl
X-Proofpoint-GUID: OjL-7KhqCMROZHqBTZsWm-Mj2hwgmPLl
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjUxMTAxMDAyMSBTYWx0ZWRfX/wp+cvDEzJz4
 5/de0HmS2If+u+VVh9tWt8x3SfhMNLnf0pAfnjtcCizuc77U8siMcepkgoPB/mt1qINUCRT3Pmf
 8fJhP1sC+UahMK/9j8WqmG9SRfe5qPsTLODh/9ZfI/AKWGK/p3JKUDHELtSfbgWCoFJU4KaPt1N
 wSr2DY5Egukx4UfxVFKDyuPCQ3Hh/UYCuD+RoHs9fV+2IsyTHDO2dbPp1sN0NLx66yh4MGXUw3c
 8Kco+pvruagZ3CbwZg/sNJxJQuYxmkUwxwxuWpR8R87dIV2m8qkYfrDUbVya2YMitTS0KeCJRZW
 vFq+1Kf8CYHggJB30/0ANYLacfXhnZnHpd+lQR9GFQ8+fAU2oyY+UhMzCOx/U9DLjxOPLHNo5rM
 2AZ2qFeAEMYnxcLfXHnzUCQkJs0lkA==
X-Authority-Analysis: v=2.4 cv=U6qfzOru c=1 sm=1 tr=0 ts=6909d959 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=IkcTkHD0fZMA:10 a=6UeiqGixMTsA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=VnNF1IyMAAAA:8 a=5tJFQP_W3D_f_7u-Zj4A:9 a=3ZKOabzyN94A:10 a=QEXdDO2ut3YA:10
 a=cPQSjfK2_nFv0Q5t_7PE:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.9,FMLib:17.12.100.49
 definitions=2025-11-03_06,2025-11-03_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 impostorscore=0 spamscore=0 phishscore=0
 clxscore=1015 malwarescore=0 lowpriorityscore=0 suspectscore=0
 priorityscore=1501 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2510240000
 definitions=main-2511010021
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251104_024551_659220_9ED049F0 
X-CRM114-Status: GOOD (  31.69  )
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
  - weights are normalized to a 0–64 scale across all paths.

Path credits are refilled based on this weight, with one credit
consumed per I/O. When all credits are consumed, the credits are
refilled again based on the current weight. This ensures that I/O is
distributed across paths proportionally to their calculated weight.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/core.c      |  15 +-
 drivers/nvme/host/ioctl.c     |  31 ++-
 drivers/nvme/host/multipath.c | 425 ++++++++++++++++++++++++++++++++--
 drivers/nvme/host/nvme.h      |  74 +++++-
 drivers/nvme/host/pr.c        |   6 +-
 drivers/nvme/host/sysfs.c     |   2 +-
 6 files changed, 530 insertions(+), 23 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index fa4181d7de73..47f375c63d2d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -672,6 +672,9 @@ static void nvme_free_ns_head(struct kref *ref)
 	cleanup_srcu_struct(&head->srcu);
 	nvme_put_subsystem(head->subsys);
 	kfree(head->plids);
+#ifdef CONFIG_NVME_MULTIPATH
+	free_percpu(head->adp_path);
+#endif
 	kfree(head);
 }
 
@@ -689,6 +692,7 @@ static void nvme_free_ns(struct kref *kref)
 {
 	struct nvme_ns *ns = container_of(kref, struct nvme_ns, kref);
 
+	nvme_free_ns_stat(ns);
 	put_disk(ns->disk);
 	nvme_put_ns_head(ns->head);
 	nvme_put_ctrl(ns->ctrl);
@@ -4137,6 +4141,9 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	if (nvme_init_ns_head(ns, info))
 		goto out_cleanup_disk;
 
+	if (nvme_alloc_ns_stat(ns))
+		goto out_unlink_ns;
+
 	/*
 	 * If multipathing is enabled, the device name for all disks and not
 	 * just those that represent shared namespaces needs to be based on the
@@ -4161,7 +4168,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	}
 
 	if (nvme_update_ns_info(ns, info))
-		goto out_unlink_ns;
+		goto out_free_ns_stat;
 
 	mutex_lock(&ctrl->namespaces_lock);
 	/*
@@ -4170,7 +4177,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	 */
 	if (test_bit(NVME_CTRL_FROZEN, &ctrl->flags)) {
 		mutex_unlock(&ctrl->namespaces_lock);
-		goto out_unlink_ns;
+		goto out_free_ns_stat;
 	}
 	nvme_ns_add_to_ctrl_list(ns);
 	mutex_unlock(&ctrl->namespaces_lock);
@@ -4201,6 +4208,8 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	list_del_rcu(&ns->list);
 	mutex_unlock(&ctrl->namespaces_lock);
 	synchronize_srcu(&ctrl->srcu);
+out_free_ns_stat:
+	nvme_free_ns_stat(ns);
  out_unlink_ns:
 	mutex_lock(&ctrl->subsys->lock);
 	list_del_rcu(&ns->siblings);
@@ -4244,6 +4253,8 @@ static void nvme_ns_remove(struct nvme_ns *ns)
 	 */
 	synchronize_srcu(&ns->head->srcu);
 
+	nvme_mpath_cancel_adaptive_path_weight_work(ns);
+
 	/* wait for concurrent submissions */
 	if (nvme_mpath_clear_current_path(ns))
 		synchronize_srcu(&ns->head->srcu);
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index c212fa952c0f..759d147d9930 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -700,18 +700,29 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
 int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 		unsigned int cmd, unsigned long arg)
 {
+	u8 opcode;
 	struct nvme_ns_head *head = bdev->bd_disk->private_data;
 	bool open_for_write = mode & BLK_OPEN_WRITE;
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
 	unsigned int flags = 0;
+	unsigned int op_type = NVME_STAT_OTHER;
 
 	if (bdev_is_partition(bdev))
 		flags |= NVME_IOCTL_PARTITION;
 
+	if (cmd == NVME_IOCTL_SUBMIT_IO) {
+		if (get_user(opcode, (u8 *)argp))
+			return -EFAULT;
+		if (opcode == nvme_cmd_write)
+			op_type = NVME_STAT_WRITE;
+		else if (opcode == nvme_cmd_read)
+			op_type = NVME_STAT_READ;
+	}
+
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, op_type);
 	if (!ns)
 		goto out_unlock;
 
@@ -733,6 +744,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
+	u8 opcode;
 	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct cdev *cdev = file_inode(file)->i_cdev;
 	struct nvme_ns_head *head =
@@ -740,9 +752,19 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
+	unsigned int op_type = NVME_STAT_OTHER;
+
+	if (cmd == NVME_IOCTL_SUBMIT_IO) {
+		if (get_user(opcode, (u8 *)argp))
+			return -EFAULT;
+		if (opcode == nvme_cmd_write)
+			op_type = NVME_STAT_WRITE;
+		else if (opcode == nvme_cmd_read)
+			op_type = NVME_STAT_READ;
+	}
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, op_type);
 	if (!ns)
 		goto out_unlock;
 
@@ -762,7 +784,10 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
+	const struct nvme_uring_cmd *cmd = io_uring_sqe_cmd(ioucmd->sqe);
+	struct nvme_ns *ns = nvme_find_path(head,
+			READ_ONCE(cmd->opcode) & 1 ?
+			NVME_STAT_WRITE : NVME_STAT_READ);
 	int ret = -EINVAL;
 
 	if (ns)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 543e17aead12..55dc28375662 100644
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
+	[NVME_IOPOLICY_ADAPTIVE] = "adaptive",
 };
 
 static int iopolicy = NVME_IOPOLICY_NUMA;
@@ -83,6 +87,8 @@ static int nvme_set_iopolicy(const char *val, const struct kernel_param *kp)
 		iopolicy = NVME_IOPOLICY_RR;
 	else if (!strncmp(val, "queue-depth", 11))
 		iopolicy = NVME_IOPOLICY_QD;
+	else if (!strncmp(val, "adaptive", 8))
+		iopolicy = NVME_IOPOLICY_ADAPTIVE;
 	else
 		return -EINVAL;
 
@@ -198,6 +204,204 @@ void nvme_mpath_start_request(struct request *rq)
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
+	int op_type = work->op_type;
+	u64 total_score = 0;
+
+	cpu = get_cpu();
+
+	srcu_idx = srcu_read_lock(&head->srcu);
+	list_for_each_entry_srcu(ns, &head->list, siblings,
+			srcu_read_lock_held(&head->srcu)) {
+
+		stat = &this_cpu_ptr(ns->info)[op_type].stat;
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
+		stat = &this_cpu_ptr(ns->info)[op_type].stat;
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
+static inline u64 ewma_update(u64 old, u64 new)
+{
+	return (old * ((1 << NVME_DEFAULT_ADP_EWMA_SHIFT) - 1)
+			+ new) >> NVME_DEFAULT_ADP_EWMA_SHIFT;
+}
+
+static void nvme_mpath_add_sample(struct request *rq, struct nvme_ns *ns)
+{
+	int cpu;
+	unsigned int op_type;
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
+	op_type = nvme_data_dir(req_op(rq));
+	info = &per_cpu_ptr(ns->info, cpu)[op_type];
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
+	if (now > stat->last_weight_ts &&
+	    (now - stat->last_weight_ts) >= NVME_DEFAULT_ADP_WEIGHT_TIMEOUT) {
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
 void nvme_mpath_end_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
@@ -205,6 +409,9 @@ void nvme_mpath_end_request(struct request *rq)
 	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
 		atomic_dec_if_positive(&ns->ctrl->nr_active);
 
+	if (test_bit(NVME_NS_PATH_STAT, &ns->flags))
+		nvme_mpath_add_sample(rq, ns);
+
 	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
@@ -238,6 +445,62 @@ static const char *nvme_ana_state_names[] = {
 	[NVME_ANA_CHANGE]		= "change",
 };
 
+static void nvme_mpath_reset_adaptive_path_stat(struct nvme_ns *ns)
+{
+	int i, cpu;
+	struct nvme_path_stat *stat;
+
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			stat = &per_cpu_ptr(ns->info, cpu)[i].stat;
+			memset(stat, 0, sizeof(struct nvme_path_stat));
+		}
+	}
+}
+
+void nvme_mpath_cancel_adaptive_path_weight_work(struct nvme_ns *ns)
+{
+	int i, cpu;
+	struct nvme_path_info *info;
+
+	if (!test_bit(NVME_NS_PATH_STAT, &ns->flags))
+		return;
+
+	for_each_online_cpu(cpu) {
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			info = &per_cpu_ptr(ns->info, cpu)[i];
+			cancel_work_sync(&info->work.weight_work);
+		}
+	}
+}
+
+static bool nvme_mpath_enable_adaptive_path_policy(struct nvme_ns *ns)
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
+static bool nvme_mpath_disable_adaptive_path_policy(struct nvme_ns *ns)
+{
+
+	if (!test_and_clear_bit(NVME_NS_PATH_STAT, &ns->flags))
+		return false;
+
+	blk_stat_disable_accounting(ns->queue);
+	blk_queue_flag_clear(QUEUE_FLAG_SAME_FORCE, ns->queue);
+	nvme_mpath_reset_adaptive_path_stat(ns);
+	return true;
+}
+
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
@@ -253,6 +516,8 @@ bool nvme_mpath_clear_current_path(struct nvme_ns *ns)
 			changed = true;
 		}
 	}
+	if (nvme_mpath_disable_adaptive_path_policy(ns))
+		changed = true;
 out:
 	return changed;
 }
@@ -271,6 +536,45 @@ void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl)
 	srcu_read_unlock(&ctrl->srcu, srcu_idx);
 }
 
+int nvme_alloc_ns_stat(struct nvme_ns *ns)
+{
+	int i, cpu;
+	struct nvme_path_work *work;
+	gfp_t gfp = GFP_KERNEL | __GFP_ZERO;
+
+	if (!ns->head->disk)
+		return 0;
+
+	ns->info = __alloc_percpu_gfp(NVME_NUM_STAT_GROUPS *
+			sizeof(struct nvme_path_info),
+			__alignof__(struct nvme_path_info), gfp);
+	if (!ns->info)
+		return -ENOMEM;
+
+	for_each_possible_cpu(cpu) {
+		for (i = 0; i < NVME_NUM_STAT_GROUPS; i++) {
+			work = &per_cpu_ptr(ns->info, cpu)[i].work;
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
+		nvme_mpath_enable_adaptive_path_policy(ns);
+	srcu_read_unlock(&ctrl->srcu, srcu_idx);
+}
+
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 {
 	struct nvme_ns_head *head = ns->head;
@@ -283,6 +587,8 @@ void nvme_mpath_revalidate_paths(struct nvme_ns *ns)
 				 srcu_read_lock_held(&head->srcu)) {
 		if (capacity != get_capacity(ns->disk))
 			clear_bit(NVME_NS_READY, &ns->flags);
+
+		nvme_mpath_reset_adaptive_path_stat(ns);
 	}
 	srcu_read_unlock(&head->srcu, srcu_idx);
 
@@ -407,6 +713,92 @@ static struct nvme_ns *nvme_round_robin_path(struct nvme_ns_head *head)
 	return found;
 }
 
+static inline bool nvme_state_is_live(enum nvme_ana_state state)
+{
+	return state == NVME_ANA_OPTIMIZED || state == NVME_ANA_NONOPTIMIZED;
+}
+
+static struct nvme_ns *nvme_adaptive_path(struct nvme_ns_head *head,
+		unsigned int op_type)
+{
+	struct nvme_ns *ns, *start, *found = NULL;
+	struct nvme_path_stat *stat;
+	u32 weight;
+	int cpu;
+
+	cpu = get_cpu();
+	ns = *this_cpu_ptr(head->adp_path);
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
+	stat = &this_cpu_ptr(ns->info)[op_type].stat;
+
+	/*
+	 * When the head path-list is singular we don't calculate the
+	 * only path weight for optimization as we don't need to forward
+	 * I/O to more than one path. The another possibility is whenthe
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
+		*this_cpu_ptr(head->adp_path) = found;
+	}
+
+	put_cpu();
+	return found;
+}
+
 static struct nvme_ns *nvme_queue_depth_path(struct nvme_ns_head *head)
 {
 	struct nvme_ns *best_opt = NULL, *best_nonopt = NULL, *ns;
@@ -463,9 +855,12 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 	return ns;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
+		unsigned int op_type)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
+	case NVME_IOPOLICY_ADAPTIVE:
+		return nvme_adaptive_path(head, op_type);
 	case NVME_IOPOLICY_QD:
 		return nvme_queue_depth_path(head);
 	case NVME_IOPOLICY_RR:
@@ -525,7 +920,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, nvme_data_dir(bio_op(bio)));
 	if (likely(ns)) {
 		bio_set_dev(bio, ns->disk->part0);
 		bio->bi_opf |= REQ_NVME_MPATH;
@@ -567,7 +962,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (ns)
 		ret = nvme_ns_get_unique_id(ns, id, type);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -583,7 +978,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (ns)
 		ret = nvme_ns_report_zones(ns, sector, nr_zones, cb, data);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -725,6 +1120,9 @@ int nvme_mpath_alloc_disk(struct nvme_ctrl *ctrl, struct nvme_ns_head *head)
 	INIT_WORK(&head->partition_scan_work, nvme_partition_scan_work);
 	INIT_DELAYED_WORK(&head->remove_work, nvme_remove_head_work);
 	head->delayed_removal_secs = 0;
+	head->adp_path = alloc_percpu_gfp(struct nvme_ns*, GFP_KERNEL);
+	if (!head->adp_path)
+		return -ENOMEM;
 
 	/*
 	 * If "multipath_always_on" is enabled, a multipath node is added
@@ -809,6 +1207,10 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	}
 	mutex_unlock(&head->lock);
 
+	mutex_lock(&nvme_subsystems_lock);
+	nvme_mpath_enable_adaptive_path_policy(ns);
+	mutex_unlock(&nvme_subsystems_lock);
+
 	synchronize_srcu(&head->srcu);
 	kblockd_schedule_work(&head->requeue_work);
 }
@@ -857,11 +1259,6 @@ static int nvme_parse_ana_log(struct nvme_ctrl *ctrl, void *data,
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
@@ -1039,10 +1436,12 @@ static void nvme_subsys_iopolicy_update(struct nvme_subsystem *subsys,
 
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
index 102fae6a231c..715c7053054c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -28,7 +28,10 @@ extern unsigned int nvme_io_timeout;
 extern unsigned int admin_timeout;
 #define NVME_ADMIN_TIMEOUT	(admin_timeout * HZ)
 
-#define NVME_DEFAULT_KATO	5
+#define NVME_DEFAULT_KATO		5
+
+#define NVME_DEFAULT_ADP_EWMA_SHIFT	3
+#define NVME_DEFAULT_ADP_WEIGHT_TIMEOUT	(15 * NSEC_PER_SEC)
 
 #ifdef CONFIG_ARCH_NO_SG_CHAIN
 #define  NVME_INLINE_SG_CNT  0
@@ -421,6 +424,7 @@ enum nvme_iopolicy {
 	NVME_IOPOLICY_NUMA,
 	NVME_IOPOLICY_RR,
 	NVME_IOPOLICY_QD,
+	NVME_IOPOLICY_ADAPTIVE,
 };
 
 struct nvme_subsystem {
@@ -459,6 +463,37 @@ struct nvme_ns_ids {
 	u8	csi;
 };
 
+enum nvme_stat_group {
+	NVME_STAT_READ,
+	NVME_STAT_WRITE,
+	NVME_STAT_OTHER,
+	NVME_NUM_STAT_GROUPS
+};
+
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
+	int op_type;			/* op type : READ/WRITE/OTHER */
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
@@ -508,6 +543,9 @@ struct nvme_ns_head {
 	unsigned long		flags;
 	struct delayed_work	remove_work;
 	unsigned int		delayed_removal_secs;
+
+	struct nvme_ns * __percpu	*adp_path;
+
 #define NVME_NSHEAD_DISK_LIVE		0
 #define NVME_NSHEAD_QUEUE_IF_NO_PATH	1
 	struct nvme_ns __rcu	*current_path[];
@@ -534,6 +572,7 @@ struct nvme_ns {
 #ifdef CONFIG_NVME_MULTIPATH
 	enum nvme_ana_state ana_state;
 	u32 ana_grpid;
+	struct nvme_path_info __percpu *info;
 #endif
 	struct list_head siblings;
 	struct kref kref;
@@ -545,6 +584,7 @@ struct nvme_ns {
 #define NVME_NS_FORCE_RO		3
 #define NVME_NS_READY			4
 #define NVME_NS_SYSFS_ATTR_LINK	5
+#define NVME_NS_PATH_STAT		6
 
 	struct cdev		cdev;
 	struct device		cdev_device;
@@ -949,7 +989,17 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
 extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
-struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
+struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int op_type);
+static inline int nvme_data_dir(const enum req_op op)
+{
+	if (op == REQ_OP_READ)
+		return NVME_STAT_READ;
+	else if (op_is_write(op))
+		return NVME_STAT_WRITE;
+	else
+		return NVME_STAT_OTHER;
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
@@ -972,12 +1022,14 @@ void nvme_mpath_init_ctrl(struct nvme_ctrl *ctrl);
 void nvme_mpath_update(struct nvme_ctrl *ctrl);
 void nvme_mpath_uninit(struct nvme_ctrl *ctrl);
 void nvme_mpath_stop(struct nvme_ctrl *ctrl);
+void nvme_mpath_cancel_adaptive_path_weight_work(struct nvme_ns *ns);
 bool nvme_mpath_clear_current_path(struct nvme_ns *ns);
 void nvme_mpath_revalidate_paths(struct nvme_ns *ns);
 void nvme_mpath_clear_ctrl_paths(struct nvme_ctrl *ctrl);
 void nvme_mpath_remove_disk(struct nvme_ns_head *head);
 void nvme_mpath_start_request(struct request *rq);
 void nvme_mpath_end_request(struct request *rq);
+int nvme_alloc_ns_stat(struct nvme_ns *ns);
 
 static inline void nvme_trace_bio_complete(struct request *req)
 {
@@ -1005,6 +1057,13 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
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
@@ -1096,6 +1155,17 @@ static inline bool nvme_mpath_queue_if_no_path(struct nvme_ns_head *head)
 {
 	return false;
 }
+static inline void nvme_mpath_cancel_adaptive_path_weight_work(
+		struct nvme_ns *ns)
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
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index ca6a74607b13..7aca2186c462 100644
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
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (ns) {
 		c->common.nsid = cpu_to_le32(ns->head->ns_id);
 		ret = nvme_submit_sync_cmd(ns->queue, c, data, data_len);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..1cbab90ed42e 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -194,7 +194,7 @@ static int ns_head_update_nuse(struct nvme_ns_head *head)
 		return 0;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (!ns)
 		goto out_unlock;
 
-- 
2.51.0


