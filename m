Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 153AFCD8CB2
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=1Ra+w8T4qrYsTGLx4fGEC/7ochd4Ne2zkqnBFU14VqE=; b=xvUO1qHttB0fTGHN6wesqOLcTq
	/JbAQ6E1pAwE51pqcYpRobd5KWX7pPugUKy2GbAI3YZuThjATsIQVSpn/aADzBZjH/27tQM2lngd/
	8uxyYgmspKfn/oBPTggMrSa7w7M08NPO8SZgD129PBURjF30F03s1H3fI0wrKVVpluJv2V/r0e5Hv
	WjaGknA5iqe5QgPL7pUW5NXy/laFMqFq5gU6YHxYTton77P9zei7fBKLv3RbSh3AeQXArcIQ+vddU
	bJdn+AjyjFnl3TJ219qXciSOqZqmcC4ORrAaINIe8C+YTawO/OTsIq9EHYLUFzabaXp9x28ZsTDej
	A9IsdF8A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvL-00000007syT-2Fgf;
	Wed, 10 Jun 2026 14:28:55 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvJ-00000007svJ-1a46
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:54 +0000
Received: from pps.filterd (m0353729.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A9TbwH3414808;
	Wed, 10 Jun 2026 14:28:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=1Ra+w8T4qrYsTGLx4
	fGEC/7ochd4Ne2zkqnBFU14VqE=; b=LbT0EtWf19dDLnx+IoeBkUubwr5udAvHe
	g27XLrjNLzO2J6ujVr95rmhdBCj7NpYTncDlVveL+oi76cL7pPnYjcrUyAwP6Jmu
	r6ia65WfTSu+CDCM9am2eTp/jwiq2JOOaQuTnM8iFqmIvFCdnCAZ2FAN6AAaa9dW
	Tcp5vwSO5u/iOepH18oRhL57fxb0Uoc72KOaZCEzlMmtHD4UCMQ+I+45imj5FMMV
	k3z580NxpeNzDlvrGi5sJCVjpWCJc4JpWttwel/aHUnaK1afMXoH9CTV+Zs2h3FV
	uohF89PMGG+eMt15PMyLXZloOfvdves2YpmZ8mkcV//VsmDhw4azw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb7qsh9m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:44 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AE4k31009722;
	Wed, 10 Jun 2026 14:28:43 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emx8w74gp-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:43 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESdut17236278
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:39 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4BC5620049;
	Wed, 10 Jun 2026 14:28:39 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1F31820040;
	Wed, 10 Jun 2026 14:28:37 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:36 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 12/15] nvme: add Clang context annotations for nvme_queue::cq_poll_lock
Date: Wed, 10 Jun 2026 19:57:32 +0530
Message-ID: <20260610142743.115898-13-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=HppG3UTS c=1 sm=1 tr=0 ts=6a29749c cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=uAbxVGIbfxUO_5tXvNgY:22 a=VnNF1IyMAAAA:8 a=THxiTVDxSJPjY8PzXJ4A:9
X-Proofpoint-GUID: O78yuH8n1bty0XKNlTHhpohTcykuh1jX
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX0Tjm9MT/K66Y
 SHP5TB2pJtP9EbA0qEM4D5QSiP0PEGd+bukYJR2rHi1GOHqkyHDwr2lBUcKnYje2X+nKeNH3+zD
 zeL6jILDxHRXmEoR+7m4Be2MghrOeuAmRfIZPu/PFPMIBmdFa3XowjGOOOJOUqSA5vntjOj4mfm
 GC7bmXMzfIlOlkK5iIaIpj/U+YsG63spnIGZUY1CRn7AJv43/pCmeOkAdFycwzJ9QrhvKsP+mi7
 UzlDEywxs6r1zF3+vYJG8uM6TAXck8/InV3TRrnua/l5I8j6Ikb67EjAnbuiwm6XxZ+dxoH5Gc7
 0OasaeF1SXz2ymQsrSdNOa2PLsdIgYvT0JfueYHvgfEqhPhB0KvpgeAHcyFHEBIwMbWgB0liBJL
 Brh4+eUwRIv8w5C1VzhuUrqGviTD/8gZ1CqVd81WfGJ6DUMrk4qUQJPiEO5BhuworctQn/Nvs1q
 zz+ubX5oTs6fAlQo5+Q==
X-Proofpoint-ORIG-GUID: cLpk2M9dTGrpp3aWq-i-6YNW7R3bzW3n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 adultscore=0 phishscore=0 malwarescore=0 impostorscore=0
 priorityscore=1501 clxscore=1011 bulkscore=0 spamscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2605210000 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072853_447404_B01023FC 
X-CRM114-Status: GOOD (  18.93  )
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

After annotating the completion queue state and helper functions,
Clang's context analysis reports that nvme_poll() invokes
nvme_cqe_pending() without holding nvme_queue::cq_poll_lock:

drivers/nvme/host/pci.c:1683:7: warning: calling function 'nvme_cqe_pending' requires holding spinlock 'hctx->driver_data->cq_poll_lock'
      exclusively [-Wthread-safety-analysis]
 1683 |             !nvme_cqe_pending(nvmeq))

Fix the warning by acquiring nvme_queue::cq_poll_lock before invoking
nvme_cqe_pending() in nvme_poll().

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c464570cffd0..343860584b31 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -369,17 +369,17 @@ struct nvme_queue {
 	void *sq_cmds;
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
 
@@ -1673,11 +1680,14 @@ static int nvme_poll(struct blk_mq_hw_ctx *hctx, struct io_comp_batch *iob)
 	struct nvme_queue *nvmeq = hctx->driver_data;
 	bool found;
 
-	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags) ||
-	    !nvme_cqe_pending(nvmeq))
+	if (!test_bit(NVMEQ_POLLED, &nvmeq->flags))
 		return 0;
 
 	spin_lock(&nvmeq->cq_poll_lock);
+	if (!nvme_cqe_pending(nvmeq)) {
+		spin_unlock(&nvmeq->cq_poll_lock);
+		return 0;
+	}
 	found = nvme_poll_cq(nvmeq, iob);
 	spin_unlock(&nvmeq->cq_poll_lock);
 
@@ -2133,6 +2143,7 @@ static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 }
 
 static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
+	__context_unsafe(/* safe to allocate queue without any protection */)
 {
 	struct nvme_queue *nvmeq = &dev->queues[qid];
 
-- 
2.53.0


