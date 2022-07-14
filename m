Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BAECC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 12:27:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=CGc46kSVDYd1zfQBq+I03Jw1iHdFzSl+8wKNNRDNzhM=; b=gRi3rpy21pfnOUqJZRD2IO1LYs
	zwrMC1tWscowr3U+xX4bk7idR8n5Eauh/WqsosUFp0eGDHsW/eazAus+avc1hQ5F9AR2Cn+eRrWM9
	aCXjsSCShrge39w+iaec5Pe/g+yJMd9XlTlu459Sd56xEGrj7DhHXs6xA7+oUUu5BrVOLlm+GaCik
	/I+mOBmFti7nYiTXT/zvclFFykH/ANiHxmh1lobIQqEwieU4u4TdK5FqxkbBHLMmLSoNUQa6hmxk5
	n1Fc2nG/6JscIJXw7UVQuaPfACvALEuPWjqJ/JAU0jyU1R0gXX79czIAB+2cxUPwECCijXheW30T+
	RXCoP3/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBxw7-00EB1I-QG; Thu, 14 Jul 2022 12:27:19 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBxvz-00EB0S-Cr
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 12:27:13 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id C17DA33ECC;
	Thu, 14 Jul 2022 12:27:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1657801625; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CGc46kSVDYd1zfQBq+I03Jw1iHdFzSl+8wKNNRDNzhM=;
	b=ARAi00XhrOo2p9wx7lDGzDjpkh9OKDTH/Mos2sLaN8JXBMbQQPmeHxRuPE/uuR9B/nKGZ0
	IkXPH2E2YBvlSahOcNfr+UEgHa5frYmftNu1JqkOgz/zPWm5v1J63Up/3vvMo/z0FYoKsg
	oCKJj9IJABsfssXebEnERCz+tLKsJuY=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1657801625;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=CGc46kSVDYd1zfQBq+I03Jw1iHdFzSl+8wKNNRDNzhM=;
	b=t75NeHNbZ4CvgZnls4THFaInlfEgaX2244jyryAjkCpanU/ugH6SI7bYQwr20ijsp6ax4K
	Yy03APvhAbOqS1CQ==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id B02232C141;
	Thu, 14 Jul 2022 12:27:05 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 9BC3451988CE; Thu, 14 Jul 2022 14:27:05 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH] nvme-tcp: delay error recovery after link drop
Date: Thu, 14 Jul 2022 14:27:03 +0200
Message-Id: <20220714122703.67621-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220714_052711_611731_BF472B09 
X-CRM114-Status: GOOD (  16.18  )
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

When the connection unexpectedly closes we must not start error
recovery right away, as the controller might not have registered
the connection failure and so retrying commands directly will
might lead to data corruption.
So wait for KATO before starting error recovery to be on the safe
side; chances are the commands will time out before that anyway.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/tcp.c           | 37 +++++++++++++++++++++----------
 drivers/nvme/target/io-cmd-bdev.c | 18 +++++++++++++++
 2 files changed, 43 insertions(+), 12 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index a7848e430a5c..70096a2e8762 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -167,7 +167,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
-	struct work_struct	err_work;
+	struct delayed_work	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
@@ -522,13 +522,21 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 	queue->ddgst_remaining = 0;
 }
 
-static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
+static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl, bool delay)
 {
+	int tmo = delay ? (ctrl->kato ? ctrl->kato : NVME_DEFAULT_KATO) : 0;
+
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
-	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
+	if (tmo)
+		dev_warn(ctrl->device,
+			 "delaying error recovery by %d seconds\n", tmo);
+	else
+		dev_warn(ctrl->device,
+			 "starting error recovery\n");
+	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work,
+			   tmo * HZ);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
@@ -542,7 +550,7 @@ static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"got bad cqe.command_id %#x on queue %d\n",
 			cqe->command_id, nvme_tcp_queue_id(queue));
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl, false);
 		return -EINVAL;
 	}
 
@@ -584,7 +592,7 @@ static int nvme_tcp_handle_c2h_data(struct nvme_tcp_queue *queue,
 		dev_err(queue->ctrl->ctrl.device,
 			"queue %d tag %#x SUCCESS set but not last PDU\n",
 			nvme_tcp_queue_id(queue), rq->tag);
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl, false);
 		return -EPROTO;
 	}
 
@@ -895,7 +903,7 @@ static int nvme_tcp_recv_skb(read_descriptor_t *desc, struct sk_buff *skb,
 			dev_err(queue->ctrl->ctrl.device,
 				"receive failed:  %d\n", result);
 			queue->rd_enabled = false;
-			nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+			nvme_tcp_error_recovery(&queue->ctrl->ctrl, false);
 			return result;
 		}
 	}
@@ -943,7 +951,12 @@ static void nvme_tcp_state_change(struct sock *sk)
 	case TCP_LAST_ACK:
 	case TCP_FIN_WAIT1:
 	case TCP_FIN_WAIT2:
-		nvme_tcp_error_recovery(&queue->ctrl->ctrl);
+		/*
+		 * We cannot start error recovery right away, as we need
+		 * to wait for KATO to trigger to give the controller a
+		 * chance to detect the failure.
+		 */
+		nvme_tcp_error_recovery(&queue->ctrl->ctrl, true);
 		break;
 	default:
 		dev_info(queue->ctrl->ctrl.device,
@@ -2171,7 +2184,7 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
-				struct nvme_tcp_ctrl, err_work);
+				struct nvme_tcp_ctrl, err_work.work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
 	nvme_auth_stop(ctrl);
@@ -2195,7 +2208,7 @@ static void nvme_tcp_error_recovery_work(struct work_struct *work)
 
 static void nvme_tcp_teardown_ctrl(struct nvme_ctrl *ctrl, bool shutdown)
 {
-	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work);
+	cancel_work_sync(&to_tcp_ctrl(ctrl)->err_work.work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 
 	nvme_tcp_teardown_io_queues(ctrl, shutdown);
@@ -2355,7 +2368,7 @@ nvme_tcp_timeout(struct request *rq, bool reserved)
 	 * LIVE state should trigger the normal error recovery which will
 	 * handle completing this request.
 	 */
-	nvme_tcp_error_recovery(ctrl);
+	nvme_tcp_error_recovery(ctrl, false);
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -2596,7 +2609,7 @@ static struct nvme_ctrl *nvme_tcp_create_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
+	INIT_DELAYED_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 27a72504d31c..bbeeeeaedc9b 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -157,6 +157,24 @@ u16 blk_to_nvme_status(struct nvmet_req *req, blk_status_t blk_sts)
 		req->error_loc = offsetof(struct nvme_rw_command, nsid);
 		break;
 	case BLK_STS_IOERR:
+		switch (req->cmd->common.opcode) {
+		case nvme_cmd_read:
+			status = NVME_SC_READ_ERROR;
+			req->error_loc = offsetof(struct nvme_rw_command,
+						  slba);
+			break;
+		case nvme_cmd_write:
+			status = NVME_SC_WRITE_FAULT;
+			req->error_loc = offsetof(struct nvme_rw_command,
+						  slba);
+			break;
+		default:
+			status = NVME_SC_DATA_XFER_ERROR | NVME_SC_DNR;
+			req->error_loc = offsetof(struct nvme_common_command,
+						  opcode);
+			break;
+		}
+		break;
 	default:
 		status = NVME_SC_INTERNAL | NVME_SC_DNR;
 		req->error_loc = offsetof(struct nvme_common_command, opcode);
-- 
2.29.2


