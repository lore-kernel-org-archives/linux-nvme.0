Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76E60C433E0
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:17 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424C8206DF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:22:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="RERyAWKP";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="Ds3Cw3yu"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 424C8206DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=7T5UMg3eGjFZTxva9pTEMQqerbVIziq7hxCcCUdzr1g=; b=RERyAWKPya1yQfIeMGDoycpqF
	ZWvhfi1RIVjr8St57vCYLvPtz6RkTBKHqJrRNsOfUIFRD7zrny8drJ8ZqZfsnzxLsvdiIihH815Nt
	bF9XlTgkPur8J0PIMKn/ZxEuGbVQJ+zB0SCCV8mvy+FS7ZTdk/QfmaeaVmpDsnklR3YzvKUmhAbj0
	hfoTzk4HiHmZIwJ8HxQL6EJAjVDDBruYcO/vF0O7Un5IE+iCSQ3zOkgZdGelx8N9UrjlELhk2MI76
	2MYS8JvjYx5/a8TgHCfvRjMhHQzAnW7JnnRCEmmUshwBnoTYtqxq6vOQ1AZgjWZng6ab0gPqbQ4fk
	NnaTBQuDA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsbNF-0001l0-Ph; Tue, 07 Jul 2020 00:22:13 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsbNC-0001jz-U3
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 00:22:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594081336; x=1625617336;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Vypp3CVMpk8Oe+9p/EZgBU66qFBk+Lxb322upYKrTxc=;
 b=Ds3Cw3yuztU8Jh7aBLjtm8GNsk6k5CUSPN0JV+lPLAMBtQymwSZjFzrf
 IWijx5FtHBYE1qzNv2UNfi5pV4sVPclnXbMA6MSO4G5E3y2Z8qS1ycIx0
 bAsfapaEOK98EUNxVm/y9kL8RWH4d7duCvDSy6PCVZcgKXyXHB/623wgm
 whKSnjxmac6NziJExCJaVs4YkMLf0owUyc+NRdSQlDHtwaBAQwcNm3X6t
 eGk2R7v6oY9g3VHDUg6TgXdmB29F3P2dGlPOnBHfVTccCIHYA3f22+Th8
 O1/iGjehZ1J1XFUgmChyYn8IrI9KbC1CxBK/uqMBOGVzMv/8fC8zesAVQ Q==;
IronPort-SDR: 7snnyNvBLKd9KBLFk5l3XdVu4OqVM1hvBItXPMmeG7uLIaiHu7kNPDXnZjWgssHKFWgQe4/VGM
 TvAWf9bQjlmVDoAEAqPu+x5OQBoC8F+IqoV3/JW94oIHJfBBk8HyVn+twzXGU0Ghr29w3/yn18
 C/tOsKolZkfzIIcu1fG1rmJ+EYen7H7POAm84OfN4/GxcYawLbijeNv+2Nxg4dnphHv8UJYhvU
 TtpoU2Tvq+BUnBe2x0tKCuH7w5j1zTEEmxRdObn2/qmTRYVl2qMPCNULn4Gpi8yef5EPdT0gab
 S5U=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; d="scan'208";a="244791898"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 08:22:14 +0800
IronPort-SDR: uxVPK7QIvA6Yjz4VD3+46ZoGbVkNY5wwSRf3Qbll5LKlF5oMb6EoZts3kL9SYR6MDA/drxNB3N
 bxMhclZaj79DuVWxSBTnxu2IOAlrUT6tM=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 17:10:50 -0700
IronPort-SDR: GNO+NfDvtsLZGQqzJn2Hd5zffILbgs4jhW2ZgbeqCPDbpLxfnaJRki6WCAQcnUExLi7pLQmxWl
 Ym9qoC4epb6w==
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jul 2020 17:22:10 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, sagi@grimberg.me
Subject: [RFC PATCH 4/5 COMPILE TESTED] nvme-fc: reduce
 blk_rq_nr_phys_segments calls
Date: Mon,  6 Jul 2020 16:15:23 -0700
Message-Id: <20200706231524.16831-5-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
References: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200706_202211_159534_216CBB34 
X-CRM114-Status: GOOD (  13.59  )
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

In the fast path blk_rq_nr_phys_segments() is called multiple times
nvme_fc_queue_rq()(1), nvme_fc_map_data()(3) for FC fabric. The function
blk_rq_nr_phys_segments() adds a if check for special payload. The same
check gets repeated number of time we call the function in the fast path.

In order to minimize repetitive check in the fast path this patch
reduces the number of calls to one and adjust the code in submission
path.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 drivers/nvme/host/fc.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index e999a8c4b7e8..7f627890e3de 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2462,25 +2462,24 @@ nvme_fc_timeout(struct request *rq, bool reserved)
 
 static int
 nvme_fc_map_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
-		struct nvme_fc_fcp_op *op)
+		struct nvme_fc_fcp_op *op, unsigned short nseg)
 {
 	struct nvmefc_fcp_req *freq = &op->fcp_req;
 	int ret;
 
 	freq->sg_cnt = 0;
 
-	if (!blk_rq_nr_phys_segments(rq))
+	if (!nseg)
 		return 0;
 
 	freq->sg_table.sgl = freq->first_sgl;
-	ret = sg_alloc_table_chained(&freq->sg_table,
-			blk_rq_nr_phys_segments(rq), freq->sg_table.sgl,
+	ret = sg_alloc_table_chained(&freq->sg_table, nseg, freq->sg_table.sgl,
 			NVME_INLINE_SG_CNT);
 	if (ret)
 		return -ENOMEM;
 
 	op->nents = blk_rq_map_sg(rq->q, rq, freq->sg_table.sgl);
-	WARN_ON(op->nents > blk_rq_nr_phys_segments(rq));
+	WARN_ON(op->nents > nseg);
 	freq->sg_cnt = fc_dma_map_sg(ctrl->lport->dev, freq->sg_table.sgl,
 				op->nents, rq_dma_dir(rq));
 	if (unlikely(freq->sg_cnt <= 0)) {
@@ -2538,7 +2537,7 @@ nvme_fc_unmap_data(struct nvme_fc_ctrl *ctrl, struct request *rq,
 static blk_status_t
 nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	struct nvme_fc_fcp_op *op, u32 data_len,
-	enum nvmefc_fcp_datadir	io_dir)
+	enum nvmefc_fcp_datadir	io_dir, unsigned short nseg)
 {
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
@@ -2595,7 +2594,7 @@ nvme_fc_start_fcp_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_queue *queue,
 	sqe->rw.dptr.sgl.addr = 0;
 
 	if (!(op->flags & FCOP_FLAGS_AEN)) {
-		ret = nvme_fc_map_data(ctrl, op->rq, op);
+		ret = nvme_fc_map_data(ctrl, op->rq, op, nseg);
 		if (ret < 0) {
 			nvme_cleanup_cmd(op->rq);
 			nvme_fc_ctrl_put(ctrl);
@@ -2659,6 +2658,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	struct nvme_fc_queue *queue = hctx->driver_data;
 	struct nvme_fc_ctrl *ctrl = queue->ctrl;
 	struct request *rq = bd->rq;
+	unsigned short nseg = blk_rq_nr_phys_segments(rq);
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
@@ -2683,7 +2683,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	 * more physical segments in the sg list. If there is no
 	 * physical segments, there is no payload.
 	 */
-	if (blk_rq_nr_phys_segments(rq)) {
+	if (nseg) {
 		data_len = blk_rq_payload_bytes(rq);
 		io_dir = ((rq_data_dir(rq) == WRITE) ?
 					NVMEFC_FCP_WRITE : NVMEFC_FCP_READ);
@@ -2693,7 +2693,7 @@ nvme_fc_queue_rq(struct blk_mq_hw_ctx *hctx,
 	}
 
 
-	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir);
+	return nvme_fc_start_fcp_op(ctrl, queue, op, data_len, io_dir, nseg);
 }
 
 static void
@@ -2709,7 +2709,7 @@ nvme_fc_submit_async_event(struct nvme_ctrl *arg)
 	aen_op = &ctrl->aen_ops[0];
 
 	ret = nvme_fc_start_fcp_op(ctrl, aen_op->queue, aen_op, 0,
-					NVMEFC_FCP_NODATA);
+					NVMEFC_FCP_NODATA, 0);
 	if (ret)
 		dev_err(ctrl->ctrl.device,
 			"failed async event work\n");
-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
