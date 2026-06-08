Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70AF0CD8C9D
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Jun 2026 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jrvOoXSmBdTKpON/3WgE1RUXRa7QviQ26ZSUHE6GBfI=; b=o2mhgpowJ8Q18ViLqS/npNcRYC
	R9xOCrFxMQU9WlqDdpDV+Y63hqJYgzplFrP+3VoDe8TnvLxMGAx8hoMuPWDxqUuVq4Nc+VMAXoeKn
	meCJs3lu6DmvHmUIdjpzSOn0KM99UvQBVUTcOZvQEjnThzHVtT7Elb/A2zMqvNCzQhzTMeEFPKl/6
	6ElPKwX2QZ0WTifvB9YhpoD9c+P0mZ18ngK8DWfckTrbbABqWIPfJZKn2IqdccTnhmAjOWIyLRm5+
	EUMfc4Qdxfk17kno5Wvx8Cj2AHmGUzJPI5OKYpa4PZ1ItfdpLSgY+/OAvADCAoCLhkD+1QZoDJmSy
	2seFQVAg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYJl-00000003RMS-1YZV;
	Mon, 08 Jun 2026 11:38:57 +0000
Received: from dggsgout12.his.huawei.com ([45.249.212.56])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wWYJh-00000003RKq-46L1
	for linux-nvme@lists.infradead.org;
	Mon, 08 Jun 2026 11:38:56 +0000
Received: from mail.maildlp.com (unknown [172.19.163.170])
	by dggsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gYqmK384yzKHMw9
	for <linux-nvme@lists.infradead.org>; Mon,  8 Jun 2026 19:38:09 +0800 (CST)
Received: from mail02.huawei.com (unknown [10.116.40.112])
	by mail.maildlp.com (Postfix) with ESMTP id 4ACE24056F
	for <linux-nvme@lists.infradead.org>; Mon,  8 Jun 2026 19:38:43 +0800 (CST)
Received: from huaweicloud.com (unknown [10.50.87.132])
	by APP1 (Coremail) with SMTP id cCh0CgAndzzBqSZqe2I+BA--.24728S5;
	Mon, 08 Jun 2026 19:38:43 +0800 (CST)
From: Ye Bin <yebin@huaweicloud.com>
To: kbusch@kernel.org,
	axboe@kernel.dk,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org,
	yebin@huaweicloud.com,
	yebin10@huawei.com
Subject: [PATCH 1/2] nvme: operate nvme_request->flags with atomic api
Date: Mon,  8 Jun 2026 19:34:24 +0800
Message-Id: <20260608113425.3836619-2-yebin@huaweicloud.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260608113425.3836619-1-yebin@huaweicloud.com>
References: <20260608113425.3836619-1-yebin@huaweicloud.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: cCh0CgAndzzBqSZqe2I+BA--.24728S5
X-Coremail-Antispam: 1UD129KBjvJXoW3WryfGF13Gryxtw13CryxAFb_yoWfCFy5pF
	40qayYyrZrWF18trWDJayDZFZYkw10yrWxAa1xKw45Z3W5trWrAr1vkFyFqrn3GFWkur1f
	XFW8JrsrZF12qa7anT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDU0xBIdaVrnRJUUUBG14x267AKxVW5JVWrJwAFc2x0x2IEx4CE42xK8VAvwI8IcIk0
	rVWrJVCq3wAFIxvE14AKwVWUJVWUGwA2048vs2IY020E87I2jVAFwI0_Jr4l82xGYIkIc2
	x26xkF7I0E14v26r1I6r4UM28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48ve4kI8wA2z4x0
	Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI0_Gr1j6F4UJw
	A2z4x0Y4vEx4A2jsIE14v26rxl6s0DM28EF7xvwVC2z280aVCY1x0267AKxVW0oVCq3wAS
	0I0E0xvYzxvE52x082IY62kv0487Mc02F40EFcxC0VAKzVAqx4xG6I80ewAv7VC0I7IYx2
	IY67AKxVWUJVWUGwAv7VC2z280aVAFwI0_Jr0_Gr1lOx8S6xCaFVCjc4AY6r1j6r4UM4x0
	Y48IcxkI7VAKI48JM4x0x7Aq67IIx4CEVc8vx2IErcIFxwCY1x0262kKe7AKxVWUAVWUtw
	CF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j
	6r18MI8I3I0E7480Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_JF0_Jw1lIxkGc2Ij64
	vIr41lIxAIcVC0I7IYx2IY67AKxVWUJVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_
	Cr1lIxAIcVCF04k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r1j6r4UMIIF0x
	vEx4A2jsIEc7CjxVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x0JUfDGrUUUUU=
X-CM-SenderInfo: p1hex046kxt4xhlfz01xgou0bp/
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260608_043854_402892_132C8DAE 
X-CRM114-Status: GOOD (  18.07  )
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

From: Ye Bin <yebin10@huawei.com>

This patch does not change any function. The nvme_request->flags is
converted to the unsigned long type and the atomic operation interface
is used. This prevents the status exception caused by concurrent
operations on flags. In addition, this is also a preparation for fixing
the problem that I/Os are processed twice in the done phase.

Signed-off-by: Ye Bin <yebin10@huawei.com>
---
 drivers/nvme/host/apple.c     |  4 ++--
 drivers/nvme/host/core.c      |  7 ++++---
 drivers/nvme/host/fc.c        |  2 +-
 drivers/nvme/host/ioctl.c     |  4 ++--
 drivers/nvme/host/multipath.c | 12 ++++++------
 drivers/nvme/host/nvme.h      | 10 +++++-----
 drivers/nvme/host/pci.c       | 11 ++++++-----
 7 files changed, 26 insertions(+), 24 deletions(-)

diff --git a/drivers/nvme/host/apple.c b/drivers/nvme/host/apple.c
index 423c9c628e7b..f669fecd5604 100644
--- a/drivers/nvme/host/apple.c
+++ b/drivers/nvme/host/apple.c
@@ -941,7 +941,7 @@ static enum blk_eh_timer_return apple_nvme_timeout(struct request *req)
 		if (blk_mq_request_started(req) &&
 		    !blk_mq_request_completed(req)) {
 			nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
-			nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+			set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
 			blk_mq_complete_request(req);
 		}
 		return BLK_EH_DONE;
@@ -966,7 +966,7 @@ static enum blk_eh_timer_return apple_nvme_timeout(struct request *req)
 	 */
 	dev_warn(anv->dev, "I/O %d(aq:%d) timeout: resetting controller\n",
 		 req->tag, q->is_adminq);
-	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+	set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
 	apple_nvme_disable(anv, false);
 	nvme_reset_ctrl(&anv->ctrl);
 	return BLK_EH_DONE;
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index dc388e24caad..c06f18dc5a65 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -533,7 +533,7 @@ bool nvme_cancel_request(struct request *req, void *data)
 		return true;
 
 	nvme_req(req)->status = NVME_SC_HOST_ABORTED_CMD;
-	nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+	set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
 	blk_mq_complete_request(req);
 	return true;
 }
@@ -790,7 +790,8 @@ bool __nvme_check_ready(struct nvme_ctrl *ctrl, struct request *rq,
 	 * sequence. until the controller will be LIVE, fail with
 	 * BLK_STS_RESOURCE so that they will be rescheduled.
 	 */
-	if (rq->q == ctrl->admin_q && (req->flags & NVME_REQ_USERCMD))
+	if (rq->q == ctrl->admin_q &&
+	    test_bit(NVME_REQ_USERCMD, &req->flags))
 		return false;
 
 	if (ctrl->ops->flags & NVME_F_FABRICS) {
@@ -1149,7 +1150,7 @@ int nvme_execute_rq(struct request *rq, bool at_head)
 	blk_status_t status;
 
 	status = blk_execute_rq(rq, at_head);
-	if (nvme_req(rq)->flags & NVME_REQ_CANCELLED)
+	if (test_bit(NVME_REQ_CANCELLED, &nvme_req(rq)->flags))
 		return -EINTR;
 	if (nvme_req(rq)->status)
 		return nvme_req(rq)->status;
diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e4f4528fe2a2..f6e25ccc730b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2420,7 +2420,7 @@ static bool nvme_fc_terminate_exchange(struct request *req, void *data)
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
 
-	op->nreq.flags |= NVME_REQ_CANCELLED;
+	set_bit(NVME_REQ_CANCELLED, &op->nreq.flags);
 	__nvme_fc_abort_op(ctrl, op);
 	return true;
 }
diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
index 9597a87cf05d..62316da41521 100644
--- a/drivers/nvme/host/ioctl.c
+++ b/drivers/nvme/host/ioctl.c
@@ -108,7 +108,7 @@ static struct request *nvme_alloc_user_request(struct request_queue *q,
 	if (IS_ERR(req))
 		return req;
 	nvme_init_request(req, cmd);
-	nvme_req(req)->flags |= NVME_REQ_USERCMD;
+	set_bit(NVME_REQ_USERCMD, &nvme_req(req)->flags);
 	return req;
 }
 
@@ -416,7 +416,7 @@ static enum rq_end_io_ret nvme_uring_cmd_end_io(struct request *req,
 	struct io_uring_cmd *ioucmd = req->end_io_data;
 	struct nvme_uring_cmd_pdu *pdu = nvme_uring_cmd_pdu(ioucmd);
 
-	if (nvme_req(req)->flags & NVME_REQ_CANCELLED) {
+	if (test_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags)) {
 		pdu->status = -EINTR;
 	} else {
 		pdu->status = nvme_req(req)->status;
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 263161cb8ac0..7ac1b13e24cb 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -170,16 +170,16 @@ void nvme_mpath_start_request(struct request *rq)
 	struct gendisk *disk = ns->head->disk;
 
 	if ((READ_ONCE(ns->head->subsys->iopolicy) == NVME_IOPOLICY_QD) &&
-	    !(nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)) {
+	    !test_bit(NVME_MPATH_CNT_ACTIVE, &nvme_req(rq)->flags)) {
 		atomic_inc(&ns->ctrl->nr_active);
-		nvme_req(rq)->flags |= NVME_MPATH_CNT_ACTIVE;
+		set_bit(NVME_MPATH_CNT_ACTIVE, &nvme_req(rq)->flags);
 	}
 
 	if (!blk_queue_io_stat(disk->queue) || blk_rq_is_passthrough(rq) ||
-	    (nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
+	    test_bit(NVME_MPATH_IO_STATS, &nvme_req(rq)->flags))
 		return;
 
-	nvme_req(rq)->flags |= NVME_MPATH_IO_STATS;
+	set_bit(NVME_MPATH_IO_STATS, &nvme_req(rq)->flags);
 	nvme_req(rq)->start_time = bdev_start_io_acct(disk->part0, req_op(rq),
 						      jiffies);
 }
@@ -189,10 +189,10 @@ void nvme_mpath_end_request(struct request *rq)
 {
 	struct nvme_ns *ns = rq->q->queuedata;
 
-	if (nvme_req(rq)->flags & NVME_MPATH_CNT_ACTIVE)
+	if (test_bit(NVME_MPATH_CNT_ACTIVE, &nvme_req(rq)->flags))
 		atomic_dec_if_positive(&ns->ctrl->nr_active);
 
-	if (!(nvme_req(rq)->flags & NVME_MPATH_IO_STATS))
+	if (!test_bit(NVME_MPATH_IO_STATS, &nvme_req(rq)->flags))
 		return;
 	bdev_end_io_acct(ns->head->disk->part0, req_op(rq),
 			 blk_rq_bytes(rq) >> SECTOR_SHIFT,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index ccd5e05dac98..1059976b413b 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -243,8 +243,8 @@ struct nvme_request {
 	union nvme_result	result;
 	u8			genctr;
 	u8			retries;
-	u8			flags;
 	u16			status;
+	unsigned long		flags;
 #ifdef CONFIG_NVME_MULTIPATH
 	unsigned long		start_time;
 #endif
@@ -257,10 +257,10 @@ struct nvme_request {
 #define REQ_NVME_MPATH		REQ_DRV
 
 enum {
-	NVME_REQ_CANCELLED		= (1 << 0),
-	NVME_REQ_USERCMD		= (1 << 1),
-	NVME_MPATH_IO_STATS		= (1 << 2),
-	NVME_MPATH_CNT_ACTIVE		= (1 << 3),
+	NVME_REQ_CANCELLED		= 0,
+	NVME_REQ_USERCMD		= 1,
+	NVME_MPATH_IO_STATS		= 2,
+	NVME_MPATH_CNT_ACTIVE		= 3,
 };
 
 static inline struct nvme_request *nvme_req(struct request *req)
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9fd04cd7c5cb..ab77973338b5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -760,7 +760,7 @@ static inline bool nvme_pci_metadata_use_sgls(struct request *req)
 	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl))
 		return false;
 	return req->nr_integrity_segments > 1 ||
-		nvme_req(req)->flags & NVME_REQ_USERCMD;
+		test_bit(NVME_REQ_USERCMD, &nvme_req(req)->flags);
 }
 
 static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
@@ -783,7 +783,7 @@ static inline enum nvme_use_sgl nvme_pci_use_sgls(struct nvme_dev *dev,
 		 *    only way to describe such a command in NVMe.
 		 */
 		if (req_phys_gap_mask(req) & (NVME_CTRL_PAGE_SIZE - 1) ||
-		    nvme_req(req)->flags & NVME_REQ_USERCMD ||
+		    test_bit(NVME_REQ_USERCMD, &nvme_req(req)->flags) ||
 		    req->nr_integrity_segments > 1)
 			return SGL_FORCED;
 		return SGL_SUPPORTED;
@@ -1303,7 +1303,8 @@ static blk_status_t nvme_pci_setup_meta_iter(struct request *req)
 	 * leverages this routine when that happens.
 	 */
 	if (!nvme_ctrl_meta_sgl_supported(&dev->ctrl) ||
-	    (entries == 1 && !(nvme_req(req)->flags & NVME_REQ_USERCMD))) {
+	    (entries == 1 &&
+	     !test_bit(NVME_REQ_USERCMD, &nvme_req(req)->flags))) {
 		iod->cmd.common.metadata = cpu_to_le64(iter.addr);
 		iod->meta_total_len = iter.len;
 		iod->meta_dma = iter.addr;
@@ -1909,7 +1910,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 		dev_warn_ratelimited(dev->ctrl.device,
 			 "I/O tag %d (%04x) QID %d timeout, disable controller\n",
 			 req->tag, nvme_cid(req), nvmeq->qid);
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
 		nvme_dev_disable(dev, true);
 		return BLK_EH_DONE;
 	case NVME_CTRL_RESETTING:
@@ -1929,7 +1930,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 			 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout, reset controller\n",
 			 req->tag, nvme_cid(req), opcode,
 			 nvme_opcode_str(nvmeq->qid, opcode), nvmeq->qid);
-		nvme_req(req)->flags |= NVME_REQ_CANCELLED;
+		set_bit(NVME_REQ_CANCELLED, &nvme_req(req)->flags);
 		goto disable;
 	}
 
-- 
2.34.1


