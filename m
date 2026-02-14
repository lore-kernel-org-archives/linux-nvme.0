Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F32C4EF99FD
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Feb 2026 04:28:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=B78xagprpyBVY7dOisWT+DL2wEB4yi6Dl89xT/FMHaI=; b=0EOKfuROOcp7X60nfhXJYp+/Rg
	lHjc9WqzqRSzTrIgO/WulbGZF13+2Xb3soDDsa/sGtNaZbZRSi95D+J4e2NUmvbQVvw06XDS5OBOx
	W/v/9dzJqW6BG2gqeHhlH7pFEia4XEU5ma7vLb7Hfb03JwnqnhGnNwYCNOKsKL7ju3bxe9hjiqqAW
	M+bteI0y2li6Zu0bQkVemxyH1u2s01xrBbg4LlVEkkdycBKyD7QJFQQ0AMY0juJrasVoVyzz5Kir/
	sAgJASgb2adHKKv7adrRvLuhquSaKjyDLNLst1mzQZPTmcMETE6SF29vfFWC+huoA2LnfWB8w219c
	s53NAnYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gl-00000004FAQ-1Jzb;
	Sat, 14 Feb 2026 04:28:35 +0000
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vr7Gh-00000004F2S-1ITV
	for linux-nvme@lists.infradead.org;
	Sat, 14 Feb 2026 04:28:32 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1271195d2a7so1945491c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Feb 2026 20:28:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1771043310; x=1771648110; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B78xagprpyBVY7dOisWT+DL2wEB4yi6Dl89xT/FMHaI=;
        b=cCLv9ozM9GMh6clVq7qLQLJOfpi0oyb5+3NbopZQwglBK+Tmp28jrY1R8XuQZgXEdY
         50/fdI/U22cbqY1vi4NCu6bN9yqR+8FnNcxyDcYLIaHV5mR5gboGhr49P3RZkpM67M9O
         Qs8ABDsPphKI1yBLxSx9/kM9aWrCGe49eZBDOSSp59hjqwz3GPy6+HNN/Ttgne4VZbtG
         mBQ1VSTjPTksJ1qk9HT7P8I4ty/A2ocBLAdIkqT/x54uwNtcOQMHc8A74VdX2ZeX2cCE
         5Lj0QYzusEuTkWsKtjr4sXWhbne08GkpkzIiYYGMhKTBejnM6lwJCiEdNAE+XnrJ3Qgy
         gEew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771043310; x=1771648110;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B78xagprpyBVY7dOisWT+DL2wEB4yi6Dl89xT/FMHaI=;
        b=R0scl+tUFisgzx75IbZP2OJN6ZMFhu7Efil77iNjD4zXchh4++MDkOElbKxMXxL7SF
         8ZEnJzAYYDzIecnOro0NzG4OO9AKcAv/Mhfj6LnFYGuAmLvC0zWLD4PI3LqH2ddNf/o1
         +MOzOGB1Ak2PS+sg5SrVGwWMashXZEUVBSE3HvP3wbrD2IZgnjqKYx9m+jX2rFk8xUpR
         Zr3T5tUHAbJel0QDDC0brGjP5Ka/OZbeKurWMG3QxVsCi1SQi2kNcEsdXg/YM9KzoB9G
         m+3+yqqU9B263DSlki1FAnnI4Yc3RDA9wS2PDgDtUCmf8PObvKFFfBYc/SckJG4hKzm9
         vcUw==
X-Forwarded-Encrypted: i=1; AJvYcCXerPGx6hts8CPcfUxcgPxR356jbpiDoUwdS+WGLXUPPyWtWsYEhGzYCelbcPooaL18zUcxjTIn8+8F@lists.infradead.org
X-Gm-Message-State: AOJu0YzCtni2GxpQM95UivAUBn1kB1uHcdGdbePJncmUY8adGNuQ/USU
	EtlR3kpB+TzgoM37tl7fRu+HKsQYZnGAPnJX+VK+miAXPZM6j9Iod5TA38z39rQd/iY=
X-Gm-Gg: AZuq6aLRbf6nWr793Cw93EErvnX4ZCAM3D1NrUDL1mvfsYG3Nsn7FBitV7X5DbZyg85
	v+qGqjfb+OwDaSzJH5yA+A0Mn8YLUe8Fj8JOqkDjjWvBIxpclZqCTXgz6MczO7lITBkOeNBVhu7
	n/n+O4pyuWsb+GhZmvcF9x+hWiUHMLjgVu58ZoLJmDqInitNvGxLO2QXARdpvY42+Kfm1iIgog8
	a5eGTBayt39/AZGwZRa3sfBtAiFUDPYLKzO3q8E3t4gVVaYf4kz1PxGhANTc9iEB3QMBEzlRYQ9
	hVILqZim/V7S/lPxBqJvihBAL5qt+KNDANLxsXvauhyfthNAX8/DQLLabBuzVO5FCcO8VAX13u5
	4KNMkPzYgCjAQIGNzfn1YZuTBqZDAVT2Wut5jOi4Hwsgch/vAMsZPy1R4Kui1o4axoXBlaU14IY
	gKnPWd95A85xz/GTgpHoEpL7QaXhWCdWVT2AOYkMQHvr0XAg==
X-Received: by 2002:a05:7022:6183:b0:123:3bba:fc4c with SMTP id a92af1059eb24-12741bd1a97mr687392c88.38.1771043310143;
        Fri, 13 Feb 2026 20:28:30 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-12742cbc900sm1021042c88.14.2026.02.13.20.28.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Feb 2026 20:28:29 -0800 (PST)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
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
Subject: [PATCH v3 11/21] nvme-rdma: Use CCR to recover controller that hits an error
Date: Fri, 13 Feb 2026 20:25:12 -0800
Message-ID: <20260214042753.4073668-12-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <20260214042753.4073668-1-mkhalfella@purestorage.com>
References: <20260214042753.4073668-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260213_202831_422105_DD6534A1 
X-CRM114-Status: GOOD (  14.88  )
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
 drivers/nvme/host/rdma.c | 32 +++++++++++++++++++++++++++++++-
 1 file changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 35c0822edb2d..2fb47f41215f 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -106,6 +106,7 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -1120,11 +1121,30 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static void nvme_rdma_fencing_work(struct work_struct *work)
+{
+	struct nvme_rdma_ctrl *rdma_ctrl = container_of(work,
+			struct nvme_rdma_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &rdma_ctrl->ctrl;
+	unsigned long rem;
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem) {
+		dev_info(ctrl->device,
+			 "CCR failed, skipping time-based recovery\n");
+	}
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
+}
+
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
 			struct nvme_rdma_ctrl, err_work);
 
+	flush_work(&ctrl->fencing_work);
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -1147,6 +1167,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 {
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->ctrl.device, "starting controller fencing\n");
+		queue_work(nvme_wq, &ctrl->fencing_work);
+		return;
+	}
+
 	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
@@ -1957,13 +1983,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
 	struct nvme_command *cmd = req->req.cmd;
 	int qid = nvme_rdma_queue_idx(queue);
+	enum nvme_ctrl_state state;
 
 	dev_warn(ctrl->ctrl.device,
 		 "I/O tag %d (%04x) opcode %#x (%s) QID %d timeout\n",
 		 rq->tag, nvme_cid(rq), cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
+	state = nvme_ctrl_state(&ctrl->ctrl);
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_FENCING) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -2169,6 +2197,7 @@ static void nvme_rdma_reset_ctrl_work(struct work_struct *work)
 		container_of(work, struct nvme_rdma_ctrl, ctrl.reset_work);
 	int ret;
 
+	flush_work(&ctrl->fencing_work);
 	nvme_stop_ctrl(&ctrl->ctrl);
 	nvme_rdma_shutdown_ctrl(ctrl, false);
 
@@ -2281,6 +2310,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-- 
2.52.0


