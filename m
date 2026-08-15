Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4B64C5CFDB
	for <linux-nvme@archiver.kernel.org>; Sat, 15 Aug 2026 17:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=65yliJeKk8MctAIzlQaj1GrwA5nKNGRwW4osQnNMFj4=; b=ZKCKF6UO+eHMYZkj1JCWsXH7pm
	csJVoonsa+PA+Fmf/ARlULqBWcHWe8werZBntICre1hgC88dmcYYG0uqpvVFkocYSjg3vmU5F2kGP
	cJyaqFIj6OzqQHjuUgwzv0DIn691iyPfntfxG6JQjWlUt8GWAqP2frJo5Ag7lXozSnjuL0gAeTSTt
	ZUpzFsWtlTOB+/XafCH1ZSS3LxCbRbkoWJ4ktbv8CM0OH2V8YnYrWAgazZ4Wt2XCGAUG8OXkMwOrV
	6DSwATgZMlsKbFwyJMamTnmCxTR1XXHwYbQvPlcJ+O8dZSv35umUjVwLp6xzhixtwUuLgZFz8j0TO
	+JBB8j/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIIi-00000003ziR-1kuK;
	Sat, 15 Aug 2026 17:36:08 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wvIId-00000003zgC-0FNj
	for linux-nvme@lists.infradead.org;
	Sat, 15 Aug 2026 17:36:04 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67FGVjGb2640033;
	Sat, 15 Aug 2026 17:35:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=65yliJeKk8MctAIzl
	Qaj1GrwA5nKNGRwW4osQnNMFj4=; b=JihKMrcHsfqBPjY/C4duYfzR1SSgbbpHe
	NROkbQsVKTF8yMBM4KLR1q7kj1W9FMuOZ41it6tvEjqgG0zzFizIGedFKMxjeSk5
	+mIlxlkfqQaZHfA4DxnCj7dqwmsvRtE8alwe1d+RWmZbcbU1QbVAqFPKWLnVj8cb
	9FW5pWfF/ZYWFBwZnePkT75CtQ5pNLRDy2e8hA9huognLMIHcVY79VxMOZSq7q1L
	eXFFnqAEzU3AYkQpn32LpZoWKS69dMLIT8Vg6IOmGjPD13m5Fxx3fK8JtC62Rlfe
	ow3h8D/rLs8kd0XEe4Ra5MIzLkplnN6uc3yyIcfV8SY9greX1xVqw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2fsqa7ga-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67FHQMVV026249;
	Sat, 15 Aug 2026 17:35:50 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxfskc101-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 15 Aug 2026 17:35:50 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67FHZmwS51183896
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 15 Aug 2026 17:35:48 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8115320043;
	Sat, 15 Aug 2026 17:35:48 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7AD1F20040;
	Sat, 15 Aug 2026 17:35:43 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.9.204])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sat, 15 Aug 2026 17:35:43 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCH v8 04/10] nvme-multipath: pass I/O type to nvme_find_path()
Date: Sat, 15 Aug 2026 23:04:26 +0530
Message-ID: <20260815173502.1185929-5-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260815173502.1185929-1-nilay@linux.ibm.com>
References: <20260815173502.1185929-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX0BA2vZHT2Uwi
 quBRde787tP0YESdhs1tRBSdBS2T9eSQ1bvW6Sq8iiLf7x/rEhQp8WVSkUry5Ixwii/sdW9Zg+u
 taZ9m9f04wJsd+MhSiagb6VPVFDTcCqHQ23XS9IvqeuEilVIJsTvFmq2bfzTE0uS/yCOLQW4uth
 1qJ6p9BXKaJWE1sNZX9WpI95jaBgTAMqFrL8W+cEpPrFA4V8ZRPW/E4e93Quwg5ULIJuv+kul7d
 9BtCmL8qSPuOUx3mgSHMVIuURPwfZ3Yo9fcMmU+VDvbXxYtsULn3WLEYFRHvvBSrev3uZG/e7tp
 ah4VmOSt6OyBilpYvuJttXQtZX28Qu/JiaTTkwUC1TglSiAFF5T0dsBxWgmMmhxBrB2FKWIHUcw
 WqEMiAZEm9pXdlEoTh6yBR1wkfLcrxTWdVWqQZx8YKGxhCn/m0G664OjazgI+GowXEK/9wbuAM7
 7FSzjXvGJf+bUUuLQEQ==
X-Proofpoint-ORIG-GUID: Hz4iU6b4lxu4S_Wnfwtup4Yj286Zu4GS
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE1MDEzMCBTYWx0ZWRfX1Z+qiQsTg4l8
 5SFLOMIwBGBGNm8ud6+uJOmcP2g6xPzwwPlG2no1XzfDIuZZA6JQyY+3/BMhKG0kAu0IcOz+Rkp
 +8ZQfa3k/o34Oy4xI/nuRM3ODSygMPI=
X-Authority-Analysis: v=2.4 cv=DJe/JSNb c=1 sm=1 tr=0 ts=6a80a378 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=SRrdq9N9AAAA:8 a=VnNF1IyMAAAA:8
 a=we6Qoqlb9_Q2I3Q12V0A:9
X-Proofpoint-GUID: B90NR3t1Oyq9d0SZWavGuneIYcZHQSDr
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-15_05,2026-08-12_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 priorityscore=1501 impostorscore=0 spamscore=0 clxscore=1015 bulkscore=0
 suspectscore=0 malwarescore=0 phishscore=0 adultscore=0 lowpriorityscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608150130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260815_103603_107134_CC277832 
X-CRM114-Status: GOOD (  23.43  )
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

Currently, nvme_find_path() only accepts an nvme_ns_head argument.
However, the upcoming latency-aware I/O policy also needs to know
the I/O type (read/write/other) associated with the request in order
to make path selection decisions.

Update nvme_find_path() to accept an additional argument describing
the I/O type. Classify requests into three categories: READ, WRITE,
and OTHER. Admin commands and I/O requests that are neither reads nor
writes are classified as OTHER.

This patch does not introduce any functional change and only prepares
the interface for subsequent latency-policy changes.

Reviewed-by: Guixin Liu <kanie@linux.alibaba.com>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/ioctl.c     | 44 +++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c |  9 ++++---
 drivers/nvme/host/nvme.h      | 50 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pr.c        |  6 +++--
 drivers/nvme/host/sysfs.c     |  2 +-
 5 files changed, 100 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 6539d4750098..b0538ed2adbc 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -751,12 +751,25 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
 	unsigned int flags = 0;
+	unsigned int op_type = NVME_STAT_GROUP_OTHER;
 
 	if (bdev_is_partition(bdev))
 		flags |= NVME_IOCTL_PARTITION;
 
+	if (cmd == NVME_IOCTL_SUBMIT_IO) {
+		u8 opcode;
+
+		if (get_user(opcode, (u8 *)argp))
+			return -EFAULT;
+
+		if (opcode == nvme_cmd_write)
+			op_type = NVME_STAT_GROUP_WRITE;
+		else if (opcode == nvme_cmd_read)
+			op_type = NVME_STAT_GROUP_READ;
+	}
+
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, op_type);
 	if (!ns)
 		goto out_unlock;
 
@@ -785,9 +798,22 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 	void __user *argp = (void __user *)arg;
 	struct nvme_ns *ns;
 	int srcu_idx, ret = -EWOULDBLOCK;
+	unsigned int op_type = NVME_STAT_GROUP_OTHER;
+
+	if (cmd == NVME_IOCTL_SUBMIT_IO) {
+		u8 opcode;
+
+		if (get_user(opcode, (u8 *)argp))
+			return -EFAULT;
+
+		if (opcode == nvme_cmd_write)
+			op_type = NVME_STAT_GROUP_WRITE;
+		else if (opcode == nvme_cmd_read)
+			op_type = NVME_STAT_GROUP_READ;
+	}
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, op_type);
 	if (!ns)
 		goto out_unlock;
 
@@ -804,12 +830,24 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 		unsigned int issue_flags)
 {
+	struct nvme_ns *ns;
+	unsigned int op_type;
 	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
 	int ret = -EINVAL;
+	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
+						struct nvme_uring_cmd);
+	__u8 opcode = READ_ONCE(cmd->opcode);
+
+	if (opcode == nvme_cmd_write)
+		op_type = NVME_STAT_GROUP_WRITE;
+	else if (opcode == nvme_cmd_read)
+		op_type = NVME_STAT_GROUP_READ;
+	else
+		op_type = NVME_STAT_GROUP_OTHER;
 
+	ns = nvme_find_path(head, op_type);
 	if (ns)
 		ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
 	srcu_read_unlock(&head->srcu, srcu_idx);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..95768eaef843 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -484,7 +484,8 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 	return ns;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
+		enum nvme_stat_group op_type)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
 	case NVME_IOPOLICY_QD:
@@ -547,7 +548,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, __nvme_get_stat_group(bio_op(bio)));
 	if (likely(ns)) {
 		bio_set_dev(bio, ns->disk->part0);
 		/*
@@ -597,7 +598,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_GROUP_OTHER);
 	if (ns)
 		ret = nvme_ns_get_unique_id(ns, id, type);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -613,7 +614,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_GROUP_OTHER);
 	if (ns)
 		ret = nvme_ns_report_zones(ns, sector, nr_zones, args);
 	srcu_read_unlock(&head->srcu, srcu_idx);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75e5d5a8a77c..5af272cf2f49 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -531,6 +531,20 @@ struct nvme_ns_ids {
 	u8	csi;
 };
 
+/*
+ * Enum used to classify NVMe I/O type into a stat group. Read and write
+ * I/Os are classified as NVME_STAT_GROUP_READ and NVME_STAT_GROUP_WRITE
+ * respectively; all other I/Os or admin commands are classified as
+ * NVME_STAT_GROUP_OTHER.
+ */
+enum nvme_stat_group {
+	NVME_STAT_GROUP_READ,
+	NVME_STAT_GROUP_WRITE,
+	NVME_STAT_GROUP_OTHER,
+
+	NVME_NUM_STAT_GROUPS
+};
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -1046,8 +1060,42 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
 extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
-struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
+		enum nvme_stat_group op_type)
 	__must_hold_shared(&head->srcu);
+
+static inline enum nvme_stat_group __nvme_get_stat_group(const enum req_op op)
+{
+	if (op == REQ_OP_READ)
+		return NVME_STAT_GROUP_READ;
+	else if (op == REQ_OP_WRITE)
+		return NVME_STAT_GROUP_WRITE;
+	else
+		return NVME_STAT_GROUP_OTHER;
+}
+
+static inline enum nvme_stat_group __nvme_get_passthru_stat_group(
+		enum nvme_opcode op)
+{
+	if (op == nvme_cmd_read)
+		return NVME_STAT_GROUP_READ;
+	else if (op == nvme_cmd_write)
+		return NVME_STAT_GROUP_WRITE;
+	else
+		return NVME_STAT_GROUP_OTHER;
+}
+
+static inline enum nvme_stat_group nvme_get_stat_group(struct request *req)
+{
+	if (blk_rq_is_passthrough(req)) {
+		struct nvme_request *nr = nvme_req(req);
+
+		return __nvme_get_passthru_stat_group(nr->cmd->common.opcode);
+	}
+
+	return __nvme_get_stat_group(req_op(req));
+}
+
 #ifdef CONFIG_NVME_MULTIPATH
 static inline bool nvme_ctrl_use_ana(struct nvme_ctrl *ctrl)
 {
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe264815..715e6c242bd1 100644
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
+	ns = nvme_find_path(head, NVME_STAT_GROUP_OTHER);
 	if (ns) {
 		c->common.nsid = cpu_to_le32(ns->head->ns_id);
 		ret = nvme_submit_sync_cmd(ns->queue, c, data, data_len);
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index abf8edaae371..e95543fecb2a 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -195,7 +195,7 @@ static int ns_head_update_nuse(struct nvme_ns_head *head)
 		return 0;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_GROUP_OTHER);
 	if (!ns)
 		goto out_unlock;
 
-- 
2.53.0


