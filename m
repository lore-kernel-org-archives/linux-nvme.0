Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C6BEC76196
	for <linux-nvme@archiver.kernel.org>; Fri,  7 Apr 2023 19:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:CC:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+UFhzrSYqKN+JTPh69ZvXohlHMlA6GbEecv7ZNmfRBc=; b=KWQCIn/V+TvHdSnfVACedqvNZB
	P/MP3xtmvtWyn8eUN+dhxcqJTf6w/bdOhY7kW8NhSOVanQI27pSwXT36YOwwrSSJhJCp834GqCLCT
	Achq6C60cG0w4qp4S6mb3KMxsjPE0jQ7C1WN3de/b0yTF8tuWMLxkPeeixIhhLXowNkOG7iAFZMp8
	gJ6ofWozQjQiA20lQ+DwoZKcxOuZmNipcI9mUW70LqNekI+JHwnEc6PvTVC+bZ6W34xBWxzqKl6Md
	jdiocWfuUAe9FMWHheMsEOJeMgACpyYMR3JCiIu1s7ycllthW+c7aqX0E7aMayFFf4ANYGsU2445H
	A5Wx+yvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pkraa-00AxW4-0V;
	Fri, 07 Apr 2023 19:17:36 +0000
Received: from mx0b-00082601.pphosted.com ([67.231.153.30])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pkraX-00AxUx-31
	for linux-nvme@lists.infradead.org;
	Fri, 07 Apr 2023 19:17:35 +0000
Received: from pps.filterd (m0148460.ppops.net [127.0.0.1])
	by mx0a-00082601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 337Gh4qo027808
	for <linux-nvme@lists.infradead.org>; Fri, 7 Apr 2023 12:17:33 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=meta.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references : mime-version :
 content-transfer-encoding : content-type; s=s2048-2021-q4;
 bh=+UFhzrSYqKN+JTPh69ZvXohlHMlA6GbEecv7ZNmfRBc=;
 b=Kx5ChT/ZAC2veEgWkzuJZCBtuUkWcS/9HIW46R16xXGeFjHqh1i5MaP6yeuz7v0l7Ari
 jD7Mpi++ZQ9Bh9YNmTZEEVfR67NGTf1YYcfoRKDAOf1YtPj3IIzk0tWRfBWHQNDj6k1j
 erJTKwL/Q6S8WxYJnbMzBhjwg/FBYKlWWJbprDB7PNpGYrlwtEXcEEq/cj3NuLme2Tmh
 Dzr0CR77f++g+xcgB/RLqNuT9eTwqNFe2iCxSI/gT5MSyiov/9b/+T73gcpjZsR/Eizg
 n+PWf47AvXUdB0aHjc6k+KyasGZZSkSshAQfBqy48W0QmaHhh+DGftUfJui37Gl4DN1p 2w== 
Received: from maileast.thefacebook.com ([163.114.130.16])
	by mx0a-00082601.pphosted.com (PPS) with ESMTPS id 3pt6y25wbs-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT)
	for <linux-nvme@lists.infradead.org>; Fri, 07 Apr 2023 12:17:32 -0700
Received: from twshared25760.37.frc1.facebook.com (2620:10d:c0a8:1b::d) by
 mail.thefacebook.com (2620:10d:c0a8:82::e) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 7 Apr 2023 12:17:01 -0700
Received: by devbig007.nao1.facebook.com (Postfix, from userid 544533)
	id 6CCB9157B5F7F; Fri,  7 Apr 2023 12:16:47 -0700 (PDT)
From: Keith Busch <kbusch@meta.com>
To: <linux-nvme@lists.infradead.org>, <linux-block@vger.kernel.org>,
        <io-uring@vger.kernel.org>, <axboe@kernel.dk>, <hch@lst.de>
CC: <sagi@grimberg.me>, <joshi.k@samsung.com>, Keith Busch <kbusch@kernel.org>
Subject: [PATCHv2 1/5] block: add request polling helper
Date: Fri, 7 Apr 2023 12:16:32 -0700
Message-ID: <20230407191636.2631046-2-kbusch@meta.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230407191636.2631046-1-kbusch@meta.com>
References: <20230407191636.2631046-1-kbusch@meta.com>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-FB-Internal: Safe
Content-Type: text/plain
X-Proofpoint-ORIG-GUID: nzjwWUgam5yXTVElclLvW7yNLt339AqI
X-Proofpoint-GUID: nzjwWUgam5yXTVElclLvW7yNLt339AqI
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-04-07_12,2023-04-06_03,2023-02-09_01
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230407_121734_090009_0AF0F923 
X-CRM114-Status: GOOD (  14.35  )
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

This will be used by drivers that allocate polling requests.

Signed-off-by: Keith Busch <kbusch@kernel.org>
---
 block/blk-mq.c         | 18 ++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 20 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 1b304f66f4e8e..67707a488b7e5 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -4737,6 +4737,24 @@ int blk_mq_poll(struct request_queue *q, blk_qc_t =
cookie, struct io_comp_batch *
 	return 0;
 }
=20
+int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
+		unsigned int poll_flags)
+{
+	struct request_queue *q =3D rq->q;
+	int ret;
+
+	if (!blk_rq_is_poll(rq))
+		return 0;
+	if (!percpu_ref_tryget(&q->q_usage_counter))
+		return 0;
+
+	ret =3D blk_mq_poll(q, blk_rq_to_qc(rq), iob, poll_flags);
+	blk_queue_exit(q);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(blk_rq_poll);
+
 unsigned int blk_mq_rq_cpu(struct request *rq)
 {
 	return rq->mq_ctx->cpu;
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 06caacd77ed66..579818fa1f91d 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -722,6 +722,8 @@ int blk_mq_alloc_sq_tag_set(struct blk_mq_tag_set *se=
t,
 void blk_mq_free_tag_set(struct blk_mq_tag_set *set);
=20
 void blk_mq_free_request(struct request *rq);
+int blk_rq_poll(struct request *rq, struct io_comp_batch *iob,
+		unsigned int poll_flags);
=20
 bool blk_mq_queue_inflight(struct request_queue *q);
=20
--=20
2.34.1


