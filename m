Return-Path: <SRS0=Ir45=W2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3DA8C3A59B
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:19:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C511F23429
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Aug 2019 19:19:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="tTs2X+ex"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C511F23429
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:References:
	In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Owner;
	bh=C5R3PlOVAeXIQ4a9u/jvIyDDnTtqf9Kqei6OMkcpkOA=; b=tTs2X+exve9Vw1w/jI/LJaMNw2
	rXQ59YXN1ZGZtp2O88DBTjdsWJ/bbVOlJ8Az6bgKgOSLVkN8h6l6vf+huKlUKXf2hpnDs0IMFJOrT
	sGjsxeHv3+VsBTJGW/TbidW5T5YvRdo8zGMu4KtfK2AV/4EXEv+YVPOl+0R/ywMZNyjH4n66X4web
	f8n7nlgRbK9FVGdtVCeNNVya+OGj0r4jN6ICLk8s2rT00FHq5/y3JRKEjaLYH9zCE92SvLsQ1ECiD
	P99x6CXtDh5AG+oRDiWpf+KyzFUMqFbuSP4HULrsEcxMh7mPaY0dGZ2sHljplwMGy+loQfctAWGn6
	ioHinXwg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92 #3 (Red Hat Linux))
	id 1i3mQz-0003Wy-VK; Fri, 30 Aug 2019 19:19:46 +0000
Received: from [2600:1700:65a0:78e0:514:7862:1503:8e4d]
 (helo=sagi-Latitude-E7470.lbits)
 by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
 id 1i3mQV-00030j-HU; Fri, 30 Aug 2019 19:19:15 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v10 3/7] nvme-fc: Fail transport errors with NVME_SC_HOST_PATH
Date: Fri, 30 Aug 2019 12:19:10 -0700
Message-Id: <20190830191914.29713-4-sagi@grimberg.me>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190830191914.29713-1-sagi@grimberg.me>
References: <20190830191914.29713-1-sagi@grimberg.me>
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
Cc: Keith Busch <keith.busch@intel.com>, James Smart <james.smart@broadcom.com>,
 Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: James Smart <james.smart@broadcom.com>

NVME_SC_INTERNAL should indicate an internal controller errors
and not host transport errors. These errors will propagate to
upper layers (essentially nvme core) and be interpereted as
transport errors which should not be taken into account for
namespace state or condition.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: James Smart <james.smart@broadcom.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/fc.c | 37 ++++++++++++++++++++++++++++++-------
 1 file changed, 30 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index bafe35bdffac..265f89e11d8b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1608,9 +1608,13 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 				sizeof(op->rsp_iu), DMA_FROM_DEVICE);
 
 	if (opstate == FCPOP_STATE_ABORTED)
-		status = cpu_to_le16(NVME_SC_ABORT_REQ << 1);
-	else if (freq->status)
-		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
+		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+	else if (freq->status) {
+		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: io failed due to lldd error %d\n",
+			ctrl->cnum, freq->status);
+	}
 
 	/*
 	 * For the linux implementation, if we have an unsuccesful
@@ -1637,8 +1641,13 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		 * no payload in the CQE by the transport.
 		 */
 		if (freq->transferred_length !=
-			be32_to_cpu(op->cmd_iu.data_len)) {
-			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
+		    be32_to_cpu(op->cmd_iu.data_len)) {
+			status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+			dev_info(ctrl->ctrl.device,
+				"NVME-FC{%d}: io failed due to bad transfer "
+				"length: %d vs expected %d\n",
+				ctrl->cnum, freq->transferred_length,
+				be32_to_cpu(op->cmd_iu.data_len));
 			goto done;
 		}
 		result.u64 = 0;
@@ -1655,7 +1664,17 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 					freq->transferred_length ||
 			     op->rsp_iu.status_code ||
 			     sqe->common.command_id != cqe->command_id)) {
-			status = cpu_to_le16(NVME_SC_INTERNAL << 1);
+			status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+			dev_info(ctrl->ctrl.device,
+				"NVME-FC{%d}: io failed due to bad NVMe_ERSP: "
+				"iu len %d, xfr len %d vs %d, status code "
+				"%d, cmdid %d vs %d\n",
+				ctrl->cnum, be16_to_cpu(op->rsp_iu.iu_len),
+				be32_to_cpu(op->rsp_iu.xfrd_len),
+				freq->transferred_length,
+				op->rsp_iu.status_code,
+				sqe->common.command_id,
+				cqe->command_id);
 			goto done;
 		}
 		result = cqe->result;
@@ -1663,7 +1682,11 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		break;
 
 	default:
-		status = cpu_to_le16(NVME_SC_INTERNAL << 1);
+		status = cpu_to_le16(NVME_SC_HOST_PATH_ERROR << 1);
+		dev_info(ctrl->ctrl.device,
+			"NVME-FC{%d}: io failed due to odd NVMe_xRSP iu "
+			"len %d\n",
+			ctrl->cnum, freq->rcv_rsplen);
 		goto done;
 	}
 
-- 
2.17.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
