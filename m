Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C9E1C982D8
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=i0UuleHNrFJL7Ac1BNRBp4u482qJaS6x4l4kwP4ak8U=; b=iCib+rtDfPoqJAQL28b7TvDThB
	izZNvIaLlnYoUIJc65kH3+ByUQdtkMn3nL193SPopRA0+BYN1HuhriNyrEurwMV22Tdns9ZW1mY+R
	IbWgV5Ntz1bR+9vY550SGlRtvkETppPQirHhhHMkebPa1MfiHcM6ApjHOnWiHoL8jkbW92fsZ4Wz9
	JfzhZW/mvjTPF1QwkcztBbwAnPUMltHuKmNQeQmMxwi3bJVzZdks92pHkR0PGVWIDENwTUfzMVCX8
	YlZNsc4Gsym31W+nk2WeZsWTj9pWiVKJk62owVaay6uDDOPlvjXZwa0i5DnfxHMTP1QMEZCbnkydK
	HyWXx+nQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJC-00000000E1C-3hIF;
	Sun, 20 Sep 2026 18:30:38 +0000
Received: from mail-pz2-x0f.google.com ([2607:f8b0:4864:3b::f])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJ8-00000000DuY-0K4n
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:35 +0000
Received: by mail-pz2-x0f.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so2523270b3a.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929033; x=1790533833; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=i0UuleHNrFJL7Ac1BNRBp4u482qJaS6x4l4kwP4ak8U=;
        b=QpIX8hVggtwBEO7Yj+5/Za7SDuntDH8i03uDouKodvBFs2ZjhveVVKLNs1fWwE6x4O
         wczkTijZzV091qyFasR8g8Vx/VQep5EjiYqw5z/nRJ7X2Q4EA7W+EkvHQ1iyxmDHvI4A
         E7tW6qOsaH8eSXfLUCmAfcAhiVLSEwJaLbKwteP4iUhSWX8dSeU8SrzwTrqZbrfYiba1
         NZhHEzzP971CrzRcmtDFhXKeA4NKPNyoC04CiPiCk4uUTFfC499Ol6s+06SCwb4q3LTm
         GGVCQKW6bOCaLge6beEwXPc6de6ryX3BCf8W2BIzGPNpeoilMv2SYuEGbY9Nihdj3dg3
         lkqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929033; x=1790533833;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=i0UuleHNrFJL7Ac1BNRBp4u482qJaS6x4l4kwP4ak8U=;
        b=KQQsFp/aqSbt2ya1eOd2XzURhg7zrx/H91RMraMwgiCdIpcUkco/ExTp4FEEhFURwX
         lmKiTHdUbwJ0GN1CXE6NztJ+HKfrV2E8Ha8bjQ2XS/FU287sdRyiajb2ElYFE1l+qVN4
         T99nW23wqnxpyIAr92CQWdyZI0gvAJYmMnQ27O7yp5+5ab4ZQNwwRExBUnfNe6hRd2kC
         LxpzHrCiMGDGnDsbT5PhpNrZmQHpBmb9uhdoF4txCNqQD9I5VsZYPSObH2hGx1kcl60y
         x8FU0SzJC4ALHeBfv7lXIVgmputN/XK2YSSghEMXFR3pi2fFMFJJAey1IVt7jMQG+0rn
         gqNw==
X-Forwarded-Encrypted: i=1; AKwUvByWlQejN6qpEYFQNwOc1GnJeswUZC25BisgyF2tuuOqFCmMMn7sFbGEFlMQYJX/X097zf8+BsPpD1we@lists.infradead.org
X-Gm-Message-State: AFuF++k1uTsvQxq612fvprZdE2hrMRwpnsFZJpfq9shlGruZ/0IPrSsw
	RtXUqOoQUTQTIDo34zZoac9wwpe8E1dHmkfCI8kpJnHhcEDD5V7xH2tsK8pfXS3NVFM=
X-Gm-Gg: AYBFou0mL9a9moe4iFEhj448F2lj/b56uV8jpEXm07X7z3pCM2WKzLO+xTL+ouyuz2y
	ZhS1J45SKWqyCPKI/UidXwehdmmfLmNCSHJiz1oG9rPN5KqxweHPqRP1O63pmO8oBza2yfy9/bh
	eQ4A2cCZZnBcYf3XQO8L5Gk6lh1/NPD7NiofxBI7bGGZV899CtbZ3+GnIl4T4WTXsTZPcVDx2LN
	cRlu42w0JseSrPlcB8P775qzWRlIEovpyOshtftT0rOE/vyumlaAjaQkPna15Ao/x+/YAqENiPs
	tdVVvcbL3SXn1xc2+HZ2CCws3FKKdD3kPUzQFeFSivi0WJqJj0T2dFElkk1fumPyvR5d6QMes0s
	UAwipFVhJ+HJD+9AdcIJ85yx3ZpZ5Pjr9jnKlnSANtcSO+9ttuuIBS14OqP/2pcDpiaPYbds0GO
	9mZ3jUyuD7NaSSS/yyQedYs3bIK148dnqH+UXGpjXmOQZsKYHVrduxnC/7
X-Received: by 2002:a05:6a20:2586:b0:3dd:85a8:4c66 with SMTP id adf61e73a8af0-3dd8c5db1e1mr13018748637.45.1789929033190;
        Sun, 20 Sep 2026 11:30:33 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:32 -0700 (PDT)
From: Mohamed Khalfella <mkhalfella@purestorage.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Justin Tee <justin.tee@broadcom.com>,
	Naresh Gottumukkala <nareshgottumukkala83@gmail.com>,
	Paul Ely <paul.ely@broadcom.com>,
	Hannes Reinecke <hare@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	James Smart <jsmart833426@gmail.com>,
	Randy Jennings <randyj@purestorage.com>,
	Mohamed Khalfella <mkhalfella@purestorage.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v6 11/18] nvme-rdma: Use CCR to recover controller that hits an error
Date: Sun, 20 Sep 2026 11:28:09 -0700
Message-ID: <20260920182936.2317916-12-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113034_119865_B503D6BC 
X-CRM114-Status: GOOD (  16.63  )
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
 drivers/nvme/host/rdma.c | 29 ++++++++++++++++++++++++++++-
 1 file changed, 28 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/rdma.c b/drivers/nvme/host/rdma.c
index 29ecbe71bb2e..9c50421d79c4 100644
--- a/drivers/nvme/host/rdma.c
+++ b/drivers/nvme/host/rdma.c
@@ -119,6 +119,7 @@ struct nvme_rdma_ctrl {
 
 	/* other member variables */
 	struct blk_mq_tag_set	tag_set;
+	struct work_struct	fencing_work;
 	struct work_struct	err_work;
 
 	struct nvme_rdma_qe	async_event_sqe;
@@ -992,6 +993,7 @@ static void nvme_rdma_stop_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_rdma_ctrl *ctrl = to_rdma_ctrl(nctrl);
 
+	flush_work(&ctrl->fencing_work);
 	flush_work(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->reconnect_work);
 }
@@ -1153,6 +1155,22 @@ static void nvme_rdma_reconnect_ctrl_work(struct work_struct *work)
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
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &rdma_ctrl->err_work);
+}
+
 static void nvme_rdma_error_recovery_work(struct work_struct *work)
 {
 	struct nvme_rdma_ctrl *ctrl = container_of(work,
@@ -1180,6 +1198,12 @@ static void nvme_rdma_error_recovery_work(struct work_struct *work)
 
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
 
@@ -1990,13 +2014,15 @@ static enum blk_eh_timer_return nvme_rdma_timeout(struct request *rq)
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
@@ -2327,6 +2353,7 @@ static struct nvme_rdma_ctrl *nvme_rdma_alloc_ctrl(struct device *dev,
 
 	INIT_DELAYED_WORK(&ctrl->reconnect_work,
 			nvme_rdma_reconnect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_rdma_fencing_work);
 	INIT_WORK(&ctrl->err_work, nvme_rdma_error_recovery_work);
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_rdma_reset_ctrl_work);
 
-- 
2.55.0


