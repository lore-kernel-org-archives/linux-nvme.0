Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CD7110F3DC1
	for <linux-nvme@archiver.kernel.org>; Sat, 28 Mar 2026 00:46:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=D4p3ffVPEhhvzgCSyBZ1x+AvHTOlODCgnogumXFocGc=; b=D7KJTIvo6GkfCn9DGvxCuA2XaK
	i9XclArBWknOslWExfFGQ722KxM2UtKVdoiSZ5I6/EI0WcgMK38T+XCLR43L45zOojXcUvElSZkv8
	Vtl//TzvH8oWIxZvFhmuskdIJM4q/0yomJobmcsGKs51UNXHnZpQTjYNZTGZW8eKqjjA0CAieH8E7
	fmNURJl8UPM3FvukftUqDC5PsqxF73jMAq4gTrHiQzm2k16T21mz7aln9S6Y9hNTMHjz+gWnTkjG9
	n+Xnwy7hCAbSUJZi5bfiqJ0f6+90Lmmufvv3kNYKb1eIFbuI/vsJsn5uDdpAFnQVNgAOOkToisP/r
	SGSnLj7w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoW-00000008O12-2Mmx;
	Sat, 28 Mar 2026 00:46:08 +0000
Received: from mail-pg1-x534.google.com ([2607:f8b0:4864:20::534])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w6HoT-00000008Ny3-1xGo
	for linux-nvme@lists.infradead.org;
	Sat, 28 Mar 2026 00:46:06 +0000
Received: by mail-pg1-x534.google.com with SMTP id 41be03b00d2f7-c73ba417c6eso1058983a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 27 Mar 2026 17:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1774658764; x=1775263564; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=D4p3ffVPEhhvzgCSyBZ1x+AvHTOlODCgnogumXFocGc=;
        b=CC1ZGGMaHFJa4zl0EoMT04AeNXKrjuCjVIV/Jm3j/twQPigcFO15srIVDX5K8+8mKx
         YOxuBzo3Oj0SEBnEP7t0EvZT//Apy2gee8ZNtrMPXLQA9sYDCanR5Wfwl1ktwkQLgsG+
         sSgCWysDpWVn7cwTwc92DAJ7/4MgdHcrA02zfJZSuzgyk2DtB9KjnV0Rfk0mzRX0JQWu
         jCyHwi3JpY+k7Sb72IZu4WkofoWXrWtxUuXgs0e8LsG2oIKvfI5kVX8OSsDmHBfFff5p
         MwKKBRp8ztWUVhfm/NP6aPkeH2hTh+FTS2tgqYFLJFt6bTnsoHlwks0F4hJi/3se7ZkB
         EFRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774658764; x=1775263564;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=D4p3ffVPEhhvzgCSyBZ1x+AvHTOlODCgnogumXFocGc=;
        b=SVqeIE6aFCb5wt7XOmV8VcJb6+yDfnx7ZwgwDl/X9zecaEswrNHRm8dIjCSScp4aOS
         QaweRewmjee8gbUiHQA5uq9LhK1HL+LF3hkkF2lnMozIdSkfqsbpH/ssvUeGY+wDx17S
         eBIw9rFz0juBcP+pKCTPPRlCwVyBddmTi+OYfvgD9u/bPc9TpnygIz2k0vQG6JUW883H
         7DXzxWNu1DFa+fPim0YDfmDqR41vvzbc6foFTYwZJeJj/+sxbcTXEdYnxVnCC1ZVhIaR
         RCAMb5QZspjH85iehjZ9pdIuYJQVLR2yCrlPozuDi89nZLYWjMOtKFxPbll26eYKCZiH
         tF9A==
X-Forwarded-Encrypted: i=1; AJvYcCWCS7LR1N7N28Up9TKlzcWBxrCR0dsDBHQiAFwQuoh0HyTw134RZW750Gkilv73wc77pZ4BT7HcY34F@lists.infradead.org
X-Gm-Message-State: AOJu0YzBO6sypTx9BG2w57gEhIqfr5sdaNmdhEayZRkP025wy+XdirsO
	aYxXM4RFzMakjJ0+Db/xmqCnSTbTFMQB3wL7wyJfoI7Rwu8DN4Gy94kEbG27wI1X0/I=
X-Gm-Gg: ATEYQzwyW541JxTJhDx0v14FLFNxzBik2kgFUnguNNUqQOFIeVDEBEP4TyQ55qj5qS8
	+aM94uxka7MMhscn/g4yxtbb01pPn0UmBLKrBvGhbV7o0klekbQ29GPVgKhcsVQ7/7cZ3pW33tI
	ejVJwN4Ck5xy664lsEzsjtmplqg9pvByi9pOnaZH7h73e1i9UIJvHhaGWLR/LOk+RHBoNt1atj+
	TpjfZoR0IkLoL+VatMs/5V3UJxn3I/AtI5krJGRYx3iUtzuysXyJBranSHnHw4n5epBCAZ6tE7b
	Ppt1Z6DCRO7ROpQXTm9YrzNT6ro3cD25lEtdKqNZpsPtEbwBktOjGx3ZEp35WekY5w+5miAz6kF
	SkvdHM+aaN7n39dwNhSEF8k7VFkAjJt+HcZe8CHBB/YluWd3ACJnrvBZ1fSp/7vmF9bjQcBw6vB
	mz4ZJz19s=
X-Received: by 2002:a17:903:2f87:b0:2ae:7f84:79e3 with SMTP id d9443c01a7336-2b0cdc40b8cmr45255945ad.16.1774658764354;
        Fri, 27 Mar 2026 17:46:04 -0700 (PDT)
Received: from ceto ([2601:640:8202:6fb0::9c63])
        by smtp.googlemail.com with ESMTPSA id d9443c01a7336-2b242683064sm5342705ad.33.2026.03.27.17.46.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 17:46:04 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	James Smart <jsmart833426@gmail.com>,
	Hannes Reinecke <hare@suse.de>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v4 10/15] nvme-tcp: Use CCR to recover controller that hits an error
Date: Fri, 27 Mar 2026 17:43:41 -0700
Message-ID: <20260328004518.1729186-11-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260328004518.1729186-1-mkhalfella@purestorage.com>
References: <20260328004518.1729186-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260327_174605_507173_0B96E2EC 
X-CRM114-Status: GOOD (  14.03  )
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

An alive nvme controller that hits an error now will move to FENCING
state instead of RESETTING state. ctrl->fencing_work attempts CCR to
terminate inflight IOs. Regardless of the success or failure of CCR
operation the controller is transitioned to RESETTING state to continue
error recovery process.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 30 +++++++++++++++++++++++++++++-
 1 file changed, 29 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 243dab830dc8..6393ec2b3b55 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -194,6 +194,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -612,6 +613,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 {
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->device, "starting controller fencing\n");
+		queue_work(nvme_wq, &to_tcp_ctrl(ctrl)->fencing_work);
+		return;
+	}
+
 	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
@@ -2471,12 +2478,29 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_tcp_fencing_work(struct work_struct *work)
+{
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
+			struct nvme_tcp_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	int ret;
+
+	ret = nvme_fence_ctrl(ctrl);
+	if (ret)
+		dev_info(ctrl->device, "CCR failed with error %d\n", ret);
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
@@ -2519,6 +2543,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);
@@ -2644,13 +2669,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_command *cmd = &pdu->cmd;
 	int qid = nvme_tcp_queue_id(req->queue);
+	enum nvme_ctrl_state state;
 
 	dev_warn(ctrl->device,
 		 "I/O tag %d (%04x) type %d opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+	state = nvme_ctrl_state(ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -2905,6 +2932,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.52.0


