Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1FB6D10372
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BQmj5nXyQdvOjMIGkVkElVH5J/B/tLkJ1kT/MLrqiIw=; b=sTEkRU61riqwuCOEr4mAzwB0Ok
	G3wD0em7zVks0imOODRu/1UuAQymprEZeFhW0UOUR9lTASt4Fv+Yn9719C/CS8a6+0iB656f9fSoR
	bN6HwMERqNihQJK2kvqi+ePLijlmrHHhdnuA1lPneTIkLmiHQFgJIKyxL8lY3qla7kDOwrnoCwz5q
	xgTTwGQhvVmc9811KhJTABdKyM7mwJ0y0yM1dgknUnMscaAz0aYXvPf+EXQ9HausR9r/k90JcuMe2
	rxBbpKLAcnoI9CzdnG/dqEyy1PGJch6rx5qv/hXMgt8wmLQlYLoGEvjRVFxDhXVJp3pNRM0YkNZXW
	2fU/rrrw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52J-0000000EDc2-1eI4;
	Wed, 26 Nov 2025 02:13:39 +0000
Received: from mail-pg1-x52e.google.com ([2607:f8b0:4864:20::52e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52A-0000000EDPX-3DsW
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:33 +0000
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-bb2447d11ceso3750075a12.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123210; x=1764728010; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BQmj5nXyQdvOjMIGkVkElVH5J/B/tLkJ1kT/MLrqiIw=;
        b=AFkuRPUqU/H0aCy6J2F3FHVvE3zb1AKenN9LsqQKHBWfBw2u/gp3MBeWzxAynJ0g5E
         OUbHoNCLwDIqYkRn9GvI6X6437wfBlUE5y1lhkfcbP287Ir2ZhebVJFnfRBqGsXyOCpk
         A32JsNqMYhvg1L7KeOBLEREmAG2gMvALkAcCItAEKTkvMGXORwMe+mo+NW9XC+vq0N5O
         //uGSVCqWg81XR2mvoNtP/Q1nU1iTCHflURYvumvq3VtvK346to9M5u91gINOUz5ybxc
         g2VgYXl3zod7h+kCH15/WpBKNNvcU3Nh8v+6FPeH1yAGS0uD8XZUqiFyBrIAFq4okwLv
         yB7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123210; x=1764728010;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=BQmj5nXyQdvOjMIGkVkElVH5J/B/tLkJ1kT/MLrqiIw=;
        b=fsZ6ZiBR/kiLqwqOib+bAvAjHYQ4uiNyldUJZvVewjaGl1QxHuv3oUe7QMqTcyk9jn
         YO0godH56reTdbG8Y9eE2XTC8a+2xhbXj1O1Vha+JsrK+U/MppSBxpUrOpBcL7q+bMy7
         8ntdqntwb7J/1grNM8xN5FGO7EPN2Fk93SkqW3zDQ/MujDHfsWP9DtX2d2/Wsx84Kqx+
         CsUk/MFrT53sdPfBi0opHt71nvgkVRTHK76x2LBZ9BYGFCI/cysVkqqomUXsCRJrMV2N
         Fof5UftTHC+IHdLoTS2IPkOSHKPacpZFVhc9jQM40jZAgd153czRAKrNHF+H8tzD6V8G
         4pFA==
X-Forwarded-Encrypted: i=1; AJvYcCVWBiTYd8/KahXVAAy58TyIv69gyJlbu1dViMUc4aXObxYnUPyg+FLlBKjWErFsluUWgrlMaaE3OjhD@lists.infradead.org
X-Gm-Message-State: AOJu0YzCKeT+XNr9hAdAo4ILPOkhtOdartxHKST7N9kSwZ4ukjK9fHtw
	df0qkULRiMIzN08agNNdYYPGjaIu76EvrIRUqujQraBc5CFri6mWxcOd/rEy4QTyzoE=
X-Gm-Gg: ASbGncvNSgKfn7kq5mEm8BfjD+4i5jw6GDiOYZBJIVHVdCpC0qySbAONtFX1JvHK0Gh
	xWdsqM07oj82iGm19Yi3qgi0dCHuXKOdkyaIZfvQ4IMJpuFAOLUsHDrs3LVycLC/BpG+fPIWn2t
	ZCV90tTYC8hJ/YfAlv5Zsd0Hlvohpuqsl1HCL5MwlQ+/6RFWURMcUQ4y/KxCj3CqkWHn9oWcHmD
	JxK8KUPqc6Rzq8HBBBT2cfXDot041FobLlkjc4MG5CpM+eZnNOzNmTLe7vkHg/wqUHWzjnph7wV
	CMnf1Snina4eCdyJpzAyGPlxsYZiSVra9icOWDgbjZGzsdH1SpbK/DGVanwS+WBMeP6ZrENoRNS
	8dWO904XcLhEVshznE/cbQGE8m43BFN1r+M4a6gbOilJ0m7wh00c3h/V4wIAab7p0B0f7ID7JE4
	C61bOZZR8ib/lEqQomFwTUMmcXQIeA47FTTyXlxhNoA8Bc
X-Google-Smtp-Source: AGHT+IFZdLGKDcA+r7MKkSNJWp8uXhLGGJGNxCq8RRfg9SzsFBF2+PRo74PS1C/YdROofIqV0sX2Ag==
X-Received: by 2002:a05:7022:6621:b0:11b:9386:8273 with SMTP id a92af1059eb24-11cbba6ec84mr3823215c88.48.1764123209644;
        Tue, 25 Nov 2025 18:13:29 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:29 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	John Meneghini <jmeneghi@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [RFC PATCH 10/14] nvme-tcp: Use CCR to recover controller that hits an error
Date: Tue, 25 Nov 2025 18:11:57 -0800
Message-ID: <20251126021250.2583630-11-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181332_093919_4D9B7D15 
X-CRM114-Status: GOOD (  19.35  )
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

An alive nvme controller that hits an error now will move to RECOVERING
state instead of RESETTING state. In RECOVERING state ctrl->err_work
will attempt to use cross-controller recovery to terminate inflight IOs
on the controller. If CCR succeeds, then switch to RESETTING state and
continue error recovery as usuall by tearing down controller and attempt
reconnecting to target. If CCR fails, then the behavior of recovery
depends on whether CQT is supported or not. If CQT is supported, switch
to time-based recovery by holding inflight IOs until it is safe for them
to be retried. If CQT is not supported proceed to retry requests
immediately, as the code currently does.

To support implementing time-based recovery turn ctrl->err_work into
delayed work. Update nvme_tcp_timeout() to not complete inflight IOs
while controller in RECOVERING state.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 52 +++++++++++++++++++++++++++++++++++------
 1 file changed, 45 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 9a96df1a511c..ec9a713490a9 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -193,7 +193,7 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
-	struct work_struct	err_work;
+	struct delayed_work	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
 	u32			io_queues[HCTX_MAX_TYPES];
@@ -611,11 +611,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 
 static void nvme_tcp_error_recovery(struct nvme_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(ctrl, NVME_CTRL_RECOVERING) &&
+	    !nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
 		return;
 
 	dev_warn(ctrl->device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work);
+	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, 0);
 }
 
 static int nvme_tcp_process_nvme_cqe(struct nvme_tcp_queue *queue,
@@ -2470,12 +2471,48 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
+static int nvme_tcp_recover_ctrl(struct nvme_ctrl *ctrl)
+{
+	unsigned long rem;
+
+	if (test_and_clear_bit(NVME_CTRL_RECOVERED, &ctrl->flags)) {
+		dev_info(ctrl->device, "completed time-based recovery\n");
+		goto done;
+	}
+
+	rem = nvme_recover_ctrl(ctrl);
+	if (!rem)
+		goto done;
+
+	if (!ctrl->cqt) {
+		dev_info(ctrl->device,
+			 "CCR failed, CQT not supported, skip time-based recovery\n");
+		goto done;
+	}
+
+	dev_info(ctrl->device,
+		 "CCR failed, switch to time-based recovery, timeout = %ums\n",
+		 jiffies_to_msecs(rem));
+	set_bit(NVME_CTRL_RECOVERED, &ctrl->flags);
+	queue_delayed_work(nvme_reset_wq, &to_tcp_ctrl(ctrl)->err_work, rem);
+	return -EAGAIN;
+
+done:
+	nvme_end_ctrl_recovery(ctrl);
+	return 0;
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
+	if (nvme_ctrl_state(ctrl) == NVME_CTRL_RECOVERING) {
+		if (nvme_tcp_recover_ctrl(ctrl))
+			return;
+	}
+
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
@@ -2545,7 +2582,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 
 static void nvme_tcp_stop_ctrl(struct nvme_ctrl *ctrl)
 {
-	flush_work(&to_tcp_ctrl(ctrl)->err_work);
+	flush_delayed_work(&to_tcp_ctrl(ctrl)->err_work);
 	cancel_delayed_work_sync(&to_tcp_ctrl(ctrl)->connect_work);
 }
 
@@ -2640,6 +2677,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 {
 	struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
+	enum nvme_ctrl_state state = nvme_ctrl_state(ctrl);
 	struct nvme_tcp_cmd_pdu *pdu = nvme_tcp_req_cmd_pdu(req);
 	struct nvme_command *cmd = &pdu->cmd;
 	int qid = nvme_tcp_queue_id(req->queue);
@@ -2649,7 +2687,7 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
 		 rq->tag, nvme_cid(rq), pdu->hdr.type, cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(ctrl) != NVME_CTRL_LIVE) {
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_RECOVERING) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -2903,7 +2941,7 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
+	INIT_DELAYED_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
 	if (!(opts->mask & NVMF_OPT_TRSVCID)) {
-- 
2.51.2


