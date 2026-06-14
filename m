Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6EEACD98DA
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=LRd6aDdwUGHXCVHcaHRwLNSTCJYpn+QSu1MsfGAhrcM=; b=LSaPIakzny5zN3f7a2TWHPtTFp
	2ntzxuQN/uAbg3jPUtFr5sbiIZRidqGKoyj3DxNwtLapanpsgk5pCAg6VLOKm1a4QVOwalP1TfNaF
	YU5FCsEpIPveXIG3+ray1Y9qbxVa2zHsH7wv+jpl3s8zRs9KreqfNHeXQVarUbCcZdkiTehscGtPf
	zMx1eOB0Ifks7dpWXCqrCUmtRSDc7tv8kulcx0AuP96NigXxn4Li2pw+pFbv3ndAgcXbCHk0Lc41r
	oRBgQASHAxTi9V+OkPlh1YIu2T4PCx5A5l7oTpb9Gpq2VoBKI1OjhpjOVpGEoggV6LOnPcvNvO13h
	xXhvCsHA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhd-0000000D12C-2twt;
	Sun, 14 Jun 2026 13:16:41 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhb-0000000D0yi-1cmX
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:40 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECmWjo3478035;
	Sun, 14 Jun 2026 13:16:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=LRd6aDdwUGHXCVHca
	HRwLNSTCJYpn+QSu1MsfGAhrcM=; b=dKgAluREsUKkw8s5tcA8XqZ67fLRr1fWj
	rUAQDlvkxfEnUsBC/lHHZUPvcZGc23GgMegf34e7rq62knmtJOY+ktYlC+9FArA4
	AGMXjPbavBoSOxBY0YNyAFSMtjv1xEP7L7JdbcMCqi+qzAfX7C7tcwKZ2i87KIuF
	C0FJIwnb3r7fpujfzhaE2qZtDteeD8OTUUXIeFttBGVtR4Y3EOWPzeZvL5lt7me5
	+W92W5zQs+zPxypRzPWThe8CmIuDsnijK9G+vUx9Q6x9G9cqWKv6QfNlXAg2ddbY
	BvZIKiDpQGsBCAeR5APfBU+whr4wRPRZb9AID06W9DXtWWn577xfw==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nbm6x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:31 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4bkn008939;
	Sun, 14 Jun 2026 13:16:30 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4eshhpstgt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:30 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGRN419530164
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:27 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 43BE120040;
	Sun, 14 Jun 2026 13:16:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C51012004B;
	Sun, 14 Jun 2026 13:16:24 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:24 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 12/17] nvme: add Clang context annotations for nvme_queue::cq_poll_lock
Date: Sun, 14 Jun 2026 18:45:27 +0530
Message-ID: <20260614131541.2017845-13-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2ea9b0 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=SckEKExZ8DwT-d0CZqMA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX7MGowU/NFUrw
 hnFm4zb93b81dsh4C8djBqE1yycTnDVGCzswKDL2iUNTfkVXZrFjubTZbZbkNGeY2bPHHQS4LT8
 Wzkvc5irtjEQAZlzeT2HrgESOkrd9BwvfcAtMlo+cPh+NUaHR1VdOBfpTdHxmmU/kRhTl7TFcnK
 wv+IDD9p/7DEI5L5Wc5VMVEFmh8R5BTIuj+BYcl8Jvg9T9k/MMWSRbsMTCjSKICDdBydkoeAwkq
 smBuu+UaTJcmfhSWZw2WRm7wnbPAZiU0P/hFlkdFIV3qElu6MJiQUxRmAYsR4xgo3tSTTRZjpQm
 X/ILenIH6k9zEEcZ0513euarm7ipMxYyxmMl7i+KLdDZDjL1+WBDWpgY2ABnsx4XdGEoGNAw79L
 yaFnPgyv/JxcK9xwzcQLVmVymeFe2wv7zpwV5b8kyifx/h20FHAHsMc8RxsgkwlRXaXXl12Npad
 ehKS0jT9ulVrdBu7hhQ==
X-Proofpoint-GUID: 4cMtZbjFY2ymmB9cBtMWKKrUZzeBHDi8
X-Proofpoint-ORIG-GUID: rkggQ97-BJu4djzmVyqh_b3jkxSpJRKl
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX2vFNHUu9+wyA
 pTRNqZHxM5VBJFWIjJiK462hD9bc25G6eZVFHNteL9vfACBCOiUEqAB335cK4T6QPyWM3+NQf7K
 v9T67DIOqAf+UR9UCxh58L8yZn6zj9c=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061639_431636_9A928022 
X-CRM114-Status: GOOD (  19.17  )
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

nvme_queue::cqes, nvme_queue::cq_head, and nvme_queue::cq_phase are
protected by nvme_queue::cq_poll_lock. Annotate these fields with
__guarded_by(&cq_poll_lock) and annotate helpers accessing them with
__must_hold(&cq_poll_lock) so that Clang's context analysis can
validate the locking requirements.

IRQ-based queues do not use cq_poll_lock and instead rely on interrupt
serialization. Annotate nvme_irq() and nvme_irq_check() with
__context_unsafe() to suppress the corresponding context analysis
warnings.

nvme_poll() invokes nvme_cqe_pending() as a lockless fast-path check
before acquiring cq_poll_lock. This check is intentionally kept outside
the lock because nvme_poll() may be called repeatedly in a tight polling
loop until completions are found. The result is only advisory, as the
completion queue is subsequently revalidated under cq_poll_lock by
nvme_poll_cq(). Suppress the corresponding context analysis warning by
annotating the lockless invocation of nvme_cqe_pending() with
context_unsafe().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 86cbc88a05b5..2e60d95c11a2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -369,17 +369,17 @@ struct nvme_queue {
 	void *sq_cmds __guarded_by(&sq_lock);
 	 /* only used for poll queues: */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
-	struct nvme_completion *cqes;
+	struct nvme_completion *cqes __guarded_by(&cq_poll_lock);
 	dma_addr_t sq_dma_addr;
 	dma_addr_t cq_dma_addr;
 	u32 __iomem *q_db;
 	u32 q_depth;
 	u16 cq_vector;
-	u16 cq_head;
+	u16 cq_head __guarded_by(&cq_poll_lock);
 	u16 sq_tail __guarded_by(&sq_lock);
 	u16 last_sq_tail __guarded_by(&sq_lock);
 	u16 qid;
-	u8 cq_phase;
+	u8 cq_phase __guarded_by(&cq_poll_lock);
 	u8 sqes;
 	unsigned long flags;
 #define NVMEQ_ENABLED		0
@@ -1534,6 +1534,7 @@ static void nvme_pci_complete_batch(struct io_comp_batch *iob)
 
 /* We read the CQE phase first to check if the rest of the entry is valid */
 static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
+	__must_hold(nvmeq->cq_poll_lock)
 {
 	struct nvme_completion *hcqe = &nvmeq->cqes[nvmeq->cq_head];
 
@@ -1541,6 +1542,7 @@ static inline bool nvme_cqe_pending(struct nvme_queue *nvmeq)
 }
 
 static inline void nvme_ring_cq_doorbell(struct nvme_queue *nvmeq)
+	__must_hold(nvmeq->cq_poll_lock)
 {
 	u16 head = nvmeq->cq_head;
 
@@ -1558,6 +1560,7 @@ static inline struct blk_mq_tags *nvme_queue_tagset(struct nvme_queue *nvmeq)
 
 static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 				   struct io_comp_batch *iob, u16 idx)
+	__must_hold(nvmeq->cq_poll_lock)
 {
 	struct nvme_completion *cqe = &nvmeq->cqes[idx];
 	__u16 command_id = READ_ONCE(cqe->command_id);
@@ -1595,6 +1598,7 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 }
 
 static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
+	__must_hold(nvmeq->cq_poll_lock)
 {
 	u32 tmp = nvmeq->cq_head + 1;
 
@@ -1608,6 +1612,7 @@ static inline void nvme_update_cq_head(struct nvme_queue *nvmeq)
 
 static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 			        struct io_comp_batch *iob)
+	__must_hold(nvmeq->cq_poll_lock)
 {
 	bool found = false;
 
@@ -1628,6 +1633,7 @@ static inline bool nvme_poll_cq(struct nvme_queue *nvmeq,
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
+	__context_unsafe(/* IRQ queues do not use cq_poll_lock  */)
 {
 	struct nvme_queue *nvmeq = data;
 	DEFINE_IO_COMP_BATCH(iob);
@@ -1641,6 +1647,7 @@ static irqreturn_t nvme_irq(int irq, void *data)
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)
+	__context_unsafe(/* IRQ queues do not use cq_poll_lock */)
 {
 	struct nvme_queue *nvmeq = data;
 
@@ -1673,8 +1680,14 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	bool found;
 
+	/*
+	 * nvme_cqe_pending() is intentionally used as a lockless fast-path
+	 * check before taking ->cq_poll_lock. The result is only advisory and
+	 * the CQ is revalidated under ->cq_poll_lock by nvme_poll_cq(), so
+	 * suppress the context analysis warning for this lockless inspection.
+	 */
 	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) ||
-	    !nvme_cqe_pending(nvmeq))
+	    context_unsafe(!nvme_cqe_pending(nvmeq)))
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
@@ -2134,6 +2147,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 }
 
 static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
+	__context_unsafe(/* safe to allocate queue without any protection */)
 {
 	struct nvme_queue *nvmeq = &dev->queues[qid];
 
-- 
2.53.0


