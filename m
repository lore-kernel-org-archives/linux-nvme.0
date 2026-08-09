Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26980C5AC80
	for <linux-nvme@archiver.kernel.org>; Sun,  9 Aug 2026 10:09:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=vHEWfg1oX4NIvwhZWwIWUWtHqXtlKChKW4q6i3yFANQ=; b=Ta7oOOpHNnnoNJ7n6vk3K1a8Iu
	ka1l74+e4rrROxBtJM7qMstIcMTnufe3jOVwMylwn2cyow/0WQkbgN20s6bZOrL44S6OqceMWPoIv
	y4h8T+yN1JWJEVFBURwhpzEmf/RtWpy1SIrcaE4Mft+FlFq01Ez21ovh/pK4iXkgwgyS2zpH/ygjV
	aux+X3YpqIFJ9yzR/1yuxP4IzJ6ao/Yb64k0CX6V5GD3uZvnoE7ElYCbIYukFyW9XBLwmcW5GOWrh
	1IDUaxtlIPPmJLiU3v0jXUqtJjlTHnOGUt3Wr92ih5Lj87srtBLd0zfwR2bxxOXFXhO2sj+EOEZt1
	ufCH0c8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sq-0000000AAgf-1cIf;
	Sun, 09 Aug 2026 10:09:08 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wt0Sm-0000000AAea-3QJ3
	for linux-nvme@lists.infradead.org;
	Sun, 09 Aug 2026 10:09:06 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67991xBe2605374;
	Sun, 9 Aug 2026 10:09:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=vHEWfg1oX4NIvwhZW
	wIWUWtHqXtlKChKW4q6i3yFANQ=; b=cXSFNAj+hf7xLCcVatBlezxVhOtS1+/6h
	r5rhlBfknIB/PYXDZhwzhcn0Qwojx8h0UZ4CRWhQhE1ggJnAIQ5o7SNRxAYWbSvl
	7pwiyWujoN5i/fgyjUDo2uhnRZ3L1cFS69bTgNNnW2SSYjFHiCxPMN90cVUAequ/
	ZdN1q512Q0oADBRk8Gr7iYDHgQdqmjP/zdx1/oop/M8nYVy/4NtlrtFpU0Ev1SqL
	/6DMPtFjC6YzsxrGsK+2XGmcCuksPfUBhZEI96I0D2qADhlaIwRWLV7nTS6iHFd1
	nEQOs/Z2Qfs0N3QXGHN0twNAW4cipRQ4hGcfr0wZ1hGIsbS1ax6qw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fwvnvumpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:09:00 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6799uOC4030458;
	Sun, 9 Aug 2026 10:08:59 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fxf5vs475-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Aug 2026 10:08:59 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 679A8twn39977234
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 9 Aug 2026 10:08:55 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A6C2C20043;
	Sun,  9 Aug 2026 10:08:55 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id B00E620040;
	Sun,  9 Aug 2026 10:08:52 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.73.213])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun,  9 Aug 2026 10:08:52 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org
Cc: hare@suse.de, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me,
        dwagner@suse.de, kanie@linux.alibaba.com, jmeneghi@redhat.com,
        randyj@purestorage.com, martin.petersen@oracle.com,
        john.g.garry@oracle.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v7 3/9] nvme-multipath: pass I/O type to nvme_find_path()
Date: Sun,  9 Aug 2026 15:37:58 +0530
Message-ID: <20260809100825.2014133-4-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809100825.2014133-1-nilay@linux.ibm.com>
References: <20260809100825.2014133-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=RsP16imK c=1 sm=1 tr=0 ts=6a7851bc cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=5trHZi3AoRbtZWZe9cAA:9
X-Proofpoint-GUID: gkoFdJxQ0GSjbFVFg_hgQABhYT-bCI3w
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfXw1HdD1SIl5wI
 Nu0EdIfOdq15G3QUZPMTu/lMSbjK5Ntm/m57XEm4kNjw1T7bJtL2jU6K1QFILcjx9jXBvnFhBBU
 /60cOwZhnqc0wmjrPOqmPBBa/wO/sDF+qYUmRdKlzjXWR0wIhe/MtHjkssrRFKipBuHgvJLz/mP
 y9N6UZ2ZRMbD3BKsuHZUEgg5n4Mit6XDN6Gwc+emXDWxt8TQ0/fOiEyey70W6XLhTGkidjEjI8F
 f1DbBAjYQxfCldoxBx9/AvDfSixtkpuhcgwQs6JARdb53FW8DKMxwanwslx6NS73nXD23fzpyYX
 wqv+ghC+X2DdXVo9FZ9e2UvR3MYIS5VoPNkOZJLdm7blCCkJfZygnUaZ6BVX6FPwwahxpb4jB9J
 584S+yS3HOle0yiHQbesU+RMwXskX6YhPraxDFIcs9M5pmL/DPL4TZ6UQr3+UOQZZIe6sOEclbM
 gXPPzcXYO7OrEeXV4Pw==
X-Proofpoint-ORIG-GUID: BPgR_SSnXhLmx7l1oy4B0Nd2aPEI-acW
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA5MDA4OCBTYWx0ZWRfX+ZT0bXSjVEk7
 vadfYVuq9CINUJ7fOoy4PDfakxF4DskR7LIRlXFflS0+2xm7LlrbCKonV4j4LcJTFz24cmSisFF
 odrrp7aQUCv8s2wG/wbmjodDarOGLYc=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-09_03,2026-08-07_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 spamscore=0 impostorscore=0 suspectscore=0 clxscore=1011 malwarescore=0
 phishscore=0 adultscore=0 lowpriorityscore=0 priorityscore=1501 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608090088
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260809_030904_993011_B2DB5DBD 
X-CRM114-Status: GOOD (  23.98  )
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

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/ioctl.c     | 38 +++++++++++++++++++++++++++++---
 drivers/nvme/host/multipath.c |  9 ++++----
 drivers/nvme/host/nvme.h      | 41 ++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/pr.c        |  6 +++--
 drivers/nvme/host/sysfs.c     |  2 +-
 5 files changed, 85 insertions(+), 11 deletions(-)

diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 664216eece4a..8a8ed132fab2 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -708,18 +708,29 @@ static int nvme_ns_head_ctrl_ioctl(struct nvme_ns *ns, unsigned int cmd,
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
 
@@ -741,6 +752,7 @@ int nvme_ns_head_ioctl(struct block_device *bdev, blk_mode_t mode,
 long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
 		unsigned long arg)
 {
+	u8 opcode;
 	bool open_for_write = file->f_mode & FMODE_WRITE;
 	struct cdev *cdev = file_inode(file)->i_cdev;
 	struct nvme_ns_head *head =
@@ -748,9 +760,19 @@ long nvme_ns_head_chr_ioctl(struct file *file, unsigned int cmd,
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
 
@@ -770,9 +792,19 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 	struct cdev *cdev = file_inode(ioucmd->file)->i_cdev;
 	struct nvme_ns_head *head = container_of(cdev, struct nvme_ns_head, cdev);
 	int srcu_idx = srcu_read_lock(&head->srcu);
-	struct nvme_ns *ns = nvme_find_path(head);
+	struct nvme_ns *ns;
 	int ret = -EINVAL;
+	const struct nvme_uring_cmd *cmd = io_uring_sqe128_cmd(ioucmd->sqe,
+						struct nvme_uring_cmd);
+	unsigned int op_type = NVME_STAT_OTHER;
+	__u8 opcode = READ_ONCE(cmd->opcode);
+
+	if (opcode == nvme_cmd_write)
+		op_type = NVME_STAT_WRITE;
+	else if (opcode == nvme_cmd_read)
+		op_type = NVME_STAT_READ;
 
+	ns = nvme_find_path(head, op_type);
 	if (ns)
 		ret = nvme_ns_uring_cmd(ns, ioucmd, issue_flags);
 	srcu_read_unlock(&head->srcu, srcu_idx);
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 9b9a657fa330..8c20ff516e61 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -460,7 +460,8 @@ static struct nvme_ns *nvme_numa_path(struct nvme_ns_head *head)
 	return ns;
 }
 
-inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head)
+inline struct nvme_ns *nvme_find_path(struct nvme_ns_head *head,
+		unsigned int op_type)
 {
 	switch (READ_ONCE(head->subsys->iopolicy)) {
 	case NVME_IOPOLICY_QD:
@@ -522,7 +523,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 		return;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, __nvme_data_dir(bio_op(bio)));
 	if (likely(ns)) {
 		bio_set_dev(bio, ns->disk->part0);
 		/*
@@ -572,7 +573,7 @@ static int nvme_ns_head_get_unique_id(struct gendisk *disk, u8 id[16],
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (ns)
 		ret = nvme_ns_get_unique_id(ns, id, type);
 	srcu_read_unlock(&head->srcu, srcu_idx);
@@ -588,7 +589,7 @@ static int nvme_ns_head_report_zones(struct gendisk *disk, sector_t sector,
 	int srcu_idx, ret = -EWOULDBLOCK;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (ns)
 		ret = nvme_ns_report_zones(ns, sector, nr_zones, args);
 	srcu_read_unlock(&head->srcu, srcu_idx);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..8a9ec502912d 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -520,6 +520,13 @@ struct nvme_ns_ids {
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
@@ -1032,7 +1039,39 @@ extern const struct attribute_group *nvme_dev_attr_groups[];
 extern const struct block_device_operations nvme_bdev_ops;
 
 void nvme_delete_ctrl_sync(struct nvme_ctrl *ctrl);
-struct nvme_ns *nvme_find_path(struct nvme_ns_head *head);
+struct nvme_ns *nvme_find_path(struct nvme_ns_head *head, unsigned int op_type);
+
+static inline int __nvme_data_dir(const enum req_op op)
+{
+	if (op == REQ_OP_READ)
+		return NVME_STAT_READ;
+	else if (op == REQ_OP_WRITE)
+		return NVME_STAT_WRITE;
+	else
+		return NVME_STAT_OTHER;
+}
+
+static inline int __nvme_data_dir_passthru(enum nvme_opcode op)
+{
+	if (op == nvme_cmd_read)
+		return NVME_STAT_READ;
+	else if (op == nvme_cmd_write)
+		return NVME_STAT_WRITE;
+	else
+		return NVME_STAT_OTHER;
+}
+
+static inline int nvme_data_dir(struct request *req)
+{
+	if (blk_rq_is_passthrough(req)) {
+		struct nvme_request *nr = nvme_req(req);
+
+		return __nvme_data_dir_passthru(nr->cmd->common.opcode);
+	}
+
+	return __nvme_data_dir(req_op(req));
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
index 75b2d69b5957..b2034e033ac3 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -195,7 +195,7 @@ static int ns_head_update_nuse(struct nvme_ns_head *head)
 		return 0;
 
 	srcu_idx = srcu_read_lock(&head->srcu);
-	ns = nvme_find_path(head);
+	ns = nvme_find_path(head, NVME_STAT_OTHER);
 	if (!ns)
 		goto out_unlock;
 
-- 
2.53.0


