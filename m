Return-Path: <SRS0=yNQM=5Q=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEE98C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:51:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7F88E206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:51:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qwapVtmY";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P5Vc/z36"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7F88E206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=SXXRN1h+/o3euJwTpiLPrQQw8r6pK3kZcsF9a810/jM=; b=qwapVtmY2pB8QjxlbsorJhL5Io
	xLsVef6T8Y131j+onxpaU15vsr7iEDLEOdtJN3Na3Jv0Iqw6aReEw5XhoEHyDsekQKYioH+ECAzP5
	Tvc6v92EwJlkR5/1JbMxzx2gtsZjqnAFm2/DDs+pHkkcyxtubutnrvv0wDLwj1u1yDDGD/BSWdWw/
	fFBtg0s26ISXVcTJ7oXyoRrgx1wEobosSGOGCeytYvYOH8Rk7S9QTXjMcuDeumPjv5v+Jsd+cCefK
	6GzpF0+HGDnmYym1mJJ09zWYiAwFzIUfG5iv/reOEgyBtd0pEGS1jG8qysChBeVB21VzGq4JjbO5x
	Hi83sg4g==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK6s-0005LZ-UC; Tue, 31 Mar 2020 16:51:30 +0000
Received: from mail-wm1-x342.google.com ([2a00:1450:4864:20::342])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK5s-0004OT-Ad
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:31 +0000
Received: by mail-wm1-x342.google.com with SMTP id j19so3616223wmi.2
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=ilMafgc5WW4V5422uWmZvYBCZ6324nhtMgtQvK6TPbM=;
 b=P5Vc/z36rHtyFCXdv1LV8sD8X/y/uXevS06Ojc26SCYczHf7+XLPKR21J6sDa6zPNe
 oTmrhpRET6aeDTzA8Q02OKqAhEryEzo4z3bKfBAacV7TuTtnSjmyAzpCCOC7DAcJuTTH
 pdaRFN65t4ymRpOXn0LYccoiplOY4lprRaMqZFphDXWU3fV4B/nhyuaewkKHgk7plwL9
 NvQVJFMZR86Ro5OzyKXZHzbSRtPb8ep1jqOZuhmk5xXxx1PELF/+w7WFoU2ciMzl1YDN
 u9dcj9BYCAotTr7a0iT/Msz+CDH+hA8Y+9EwQG/Kgll8OIl47RNW5SglBhr/SV5FL17G
 5nWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=ilMafgc5WW4V5422uWmZvYBCZ6324nhtMgtQvK6TPbM=;
 b=puvzfjdCIoBTgbA0Lsah9RwWPMfPCl+t0cma4uTrToT1VZK8q8orGaE3weM9KByp3X
 KSrwUYa9bRmi0G1CfAJRa9KOLSZuoucPJNxOQeqBwcGh2nYXaB6BIch+901GXX/C/KvC
 +t1FhrTo7ldPcHspd01efyDtMeEJKq3fMWRq42ioKVKaxBurEGqm8LBqpVSSnIHTu5zY
 60KyCbz54WwCr55KnqAlXqHw3J0duE2Z2nRPIzXfaQHdfTz7/k7sK3dtxST+p890egjK
 QRQ1pwIQk1QPGeEgUqoOUb63vFbvsrHU/w+ECLuswCGryzqe9r9J0awIGMRuTDQEvk8a
 WX7w==
X-Gm-Message-State: ANhLgQ1dWFB3hNbOGkSwJb5IuYnrX2IjQdrmHI6LYpoll1VxcEyhUHBH
 6V2v7kFvwsXHcPrmz2W4r5KhUqle
X-Google-Smtp-Source: ADFU+vup+AWTBPvfeqtfNWighgP+N7VRJY/qXkRD6pQRrXonwRClnW/fd09u0hoU8ER4hUbOYCkT1Q==
X-Received: by 2002:a1c:4987:: with SMTP id w129mr4602035wma.168.1585673426174; 
 Tue, 31 Mar 2020 09:50:26 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.24
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:25 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 04/26] nvmet-fc: Better size LS buffers
Date: Tue, 31 Mar 2020 09:49:49 -0700
Message-Id: <20200331165011.15819-5-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095028_444500_EF4A4046 
X-CRM114-Status: GOOD (  14.65  )
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
Cc: James Smart <jsmart2021@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Current code uses NVME_FC_MAX_LS_BUFFER_SIZE (2KB) when allocating
buffers for LS requests and responses. This is considerable overkill
for what is actually defined.

Rework code to have unions for all possible requests and responses
and size based on the unions.  Remove NVME_FC_MAX_LS_BUFFER_SIZE.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/fc.h   | 15 ++++++++++++++
 drivers/nvme/target/fc.c | 53 +++++++++++++++++++++---------------------------
 2 files changed, 38 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/fc.h b/drivers/nvme/host/fc.h
index d2861cdd58ee..08fa88381d45 100644
--- a/drivers/nvme/host/fc.h
+++ b/drivers/nvme/host/fc.h
@@ -16,6 +16,21 @@
  * ******************  FC-NVME LS HANDLING ******************
  */
 
+union nvmefc_ls_requests {
+	struct fcnvme_ls_cr_assoc_rqst		rq_cr_assoc;
+	struct fcnvme_ls_cr_conn_rqst		rq_cr_conn;
+	struct fcnvme_ls_disconnect_assoc_rqst	rq_dis_assoc;
+	struct fcnvme_ls_disconnect_conn_rqst	rq_dis_conn;
+} __aligned(128);	/* alignment for other things alloc'd with */
+
+union nvmefc_ls_responses {
+	struct fcnvme_ls_rjt			rsp_rjt;
+	struct fcnvme_ls_cr_assoc_acc		rsp_cr_assoc;
+	struct fcnvme_ls_cr_conn_acc		rsp_cr_conn;
+	struct fcnvme_ls_disconnect_assoc_acc	rsp_dis_assoc;
+	struct fcnvme_ls_disconnect_conn_acc	rsp_dis_conn;
+} __aligned(128);	/* alignment for other things alloc'd with */
+
 static inline void
 nvme_fc_format_rsp_hdr(void *buf, u8 ls_cmd, __be32 desc_len, u8 rqst_ls_cmd)
 {
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index 1f3118a3b0a3..66de6bd8f4fd 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -22,9 +22,6 @@
 
 #define NVMET_LS_CTX_COUNT		256
 
-/* for this implementation, assume small single frame rqst/rsp */
-#define NVME_FC_MAX_LS_BUFFER_SIZE		2048
-
 struct nvmet_fc_tgtport;
 struct nvmet_fc_tgt_assoc;
 
@@ -37,8 +34,8 @@ struct nvmet_fc_ls_iod {
 	struct nvmet_fc_tgtport		*tgtport;
 	struct nvmet_fc_tgt_assoc	*assoc;
 
-	u8				*rqstbuf;
-	u8				*rspbuf;
+	union nvmefc_ls_requests	*rqstbuf;
+	union nvmefc_ls_responses	*rspbuf;
 	u16				rqstdatalen;
 	dma_addr_t			rspdma;
 
@@ -340,15 +337,16 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 		iod->tgtport = tgtport;
 		list_add_tail(&iod->ls_list, &tgtport->ls_list);
 
-		iod->rqstbuf = kcalloc(2, NVME_FC_MAX_LS_BUFFER_SIZE,
-			GFP_KERNEL);
+		iod->rqstbuf = kzalloc(sizeof(union nvmefc_ls_requests) +
+				       sizeof(union nvmefc_ls_responses),
+				       GFP_KERNEL);
 		if (!iod->rqstbuf)
 			goto out_fail;
 
-		iod->rspbuf = iod->rqstbuf + NVME_FC_MAX_LS_BUFFER_SIZE;
+		iod->rspbuf = (union nvmefc_ls_responses *)&iod->rqstbuf[1];
 
 		iod->rspdma = fc_dma_map_single(tgtport->dev, iod->rspbuf,
-						NVME_FC_MAX_LS_BUFFER_SIZE,
+						sizeof(*iod->rspbuf),
 						DMA_TO_DEVICE);
 		if (fc_dma_mapping_error(tgtport->dev, iod->rspdma))
 			goto out_fail;
@@ -361,7 +359,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 	list_del(&iod->ls_list);
 	for (iod--, i--; i >= 0; iod--, i--) {
 		fc_dma_unmap_single(tgtport->dev, iod->rspdma,
-				NVME_FC_MAX_LS_BUFFER_SIZE, DMA_TO_DEVICE);
+				sizeof(*iod->rspbuf), DMA_TO_DEVICE);
 		kfree(iod->rqstbuf);
 		list_del(&iod->ls_list);
 	}
@@ -379,7 +377,7 @@ nvmet_fc_free_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 
 	for (i = 0; i < NVMET_LS_CTX_COUNT; iod++, i++) {
 		fc_dma_unmap_single(tgtport->dev,
-				iod->rspdma, NVME_FC_MAX_LS_BUFFER_SIZE,
+				iod->rspdma, sizeof(*iod->rspbuf),
 				DMA_TO_DEVICE);
 		kfree(iod->rqstbuf);
 		list_del(&iod->ls_list);
@@ -1262,10 +1260,8 @@ static void
 nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
 {
-	struct fcnvme_ls_cr_assoc_rqst *rqst =
-				(struct fcnvme_ls_cr_assoc_rqst *)iod->rqstbuf;
-	struct fcnvme_ls_cr_assoc_acc *acc =
-				(struct fcnvme_ls_cr_assoc_acc *)iod->rspbuf;
+	struct fcnvme_ls_cr_assoc_rqst *rqst = &iod->rqstbuf->rq_cr_assoc;
+	struct fcnvme_ls_cr_assoc_acc *acc = &iod->rspbuf->rsp_cr_assoc;
 	struct nvmet_fc_tgt_queue *queue;
 	int ret = 0;
 
@@ -1313,7 +1309,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 			"Create Association LS failed: %s\n",
 			validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
-				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
+				sizeof(*acc), rqst->w0.ls_cmd,
 				FCNVME_RJT_RC_LOGIC,
 				FCNVME_RJT_EXP_NONE, 0);
 		return;
@@ -1348,10 +1344,8 @@ static void
 nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
 {
-	struct fcnvme_ls_cr_conn_rqst *rqst =
-				(struct fcnvme_ls_cr_conn_rqst *)iod->rqstbuf;
-	struct fcnvme_ls_cr_conn_acc *acc =
-				(struct fcnvme_ls_cr_conn_acc *)iod->rspbuf;
+	struct fcnvme_ls_cr_conn_rqst *rqst = &iod->rqstbuf->rq_cr_conn;
+	struct fcnvme_ls_cr_conn_acc *acc = &iod->rspbuf->rsp_cr_conn;
 	struct nvmet_fc_tgt_queue *queue;
 	int ret = 0;
 
@@ -1404,7 +1398,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 			"Create Connection LS failed: %s\n",
 			validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
-				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
+				sizeof(*acc), rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
 					FCNVME_RJT_RC_INV_ASSOC :
 					FCNVME_RJT_RC_LOGIC,
@@ -1437,9 +1431,9 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
 {
 	struct fcnvme_ls_disconnect_assoc_rqst *rqst =
-			(struct fcnvme_ls_disconnect_assoc_rqst *)iod->rqstbuf;
+						&iod->rqstbuf->rq_dis_assoc;
 	struct fcnvme_ls_disconnect_assoc_acc *acc =
-			(struct fcnvme_ls_disconnect_assoc_acc *)iod->rspbuf;
+						&iod->rspbuf->rsp_dis_assoc;
 	struct nvmet_fc_tgt_assoc *assoc;
 	int ret = 0;
 
@@ -1484,7 +1478,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 			"Disconnect LS failed: %s\n",
 			validation_errors[ret]);
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(acc,
-				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
+				sizeof(*acc), rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
 					FCNVME_RJT_RC_INV_ASSOC :
 					FCNVME_RJT_RC_LOGIC,
@@ -1522,7 +1516,7 @@ nvmet_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 	struct nvmet_fc_tgtport *tgtport = iod->tgtport;
 
 	fc_dma_sync_single_for_cpu(tgtport->dev, iod->rspdma,
-				NVME_FC_MAX_LS_BUFFER_SIZE, DMA_TO_DEVICE);
+				sizeof(*iod->rspbuf), DMA_TO_DEVICE);
 	nvmet_fc_free_ls_iod(tgtport, iod);
 	nvmet_fc_tgtport_put(tgtport);
 }
@@ -1534,7 +1528,7 @@ nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	int ret;
 
 	fc_dma_sync_single_for_device(tgtport->dev, iod->rspdma,
-				  NVME_FC_MAX_LS_BUFFER_SIZE, DMA_TO_DEVICE);
+				  sizeof(*iod->rspbuf), DMA_TO_DEVICE);
 
 	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsrsp);
 	if (ret)
@@ -1548,8 +1542,7 @@ static void
 nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 			struct nvmet_fc_ls_iod *iod)
 {
-	struct fcnvme_ls_rqst_w0 *w0 =
-			(struct fcnvme_ls_rqst_w0 *)iod->rqstbuf;
+	struct fcnvme_ls_rqst_w0 *w0 = &iod->rqstbuf->rq_cr_assoc.w0;
 
 	iod->lsrsp->nvme_fc_private = iod;
 	iod->lsrsp->rspbuf = iod->rspbuf;
@@ -1580,7 +1573,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 		break;
 	default:
 		iod->lsrsp->rsplen = nvme_fc_format_rjt(iod->rspbuf,
-				NVME_FC_MAX_LS_BUFFER_SIZE, w0->ls_cmd,
+				sizeof(*iod->rspbuf), w0->ls_cmd,
 				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
 	}
 
@@ -1627,7 +1620,7 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
 	struct nvmet_fc_ls_iod *iod;
 
-	if (lsreqbuf_len > NVME_FC_MAX_LS_BUFFER_SIZE)
+	if (lsreqbuf_len > sizeof(union nvmefc_ls_requests))
 		return -E2BIG;
 
 	if (!nvmet_fc_tgtport_get(tgtport))
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
