Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4789C43458
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Jul 2026 11:55:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=QxRAGixmwL0kgeaaopK6cJ/hkegshcFF1sp+4+CUmzE=; b=lC9YNNTDdeO8nnbeWOOvfhb66r
	q+b6gcOGn7TgwAs6eDy25Yu8+IY5bnmPU/WaoRRiYX837UJOLjEOA9Wu4gvmrs9t9seuq0k5wA3iP
	VLL8VLlActHfQshpiDLZFfxTICOVk9yrSNNS7sZ3GJt98iAzOL895e0B6Op51Q59fGGHS1c+N9uQS
	sxOBHLb78ptoEYJJ+F28boMTdkVQxT5BzoIqRJzSAA1zk5jiGofWwKUJdw+DgyakBdn+WAQbNz43T
	B9/h1PreR5TgXR9Nem/R8EBwHJ6rj5yRakmZd4qCXb0NJP6pVaIrA/4CdI8QfKTuQIwd8Kqu6pHAo
	Ol6c877A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGD-000000094zq-3dR0;
	Mon, 13 Jul 2026 11:55:45 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wjFGB-000000094tH-279H
	for linux-nvme@lists.infradead.org;
	Mon, 13 Jul 2026 11:55:44 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 66D6g3Jq1727673;
	Mon, 13 Jul 2026 11:55:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=QxRAGixmwL0kgeaao
	pK6cJ/hkegshcFF1sp+4+CUmzE=; b=i+mbpnjLmYM3CVhFbk5GdHGWCXD9ZBgB8
	9A3M8nuP7n6kZ6ONwy1pWgqEb3i9wiw/0PC4BSyM87M+Syw2Vu2ObLtsloEsNd9o
	sQz/MDTIBEUkUS4cw/glVo34WTl99fHd3oOZEAK0NnChB6DM8HNZLhtuMAkxAhKB
	N4OJhi1Z1ncKmMu0H6uBWSlvJAVHffYodGttXqJZBTDLyjhpENjrVsvt+wC4Q+h4
	/htwbWrKUshtZ5XlLzZ5RK3ln/C4cneQsM2c71uG88gWRcJoZk4u3RVYIctWUpv1
	iJZ5w0qslCEBwtxcW5w4Z9Q+2yVhlc+ll+A5fVLAxrGlIaVko/nEw==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fbepx8de6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:34 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 66DBnc38012359;
	Mon, 13 Jul 2026 11:55:33 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fc0hvwk63-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 13 Jul 2026 11:55:33 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 66DBtTcS46465338
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 Jul 2026 11:55:29 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7C9FC2004B;
	Mon, 13 Jul 2026 11:55:29 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 9562620040;
	Mon, 13 Jul 2026 11:55:27 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 13 Jul 2026 11:55:27 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v4 15/20] nvme: add context annotations for nvme_queue::sq_lock
Date: Mon, 13 Jul 2026 17:24:16 +0530
Message-ID: <20260713115444.465704-16-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260713115444.465704-1-nilay@linux.ibm.com>
References: <20260713115444.465704-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: hTVD9Xl3iTGsN5Vib3Qnk3KbAva9uYmw
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfX3Dq0/wMaidpt
 RfeA+4fkUQd6DzWBvvRp/c6+qmH4vI4kadLt3V3zUvRcbSy9xRTp5uAuSmR9GX2qxszRs/WIEoR
 OpVP8qT1d+6uQJ/Mm+BLC7jfkyboS64=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzEzMDEyMiBTYWx0ZWRfXzsJitAQCvoQD
 BPyIty8GNNauE+kfT1xTqtyLubeMBFQ8c9CCzmv94owcLQo3vaf4N9RgaYkP4f4Y+ZsLbsLsiUC
 cRrMUgs8PGlLfsw5GoxGaB/kiy5o+sfW9vjdaIB9lNW/ziKKaOvp8EXlvK4LCv6irztp76D8mC5
 OrTDPpmNXB4elffHu2+sJRWxXEWJDkV5WfXgb2CoXDFR0HQ7t0qkTsZuK9MG+10vRADmfnyVFpU
 BhnYxleaVQp9Abook82WSubYCC2iLdf4rPGHFAwQ1yes6wu/kWccu7YKN/09Qu11pYOgfUcv4zk
 gMhYJSCf3EkvpLLuQjhgWS3vWkmp1TptvjkLJdxiE+1rjHDHzI+aKvbCipqFasAwOsqRRE7wubN
 RNG9a1QSOy3SbOUU/QmeC8Dtk5X2lzFTGj22abdCKCgXhUnUROYm/0reA620IFRrDDOWfxKD3uZ
 VJ95GdtszprjzMXZ2Sw==
X-Authority-Analysis: v=2.4 cv=XbS5Co55 c=1 sm=1 tr=0 ts=6a54d237 cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=YfWjjCuxrD_un2WB3cEA:9
X-Proofpoint-ORIG-GUID: Byqlq2H5JarKp6CYv3NdKAEukqnPCs1n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-13_02,2026-07-10_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 suspectscore=0 spamscore=0 phishscore=0 lowpriorityscore=0
 priorityscore=1501 adultscore=0 malwarescore=0 impostorscore=0 bulkscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607130122
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260713_045543_552753_911F9A97 
X-CRM114-Status: GOOD (  19.11  )
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

nvme_queue::sq_tail, nvme_queue::last_sq_tail and nvme_queue::sq_cmds
are protected by nvme_queue::sq_lock. Annotate each field with
__guarded_by(&sq_lock) and annotate helpers that access them with
__must_hold(&sq_lock) so that Clang's context analysis can validate
the locking requirements.

Access to nvme_queue::sq_tail used solely for tracing is annotated with
data_race(), as they only require a lockless snapshot of the value.

nvme_init_queue() initializes nvme_queue::sq_tail and
nvme_queue::last_sq_tail before the queue is published and thus do not
require nvme_queue::sq_lock protection. So annotate nvme_init_queue()
with context_unsafe() to suppress false positive context analyzer
warning.

nvme_free_queue() operate on queues which are no longer reachable, and
therefore do not require nvme_queue::sq_lock protection. Similarly,
nvme_alloc_sq_cmds() allocates memory for nvme_queue::sq_cmds for the
queue which is not yet published or in use and hence it's safe to
annotate all these helpers using context_unsafe.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 21 +++++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7954417d1252..50ca643c16c5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -366,7 +366,8 @@ struct nvme_queue {
 	struct nvme_dev *dev;
 	struct nvme_descriptor_pools descriptor_pools;
 	spinlock_t sq_lock;
-	void *sq_cmds;
+	void *sq_cmds
+		__guarded_by(&sq_lock);
 	 /* only used for poll queues: */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	struct nvme_completion *cqes;
@@ -375,9 +376,11 @@ struct nvme_queue {
 	u32 __iomem *q_db;
 	u32 q_depth;
 	u16 cq_vector;
-	u16 sq_tail;
-	u16 last_sq_tail;
 	u16 cq_head;
+	u16 sq_tail
+		__guarded_by(&sq_lock);
+	u16 last_sq_tail
+		__guarded_by(&sq_lock);
 	u16 qid;
 	u8 cq_phase;
 	u8 sqes;
@@ -716,6 +719,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
  * Write sq tail if we are asked to, or if the next command would wrap.
  */
 static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
+	__must_hold(&nvmeq->sq_lock)
 {
 	if (!write_sq) {
 		u16 next_tail = nvmeq->sq_tail + 1;
@@ -734,6 +738,7 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 
 static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
 				    struct nvme_command *cmd)
+	__must_hold(&nvmeq->sq_lock)
 {
 	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
 		absolute_pointer(cmd), sizeof(*cmd));
@@ -1586,7 +1591,12 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
-	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
+	/*
+	 * Tracing only; annotate a lockless snapshot of nvmeq->sq_tail using
+	 * data_race(). This would also help suppress context analysis warning
+	 * while accessing nvmeq->sq_tail without acquiring ->sq_lock.
+	 */
+	trace_nvme_sq(req, cqe->sq_head, data_race(nvmeq->sq_tail));
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
 	    !blk_mq_add_to_batch(req, iob,
 				 nvme_req(req)->status != NVME_SC_SUCCESS,
@@ -2013,6 +2023,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
+	__context_unsafe(/* frees queue which is no longer in use */)
 {
 	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
@@ -2107,6 +2118,7 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				int qid)
+	__context_unsafe(/* safe to allocate sq_cmds without any protection */)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
@@ -2181,6 +2193,7 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
+	__context_unsafe(/* initialize unpublished/lock-guarded variables */)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-- 
2.53.0


