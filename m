Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CBE6C76196
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Mar 2023 21:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:CC:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=2umER3Yy5QQjdTn23cuNP0N+AWlhdN1P40sj7bMbuKM=; b=CVwpDGyykdS6ckEYyfgNvko0sE
	SuoSTVOzNwLnOKlghV+Srsfg5MMhr528rI4VefoPpDY8iVdQHKejj2qlGLzO18PupRhxCA79s8AVq
	742/9aviG0pbnDltMPuUIlcyQ3LgW+fBVw/2a3ENot2u0VKz93y7yzqCBHoPrRGm9z3YID6ee31uh
	tFuMkJ/evGYc8nbWF5B6rp5P10zxsHjAXoha+CoB+rVppgS1I2nywLjuHAatoQaKHaC0+frA4qMOY
	sPuRRyI0bV9BRWiIodYylDSDHwOQPykaFfgVZAfgjHQIJiD6DKuGR5DHbQPc9u+dKPKqav17r/Stp
	SnRvOaTA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pfoxQ-005eC7-0p;
	Fri, 24 Mar 2023 21:28:20 +0000
Received: from mx0a-00082601.pphosted.com ([67.231.145.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pfoxN-005eBG-2U
	for linux-nvme@lists.infradead.org;
	Fri, 24 Mar 2023 21:28:19 +0000
Received: from pps.filterd (m0109333.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32OGOQID000497
	for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 14:28:16 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : mime-version : content-transfer-encoding :
 content-type; s=s2048-2021-q4;
 bh=2umER3Yy5QQjdTn23cuNP0N+AWlhdN1P40sj7bMbuKM=;
 b=bFWV+bjxAj5EIPYMUdyM1kPmJQtwm0DgaqDj33k2/1UgKqtOLZat4pma2qJ8R0NQeaWI
 O4P2h5Rs9Go4f3+vV+r0JbfHNty0WgDWdNOLUNQEDS7giDKMrEdNQWtcs5SC5eqmQ2CO
 HQgMpUoGtL/AzRsZrjG9Zyh5c3cdD/oK9tvPLsbXb7pW5I4HnPdtYGID5+FARJ/WIw62
 HUrLqGDLKm+8H/+0UKPw9Y4zd319XYjw+bGIhu0GmikO4JgQXOsDV/1J8VhkQ+H6aaWQ
 P6ZRAPCbiZf7V4LOvj5H0g3yOufwvzNUPCvt6NELGmusSn4YMKwBvVdBBB7FQwry5k07 Gg== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pgxmqxp32-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 24 Mar 2023 14:28:16 -0700
Received: from ash-exhub204.TheFacebook.com (2620:10d:c0a8:83::4) by
 ash-exhub101.TheFacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Mar 2023 14:28:15 -0700
Received: from twshared52565.14.frc2.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:83::4) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 24 Mar 2023 14:28:14 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id C5CA31456476F; Fri, 24 Mar 2023 14:28:04 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-block@vger.kernel.org>, <linux-nvme@lists.infradead.org>,
        <axboe@kernel.dk>, <hch@lst.de>
CC: Keith Busch <kbusch@kernel.org>
Subject: [PATCH 1/2] blk-mq: export request polling helpers
Date: Fri, 24 Mar 2023 14:28:02 -0700
Message-ID: <20230324212803.1837554-1-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-GUID: isDsMoSJLFarYqatZyLDzycb664DFW8-
X-Proofpoint-ORIG-GUID: isDsMoSJLFarYqatZyLDzycb664DFW8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-24_01,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230324_142817_816461_AB44803F 
X-CRM114-Status: GOOD (  16.69  )
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

From: Keith Busch <kbusch@kernel.org>

These will be used by drivers later.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 6 +-----
 block/blk-mq.h         | 2 --
 include/linux/blk-mq.h | 7 +++++++
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 37d8a2f4d5da8..34ac95fc43a66 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -52,11 +52,6 @@ static inline struct blk_mq_hw_ctx *blk_qc_to_hctx(str=
uct request_queue *q,
 	return xa_load(&q->hctx_table, qc);
 }
=20
-static inline blk_qc_t blk_rq_to_qc(struct request *rq)
-{
-	return rq->mq_hctx->queue_num;
-}
-
 /*
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
@@ -4744,6 +4739,7 @@ int blk_mq_poll(struct request_queue *q, blk_qc_t c=
ookie, struct io_comp_batch *
 	__set_current_state(TASK_RUNNING);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(blk_mq_poll);
=20
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
diff --git a/block/blk-mq.h b/block/blk-mq.h
index ef59fee62780d..92bc058fba3e5 100644
--- a/block/blk-mq.h
+++ b/block/blk-mq.h
@@ -31,8 +31,6 @@ struct blk_mq_ctx {
 } ____cacheline_aligned_in_smp;
=20
 void blk_mq_submit_bio(struct bio *bio);
-int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp=
_batch *iob,
-		unsigned int flags);
 void blk_mq_exit_queue(struct request_queue *q);
 int blk_mq_update_nr_requests(struct request_queue *q, unsigned int nr);
 void blk_mq_wake_waiters(struct request_queue *q);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1dacb2c81fdda..ed10b5e380103 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -438,6 +438,11 @@ struct blk_mq_hw_ctx {
 	struct list_head	hctx_list;
 };
=20
+static inline blk_qc_t blk_rq_to_qc(struct request *rq)
+{
+	return rq->mq_hctx->queue_num;
+}
+
 /**
  * struct blk_mq_queue_map - Map software queues to hardware queues
  * @mq_map:       CPU ID to hardware queue index map. This is an array
@@ -716,6 +721,8 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *se=
t,
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
=20
 void blk_mq_free_request(struct request *rq);
+int blk_mq_poll(struct request_queue *q, blk_qc_t cookie, struct io_comp=
_batch *iob,
+		unsigned int flags);
=20
 bool blk_mq_queue_inflight(struct request_queue *q);
=20
--=20
2.34.1


