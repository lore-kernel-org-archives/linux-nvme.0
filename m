Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C39FC6FD1A
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 16:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Uh1zAut2WqMt/69Rq9QnMVfPAKqVtcZoDsnWKgouBI4=; b=TipQLBKovlzdBadABL0RrU/wog
	LB0zKacOO6YDaFVJ4BnsUHyuaguNZKODpuZxM+tb3iJQxCLiquNVROrYeZlhxoHT415IZstpbqUQY
	EB8bP6Z/ocojEt1QRNTbnqxA665x6CLJPLq4s9V0D3F01oxFOTOI2oAo7QhRYJ/6TjJ2WHDxyBr7C
	hNjID4V3dslJaS6pNyqDahNOuQdecAznziFaaWhX/pq+6tQJ5Jgz+wutShO3VSOmXiCfwxdWzJCpT
	2Z6bQfqx93VFTxLHzH0/f7uw2m76jmivk8u/lZ2GqnAYYfGK7pwJukUoJNfVcTDB1yW225dZKoCOe
	Cax/PgXw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZaDV-001Y02-5e; Tue, 07 Mar 2023 16:31:09 +0000
Received: from mail-pj1-x1031.google.com ([2607:f8b0:4864:20::1031])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZaDS-001Xyw-Sr
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 16:31:08 +0000
Received: by mail-pj1-x1031.google.com with SMTP id l1so13785539pjt.2
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 08:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678206662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Uh1zAut2WqMt/69Rq9QnMVfPAKqVtcZoDsnWKgouBI4=;
        b=O30pfCwlt0gcB52q3WQFBd9lz8oNbXcpF9NX0tkxvyTixjmfB7/qa4fhoD2XfqOSvB
         zsS5rQhWJVTXAxY0m6ABHvphtWaT+eK0BBjctsMP0fOuuZgrha53NDTp8L/wV4COSfSb
         I2gJh5yLIrB1ImIFHudSjXUXlhqpKGwXQCp+iO31dOynMgnbcedrwFUOnsF4evwJsZR2
         SigPNLum6AZuJZl+ReDAa/1mjalVxHHsOmat/XzwZEC/9DZ9Rk2iYuoYKrG5FjjOobZ6
         /hJ2W/Czt8uNx+QwE+1L7mJ2vNYQfH+lzHbWigIWcPWCyPf1ecd4nDSy9VTo30iyd5B5
         n3JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678206662;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Uh1zAut2WqMt/69Rq9QnMVfPAKqVtcZoDsnWKgouBI4=;
        b=D0Lc7YktH1eoamOzi3P05g75SsipA5cr5ENcWbOfVIX73FP5PtbzPookNP7j0dyu2v
         DICszL/BT2kTbpaemJJIxTjIqCWEKRmFkDCKlhIluOZblDvaLIwRqrmgL0nncG8iu2Sq
         GUsWrVJxPRVOG/JsYUYsI75WDuJSU107N3u0hyaPkyqVtXb30SUoWSgf0VHS81cvXxdd
         JDpa4rwMGjcxLDcC4IqTdV/4oNUvQaxSaV1i7+U29J7Jqgr8eBbZZzaJqBgTcHHTgBJl
         biifBGEeTedTq+tVxPtFEaO2NMed5IOFcuBprusCVqVFRSmKoeIL172B3kjVWNf23Izv
         smcw==
X-Gm-Message-State: AO0yUKVWBCFJuYpeZf/99OlvKGbIkEswH6PKfZxxpmik44CQCyTDvPHY
	f8e2lbBh8bNEoaeYjV1Q6WNu1Ep5NcM=
X-Google-Smtp-Source: AK7set8sAu4LohwxToedAFK04TbheTM5/IsmvpHo3zjeLe+y/GC8MMOSwkgne8GX3K4w5lpZ6EfcaA==
X-Received: by 2002:a17:902:d492:b0:19d:abd:bb7e with SMTP id c18-20020a170902d49200b0019d0abdbb7emr18735955plg.34.1678206662531;
        Tue, 07 Mar 2023 08:31:02 -0800 (PST)
Received: from localhost.localdomain ([240f:34:212d:1:2dbf:7a30:9c8:848e])
        by smtp.gmail.com with ESMTPSA id y15-20020a17090322cf00b0019a95baaaa6sm8578372plg.222.2023.03.07.08.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 08:31:01 -0800 (PST)
From: Akinobu Mita <akinobu.mita@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Akinobu Mita <akinobu.mita@gmail.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-tcp: print correct opcode on timeout and error handling
Date: Wed,  8 Mar 2023 01:30:45 +0900
Message-Id: <20230307163045.5882-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_083106_958538_D7D0531B 
X-CRM114-Status: GOOD (  21.40  )
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

In timeout and error handling, various information is reported about the
command in error, but the printed opcode may not be correct

The opcode is obtained from the nvme_command structure referenced by the
'cmd' member in the nvme_request structure.
(i.e. nvme_req(req)->cmd->common.opcode)

For the nvme-tcp driver, the 'cmd' member in the nvme_request structure
points to a structure within the page fragment allocated by
nvme_tcp_init_request().  This page fragment is used as a command capsule
PDU, and then may be reused as a h2c data PDU, so the nvme_command
referenced by the 'cmd' member has already been overwritten.

To fix this problem, when setting up the nvme_command, keep the opcode in
a newly added member in the nvme_tcp_request and use that instead.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Chaitanya Kulkarni <kch@nvidia.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>
Cc: Jens Axboe <axboe@fb.com>
Cc: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 10 ++++++----
 drivers/nvme/host/nvme.h | 11 +++++++++++
 drivers/nvme/host/tcp.c  | 15 ++++++++++++++-
 3 files changed, 31 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index c2730b116dc6..a86f787ba3bd 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -310,12 +310,14 @@ static void nvme_log_error(struct request *req)
 {
 	struct nvme_ns *ns = req->q->queuedata;
 	struct nvme_request *nr = nvme_req(req);
+	u8 opcode;
 
+	nvme_get_request_info(req, &opcode);
 	if (ns) {
 		pr_err_ratelimited("%s: %s(0x%x) @ LBA %llu, %llu blocks, %s (sct 0x%x / sc 0x%x) %s%s\n",
 		       ns->disk ? ns->disk->disk_name : "?",
-		       nvme_get_opcode_str(nr->cmd->common.opcode),
-		       nr->cmd->common.opcode,
+		       nvme_get_opcode_str(opcode),
+		       opcode,
 		       (unsigned long long)nvme_sect_to_lba(ns, blk_rq_pos(req)),
 		       (unsigned long long)blk_rq_bytes(req) >> ns->lba_shift,
 		       nvme_get_error_status_str(nr->status),
@@ -328,8 +330,8 @@ static void nvme_log_error(struct request *req)
 
 	pr_err_ratelimited("%s: %s(0x%x), %s (sct 0x%x / sc 0x%x) %s%s\n",
 			   dev_name(nr->ctrl->device),
-			   nvme_get_admin_opcode_str(nr->cmd->common.opcode),
-			   nr->cmd->common.opcode,
+			   nvme_get_admin_opcode_str(opcode),
+			   opcode,
 			   nvme_get_error_status_str(nr->status),
 			   nr->status >> 8 & 7,	/* Status Code Type */
 			   nr->status & 0xff,	/* Status Code */
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index bf46f122e9e1..bbb458323e91 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -525,6 +525,7 @@ struct nvme_ctrl_ops {
 	int (*get_address)(struct nvme_ctrl *ctrl, char *buf, int size);
 	void (*print_device_info)(struct nvme_ctrl *ctrl);
 	bool (*supports_pci_p2pdma)(struct nvme_ctrl *ctrl);
+	void (*get_request_info)(struct request *req, u8 *opcode);
 };
 
 /*
@@ -597,6 +598,16 @@ static inline void nvme_print_device_info(struct nvme_ctrl *ctrl)
 		subsys->firmware_rev);
 }
 
+static inline void nvme_get_request_info(struct request *rq, u8 *opcode)
+{
+	struct nvme_request *req = nvme_req(rq);
+
+	if (req->ctrl->ops->get_request_info)
+		req->ctrl->ops->get_request_info(rq, opcode);
+	else
+		*opcode = req->cmd->common.opcode;
+}
+
 #ifdef CONFIG_FAULT_INJECTION_DEBUG_FS
 void nvme_fault_inject_init(struct nvme_fault_inject *fault_inj,
 			    const char *dev_name);
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 7723a4989524..a6c0ae51d830 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -90,6 +90,8 @@ struct nvme_tcp_request {
 	struct list_head	entry;
 	struct llist_node	lentry;
 	__le32			ddgst;
+	u8			opcode;
+	u8			fctype;
 
 	struct bio		*curr_bio;
 	struct iov_iter		iter;
@@ -2285,7 +2287,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
 	struct nvme_tcp_cmd_pdu *pdu = req->pdu;
-	u8 opc = pdu->cmd.common.opcode, fctype = pdu->cmd.fabrics.fctype;
+	u8 opc = req->opcode, fctype = req->fctype;
 	int qid = nvme_tcp_queue_id(req->queue);
 
 	dev_warn(ctrl->device,
@@ -2354,6 +2356,9 @@ static blk_status_t nvme_tcp_setup_cmd_pdu(struct nvme_ns *ns,
 
 	req->state = NVME_TCP_SEND_CMD_PDU;
 	req->status = cpu_to_le16(NVME_SC_SUCCESS);
+	req->opcode = pdu->cmd.common.opcode;
+	if (req->opcode == nvme_fabrics_command)
+		req->fctype = pdu->cmd.fabrics.fctype;
 	req->offset = 0;
 	req->data_sent = 0;
 	req->pdu_len = 0;
@@ -2509,6 +2514,13 @@ static int nvme_tcp_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 	return len;
 }
 
+static void nvme_tcp_get_request_info(struct request *rq, u8 *opcode)
+{
+	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
+
+	*opcode = req->opcode;
+}
+
 static const struct blk_mq_ops nvme_tcp_mq_ops = {
 	.queue_rq	= nvme_tcp_queue_rq,
 	.commit_rqs	= nvme_tcp_commit_rqs,
@@ -2542,6 +2554,7 @@ static const struct nvme_ctrl_ops nvme_tcp_ctrl_ops = {
 	.delete_ctrl		= nvme_tcp_delete_ctrl,
 	.get_address		= nvme_tcp_get_address,
 	.stop_ctrl		= nvme_tcp_stop_ctrl,
+	.get_request_info	= nvme_tcp_get_request_info,
 };
 
 static bool
-- 
2.34.1


