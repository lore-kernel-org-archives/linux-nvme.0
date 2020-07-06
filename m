Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B2CC433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5E0D4206DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="z2wtjLKw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="bkSvsQaD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5E0D4206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=QE7v1GBtb3P6zqblRJoEtrleyYOsj7WtcyDoD2vSNuA=; b=z2wtjLKwa5SrgVtwLAIDf7C/P
	Ca8Ztf8zQzSYCx5qsbO/yt2BUfFSFVx4wSS6sv1MHdBylO7ITbPFmIRDzk28osctpxevnwM56nIYM
	xuai7ped72p0fccS7XrYNwEljGd3bsQiKZH4wTYUf087qH5EVQzaRaOZ7n1gAKLs0NkqkWuCliLtJ
	pbpBk5RQGpjeToR85WW6D9M5MvMOLEOTdH04vWOzmInzbsU0znwd2TXq+58aCHh7mBghgRPt2DjON
	n1EHSZ54rwd4ibea/ACPcadl72qpIufxRp4+N51j6+W2Tthu6LnIRfZEsq39fYxBDTSDNlN16iuAO
	snzsF0rUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsbNN-0001nU-S6; Tue, 07 Jul 2020 00:22:21 +0000
Received: from esa4.hgst.iphmx.com ([216.71.154.42])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsbNK-0001mK-W8
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 00:22:19 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594081338; x=1625617338;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=5Ug0MLLy8R6AUWOnWd/wQSeyUo4cHzB9IV7AN6YecyQ=;
 b=bkSvsQaDoCnwYiLS4AWs+Xlt9DXbK21IN9ieyXCmv4/MRAlpDEtQYVEW
 vqJA4GZyHEXMrOf/MsNzweIqkFxgMdRRWcjEcvTtDfljynibjwYuFWEyu
 iLqD0C1UYyEDf9l8ZSgvR1OBvE0QKc9S7VkiFHPi0Z9Qn8g2umklR/Uyh
 vtekRFw4m4uEVSvOfsMSsPWHyuOlpSMqWvWqH+A8w72vMi59O2Rr2uyXJ
 gzBsV3yqWQgt2NFfnM3yXJrJJZYeTg9oyeEx4po17NGYz6LpQE8El6K5N
 kHzr1xyNIcYeiCOZxMN7E8ii6rYAefA1AO4jh9KlZw5yzQuagnLPlqT4N Q==;
IronPort-SDR: q0uh0+L55cVQ3Ad1bmsv3xXxUL8NHmMgMQ28Dk3915foYbuDzWu0YgOp52FqmcjgVpfHLEi2d2
 qjMOqVb6VxINaZeZrFvJ53vavtQOAlXXogbsH1oHDvdQJNLzrSif+VnKbnsvsUs1Vo/nvUwCkL
 0rACNF/tPpYG99y/oKiNhvR8n92q3uARwmvOvh+WZbvdzjFRD5MgMHyjCsr53QwbhDjQqaQ+jR
 7EndSXMHr/0olkTccoG+YV847iHpBNZQ0ac0zfk2EuMVHP4jjADv4j7y5ay3wa3vGXHMBtR/+L
 ho4=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; d="scan'208";a="141770960"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 08:22:18 +0800
IronPort-SDR: hC2w1tah5Dbov3Y5Efocrno+xfUrcKwFzWy8kLJDks3FxAxNdZYdvpMpZocOhP3IADDjoun7nT
 T1w6TU+mHhOEdajYXN7UHd+/MuMsHs1E4=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 17:10:25 -0700
IronPort-SDR: +EZQFvbpTADXoTrMM5Iy3Mi3CAJ56XgY3F8R9HnpPxSevfO98EkS3B6VpGF14gG44upoFt4hd/
 hX8hEuBETivQ==
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jul 2020 17:22:18 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, sagi@grimberg.me
Subject: [RFC PATCH 5/5] nvme-loop: reduce blk_rq_nr_phys_segments calls
Date: Mon,  6 Jul 2020 16:15:24 -0700
Message-Id: <20200706231524.16831-6-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
References: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200706_202219_177239_2C32980D 
X-CRM114-Status: GOOD (  10.33  )
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

In the fast path blk_rq_nr_phys_segments() is called twice for
nvme-loop. The function blk_rq_nr_phys_segments() adds a if check for
special payload. The same check gets repeated number of times we call
the function in the fast path.

In order to minimize repetitive check in the fast path this patch
reduces the number of calls to one and adjust the code in submission
path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/target/loop.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/target/loop.c b/drivers/nvme/target/loop.c
index 6e8d14a8227c..b5a93b9db783 100644
--- a/drivers/nvme/target/loop.c
+++ b/drivers/nvme/target/loop.c
@@ -130,6 +130,7 @@ static void nvme_loop_execute_work(struct work_struct *work)
 static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 		const struct blk_mq_queue_data *bd)
 {
+	unsigned short nseg = blk_rq_nr_phys_segments(bd->rq);
 	struct nvme_ns *ns = hctx->queue->queuedata;
 	struct nvme_loop_queue *queue = hctx->driver_data;
 	struct request *req = bd->rq;
@@ -151,10 +152,9 @@ static blk_status_t nvme_loop_queue_rq(struct blk_mq_hw_ctx *hctx,
 			&queue->nvme_sq, &nvme_loop_ops))
 		return BLK_STS_OK;
 
-	if (blk_rq_nr_phys_segments(req)) {
+	if (nseg) {
 		iod->sg_table.sgl = iod->first_sgl;
-		if (sg_alloc_table_chained(&iod->sg_table,
-				blk_rq_nr_phys_segments(req),
+		if (sg_alloc_table_chained(&iod->sg_table, nseg,
 				iod->sg_table.sgl, NVME_INLINE_SG_CNT)) {
 			nvme_cleanup_cmd(req);
 			return BLK_STS_RESOURCE;
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
