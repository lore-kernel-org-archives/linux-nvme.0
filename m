Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A05F2C43458
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jul 2026 14:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=wiDFbQK8IloUzjEkzz+Hxrc6mLZpdf91OPphsHzmdAk=; b=hIfUb5DTILNOWtmGUYZPwzULA+
	aHkpbOz3FseoMALyRP6h8DyQVm8W8MpVDJpgWuQFzu3QOnfGeB4nmgpALM3i6gveCu0+xl1H7SuKh
	11QUwl+CWb25iwFezoPLp0HHiUBEQQHEOBqjEKQ3JHGNnRg31KOJ9uQ0qzc6kQqLjLGK/wNLe212N
	Vkligu42tL38DZbl90YInHOzZSfk66ZKhbbiLTYAQ4tTlFPMVj3XN0P1cwNadPePQtDYUoHOy+iAc
	+KvXN47F+q9mjAf7rOf17uLiDCTq3WnjfcJGaTBlPTsCfmJBSasSe9dQn7SEC/0fazF62n0Du9NlE
	0d64+1jA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7T-0000000CiGu-0HNV;
	Mon, 06 Jul 2026 14:16:23 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wgk7N-0000000CiBj-3gV0
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jul 2026 14:16:21 +0000
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 666BIWvg4094363;
	Mon, 6 Jul 2026 14:16:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=wiDFbQK8IloUzjEkz
	z+Hxrc6mLZpdf91OPphsHzmdAk=; b=j5JFsbe8L0crKIQ/GvbfHkZhJM1s2tiL6
	o4e8fC+KyJCFvMA9WWBGcJvR2YKdhPmqpx9QwvllOCOVX2eTNcrXx94RYjPzSmiW
	qXtepMjLG5Quza5fe8ydmGG4TOdg2eCeDkrZiW/clSG4HhjmHUtviCPj/TSFxVG6
	NwtWtJB3bm3okqown8/rQXMY/Te3NwPQTOdUnmD+X1QyRkWP8+mGpw0Wp2VgCVwC
	inNBaQg5OY+aFkPP1CYx3PL4Jtk7N9/Dj5IHTj53cpdx/mDbsPrKk2Q5GGqKEed1
	ncZBboKRlcquUezu484Mi/QubpjfrxyIAxnpUgncYoBuoIw4k1TWQ==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6sw4hstq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:10 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 666E4cYI015292;
	Mon, 6 Jul 2026 14:16:09 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4f7eqfwpa7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 06 Jul 2026 14:16:09 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (smtpav04.fra02v.mail.ibm.com [10.20.54.103])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 666EG6qL25690394
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 6 Jul 2026 14:16:06 GMT
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0369520043;
	Mon,  6 Jul 2026 14:16:06 +0000 (GMT)
Received: from smtpav04.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id CBED720040;
	Mon,  6 Jul 2026 14:16:03 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.bl1-in.ibm.com (unknown [9.123.7.57])
	by smtpav04.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon,  6 Jul 2026 14:16:03 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, elver@google.com, kbusch@kernel.org, sagi@grimberg.me,
        axboe@fb.com, bvanassche@acm.org, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH v3 12/18] nvme: add context annotations for nvme_queue::sq_lock
Date: Mon,  6 Jul 2026 19:44:14 +0530
Message-ID: <20260706141452.3008233-13-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260706141452.3008233-1-nilay@linux.ibm.com>
References: <20260706141452.3008233-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-GUID: 3l16uyJqEEJBFFVFSoud3lGKgaVOGpZE
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX3dHf1PlXiS6M
 XuQ5AXwq4pFXj1Jt1NDkHN1oM+Jgyh2c8NHY678f6KNy7FwpigkiRcG6heIpuHTc7MV/rUR90+v
 DAjjkxhwdTqPJkfu3RSpeDTXr1W/wTY/7K2UnEuSP4MJHZsfhVSyu+JTdX30CcWzSBbRqvJk7Gy
 YdvqtaxvlUPso+M50OtUO+Z8zgQwpjEG3s/QauKnlQIFXm00bC9W97qpLpvaJBbX7q0JFTWRqmh
 i+dEVSoEHwaWkoVi2fakdYELt+8Atd6pOZCIKq7lrOymleSmvLeAIXw5/8xdSNNrMJwjNc8VsON
 B7IDJ8rGNzF1Fvb/Sbz+SDIDz3PGwHxrsuH9cydHnPgahYlu+25PJSAVB7KyCESAzv5zpBYG1TQ
 xsvttpkco3wzFToTYzckgYq7wVn4K4S8w91Nk5ZNvJpK4Udy6Knj4PNz+xzpHr36+yFcgiMDWMG
 Z2Mg1BowP/JyR0jNL4Q==
X-Proofpoint-ORIG-GUID: 68dVjuzx5HLLL-YRa0ILUGEEnRq-Jo0T
X-Authority-Analysis: v=2.4 cv=FqQ1OWrq c=1 sm=1 tr=0 ts=6a4bb8ab cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=jRDl6zYAfE20JmiUrPQA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA2MDE0MSBTYWx0ZWRfX3m3Rwhh28ZDA
 bHLvWnDYylq1l7eAHgiVI0EiNgFOcgptg3K9Saab/rwOqRConCuwjAqqAfTuTLSr2cpeJNFqRbI
 +q6aLFajs9po247ONTnpsH/i8IYXHKg=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-06_01,2026-07-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 clxscore=1015 malwarescore=0 lowpriorityscore=0
 priorityscore=1501 bulkscore=0 suspectscore=0 spamscore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607060141
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260706_071618_551236_A3B042B9 
X-CRM114-Status: GOOD (  20.29  )
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
require nvme_queue::sq_lock protection. So wrap the corresponding
initializations with context_unsafe().

nvme_free_queue() operate on queues which are no longer reachable, and
therefore do not require nvme_queue::sq_lock protection. Similarly,
nvme_alloc_sq_cmds() allocates memory for nvme_queue::sq_cmds for the
queue which is not yet published or in use and hence it's safe to
annotate all these helpers using context_unsafe.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7954417d1252..11720342a6b7 100644
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
 
@@ -2184,8 +2196,11 @@ static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-	nvmeq->sq_tail = 0;
-	nvmeq->last_sq_tail = 0;
+	/* Initialize unpublished lock-guarded variables. */
+	context_unsafe(
+		nvmeq->sq_tail = 0;
+		nvmeq->last_sq_tail = 0;
+	);
 	nvmeq->cq_head = 0;
 	nvmeq->cq_phase = 1;
 	nvmeq->q_db = &dev->dbs[qid * 2 * dev->db_stride];
-- 
2.53.0


