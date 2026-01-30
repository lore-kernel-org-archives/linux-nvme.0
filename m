Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64AF5E6BF3C
	for <linux-nvme@archiver.kernel.org>; Fri, 30 Jan 2026 22:36:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xDu7rcI44pdZ7ozlYZ8/MRynW2sKdwev0diNQdJpydQ=; b=GZZ3SOgcdGY5ms01L48P4qYG5H
	MssqOY6qr3VOvuIdnCyKsJ154CZ5DZRH+tmOd94Vs8O8/21ffCMXOti3dQNT2KDGin218IMqTAAIx
	q8TnQFyMMcGcgGPrdM6VvJAuWSkbxmof0LQeFMNWSEoPwA2Zm+EM01LdJ1LMCqmRx8Iuu8q6tL7ok
	M3JAiQqTg6sznPgvFowhhLTo+B5NEhfAAMWqr3weIBQT26dxpTGv92BqQ9rxus1cistr6p/P989uN
	40MyQCpqOdXFpzFVHak/pbc4rl304CX8B6YuhXEnVNwBgclaV0rvxJ/EatkqEaPnaQ3aCv8cRed9F
	StHoJctg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6W-000000022yo-1u5f;
	Fri, 30 Jan 2026 22:36:40 +0000
Received: from mail-dl1-x122a.google.com ([2607:f8b0:4864:20::122a])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vlx6P-000000022oR-3JVa
	for linux-nvme@lists.infradead.org;
	Fri, 30 Jan 2026 22:36:36 +0000
Received: by mail-dl1-x122a.google.com with SMTP id a92af1059eb24-12339e2e2c1so1688649c88.1
        for <linux-nvme@lists.infradead.org>; Fri, 30 Jan 2026 14:36:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1769812593; x=1770417393; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xDu7rcI44pdZ7ozlYZ8/MRynW2sKdwev0diNQdJpydQ=;
        b=R02pYocx7SJFKPsHsfBxZ/FIA+y8z82QMRZRDriUdOTjlHtNdbZi/OBxzJRJi2kkEu
         dPdB2VuKL3t9AThhS/aK9oELMiYwH4vbQ+djx22xydEHyqCmYCxlUvB+75gULthZnRfD
         +mzljQwSi1To5RCH4owpmXIOUf5cKBGpehCdoYCORlHhvHg/t6pBcxSM0Xs5NssvjwNF
         9NrMym3HIh1QzzmHXMxtLYsbn7RFoD7+8kDC6aYXB6qaAFvo4l71ZtI21dgUAZX1iyMK
         jvgQ7vCoSLQbble0Ld8iJQM5kWFCLnks9asgVYtdPuMVgaOw4nfOW1g22vIYGxS+hrSe
         jPFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1769812593; x=1770417393;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xDu7rcI44pdZ7ozlYZ8/MRynW2sKdwev0diNQdJpydQ=;
        b=JTkkJAmqCziTh23F0defBF4KWrKss8/T3EhzAJcWHA8940jfg+4E8hOZ4i/PVo5LMv
         RZ4Y0KUIIH1gHvDZKr9peNy210XdZChclTgoCl3gEGXscP3KJt931zxNoHXD37fxaVQK
         BNp5X/LuWz8eGM7mjAPrsTPpTwtknHLFzq3kCAksB0xy5FkqQHRSmnROgEkWonEK5t41
         hnwKVXZXp7KV9KNdLKUueyvE7+qlVHfHsKVxCGS/gozv/5pW/XOfjR6B0fuiYiuXBnfh
         VcWkiewTGBROcmEgbzRi89l/ulKY7uQKBm/wICzoiRnbYQZ8fDsNFGQpbBSC1gtEGHbd
         yozA==
X-Forwarded-Encrypted: i=1; AJvYcCVt6nZE7SslvwvuO3Rkz9FAOmcIcFmnk1DyTfsdD0iXerWukJ/OLHqGg5r3zYp6Sr4t9yxAxHqHQnJg@lists.infradead.org
X-Gm-Message-State: AOJu0YwcY/+si9w/nTQ3O1f8s8e4W+VI3OcrKloqeKZmY3A1x/n8OZO8
	T6TUYCncC1nETEK6XM0L+CJ+Hz1H5mB2sgxht9gBM5OKM3WFl6/QqiXA/VpptO3gEdQ=
X-Gm-Gg: AZuq6aI/Do3f3Sd7laiOTvaih/JU0ju++YQy5Xh4vj0q0dGlV112/9Swb+Zeeh7bEir
	QOVFrd9RcrSgL7Fu/T9Pq3Ho9OApgIcG3sxXmaDysJe4KVibXImJNTlVioWlUmMtBeJk144QxAr
	o7p7x/YcPerpuHWxTSfMnNqdNTD2l4LTaXvpwbQ4vDT6nzHvg7IhJDzvZShVbkoER1KytGgLvOO
	Uz47A23IW/+1oeKojv8pZKl8jksBdj//AIVhczscP6YsOfqSULagi+si88M8U/QSdtiwFlWp1aS
	Q5DbRfX7Vq1EDJUP5WWr1DvCG2AVbspNfcv5Hvxg78/4k0YkezRpdNugIhUxJca7vXQYRg4JtrE
	NFmonslUwxvhzCOcysDOvN9uBMgbD+9Ue1/lzqBSVnlDMAEpc4+OE/j4QXRv5QmP9fhrzJuogbY
	KN0uz0d/EcahGSD2XQJ63+bjlGerrdBR6RSA==
X-Received: by 2002:a05:7022:4589:b0:11e:4fc:9b33 with SMTP id a92af1059eb24-124b100d8d5mr4190399c88.1.1769812593015;
        Fri, 30 Jan 2026 14:36:33 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-124a9d6b906sm13161717c88.4.2026.01.30.14.36.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Jan 2026 14:36:32 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Aaron Dailey <adailey@purestorage.com>,
	Randy Jennings <randyj@purestorage.com>,
	Dhaval Giani <dgiani@purestorage.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Mohamed Khalfella <mkhalfella@purestorage.com>
Subject: [PATCH v2 10/14] nvme-tcp: Use CCR to recover controller that hits an error
Date: Fri, 30 Jan 2026 14:34:14 -0800
Message-ID: <20260130223531.2478849-11-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260130223531.2478849-1-mkhalfella@purestorage.com>
References: <20260130223531.2478849-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260130_143633_835329_9FAC537B 
X-CRM114-Status: GOOD (  17.38  )
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
terminate inflight IOs. If CCR succeeds, switch to FENCED -> RESETTING
and continue error recovery as usual. If CCR fails, the behavior depends
on whether the subsystem supports CQT or not. If CQT is not supported
then reset the controller immediately as if CCR succeeded in order to
maintain the current behavior. If CQT is supported switch to time-based
recovery. Schedule ctrl->fenced_work resets the controller when time
based recovery finishes.

Either ctrl->err_work or ctrl->reset_work can run after a controller is
fenced. Flush fencing work when either work run.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/tcp.c | 62 ++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 61 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 69cb04406b47..af8d3b36a4bb 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -193,6 +193,8 @@ struct nvme_tcp_ctrl {
 	struct sockaddr_storage src_addr;
 	struct nvme_ctrl	ctrl;
 
+	struct work_struct	fencing_work;
+	struct delayed_work	fenced_work;
 	struct work_struct	err_work;
 	struct delayed_work	connect_work;
 	struct nvme_tcp_request async_req;
@@ -611,6 +613,12 @@ static void nvme_tcp_init_recv_ctx(struct nvme_tcp_queue *queue)
 
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
 
@@ -2470,12 +2478,59 @@ static void nvme_tcp_reconnect_ctrl_work(struct work_struct *work)
 	nvme_tcp_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_tcp_fenced_work(struct work_struct *work)
+{
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(to_delayed_work(work),
+					struct nvme_tcp_ctrl, fenced_work);
+	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
+static void nvme_tcp_fencing_work(struct work_struct *work)
+{
+	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
+			struct nvme_tcp_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
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
+	queue_delayed_work(nvme_wq, &tcp_ctrl->fenced_work, rem);
+	return;
+
+done:
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &tcp_ctrl->err_work);
+}
+
+static void nvme_tcp_flush_fencing_work(struct nvme_ctrl *ctrl)
+{
+	flush_work(&to_tcp_ctrl(ctrl)->fencing_work);
+	flush_delayed_work(&to_tcp_ctrl(ctrl)->fenced_work);
+}
+
 static void nvme_tcp_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_tcp_ctrl *tcp_ctrl = container_of(work,
 				struct nvme_tcp_ctrl, err_work);
 	struct nvme_ctrl *ctrl = &tcp_ctrl->ctrl;
 
+	nvme_tcp_flush_fencing_work(ctrl);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_keep_alive(ctrl);
@@ -2518,6 +2573,7 @@ static void nvme_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_ctrl, reset_work);
 	int ret;
 
+	nvme_tcp_flush_fencing_work(ctrl);
 	if (nvme_tcp_key_revoke_needed(ctrl))
 		nvme_auth_revoke_tls_key(ctrl);
 	nvme_stop_ctrl(ctrl);
@@ -2643,13 +2699,15 @@ static enum blk_eh_timer_return nvme_tcp_timeout(struct request *rq)
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
@@ -2904,6 +2962,8 @@ static struct nvme_tcp_ctrl *nvme_tcp_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->connect_work,
 			nvme_tcp_reconnect_ctrl_work);
+	INIT_DELAYED_WORK(&ctrl->fenced_work, nvme_tcp_fenced_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_tcp_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_tcp_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_reset_ctrl_work);
 
-- 
2.52.0


