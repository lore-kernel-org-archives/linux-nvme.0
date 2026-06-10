Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D108BCD8CB9
	for <linux-nvme@archiver.kernel.org>; Wed, 10 Jun 2026 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=it0E/8aX7UIgcekI0hpC7toDEwVrRJ7SZBXjthGxp/8=; b=LPE/DmTwlwFP16HJdNrD0GAw2w
	WzniCe3yOeWlU2k5gnmN+s+kCJ0LxwwsqfYmv+NkLF+9JFY/JZlCAAIp2sdVmNq+xW/GJisdVjX57
	yMXGb5GeW4TawIylKy0KSonufofCsnS6VDWJR0brVv50GONseeSZyBQQE1eM3XU5Prgo+0EC3abMH
	mmiM7UnpWX0SLWAbwe9Oz6gFgJT+q7Tk4pgAF1EG33wpcZffh3hgq/wYojfpP114qxNaWTxaaQQAQ
	jW3tmOdng8lv7YZTQG+KqPDQU+8QXQYxtHudm8Qn7peCGbt4H9Z6epaO1KBCBi9yHVcFWSwahOE9T
	7O7Cyl/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvK-00000007swk-0yJ2;
	Wed, 10 Jun 2026 14:28:54 +0000
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wXJvE-00000007spu-2jFA
	for linux-nvme@lists.infradead.org;
	Wed, 10 Jun 2026 14:28:53 +0000
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 65A56Wwt2876689;
	Wed, 10 Jun 2026 14:28:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=it0E/8aX7UIgcekI0
	hpC7toDEwVrRJ7SZBXjthGxp/8=; b=Mx7IUGrWKg/1xstsXhulpOFxa8dxLaAXx
	w6IzI9MqfRRSTOjXOCrFdGoi1kQyuL9vPvM6bGKczh2OXxXBuCHvTsXkbeH0M08P
	uIiqm638ePlP/XJrXaPuAYZZHIG6aCafgEC68wnF2P+wAa34L1w2R0nhFWqohFxa
	hWsmw7MmL7SohjNq+9IaTqxJtfj02mqaer+DFUtiwhC+9/1U52H5LQy92KOHl/F5
	S1SOiDmrAQvEKVm9Z8AhcnWqh57TZmktoVY3Z/0MpdgS1wDl0mSkidOFh8zTdcaw
	jEbab+d8+fOAQMLNOgGVeK6/kjiYwHIdxr/UcTXD2KgB5elX4h4Cg==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4emb6t12dy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:41 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 65AEKAJs009499;
	Wed, 10 Jun 2026 14:28:40 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4emych6wjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jun 2026 14:28:40 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 65AESaqT48497090
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 10 Jun 2026 14:28:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id BCCD620049;
	Wed, 10 Jun 2026 14:28:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 8583520040;
	Wed, 10 Jun 2026 14:28:34 +0000 (GMT)
Received: from li-a84c74cc-2b13-11b2-a85c-acdd023f0674.ibm.com.com (unknown [9.43.34.89])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 10 Jun 2026 14:28:34 +0000 (GMT)
From: Nilay Shroff <nilay@linux.ibm.com>
To: linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: hch@lst.de, kbusch@kernel.org, sagi@grimberg.me, axboe@fb.com,
        bvanassche@acm.org, elver@google.com, gjoyce@linux.ibm.com,
        Nilay Shroff <nilay@linux.ibm.com>
Subject: [PATCH 11/15] nvme: add Clang context annotations for nvme_queue::sq_lock
Date: Wed, 10 Jun 2026 19:57:31 +0530
Message-ID: <20260610142743.115898-12-nilay@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260610142743.115898-1-nilay@linux.ibm.com>
References: <20260610142743.115898-1-nilay@linux.ibm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-ORIG-GUID: h3xSynwxZMdEHyW9xFcdJ_gP2q10Ji65
X-Proofpoint-GUID: yCR3c4NfMXNMfEfn9rVQAVgskWCFmTpY
X-Authority-Analysis: v=2.4 cv=ZbEt8MVA c=1 sm=1 tr=0 ts=6a297499 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=FelO9ux0wxsA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=CvIxRCW3bcRDgs9PjT4A:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNjEwMDEzNSBTYWx0ZWRfX1hmQ+QnGjH18
 60zPsFbgu91my4VCPQWlS5Cl855PaLxGfZ3w9Uyh96sUyQxNp+yOiNCRy/l7RVQrZIZ5y8H2Tby
 h/z5Tjrz1d1Fl5uvIt6WPSm0nDPzFsblr2/BeG5Bn1geTq3IgdACyi+YGNlVCT8xPHwIyJPPeDK
 NCQ+IIvaAIEt7kYfHO1foPsmprGeFX1rB/xrL2bbB5wZFXyfDd2ifBYbbpzSiG6YIy1c3dqracK
 uwSW6nxsdTVucTy97XDs4UWmllJlKSFoEmwNqYmTH9FjRP7vxYE84LWOgRU0YjvyPUa7J1+r9vz
 lBCVNOG/Fq+Vv/V7nsLClGR/J035tojwKvfJkRomfsKBqvvivUIGktkUltUIw/KCqsAJbtAbX6T
 QdNPP05Y/VJcp/R0HZz2waOOxbvBGsVuwcSgNn7hJUhTmmDoeJOy0dQ//1+qLTqiOmaeuDSaSXY
 j0ARcHaCav4+Ga6nyVQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.125,FMLib:17.12.100.49
 definitions=2026-06-10_03,2026-06-09_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 impostorscore=0 malwarescore=0 lowpriorityscore=0
 clxscore=1015 adultscore=0 spamscore=0 priorityscore=1501 bulkscore=0
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2605210000
 definitions=main-2606100135
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260610_072848_824127_EA26523E 
X-CRM114-Status: GOOD (  17.23  )
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

nvme_queue::sq_tail and nvme_queue::last_sq_tail are protected by
nvme_queue::sq_lock. Annotate both fields with
__guarded_by(&sq_lock) and annotate helpers that access them with
__must_hold(&sq_lock) so that Clang's context analysis can validate
the locking requirements.

Accesses to sq_tail used solely for tracing are annotated with
context_unsafe(), as they only require a lockless snapshot of the
value. Likewise, nvme_init_queue() and nvme_free_queue() operate on
queues that have not yet been published or are no longer reachable,
and therefore do not require sq_lock protection.

Signed-off-by: Nilay Shroff <nilay@linux.ibm.com>
---
 drivers/nvme/host/pci.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 894da63127a7..c464570cffd0 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
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
@@ -2176,6 +2182,7 @@ static int queue_request_irq(struct nvme_queue *nvmeq)
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
+	__context_unsafe(/* safe to init queue without any protection */)
 {
 	struct nvme_dev *dev = nvmeq->dev;
 
-- 
2.53.0


