Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1E16CD98DA
	for <linux-nvme@archiver.kernel.org>; Sun, 14 Jun 2026 13:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/085y889opPgjThHJSALL2AID2kIc2DxluXc5P2L15Y=; b=XzTTpbautTDL8ltaH/YaN7s/+/
	4Hfr+HgZowcAC026kOTwjURdKMyH8xMy0hcQZ8dUOo2TL6mdbAuaUWo1yg4EjKRdoSUVbmhyzLi4e
	2kXksm/AUJwsiJ/oz6kvuxoYHjE9QT34pA+ErCZPowTE5C0EUmxxeBN+psbFZcl1xY5rWnOU/zPRZ
	InAdN6zSWnzNNjkMG/jPWUuXhVwt/nmpyN9xDIeB+i4EeB0OiXI/HzWTR02BqXioXQzDQx34xbSgK
	PPEqYspual1o1Ltr+q2OGA0m2WIoVGZce4atbzqQdGgowNPnwhyS3xFUfuRD/oUzVccyG1+TesGwO
	jwIdGAbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhb-0000000D0yq-1oRs;
	Sun, 14 Jun 2026 13:16:39 +0000
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wYkhZ-0000000D0vq-0RY2
	for linux-nvme@lists.infradead.org;
	Sun, 14 Jun 2026 13:16:38 +0000
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65ECma4d3478334;
	Sun, 14 Jun 2026 13:16:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=/085y889opPgjThHJ
	SALL2AID2kIc2DxluXc5P2L15Y=; b=eSWahQMxNjiXneqmTs3TPXPm4w8A7zwKr
	nk3NuREopgyqZHHix0beJW+QxH7a9qe18LoFzEmu21qyF4cap8sdaNNS4f5VHLvd
	zkKk+N/kT4yadMWbS1hJrVP5lzUO4FTTjmIjs3chO8dpae3SkQWSGs4eGjI+GogO
	bZLWYaLHDUHGo+8pvZ1oYAWccQvJt46sksQJK3jRk520GGeGHtc5wKQ3EdQBXrVj
	gfta2bVeqhXCnp6D7RAXJJ7tc6PwOrk2yfNRexWVLHs6rnK/ZhOdXHzGXdsLhtQV
	tP7g5fBbt0CHOU2a94YKVNG9zOk4M2qa50p6L9Ce83iuA4sOYm0Xg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4es23nbm6t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:28 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65ED4aIm013131;
	Sun, 14 Jun 2026 13:16:28 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4esm7xsdmm-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 14 Jun 2026 13:16:27 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (smtpav02.fra02v.mail.ibm.com [10.20.54.101])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65EDGO0s41746898
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sun, 14 Jun 2026 13:16:24 GMT
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 676092004B;
	Sun, 14 Jun 2026 13:16:24 +0000 (GMT)
Received: from smtpav02.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BEB4220040;
	Sun, 14 Jun 2026 13:16:21 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.80.1])
	by smtpav02.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Sun, 14 Jun 2026 13:16:21 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCHv2 11/17] nvme: add Clang context annotations for nvme_queue::sq_lock
Date: Sun, 14 Jun 2026 18:45:26 +0530
Message-ID: <20260614131541.2017845-12-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260614131541.2017845-1-nilay@linux.ibm.com>
References: <20260614131541.2017845-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=XtnK/1F9 c=1 sm=1 tr=0 ts=6a2ea9ad cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=Sk7YppiULilGF_7COUoA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX6URL+cJCTMYi
 /WCFRXQ5IgkhajcQ/z2zcsXmRDv+18tawdhvw8a3ILSultmq/cEziVpMX++dKJpF+uXAyH3hCyH
 ZlaEGIEjrB4wr2aPf8n6YUbCRL7aQyLZKfAud4C3r2/S5EQyI0V3geT+oByIPGtu45phKDOd4vq
 8hQbkPr6PLQPdue6wEvoWu67mWnUJ/IquktS9Xe5DvVBTHO/4IickBTYZyuxrFbG81h4H071KR5
 YM9aDzx9yH5KQW0Wl+x2KFqbVAvVmFtiZQjX4B2d9ogDYTDbXwcL3lec34KeIjVZhu2NCbJINZz
 gUnkua88eCm/aOeE5Un4mFUllw8H47g2Q8SJ5AXyu3Pij6kHwKwaWcgoAXaG3y4MjWQ6V+qwHnD
 9bvv4pVZDvuc3swpVegQvIqqt8ThAFfxBM2sttHTCVLmeHhoShdyBiSur1eXKSYshHqx/EXxp5y
 oEqk4Dep7YBoBs/Zbdw==
X-Proofpoint-GUID: _Ru5nEV-LtmbPikxnkWRTSgDLzvxmqr2
X-Proofpoint-ORIG-GUID: e_xt6AhG7Xo7w2cr5fhQyBlNJRbNisV4
X-Proofpoint-Spam-Info: AW1haW4tMjYwNjE0MDEzMCBTYWx0ZWRfX+NBglPZ9otVc
 nb9wME9R0JLJWeSoBNSW/bNj+fFsv5ClrcFYNkAcl3uHk0NkpB1QhOBxsBi3fo8sarJIxnD+XBi
 uJGneEIalTgT33tY10gWKjVxh+JjHlw=
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-14_03,2026-06-12_03,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 suspectscore=0 clxscore=1015 malwarescore=0 spamscore=0 impostorscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606040000 definitions=main-2606140130
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260614_061637_152712_1BCD39FB 
X-CRM114-Status: GOOD (  17.82  )
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

Accesses to sq_tail used solely for tracing are annotated with
context_unsafe(), as they only require a lockless snapshot of the
value. Likewise, nvme_init_queue() and nvme_free_queue() operate on
queues that have not yet been published or are no longer reachable,
and therefore do not require sq_lock protection. Similarly,
nvme_alloc_sq_cmds() allocates memory for nvme_queue::sq_cmds for
the queue which is not yet published or in use and hence it's safe
to annotate all these helpers using context_unsafe.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 894da63127a7..86cbc88a05b5 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -366,7 +366,7 @@ struct nvme_queue {
 	struct nvme_dev *dev;
 	struct nvme_descriptor_pools descriptor_pools;
 	spinlock_t sq_lock;
-	void *sq_cmds;
+	void *sq_cmds __guarded_by(&sq_lock);
 	 /* only used for poll queues: */
 	spinlock_t cq_poll_lock ____cacheline_aligned_in_smp;
 	struct nvme_completion *cqes;
@@ -375,9 +375,9 @@ struct nvme_queue {
 	u32 __iomem *q_db;
 	u32 q_depth;
 	u16 cq_vector;
-	u16 sq_tail;
-	u16 last_sq_tail;
 	u16 cq_head;
+	u16 sq_tail __guarded_by(&sq_lock);
+	u16 last_sq_tail __guarded_by(&sq_lock);
 	u16 qid;
 	u8 cq_phase;
 	u8 sqes;
@@ -711,6 +711,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
  * Write sq tail if we are asked to, or if the next command would wrap.
  */
 static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
+	__must_hold(&nvmeq->sq_lock)
 {
 	if (!write_sq) {
 		u16 next_tail = nvmeq->sq_tail + 1;
@@ -729,6 +730,7 @@ static inline void nvme_write_sq_db(struct nvme_queue *nvmeq, bool write_sq)
 
 static inline void nvme_sq_copy_cmd(struct nvme_queue *nvmeq,
 				    struct nvme_command *cmd)
+	__must_hold(&nvmeq->sq_lock)
 {
 	memcpy(nvmeq->sq_cmds + (nvmeq->sq_tail << nvmeq->sqes),
 		absolute_pointer(cmd), sizeof(*cmd));
@@ -1581,7 +1583,10 @@ static inline void nvme_handle_cqe(struct nvme_queue *nvmeq,
 		return;
 	}
 
-	trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail);
+	/*
+	 * Tracing only; a lockless snapshot of nvmeq sq_xxx/cqe is sufficient.
+	 */
+	context_unsafe(trace_nvme_sq(req, cqe->sq_head, nvmeq->sq_tail));
 	if (!nvme_try_complete_req(req, cqe->status, cqe->result) &&
 	    !blk_mq_add_to_batch(req, iob,
 				 nvme_req(req)->status != NVME_SC_SUCCESS,
@@ -2008,6 +2013,7 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req)
 }
 
 static void nvme_free_queue(struct nvme_queue *nvmeq)
+	__context_unsafe(/* frees queue which is no longer in use */)
 {
 	dma_free_coherent(nvmeq->dev->dev, CQ_SIZE(nvmeq),
 				(void *)nvmeq->cqes, nvmeq->cq_dma_addr);
@@ -2102,6 +2108,7 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 
 static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
 				int qid)
+	__context_unsafe(/* safe to allocate sq_cmds without any protection */)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
@@ -2176,6 +2183,7 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
+	__context_unsafe(/* safe to init queue without any protection */)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-- 
2.53.0


