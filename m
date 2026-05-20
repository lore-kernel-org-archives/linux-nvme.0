Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF48FCD5BAA
	for <linux-nvme@archiver.kernel.org>; Wed, 20 May 2026 18:21:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2KS57sObNhEdsyE1mB1CKyAd7rno08Xv2CcneVi1974=; b=DuP5MhmGDGUn5PV4w96At8MqXf
	gGIyf8591oSSBzPt0K3GkJjtJhc4gMjOst82oC9H5ILNoV0BJx+pi6YEB6RXGICgI5GV2H9XOwo/K
	NZEsGoTJO441BGeaufAn+gixiTsWY/uRzDNUW+oHGtfEahpY9shTuku+RyEAEtMl/cIjk64TXoMyv
	vP6d1H4Q9lu5O4hKn6Da/NJhSRT6lF5/6NQj6p7TAwU8SfqspYDYO1n9GCaTknDEabD6r/Ai/9u/W
	/0PbgMVSCsNiCIosJYrQBWHCXS0tBUxTvrG0COWNebFIRVp279VA1R3fpTZd+1c15xEyFvwX3Er6L
	8VyrMXmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlY7-00000005QBD-1NTH;
	Wed, 20 May 2026 18:21:43 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wPlY4-00000005Q9L-42ql
	for linux-nvme@lists.infradead.org;
	Wed, 20 May 2026 18:21:42 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 64KDtCLt069859;
	Wed, 20 May 2026 18:21:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=2KS57sObNhEdsyE1m
	B1CKyAd7rno08Xv2CcneVi1974=; b=hN7IAM5LtB6meK1i/erQrFjcndIrMSvYO
	P64Qx+rCuGoDwdzeJpwtgPYFVgkvL66tRFaeG/rrT5O7OULa8bRLxzmc6PJM7GOY
	P8/uTI5QFWUlA6WWrA7U8eBOFHTmzbjlBNxVsJzy2Vpifqkzj9dbSQtULCVrxf2v
	BfGO1KwRSlILMx+XRHVa+xtTcxuwlKCKhcbv7yiEHQPiTxI+6HcdGfXckBF2ie+4
	hW7IVYAUeHx7FPKSQAgSvdKRwk+HRvFe0YVoHpVXAywgwg2gN0Tm3yoj0pvxB52Y
	JYm/sCsij3AOBfQRbFzaWi4ScK1GyMvTgBJJGXn1rkHWgpvV6Nk+g==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4e6h8mubqj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:35 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 64KI97g4023324;
	Wed, 20 May 2026 18:21:34 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4e75ky89jd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 May 2026 18:21:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 64KILXq449283518
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 18:21:33 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EFD922004B;
	Wed, 20 May 2026 18:21:32 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2060A20040;
	Wed, 20 May 2026 18:21:26 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.61.40.237])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 20 May 2026 18:21:25 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com
Subject: [PATCHv6 2/8] nvme-multipath: pass I/O type to nvme_find_path()
Date: Wed, 20 May 2026 23:50:58 +0530
Message-ID: <20260520182112.863076-3-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260520182112.863076-1-nilay@linux.ibm.com>
References: <20260520182112.863076-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: YQloSy5jjGhs-6QfLyCO0cd9C1Rek283
X-Authority-Analysis: v=2.4 cv=GYMnWwXL c=1 sm=1 tr=0 ts=6a0dfbb0 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=NGcC8JguVDcA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=5trHZi3AoRbtZWZe9cAA:9
X-Proofpoint-ORIG-GUID: ebTCB7mUrcWU1pYRrBRq60al42ohU1ll
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTIwMDE3NyBTYWx0ZWRfX2WW2UAssBwAg
 i0hCnNwIBZm//TW/LwlmLlE0w7JNyg9DLvzMrX1EYGbyiAkgW4f7ETYtxsNqG9NKtEf5LksGSTS
 U4nU4NPZp+Qist5j4xyN8++ZDpxCJWRY0SdLeoovQ/JMb3tVBtPFoJEug/fACUUNv/9mv1bhgdV
 0CLOyFPFlrVs1AftfPfWyT27zwB9yEkOk69eq+hXSwGPCvTEJxVfHVvbTv5fBrz/ytVSpW1xFH+
 XD6S3dQ351U8eQeDQJP0oRN5ORaq274iS+D2Xsw/4hRmB2s7/saU+q9PwIPZAQW29oGwVPq+x8G
 0ru8rJLcGEHjMmAz3VpG2vwyRwagHvEfeG4Ms9+kkOCX0m+fTsn/BRHNzNpz+BmIV8cPoUkW8tD
 kdh0Dz/mRZjzhK8GW4wQZj1wJVmRA2ZyshGfThTXOgezrxdTaRquZ4znvt/6B6N2E0Ud91uiuLz
 ZriczEn/8mTjquulmDQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-05-20_03,2026-05-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 suspectscore=0 spamscore=0 clxscore=1011 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605130000 definitions=main-2605200177
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260520_112141_011464_F7C197B5 
X-CRM114-Status: GOOD (  23.35  )
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
the I/O type. This patch does not introduce any functional change and
only prepares the interface for subsequent latency-policy changes.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/ioctl.c     | 38 ++++++++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c |  9 +++++----
 drivers/nvme/host/nvme.h      | 19 +++++++++++++++++-
 drivers/nvme/host/pr.c        |  6 ++++--
 drivers/nvme/host/sysfs.c     |  2 +-
 5 files changed, 63 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 08889b20e5d8..7a9043350227 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -699,18 +699,29 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
 
@@ -732,6 +743,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
+	u8 opcode;
 	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct cdev *cdev = file_inode(file)->i_cdev;
 	struct nvme_ns_head *head =
@@ -739,9 +751,19 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
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
 
@@ -761,7 +783,17 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
+	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
+						struct nvme_uring_cmd);
+	__u8 opcode = READ_ONCE(cmd->opcode);
+	unsigned int op_type = NVME_STAT_OTHER;
+
+	if (opcode == nvme_cmd_write)
+		op_type = NVME_STAT_WRITE;
+	else if (opcode == nvme_cmd_read)
+		op_type = NVME_STAT_READ;
+
+	struct nvme_ns *ns = nvme_find_path(head, op_type);
 	int ret = -EINVAL;
 
 	if (ns)
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..90f449780e72 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -446,7 +446,8 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 	return ns;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
+		unsigned int op_type)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
 	case NVME_IOPOLICY_QD:
@@ -508,7 +509,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, nvme_data_dir(bio_op(bio)));
 	if (likely(ns)) {
 		bio_set_dev(bio, ns->disk->part0);
 		bio->bi_opf |= REQ_NVME_MPATH;
@@ -550,7 +551,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (ns)
 		ret = nvme_ns_get_unique_id(ns, id, type);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -566,7 +567,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (ns)
 		ret = nvme_ns_report_zones(ns, sector, nr_zones, args);
 	srcu_read_unlock(&head->srcu, srcu_idx);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..39e986e5f184 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -514,6 +514,13 @@ struct nvme_ns_ids {
 	u8	csi;
 };
 
+enum nvme_stat_group {
+	NVME_STAT_READ,
+	NVME_STAT_WRITE,
+	NVME_STAT_OTHER,
+	NVME_NUM_STAT_GROUPS
+};
+
 /*
  * Anchor structure for namespaces.  There is one for each namespace in a
  * NVMe subsystem that any of our controllers can see, and the namespace
@@ -1017,7 +1024,17 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
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
diff --git a/drivers/nvme/host/pr.c b/drivers/nvme/host/pr.c
index fe7dbe264815..80e106f151d2 100644
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
index e59758616f27..b6b718bd310d 100644
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
2.53.0


