Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4441FD10372
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Nov 2025 02:13:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aH2GP6wi0yyOImZ0Dp3pp8w4EIT67hcH8CtToZuUsos=; b=ujXdBNujToSSkQPcMg2q2jqneX
	AYH/xPvbQ2dmuPLKudkowTQosNVRXBAWlYFpxB14bmi9KfL6CeV6pdyoKMWlrW3Cq5mIB2nJ7pBfE
	6JOqFZWACZ0Tjh4cAuAfx/ezeM1QqKFWXU88za+pxLSWO4NppVlWHSZSDeC09BkXL7WdoGuOHK3N8
	/3Cxp4IIoEDuCwirNRazqZoKsfVe2pkvpjcOPobeejqOoJYvqkmlqJM4XVv+Lah/zdh7xNr2eV55W
	ISYXZhQ/rufGg//yxOuouIR8l/CuTuzNMCKsQepXQfzaorSdpokTEL9iC4OnPC41yUu2ImFuquntr
	AzDVnlkA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52G-0000000EDXd-0mVC;
	Wed, 26 Nov 2025 02:13:36 +0000
Received: from mail-pl1-x629.google.com ([2607:f8b0:4864:20::629])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vO52B-0000000EDPo-2T27
	for linux-nvme@lists.infradead.org;
	Wed, 26 Nov 2025 02:13:33 +0000
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-29558061c68so82636705ad.0
        for <linux-nvme@lists.infradead.org>; Tue, 25 Nov 2025 18:13:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1764123211; x=1764728011; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aH2GP6wi0yyOImZ0Dp3pp8w4EIT67hcH8CtToZuUsos=;
        b=RH8B9t8NtmOcVGaLy4L2ml8SmbVHGCnY6x2PQ+FfU8I+qY8ImIBpV+ZinWTnfTHhLO
         DyRVXIE1F+5OkQRl26V8+6O9bP4B7uQtNXABUYvu1+UdDCLv9a76FXeo7eXmJFXYJPMN
         qFsqj9w6oPTsXudrUc+n0VGFOji0jwi7/b5CFgnu5IdvZrgXOoTMf38jwwCuidFYslzA
         WR5Na+hr4XN4Z2eUYuM2P7SFdA93Ku20gKsUfIMjcKUyyN9C/uDIOH5VxuzaOPlYUEdH
         7Q4iTYQsbkKVNXs9JpumtI2C7E1he0cBGRdoDZMsgue26BpholZ9Qhgt0JbQqmN7yZ88
         UftQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764123211; x=1764728011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aH2GP6wi0yyOImZ0Dp3pp8w4EIT67hcH8CtToZuUsos=;
        b=VFg/IeDBsaLOdnfD0qQSVCFSLV64osSkGO+ywa0ocBHRKYV8GbPbsUYhFKcg8FUPS+
         vd2yrxadvW/4ZDKcVzML742v3Ww/CbdY/2DiEP6zZupMi6JqMTHe6/4ScLMtbp18RF37
         tKN8zUkl6aHTMzIHPOMNykFkNc9i7xOYzcd3IRIU5lQzIzPviW7LaDecKJ2hulUBr+do
         7+KeI+3ESKYaSVS7Ju939xeNNB2403GCOIBf8egi7/85eoc6dtPU3agZQH3beQ8dGq7N
         euqitoxfWN0WVVrbWFoSYZ062IU9Uw4MbQ0IokGr40jRL8CX2S3YAc0Z4atgR1wevSbR
         2nAw==
X-Forwarded-Encrypted: i=1; AJvYcCWURX9AbAMP+SxW22V/Hb40GaGIi5SFEKg3Q3advagSeyuX76GlZwmlBjpwNCaajNftfcbJQwHqaK/S@lists.infradead.org
X-Gm-Message-State: AOJu0Yyd3epv5txgIoN0kRpL4LP/QTvOZIDsGSZu/5n1Od275/7Jfi2c
	Vbvv+2RqG3SkjFopyoRJ1E5yoV4V+S0/9NcovVTdAC74r0+l0I5ISiktSCq1HF1hvDM=
X-Gm-Gg: ASbGncuRazGhHPG2r1sc93JV7DZb7FT2P8Qsl5yrl6sCuJfWrqnQzxcsUN2V78v1CBL
	sqOEz0+/znUJB+51ToHlR7MFjGXB+KKo1l/mfoziMAEd+zxXSP9E+ptVkgxex1qXq61QcLNdVsE
	CEVS6o/y2RVEzjJ/Ef0o74HZc/h5b5lsAPtzRrA3kHV9jUVC73Bpnivvfwb/Xi7cwCoX0X0Tkn7
	BAQxFzBW27ddriAff0sys6KkOM9X24YCO3B9twk7q6v3hisQk21ot6bV5HSGPJggpEvRxkSJkGH
	bTA9kZGzL61/tWpieZuISHRtC8Kqi9axRH/kfZ9nQdLPE/S/NhLCAKPCPV0ywuUCTHwt7DK2o6d
	sitQaTXvLArMoLHTShAt4paq3yb6N2SK5h7OKuHxzUOYEzETTEI/flLQv+JH6yo5i+rIcUGni/h
	BqGNpx6exh1yb3CUwAKK4D9T2R/4gPWG/095H7taZqGROU
X-Google-Smtp-Source: AGHT+IFvIR3so/zGM7TzoMU9iN0J/zu9A86U8fi764PcWo6NnydsjrOq2DlhO3KmCVnIDz1un0nNTQ==
X-Received: by 2002:a05:7022:f909:b0:119:e569:fbad with SMTP id a92af1059eb24-11c9d852d48mr7072685c88.28.1764123210516;
        Tue, 25 Nov 2025 18:13:30 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-11cc631c236sm17922979c88.7.2025.11.25.18.13.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Nov 2025 18:13:30 -0800 (PST)
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
Subject: [RFC PATCH 11/14] nvme-rdma: Use CCR to recover controller that hits an error
Date: Tue, 25 Nov 2025 18:11:58 -0800
Message-ID: <20251126021250.2583630-12-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.51.2
In-Reply-To: <20251126021250.2583630-1-mkhalfella@purestorage.com>
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251125_181332_089611_3FD88FF3 
X-CRM114-Status: GOOD (  19.71  )
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

An alive nvme controller that hits an error will now move to RECOVERING
state instead of RESETTING state. In RECOVERING state, ctrl->err_work
will attempt to use cross-controller recovery to terminate inflight IOs
on the controller. If CCR succeeds, then switch to RESETTING state and
continue error recovery as usuall by tearing down the controller, and
attempting reconnect to target. If CCR fails, the behavior of recovery
depends on whether CQT is supported or not. If CQT is supported, switch
to time-based recovery by holding inflight IOs until it is safe for them
to be retried. If CQT is not supported proceed to retry requests
immediately, as the code currently does.

To support implementing time-based recovery turn ctrl->err_work into
delayed work. Update nvme_rdma_timeout() to not complete inflight IOs
while controller in RECOVERING state.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/rdma.c | 51 ++++++++++++++++++++++++++++++++++------
 1 file changed, 44 insertions(+), 7 deletions(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 190a4cfa8a5e..4a8bb2614468 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -106,7 +106,7 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
-	struct work_struct	err_work;
+	struct delayed_work	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
 
@@ -961,7 +961,7 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
-	flush_work(&ctrl->err_work);
+	flush_delayed_work(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 }
 
@@ -1120,11 +1120,46 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
 	nvme_rdma_reconnect_or_remove(ctrl, ret);
 }
 
+static int nvme_rdma_recover_ctrl(struct nvme_ctrl *ctrl)
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
+	queue_delayed_work(nvme_reset_wq, &to_rdma_ctrl(ctrl)->err_work, rem);
+	return -EAGAIN;
+
+done:
+	nvme_end_ctrl_recovery(ctrl);
+	return 0;
+}
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
-	struct nvme_rdma_ctrl *ctrl = container_of(work,
+	struct nvme_rdma_ctrl *ctrl = container_of(to_delayed_work(work),
 			struct nvme_rdma_ctrl, err_work);
 
+	if (nvme_ctrl_state(&ctrl->ctrl) == NVME_CTRL_RECOVERING) {
+		if (nvme_rdma_recover_ctrl(&ctrl->ctrl))
+			return;
+	}
+
 	nvme_stop_keep_alive(&ctrl->ctrl);
 	flush_work(&ctrl->ctrl.async_event_work);
 	nvme_rdma_teardown_io_queues(ctrl, false);
@@ -1147,11 +1182,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
 static void nvme_rdma_error_recovery(struct nvme_rdma_ctrl *ctrl)
 {
-	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RECOVERING) &&
+	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
 		return;
 
 	dev_warn(ctrl->ctrl.device, "starting error recovery\n");
-	queue_work(nvme_reset_wq, &ctrl->err_work);
+	queue_delayed_work(nvme_reset_wq, &ctrl->err_work, 0);
 }
 
 static void nvme_rdma_end_request(struct nvme_rdma_request *req)
@@ -1955,6 +1991,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 	struct nvme_rdma_request *req = blk_mq_rq_to_pdu(rq);
 	struct nvme_rdma_queue *queue = req->queue;
 	struct nvme_rdma_ctrl *ctrl = queue->ctrl;
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
 	struct nvme_command *cmd = req->req.cmd;
 	int qid = nvme_rdma_queue_idx(queue);
 
@@ -1963,7 +2000,7 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
 		 rq->tag, nvme_cid(rq), cmd->common.opcode,
 		 nvme_fabrics_opcode_str(qid, cmd), qid);
 
-	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
+	if (state != NVME_CTRL_LIVE && state != NVME_CTRL_RECOVERING) {
 		/*
 		 * If we are resetting, connecting or deleting we should
 		 * complete immediately because we may block controller
@@ -2280,7 +2317,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
+	INIT_DELAYED_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
 	ctrl->ctrl.queue_count = opts->nr_io_queues + opts->nr_write_queues +
-- 
2.51.2


