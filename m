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
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5A95C43331
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:51:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD093206CC
	for <linux-nvme@archiver.kernel.org>; Tue, 31 Mar 2020 16:51:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EJN80j3s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X/2Touvj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD093206CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=0xXxHLileBjfW/aKWvtDzoDysRgCrCvzoMtOQuLVAmY=; b=EJN80j3sKquzS+8v/WVbEpLGbe
	odsGLdqFKmOm/NRpm4NYJn/09FTITZz0ydXE19ZsTiEtPmQOnYHUTanyaIcWwjryUnMTh2T0WUBpy
	Fb5sKLBoJlRVaSzjVtI5wyZ6tK5Y9rcQo0Jm7iQkndB2msReo3BEXy68ETIjoYItCt40Pzh78jbr6
	1PGUaQd4OgnJOtL56TJVrenMFuPd4f/w68/I3YgZzOSnrS6OQcKNVe1usDPx6iDVaRSOjkPdSUXhG
	XVyCIaNwitJDi1r7hzAJUjcKxvtiGnQPLKkVkIB8EzSmnzVc7m1LLHqDHEOsgi+VZlihkXOQfRT/z
	EKbZ0yqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jJK6W-00055a-6x; Tue, 31 Mar 2020 16:51:08 +0000
Received: from mail-wr1-x444.google.com ([2a00:1450:4864:20::444])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jJK5p-0004LB-93
 for linux-nvme@lists.infradead.org; Tue, 31 Mar 2020 16:50:30 +0000
Received: by mail-wr1-x444.google.com with SMTP id 31so26886492wrs.3
 for <linux-nvme@lists.infradead.org>; Tue, 31 Mar 2020 09:50:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=khAqre7Fy0dwjBm6EfbkqFpe2M1ffpuMr1aqq/Cea/U=;
 b=X/2TouvjwMiKH3zKTLvnU+K+YIR+9dAVbCJRbrSap1vew7OsIaDohHsRCGOproKEkA
 tHSkMoU+k0hwv7SLQxTqr7sm9OWH67XTVCsIHpcSaHJOYMEr+2+0HxxPAqY7NdMPbmK+
 OjLjbeWeMAbr8/RD4yKdrk4CagSSWNPhuTi8GOpwVXGR2qGpCGEKtiPZlCzkzltbq8PF
 K48tXmnVhiI+dz9JRIEceaoAqcPoe+QL1bSPBC1h2JJa6oS0akrWe9wEt4BXQbcBfNqE
 HbS0VGgpEK0A1p/koqQXyPKjNH61hkADVZb6FBp0V4376hRaVjx7fITatO1N41orMhzO
 F+nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=khAqre7Fy0dwjBm6EfbkqFpe2M1ffpuMr1aqq/Cea/U=;
 b=c0kycT3JxZeHGm0dd/YFWp1NrnvpdAq8VeU74VfojEbpFwEIhU7SUkOFVL5h7AIgZM
 WVbtxlRXwN5RM6EmbDMz/QxwudfM7PW+wdfVmkDZMnZelwZXZMt0cfkBdD8lHR45DC+E
 Z4ss7b+CarbDhmIOheVot/6+GNkY4I1Za5iHDqJpHW5yhdufcp5ZXNoqxoq0L+Khdy8p
 s8Yfjsz0+S53S1wn9cNd/fU8ZMKggtB9HV7tmVYBxlIlZygusD1I3yErMQF7Ye04HPRg
 TFBSMGtF2VPfL3lsOES/WWQs/y0MzmCCYHgH1NXeOMSU9pmusCq0FrCkxbm8jXox9QnN
 vRXw==
X-Gm-Message-State: ANhLgQ1Y6o/EZ7mxa5OwDyBoeCT5LxJkQjsXyP8GX/BlJGiEdQ14r/Dv
 wJQF+OXLDI9U/5feWRCXuwkkTqOB
X-Google-Smtp-Source: ADFU+vsQPPZ/kwqEHtdnERXcbJNdYaORsiwqBImcskBUsgni7y+aQ/5piZ14DkNkwJ/2Qy0H2lzC2w==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr22204888wrv.95.1585673421928; 
 Tue, 31 Mar 2020 09:50:21 -0700 (PDT)
Received: from localhost.localdomain.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id r14sm2711582wmg.0.2020.03.31.09.50.20
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 31 Mar 2020 09:50:21 -0700 (PDT)
From: James Smart <jsmart2021@gmail.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 02/26] nvme-fc and nvmet-fc: revise LLDD api for LS
 reception and LS request
Date: Tue, 31 Mar 2020 09:49:47 -0700
Message-Id: <20200331165011.15819-3-jsmart2021@gmail.com>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200331165011.15819-1-jsmart2021@gmail.com>
References: <20200331165011.15819-1-jsmart2021@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200331_095025_323468_1A208B82 
X-CRM114-Status: GOOD (  24.83  )
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

The current LLDD api has:
  nvme-fc: contains api for transport to do LS requests (and aborts of
    them). However, there is no interface for reception of LS's and sending
    responses for them.
  nvmet-fc: contains api for transport to do reception of LS's and sending
    of responses for them. However, there is no interface for doing LS
    requests.

Revise the api's so that both nvme-fc and nvmet-fc can send LS's, as well
as receiving LS's and sending their responses.

Change name of the rcv_ls_req struct to better reflect generic use as
a context to used to send an ls rsp. Specifically:
  nvmefc_tgt_ls_req -> nvmefc_ls_rsp
  nvmefc_tgt_ls_req.nvmet_fc_private -> nvmefc_ls_rsp.nvme_fc_private

Change nvmet_fc_rcv_ls_req() calling sequence to provide handle that
can be used by transport in later LS request sequences for an association.

nvme-fc nvmet_fc nvme_fcloop:
  Revise to adapt to changed names in api header.
  Change calling sequence to nvmet_fc_rcv_ls_req() for hosthandle.
  Add stubs for new interfaces:
    host/fc.c: nvme_fc_rcv_ls_req()
    target/fc.c: nvmet_fc_invalidate_host()

lpfc:
  Revise to adapt code to changed names in api header.
  Change calling sequence to nvmet_fc_rcv_ls_req() for hosthandle.

Signed-off-by: James Smart <jsmart2021@gmail.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>

---
v2:
  Combined the 3 patches that were present earlier to ensure compilation
    still occurs. Prior 3 patches were:
      patch to change headers
      patch to sync nvme-fc/nvmet-fc/nvme-fcloop with headers
      patch to sync lpfc with headers
---
 drivers/nvme/host/fc.c         |  35 ++++
 drivers/nvme/target/fc.c       |  77 ++++++---
 drivers/nvme/target/fcloop.c   |  20 +--
 drivers/scsi/lpfc/lpfc_nvmet.c |  10 +-
 drivers/scsi/lpfc/lpfc_nvmet.h |   2 +-
 include/linux/nvme-fc-driver.h | 368 ++++++++++++++++++++++++++++++-----------
 6 files changed, 378 insertions(+), 134 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index a8bf2fb1287b..d6e8edddbbf0 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1465,6 +1465,41 @@ nvme_fc_xmt_disconnect_assoc(struct nvme_fc_ctrl *ctrl)
 		kfree(lsop);
 }
 
+/**
+ * nvme_fc_rcv_ls_req - transport entry point called by an LLDD
+ *                       upon the reception of a NVME LS request.
+ *
+ * The nvme-fc layer will copy payload to an internal structure for
+ * processing.  As such, upon completion of the routine, the LLDD may
+ * immediately free/reuse the LS request buffer passed in the call.
+ *
+ * If this routine returns error, the LLDD should abort the exchange.
+ *
+ * @remoteport: pointer to the (registered) remote port that the LS
+ *              was received from. The remoteport is associated with
+ *              a specific localport.
+ * @lsrsp:      pointer to a nvmefc_ls_rsp response structure to be
+ *              used to reference the exchange corresponding to the LS
+ *              when issuing an ls response.
+ * @lsreqbuf:   pointer to the buffer containing the LS Request
+ * @lsreqbuf_len: length, in bytes, of the received LS request
+ */
+int
+nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *portptr,
+			struct nvmefc_ls_rsp *lsrsp,
+			void *lsreqbuf, u32 lsreqbuf_len)
+{
+	struct nvme_fc_rport *rport = remoteport_to_rport(portptr);
+	struct nvme_fc_lport *lport = rport->lport;
+
+	/* validate there's a routine to transmit a response */
+	if (!lport->ops->xmt_ls_rsp)
+		return(-EINVAL);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(nvme_fc_rcv_ls_req);
+
 
 /* *********************** NVME Ctrl Routines **************************** */
 
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index a8ceb7721640..aac7869a70bb 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -28,7 +28,7 @@ struct nvmet_fc_tgtport;
 struct nvmet_fc_tgt_assoc;
 
 struct nvmet_fc_ls_iod {
-	struct nvmefc_tgt_ls_req	*lsreq;
+	struct nvmefc_ls_rsp		*lsrsp;
 	struct nvmefc_tgt_fcp_req	*fcpreq;	/* only if RS */
 
 	struct list_head		ls_list;	/* tgtport->ls_list */
@@ -1146,6 +1146,42 @@ __nvmet_fc_free_assocs(struct nvmet_fc_tgtport *tgtport)
 	spin_unlock_irqrestore(&tgtport->lock, flags);
 }
 
+/**
+ * nvmet_fc_invalidate_host - transport entry point called by an LLDD
+ *                       to remove references to a hosthandle for LS's.
+ *
+ * The nvmet-fc layer ensures that any references to the hosthandle
+ * on the targetport are forgotten (set to NULL).  The LLDD will
+ * typically call this when a login with a remote host port has been
+ * lost, thus LS's for the remote host port are no longer possible.
+ *
+ * If an LS request is outstanding to the targetport/hosthandle (or
+ * issued concurrently with the call to invalidate the host), the
+ * LLDD is responsible for terminating/aborting the LS and completing
+ * the LS request. It is recommended that these terminations/aborts
+ * occur after calling to invalidate the host handle to avoid additional
+ * retries by the nvmet-fc transport. The nvmet-fc transport may
+ * continue to reference host handle while it cleans up outstanding
+ * NVME associations. The nvmet-fc transport will call the
+ * ops->host_release() callback to notify the LLDD that all references
+ * are complete and the related host handle can be recovered.
+ * Note: if there are no references, the callback may be called before
+ * the invalidate host call returns.
+ *
+ * @target_port: pointer to the (registered) target port that a prior
+ *              LS was received on and which supplied the transport the
+ *              hosthandle.
+ * @hosthandle: the handle (pointer) that represents the host port
+ *              that no longer has connectivity and that LS's should
+ *              no longer be directed to.
+ */
+void
+nvmet_fc_invalidate_host(struct nvmet_fc_target_port *target_port,
+			void *hosthandle)
+{
+}
+EXPORT_SYMBOL_GPL(nvmet_fc_invalidate_host);
+
 /*
  * nvmet layer has called to terminate an association
  */
@@ -1371,7 +1407,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Create Association LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				FCNVME_RJT_RC_LOGIC,
 				FCNVME_RJT_EXP_NONE, 0);
@@ -1384,7 +1420,7 @@ nvmet_fc_ls_create_association(struct nvmet_fc_tgtport *tgtport,
 
 	/* format a response */
 
-	iod->lsreq->rsplen = sizeof(*acc);
+	iod->lsrsp->rsplen = sizeof(*acc);
 
 	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(
@@ -1462,7 +1498,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Create Connection LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
 					FCNVME_RJT_RC_INV_ASSOC :
@@ -1477,7 +1513,7 @@ nvmet_fc_ls_create_connection(struct nvmet_fc_tgtport *tgtport,
 
 	/* format a response */
 
-	iod->lsreq->rsplen = sizeof(*acc);
+	iod->lsrsp->rsplen = sizeof(*acc);
 
 	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(sizeof(struct fcnvme_ls_cr_conn_acc)),
@@ -1542,7 +1578,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 		dev_err(tgtport->dev,
 			"Disconnect LS failed: %s\n",
 			validation_errors[ret]);
-		iod->lsreq->rsplen = nvmet_fc_format_rjt(acc,
+		iod->lsrsp->rsplen = nvmet_fc_format_rjt(acc,
 				NVME_FC_MAX_LS_BUFFER_SIZE, rqst->w0.ls_cmd,
 				(ret == VERR_NO_ASSOC) ?
 					FCNVME_RJT_RC_INV_ASSOC :
@@ -1555,7 +1591,7 @@ nvmet_fc_ls_disconnect(struct nvmet_fc_tgtport *tgtport,
 
 	/* format a response */
 
-	iod->lsreq->rsplen = sizeof(*acc);
+	iod->lsrsp->rsplen = sizeof(*acc);
 
 	nvmet_fc_format_rsp_hdr(acc, FCNVME_LS_ACC,
 			fcnvme_lsdesc_len(
@@ -1577,9 +1613,9 @@ static void nvmet_fc_fcp_nvme_cmd_done(struct nvmet_req *nvme_req);
 static const struct nvmet_fabrics_ops nvmet_fc_tgt_fcp_ops;
 
 static void
-nvmet_fc_xmt_ls_rsp_done(struct nvmefc_tgt_ls_req *lsreq)
+nvmet_fc_xmt_ls_rsp_done(struct nvmefc_ls_rsp *lsrsp)
 {
-	struct nvmet_fc_ls_iod *iod = lsreq->nvmet_fc_private;
+	struct nvmet_fc_ls_iod *iod = lsrsp->nvme_fc_private;
 	struct nvmet_fc_tgtport *tgtport = iod->tgtport;
 
 	fc_dma_sync_single_for_cpu(tgtport->dev, iod->rspdma,
@@ -1597,9 +1633,9 @@ nvmet_fc_xmt_ls_rsp(struct nvmet_fc_tgtport *tgtport,
 	fc_dma_sync_single_for_device(tgtport->dev, iod->rspdma,
 				  NVME_FC_MAX_LS_BUFFER_SIZE, DMA_TO_DEVICE);
 
-	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsreq);
+	ret = tgtport->ops->xmt_ls_rsp(&tgtport->fc_target_port, iod->lsrsp);
 	if (ret)
-		nvmet_fc_xmt_ls_rsp_done(iod->lsreq);
+		nvmet_fc_xmt_ls_rsp_done(iod->lsrsp);
 }
 
 /*
@@ -1612,12 +1648,12 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 	struct fcnvme_ls_rqst_w0 *w0 =
 			(struct fcnvme_ls_rqst_w0 *)iod->rqstbuf;
 
-	iod->lsreq->nvmet_fc_private = iod;
-	iod->lsreq->rspbuf = iod->rspbuf;
-	iod->lsreq->rspdma = iod->rspdma;
-	iod->lsreq->done = nvmet_fc_xmt_ls_rsp_done;
+	iod->lsrsp->nvme_fc_private = iod;
+	iod->lsrsp->rspbuf = iod->rspbuf;
+	iod->lsrsp->rspdma = iod->rspdma;
+	iod->lsrsp->done = nvmet_fc_xmt_ls_rsp_done;
 	/* Be preventative. handlers will later set to valid length */
-	iod->lsreq->rsplen = 0;
+	iod->lsrsp->rsplen = 0;
 
 	iod->assoc = NULL;
 
@@ -1640,7 +1676,7 @@ nvmet_fc_handle_ls_rqst(struct nvmet_fc_tgtport *tgtport,
 		nvmet_fc_ls_disconnect(tgtport, iod);
 		break;
 	default:
-		iod->lsreq->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
+		iod->lsrsp->rsplen = nvmet_fc_format_rjt(iod->rspbuf,
 				NVME_FC_MAX_LS_BUFFER_SIZE, w0->ls_cmd,
 				FCNVME_RJT_RC_INVAL, FCNVME_RJT_EXP_NONE, 0);
 	}
@@ -1674,14 +1710,15 @@ nvmet_fc_handle_ls_rqst_work(struct work_struct *work)
  *
  * @target_port: pointer to the (registered) target port the LS was
  *              received on.
- * @lsreq:      pointer to a lsreq request structure to be used to reference
+ * @lsrsp:      pointer to a lsrsp structure to be used to reference
  *              the exchange corresponding to the LS.
  * @lsreqbuf:   pointer to the buffer containing the LS Request
  * @lsreqbuf_len: length, in bytes, of the received LS request
  */
 int
 nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
-			struct nvmefc_tgt_ls_req *lsreq,
+			void *hosthandle,
+			struct nvmefc_ls_rsp *lsrsp,
 			void *lsreqbuf, u32 lsreqbuf_len)
 {
 	struct nvmet_fc_tgtport *tgtport = targetport_to_tgtport(target_port);
@@ -1699,7 +1736,7 @@ nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *target_port,
 		return -ENOENT;
 	}
 
-	iod->lsreq = lsreq;
+	iod->lsrsp = lsrsp;
 	iod->fcpreq = NULL;
 	memcpy(iod->rqstbuf, lsreqbuf, lsreqbuf_len);
 	iod->rqstdatalen = lsreqbuf_len;
diff --git a/drivers/nvme/target/fcloop.c b/drivers/nvme/target/fcloop.c
index 9861fcea39f6..6533f4196005 100644
--- a/drivers/nvme/target/fcloop.c
+++ b/drivers/nvme/target/fcloop.c
@@ -228,7 +228,7 @@ struct fcloop_nport {
 
 struct fcloop_lsreq {
 	struct nvmefc_ls_req		*lsreq;
-	struct nvmefc_tgt_ls_req	tgt_ls_req;
+	struct nvmefc_ls_rsp		ls_rsp;
 	int				status;
 	struct list_head		ls_list; /* fcloop_rport->ls_list */
 };
@@ -267,9 +267,9 @@ struct fcloop_ini_fcpreq {
 };
 
 static inline struct fcloop_lsreq *
-tgt_ls_req_to_lsreq(struct nvmefc_tgt_ls_req *tgt_lsreq)
+ls_rsp_to_lsreq(struct nvmefc_ls_rsp *lsrsp)
 {
-	return container_of(tgt_lsreq, struct fcloop_lsreq, tgt_ls_req);
+	return container_of(lsrsp, struct fcloop_lsreq, ls_rsp);
 }
 
 static inline struct fcloop_fcpreq *
@@ -344,7 +344,7 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
 	}
 
 	tls_req->status = 0;
-	ret = nvmet_fc_rcv_ls_req(rport->targetport, &tls_req->tgt_ls_req,
+	ret = nvmet_fc_rcv_ls_req(rport->targetport, NULL, &tls_req->ls_rsp,
 				 lsreq->rqstaddr, lsreq->rqstlen);
 
 	return ret;
@@ -352,19 +352,19 @@ fcloop_ls_req(struct nvme_fc_local_port *localport,
 
 static int
 fcloop_xmt_ls_rsp(struct nvmet_fc_target_port *targetport,
-			struct nvmefc_tgt_ls_req *tgt_lsreq)
+			struct nvmefc_ls_rsp *lsrsp)
 {
-	struct fcloop_lsreq *tls_req = tgt_ls_req_to_lsreq(tgt_lsreq);
+	struct fcloop_lsreq *tls_req = ls_rsp_to_lsreq(lsrsp);
 	struct nvmefc_ls_req *lsreq = tls_req->lsreq;
 	struct fcloop_tport *tport = targetport->private;
 	struct nvme_fc_remote_port *remoteport = tport->remoteport;
 	struct fcloop_rport *rport;
 
-	memcpy(lsreq->rspaddr, tgt_lsreq->rspbuf,
-		((lsreq->rsplen < tgt_lsreq->rsplen) ?
-				lsreq->rsplen : tgt_lsreq->rsplen));
+	memcpy(lsreq->rspaddr, lsrsp->rspbuf,
+		((lsreq->rsplen < lsrsp->rsplen) ?
+				lsreq->rsplen : lsrsp->rsplen));
 
-	tgt_lsreq->done(tgt_lsreq);
+	lsrsp->done(lsrsp);
 
 	if (remoteport) {
 		rport = remoteport->private;
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.c b/drivers/scsi/lpfc/lpfc_nvmet.c
index 9dc9afe1c255..47b983eddbb2 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.c
+++ b/drivers/scsi/lpfc/lpfc_nvmet.c
@@ -302,7 +302,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 			  struct lpfc_wcqe_complete *wcqe)
 {
 	struct lpfc_nvmet_tgtport *tgtp;
-	struct nvmefc_tgt_ls_req *rsp;
+	struct nvmefc_ls_rsp *rsp;
 	struct lpfc_nvmet_rcv_ctx *ctxp;
 	uint32_t status, result;
 
@@ -335,7 +335,7 @@ lpfc_nvmet_xmt_ls_rsp_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 	}
 
 out:
-	rsp = &ctxp->ctx.ls_req;
+	rsp = &ctxp->ctx.ls_rsp;
 
 	lpfc_nvmeio_data(phba, "NVMET LS  CMPL: xri x%x stat x%x result x%x\n",
 			 ctxp->oxid, status, result);
@@ -830,10 +830,10 @@ lpfc_nvmet_xmt_fcp_op_cmp(struct lpfc_hba *phba, struct lpfc_iocbq *cmdwqe,
 
 static int
 lpfc_nvmet_xmt_ls_rsp(struct nvmet_fc_target_port *tgtport,
-		      struct nvmefc_tgt_ls_req *rsp)
+		      struct nvmefc_ls_rsp *rsp)
 {
 	struct lpfc_nvmet_rcv_ctx *ctxp =
-		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.ls_req);
+		container_of(rsp, struct lpfc_nvmet_rcv_ctx, ctx.ls_rsp);
 	struct lpfc_hba *phba = ctxp->phba;
 	struct hbq_dmabuf *nvmebuf =
 		(struct hbq_dmabuf *)ctxp->rqb_buffer;
@@ -2000,7 +2000,7 @@ lpfc_nvmet_unsol_ls_buffer(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 	 * lpfc_nvmet_xmt_ls_rsp_cmp should free the allocated ctxp.
 	 */
 	atomic_inc(&tgtp->rcv_ls_req_in);
-	rc = nvmet_fc_rcv_ls_req(phba->targetport, &ctxp->ctx.ls_req,
+	rc = nvmet_fc_rcv_ls_req(phba->targetport, NULL, &ctxp->ctx.ls_rsp,
 				 payload, size);
 
 	lpfc_printf_log(phba, KERN_INFO, LOG_NVME_DISC,
diff --git a/drivers/scsi/lpfc/lpfc_nvmet.h b/drivers/scsi/lpfc/lpfc_nvmet.h
index b80b1639b9a7..f0196f3ef90d 100644
--- a/drivers/scsi/lpfc/lpfc_nvmet.h
+++ b/drivers/scsi/lpfc/lpfc_nvmet.h
@@ -105,7 +105,7 @@ struct lpfc_nvmet_ctx_info {
 
 struct lpfc_nvmet_rcv_ctx {
 	union {
-		struct nvmefc_tgt_ls_req ls_req;
+		struct nvmefc_ls_rsp ls_rsp;
 		struct nvmefc_tgt_fcp_req fcp_req;
 	} ctx;
 	struct list_head list;
diff --git a/include/linux/nvme-fc-driver.h b/include/linux/nvme-fc-driver.h
index 6d0d70f3219c..8b97c899517d 100644
--- a/include/linux/nvme-fc-driver.h
+++ b/include/linux/nvme-fc-driver.h
@@ -10,47 +10,26 @@
 
 
 /*
- * **********************  LLDD FC-NVME Host API ********************
+ * **********************  FC-NVME LS API ********************
  *
- *  For FC LLDD's that are the NVME Host role.
+ *  Data structures used by both FC-NVME hosts and FC-NVME
+ *  targets to perform FC-NVME LS requests or transmit
+ *  responses.
  *
- * ******************************************************************
+ * ***********************************************************
  */
 
-
-
 /**
- * struct nvme_fc_port_info - port-specific ids and FC connection-specific
- *                            data element used during NVME Host role
- *                            registrations
- *
- * Static fields describing the port being registered:
- * @node_name: FC WWNN for the port
- * @port_name: FC WWPN for the port
- * @port_role: What NVME roles are supported (see FC_PORT_ROLE_xxx)
- * @dev_loss_tmo: maximum delay for reconnects to an association on
- *             this device. Used only on a remoteport.
+ * struct nvmefc_ls_req - Request structure passed from the transport
+ *            to the LLDD to perform a NVME-FC LS request and obtain
+ *            a response.
+ *            Used by nvme-fc transport (host) to send LS's such as
+ *              Create Association, Create Connection and Disconnect
+ *              Association.
+ *            Used by the nvmet-fc transport (controller) to send
+ *              LS's such as Disconnect Association.
  *
- * Initialization values for dynamic port fields:
- * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
- *                be set to 0.
- */
-struct nvme_fc_port_info {
-	u64			node_name;
-	u64			port_name;
-	u32			port_role;
-	u32			port_id;
-	u32			dev_loss_tmo;
-};
-
-
-/**
- * struct nvmefc_ls_req - Request structure passed from NVME-FC transport
- *                        to LLDD in order to perform a NVME FC-4 LS
- *                        request and obtain a response.
- *
- * Values set by the NVME-FC layer prior to calling the LLDD ls_req
- * entrypoint.
+ * Values set by the requestor prior to calling the LLDD ls_req entrypoint:
  * @rqstaddr: pointer to request buffer
  * @rqstdma:  PCI DMA address of request buffer
  * @rqstlen:  Length, in bytes, of request buffer
@@ -63,8 +42,8 @@ struct nvme_fc_port_info {
  * @private:  pointer to memory allocated alongside the ls request structure
  *            that is specifically for the LLDD to use while processing the
  *            request. The length of the buffer corresponds to the
- *            lsrqst_priv_sz value specified in the nvme_fc_port_template
- *            supplied by the LLDD.
+ *            lsrqst_priv_sz value specified in the xxx_template supplied
+ *            by the LLDD.
  * @done:     The callback routine the LLDD is to invoke upon completion of
  *            the LS request. req argument is the pointer to the original LS
  *            request structure. Status argument must be 0 upon success, a
@@ -86,6 +65,101 @@ struct nvmefc_ls_req {
 } __aligned(sizeof(u64));	/* alignment for other things alloc'd with */
 
 
+/**
+ * struct nvmefc_ls_rsp - Structure passed from the transport to the LLDD
+ *            to request the transmit the NVME-FC LS response to a
+ *            NVME-FC LS request.   The structure originates in the LLDD
+ *            and is given to the transport via the xxx_rcv_ls_req()
+ *            transport routine. As such, the structure represents the
+ *            FC exchange context for the NVME-FC LS request that was
+ *            received and which the response is to be sent for.
+ *            Used by the LLDD to pass the nvmet-fc transport (controller)
+ *              received LS's such as Create Association, Create Connection
+ *              and Disconnect Association.
+ *            Used by the LLDD to pass the nvme-fc transport (host)
+ *              received LS's such as Disconnect Association or Disconnect
+ *              Connection.
+ *
+ * The structure is allocated by the LLDD whenever a LS Request is received
+ * from the FC link. The address of the structure is passed to the nvmet-fc
+ * or nvme-fc layer via the xxx_rcv_ls_req() transport routines.
+ *
+ * The address of the structure is to be passed back to the LLDD
+ * when the response is to be transmit. The LLDD will use the address to
+ * map back to the LLDD exchange structure which maintains information such
+ * the remote N_Port that sent the LS as well as any FC exchange context.
+ * Upon completion of the LS response transmit, the LLDD will pass the
+ * address of the structure back to the transport LS rsp done() routine,
+ * allowing the transport release dma resources. Upon completion of
+ * the done() routine, no further access to the structure will be made by
+ * the transport and the LLDD can de-allocate the structure.
+ *
+ * Field initialization:
+ *   At the time of the xxx_rcv_ls_req() call, there is no content that
+ *     is valid in the structure.
+ *
+ *   When the structure is used for the LLDD->xmt_ls_rsp() call, the
+ *     transport layer will fully set the fields in order to specify the
+ *     response payload buffer and its length as well as the done routine
+ *     to be called upon completion of the transmit.  The transport layer
+ *     will also set a private pointer for its own use in the done routine.
+ *
+ * Values set by the transport layer prior to calling the LLDD xmt_ls_rsp
+ * entrypoint:
+ * @rspbuf:   pointer to the LS response buffer
+ * @rspdma:   PCI DMA address of the LS response buffer
+ * @rsplen:   Length, in bytes, of the LS response buffer
+ * @done:     The callback routine the LLDD is to invoke upon completion of
+ *            transmitting the LS response. req argument is the pointer to
+ *            the original ls request.
+ * @nvme_fc_private:  pointer to an internal transport-specific structure
+ *            used as part of the transport done() processing. The LLDD is
+ *            not to access this pointer.
+ */
+struct nvmefc_ls_rsp {
+	void		*rspbuf;
+	dma_addr_t	rspdma;
+	u16		rsplen;
+
+	void (*done)(struct nvmefc_ls_rsp *rsp);
+	void		*nvme_fc_private;	/* LLDD is not to access !! */
+};
+
+
+
+/*
+ * **********************  LLDD FC-NVME Host API ********************
+ *
+ *  For FC LLDD's that are the NVME Host role.
+ *
+ * ******************************************************************
+ */
+
+
+/**
+ * struct nvme_fc_port_info - port-specific ids and FC connection-specific
+ *                            data element used during NVME Host role
+ *                            registrations
+ *
+ * Static fields describing the port being registered:
+ * @node_name: FC WWNN for the port
+ * @port_name: FC WWPN for the port
+ * @port_role: What NVME roles are supported (see FC_PORT_ROLE_xxx)
+ * @dev_loss_tmo: maximum delay for reconnects to an association on
+ *             this device. Used only on a remoteport.
+ *
+ * Initialization values for dynamic port fields:
+ * @port_id:      FC N_Port_ID currently assigned the port. Upper 8 bits must
+ *                be set to 0.
+ */
+struct nvme_fc_port_info {
+	u64			node_name;
+	u64			port_name;
+	u32			port_role;
+	u32			port_id;
+	u32			dev_loss_tmo;
+};
+
 enum nvmefc_fcp_datadir {
 	NVMEFC_FCP_NODATA,	/* payload_length and sg_cnt will be zero */
 	NVMEFC_FCP_WRITE,
@@ -339,6 +413,21 @@ struct nvme_fc_remote_port {
  *       indicating an FC transport Aborted status.
  *       Entrypoint is Mandatory.
  *
+ * @xmt_ls_rsp:  Called to transmit the response to a FC-NVME FC-4 LS service.
+ *       The nvmefc_ls_rsp structure is the same LLDD-supplied exchange
+ *       structure specified in the nvme_fc_rcv_ls_req() call made when
+ *       the LS request was received. The structure will fully describe
+ *       the buffers for the response payload and the dma address of the
+ *       payload. The LLDD is to transmit the response (or return a
+ *       non-zero errno status), and upon completion of the transmit, call
+ *       the "done" routine specified in the nvmefc_ls_rsp structure
+ *       (argument to done is the address of the nvmefc_ls_rsp structure
+ *       itself). Upon the completion of the done routine, the LLDD shall
+ *       consider the LS handling complete and the nvmefc_ls_rsp structure
+ *       may be freed/released.
+ *       Entrypoint is mandatory if the LLDD calls the nvme_fc_rcv_ls_req()
+ *       entrypoint.
+ *
  * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
  *       supports for cpu affinitization.
  *       Value is Mandatory. Must be at least 1.
@@ -373,7 +462,7 @@ struct nvme_fc_remote_port {
  * @lsrqst_priv_sz: The LLDD sets this field to the amount of additional
  *       memory that it would like fc nvme layer to allocate on the LLDD's
  *       behalf whenever a ls request structure is allocated. The additional
- *       memory area solely for the of the LLDD and its location is
+ *       memory area is solely for use by the LLDD and its location is
  *       specified by the ls_request->private pointer.
  *       Value is Mandatory. Allowed to be zero.
  *
@@ -409,6 +498,9 @@ struct nvme_fc_port_template {
 				struct nvme_fc_remote_port *,
 				void *hw_queue_handle,
 				struct nvmefc_fcp_req *);
+	int	(*xmt_ls_rsp)(struct nvme_fc_local_port *localport,
+				struct nvme_fc_remote_port *rport,
+				struct nvmefc_ls_rsp *ls_rsp);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
@@ -445,6 +537,34 @@ void nvme_fc_rescan_remoteport(struct nvme_fc_remote_port *remoteport);
 int nvme_fc_set_remoteport_devloss(struct nvme_fc_remote_port *remoteport,
 			u32 dev_loss_tmo);
 
+/*
+ * Routine called to pass a NVME-FC LS request, received by the lldd,
+ * to the nvme-fc transport.
+ *
+ * If the return value is zero: the LS was successfully accepted by the
+ *   transport.
+ * If the return value is non-zero: the transport has not accepted the
+ *   LS. The lldd should ABTS-LS the LS.
+ *
+ * Note: if the LLDD receives and ABTS for the LS prior to the transport
+ * calling the ops->xmt_ls_rsp() routine to transmit a response, the LLDD
+ * shall mark the LS as aborted, and when the xmt_ls_rsp() is called: the
+ * response shall not be transmit and the struct nvmefc_ls_rsp() done
+ * routine shall be called.  The LLDD may transmit the ABTS response as
+ * soon as the LS was marked or can delay until the xmt_ls_rsp() call is
+ * made.
+ * Note: if an RCV LS was successfully posted to the transport and the
+ * remoteport is then unregistered before xmt_ls_rsp() was called for
+ * the lsrsp structure, the transport will still call xmt_ls_rsp()
+ * afterward to cleanup the outstanding lsrsp structure. The LLDD should
+ * noop the transmission of the rsp and call the lsrsp->done() routine
+ * to allow the lsrsp structure to be released.
+ */
+int nvme_fc_rcv_ls_req(struct nvme_fc_remote_port *remoteport,
+			struct nvmefc_ls_rsp *lsrsp,
+			void *lsreqbuf, u32 lsreqbuf_len);
+
+
 
 /*
  * ***************  LLDD FC-NVME Target/Subsystem API ***************
@@ -474,55 +594,6 @@ struct nvmet_fc_port_info {
 };
 
 
-/**
- * struct nvmefc_tgt_ls_req - Structure used between LLDD and NVMET-FC
- *                            layer to represent the exchange context for
- *                            a FC-NVME Link Service (LS).
- *
- * The structure is allocated by the LLDD whenever a LS Request is received
- * from the FC link. The address of the structure is passed to the nvmet-fc
- * layer via the nvmet_fc_rcv_ls_req() call. The address of the structure
- * will be passed back to the LLDD when the response is to be transmit.
- * The LLDD is to use the address to map back to the LLDD exchange structure
- * which maintains information such as the targetport the LS was received
- * on, the remote FC NVME initiator that sent the LS, and any FC exchange
- * context.  Upon completion of the LS response transmit, the address of the
- * structure will be passed back to the LS rsp done() routine, allowing the
- * nvmet-fc layer to release dma resources. Upon completion of the done()
- * routine, no further access will be made by the nvmet-fc layer and the
- * LLDD can de-allocate the structure.
- *
- * Field initialization:
- *   At the time of the nvmet_fc_rcv_ls_req() call, there is no content that
- *     is valid in the structure.
- *
- *   When the structure is used for the LLDD->xmt_ls_rsp() call, the nvmet-fc
- *     layer will fully set the fields in order to specify the response
- *     payload buffer and its length as well as the done routine to be called
- *     upon compeletion of the transmit.  The nvmet-fc layer will also set a
- *     private pointer for its own use in the done routine.
- *
- * Values set by the NVMET-FC layer prior to calling the LLDD xmt_ls_rsp
- * entrypoint.
- * @rspbuf:   pointer to the LS response buffer
- * @rspdma:   PCI DMA address of the LS response buffer
- * @rsplen:   Length, in bytes, of the LS response buffer
- * @done:     The callback routine the LLDD is to invoke upon completion of
- *            transmitting the LS response. req argument is the pointer to
- *            the original ls request.
- * @nvmet_fc_private:  pointer to an internal NVMET-FC layer structure used
- *            as part of the NVMET-FC processing. The LLDD is not to access
- *            this pointer.
- */
-struct nvmefc_tgt_ls_req {
-	void		*rspbuf;
-	dma_addr_t	rspdma;
-	u16		rsplen;
-
-	void (*done)(struct nvmefc_tgt_ls_req *req);
-	void *nvmet_fc_private;		/* LLDD is not to access !! */
-};
-
 /* Operations that NVME-FC layer may request the LLDD to perform for FCP */
 enum {
 	NVMET_FCOP_READDATA	= 1,	/* xmt data to initiator */
@@ -697,17 +768,19 @@ struct nvmet_fc_target_port {
  *       Entrypoint is Mandatory.
  *
  * @xmt_ls_rsp:  Called to transmit the response to a FC-NVME FC-4 LS service.
- *       The nvmefc_tgt_ls_req structure is the same LLDD-supplied exchange
+ *       The nvmefc_ls_rsp structure is the same LLDD-supplied exchange
  *       structure specified in the nvmet_fc_rcv_ls_req() call made when
- *       the LS request was received.  The structure will fully describe
+ *       the LS request was received. The structure will fully describe
  *       the buffers for the response payload and the dma address of the
- *       payload. The LLDD is to transmit the response (or return a non-zero
- *       errno status), and upon completion of the transmit, call the
- *       "done" routine specified in the nvmefc_tgt_ls_req structure
- *       (argument to done is the ls reqwuest structure itself).
- *       After calling the done routine, the LLDD shall consider the
- *       LS handling complete and the nvmefc_tgt_ls_req structure may
- *       be freed/released.
+ *       payload. The LLDD is to transmit the response (or return a
+ *       non-zero errno status), and upon completion of the transmit, call
+ *       the "done" routine specified in the nvmefc_ls_rsp structure
+ *       (argument to done is the address of the nvmefc_ls_rsp structure
+ *       itself). Upon the completion of the done() routine, the LLDD shall
+ *       consider the LS handling complete and the nvmefc_ls_rsp structure
+ *       may be freed/released.
+ *       The transport will always call the xmt_ls_rsp() routine for any
+ *       LS received.
  *       Entrypoint is Mandatory.
  *
  * @fcp_op:  Called to perform a data transfer or transmit a response.
@@ -802,6 +875,39 @@ struct nvmet_fc_target_port {
  *       should cause the initiator to rescan the discovery controller
  *       on the targetport.
  *
+ * @ls_req:  Called to issue a FC-NVME FC-4 LS service request.
+ *       The nvme_fc_ls_req structure will fully describe the buffers for
+ *       the request payload and where to place the response payload.
+ *       The targetport that is to issue the LS request is identified by
+ *       the targetport argument.  The remote port that is to receive the
+ *       LS request is identified by the hosthandle argument. The nvmet-fc
+ *       transport is only allowed to issue FC-NVME LS's on behalf of an
+ *       association that was created prior by a Create Association LS.
+ *       The hosthandle will originate from the LLDD in the struct
+ *       nvmefc_ls_rsp structure for the Create Association LS that
+ *       was delivered to the transport. The transport will save the
+ *       hosthandle as an attribute of the association.  If the LLDD
+ *       loses connectivity with the remote port, it must call the
+ *       nvmet_fc_invalidate_host() routine to remove any references to
+ *       the remote port in the transport.
+ *       The LLDD is to allocate an exchange, issue the LS request, obtain
+ *       the LS response, and call the "done" routine specified in the
+ *       request structure (argument to done is the ls request structure
+ *       itself).
+ *       Entrypoint is Optional - but highly recommended.
+ *
+ * @ls_abort: called to request the LLDD to abort the indicated ls request.
+ *       The call may return before the abort has completed. After aborting
+ *       the request, the LLDD must still call the ls request done routine
+ *       indicating an FC transport Aborted status.
+ *       Entrypoint is Mandatory if the ls_req entry point is specified.
+ *
+ * @host_release: called to inform the LLDD that the request to invalidate
+ *       the host port indicated by the hosthandle has been fully completed.
+ *       No associations exist with the host port and there will be no
+ *       further references to hosthandle.
+ *       Entrypoint is Mandatory if the lldd calls nvmet_fc_invalidate_host().
+ *
  * @max_hw_queues:  indicates the maximum number of hw queues the LLDD
  *       supports for cpu affinitization.
  *       Value is Mandatory. Must be at least 1.
@@ -830,11 +936,19 @@ struct nvmet_fc_target_port {
  *       area solely for the of the LLDD and its location is specified by
  *       the targetport->private pointer.
  *       Value is Mandatory. Allowed to be zero.
+ *
+ * @lsrqst_priv_sz: The LLDD sets this field to the amount of additional
+ *       memory that it would like nvmet-fc layer to allocate on the LLDD's
+ *       behalf whenever a ls request structure is allocated. The additional
+ *       memory area is solely for use by the LLDD and its location is
+ *       specified by the ls_request->private pointer.
+ *       Value is Mandatory. Allowed to be zero.
+ *
  */
 struct nvmet_fc_target_template {
 	void (*targetport_delete)(struct nvmet_fc_target_port *tgtport);
 	int (*xmt_ls_rsp)(struct nvmet_fc_target_port *tgtport,
-				struct nvmefc_tgt_ls_req *tls_req);
+				struct nvmefc_ls_rsp *ls_rsp);
 	int (*fcp_op)(struct nvmet_fc_target_port *tgtport,
 				struct nvmefc_tgt_fcp_req *fcpreq);
 	void (*fcp_abort)(struct nvmet_fc_target_port *tgtport,
@@ -844,6 +958,11 @@ struct nvmet_fc_target_template {
 	void (*defer_rcv)(struct nvmet_fc_target_port *tgtport,
 				struct nvmefc_tgt_fcp_req *fcpreq);
 	void (*discovery_event)(struct nvmet_fc_target_port *tgtport);
+	int  (*ls_req)(struct nvmet_fc_target_port *targetport,
+				void *hosthandle, struct nvmefc_ls_req *lsreq);
+	void (*ls_abort)(struct nvmet_fc_target_port *targetport,
+				void *hosthandle, struct nvmefc_ls_req *lsreq);
+	void (*host_release)(void *hosthandle);
 
 	u32	max_hw_queues;
 	u16	max_sgl_segments;
@@ -852,7 +971,9 @@ struct nvmet_fc_target_template {
 
 	u32	target_features;
 
+	/* sizes of additional private data for data structures */
 	u32	target_priv_sz;
+	u32	lsrqst_priv_sz;
 };
 
 
@@ -863,10 +984,61 @@ int nvmet_fc_register_targetport(struct nvmet_fc_port_info *portinfo,
 
 int nvmet_fc_unregister_targetport(struct nvmet_fc_target_port *tgtport);
 
+/*
+ * Routine called to pass a NVME-FC LS request, received by the lldd,
+ * to the nvmet-fc transport.
+ *
+ * If the return value is zero: the LS was successfully accepted by the
+ *   transport.
+ * If the return value is non-zero: the transport has not accepted the
+ *   LS. The lldd should ABTS-LS the LS.
+ *
+ * Note: if the LLDD receives and ABTS for the LS prior to the transport
+ * calling the ops->xmt_ls_rsp() routine to transmit a response, the LLDD
+ * shall mark the LS as aborted, and when the xmt_ls_rsp() is called: the
+ * response shall not be transmit and the struct nvmefc_ls_rsp() done
+ * routine shall be called.  The LLDD may transmit the ABTS response as
+ * soon as the LS was marked or can delay until the xmt_ls_rsp() call is
+ * made.
+ * Note: if an RCV LS was successfully posted to the transport and the
+ * targetport is then unregistered before xmt_ls_rsp() was called for
+ * the lsrsp structure, the transport will still call xmt_ls_rsp()
+ * afterward to cleanup the outstanding lsrsp structure. The LLDD should
+ * noop the transmission of the rsp and call the lsrsp->done() routine
+ * to allow the lsrsp structure to be released.
+ */
 int nvmet_fc_rcv_ls_req(struct nvmet_fc_target_port *tgtport,
-			struct nvmefc_tgt_ls_req *lsreq,
+			void *hosthandle,
+			struct nvmefc_ls_rsp *rsp,
 			void *lsreqbuf, u32 lsreqbuf_len);
 
+/*
+ * Routine called by the LLDD whenever it has a logout or loss of
+ * connectivity to a NVME-FC host port which there had been active
+ * NVMe controllers for.  The host port is indicated by the
+ * hosthandle. The hosthandle is given to the nvmet-fc transport
+ * when a NVME LS was received, typically to create a new association.
+ * The nvmet-fc transport will cache the hostport value with the
+ * association for use in LS requests for the association.
+ * When the LLDD calls this routine, the nvmet-fc transport will
+ * immediately terminate all associations that were created with
+ * the hosthandle host port.
+ * The LLDD, after calling this routine and having control returned,
+ * must assume the transport may subsequently utilize hosthandle as
+ * part of sending LS's to terminate the association.  The LLDD
+ * should reject the LS's if they are attempted.
+ * Once the last association has terminated for the hosthandle host
+ * port, the nvmet-fc transport will call the ops->host_release()
+ * callback. As of the callback, the nvmet-fc transport will no
+ * longer reference hosthandle.
+ */
+void nvmet_fc_invalidate_host(struct nvmet_fc_target_port *tgtport,
+			void *hosthandle);
+
+/*
+ * If nvmet_fc_rcv_fcp_req returns non-zero, the transport has not accepted
+ * the FCP cmd. The lldd should ABTS-LS the cmd.
+ */
 int nvmet_fc_rcv_fcp_req(struct nvmet_fc_target_port *tgtport,
 			struct nvmefc_tgt_fcp_req *fcpreq,
 			void *cmdiubuf, u32 cmdiubuf_len);
-- 
2.16.4


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
