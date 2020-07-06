Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFC6C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:04 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 88DF0206DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="q3BEiT/C";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="KhHwWLWF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 88DF0206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+uD8FbcWm3WAiFU0vlRgTj4Y2cYEvXKxZpXOI5RE4HM=; b=q3BEiT/CWWo+W/Dd5ko2+vCTF
	9haYd3dt/hOpmynRErC0E/HUmf/NlJoLDA5l5nI6BkxKMQBQ+4DA9iMwq8qwPEj5ylfBkvQRGPlpD
	G3VOam/5FySIjsFs21J7vqhE9uZQ6KQhW6vsmg4NLMfmyl6PBBneUhfwNc7dlW1vx9L1iWD75C53X
	IsdjRDJ8kBRDgEGD6Y18/+vK3buEA3Xv/rv2qXl/A28mmqa4kWA6FCNnvjyMgv48vRDG3BPstWVOT
	HvyE3k4OMwdBWlCvz/pqEEcfye0ZwTujxculQ53wQepJpP+jc1pVwkuEcInNeIPbjnSnqtX5jJVzs
	ETge8AiKQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsbN4-0001iJ-RI; Tue, 07 Jul 2020 00:22:02 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsbN2-0001hf-26
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 00:22:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594081319; x=1625617319;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=xvzI+Fg8w7EykpsxCTC1WJ6YEOzmwitlFLQCiBFAms0=;
 b=KhHwWLWF6LX91uDJ3cY2o8IO20rLJyxIF00FJXAHV4m7+h8Xp40DZeqv
 RCJyP+ddf9YR4brxRyzxbsnUIC1HOD/rw8Rf8UYwpgx8dAUOc3yTpcgCo
 4psIjnFPqUTzyxxpfqmg31x40B+bilPVOzNHFbaE3fcwFJaDc9euH418J
 8HEv6oN7le1mxmn/iDIESkzIDadzRW2mI8oa9lpj1UBUvtAtyUbBfju9V
 m0IKZ8n7eKjp/m1BrcZHKKk/plx35fryeGLJpoS12iMncJhLjJxSPFMfr
 oKCe5pJ2PFJW6OSoVCvh618QQIxXYnCzYPdvqtLcVtqRCV8BKwV9NfGO1 g==;
IronPort-SDR: f5n37XfcmYVAfA7oLPpDANYzUzrzWqzjhx++4E93zi0dAWPwaOn66K3eDiAPEeJokr6CWeIh1J
 hFUhgvV45Jn5JGyVqlExQnDAKMoPOuUPcqW1gzhkuw1YU9GOLiIi0TodHfjYPyLkYsP4VcETK5
 /Lzn3oPwQtZgkZNfHIHPg3wuNsZfA5ruzxto79VPMcGzbhp04ypbI1/eTN+upAfPwJZRhkAcno
 gnUyHGKiKtrA2lm8RG2ai4Q3s+IRtQpN0Uppc50yEiKvw8NjrKO7jVha/+CukgjTr2hwMkMagy
 U4M=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; d="scan'208";a="141770942"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 08:21:57 +0800
IronPort-SDR: PtUIKY+Lr+41N7p4NUt3cda4e2aF11p6ex/H948Uu4702CMwnQIDyIcJXm+EC2Qo8jbaeY+NVO
 TMxd+NNGbMFoGJ1GjsYwTGG3hcsBH9FQk=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 17:10:37 -0700
IronPort-SDR: hUOIABZ6RMZnMXUer7viRkcx6Az9fTzhOZfwsLBfMmVgEXTDGz+l+39Ns5UmgehbcHx9ij7NBW
 rUnuFIo/+CuA==
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jul 2020 17:21:57 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, sagi@grimberg.me
Subject: [RFC PATCH 2/5 COMPILE TESTED] nvme-rdma: reduce
 blk_rq_nr_phys_segments calls
Date: Mon,  6 Jul 2020 16:15:21 -0700
Message-Id: <20200706231524.16831-3-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
References: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200706_202200_231661_EBDD7AC7 
X-CRM114-Status: GOOD (  10.55  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

In the fast path blk_rq_nr_phys_segments() is called twice for RDMA
fabric. The function blk_rq_nr_phys_segments() adds a if check for
special payload. The same check gets repeated number of times we call
the function in the fast path.

In order to minimize repetitive check in the fast path this patch
reduces the number of calls to one and adjust the code in submission
path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/rdma.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 13506a87a444..736e5741dbdc 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -1444,6 +1444,7 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 		struct request *rq, struct nvme_command *c)
 {
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
+	unsigned short nseg = blk_rq_nr_phys_segments(rq);
 	struct nvme_rdma_device *dev = queue->device;
 	struct ib_device *ibdev = dev->dev;
 	int pi_count = 0;
@@ -1454,13 +1455,12 @@ static int nvme_rdma_map_data(struct nvme_rdma_queue *queue,
 
 	c->common.flags |= NVME_CMD_SGL_METABUF;
 
-	if (!blk_rq_nr_phys_segments(rq))
+	if (!nseg)
 		return nvme_rdma_set_sg_null(c);
 
 	req->data_sgl.sg_table.sgl = (struct scatterlist *)(req + 1);
-	ret = sg_alloc_table_chained(&req->data_sgl.sg_table,
-			blk_rq_nr_phys_segments(rq), req->data_sgl.sg_table.sgl,
-			NVME_INLINE_SG_CNT);
+	ret = sg_alloc_table_chained(&req->data_sgl.sg_table, nseg,
+			req->data_sgl.sg_table.sgl, NVME_INLINE_SG_CNT);
 	if (ret)
 		return -ENOMEM;
 
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
