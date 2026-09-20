Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 640E7C982EB
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBOnOOrLTxtHRzBhBZsycN4YkbFFBvPMpRlDpWA+7GA=; b=3HdV/iX6lml7ECX6N9y7s7LFFY
	O8LQPK19mk+gRhV1h2wg0Lnodzn+epxtlGso90qYHg+rUhGjfY54MI3om1+dNBRxco46Ug5lIUQxq
	QBS6qAiIf8dBN4FFho2NTX2uWJ3BpNOhhyA3Gaex6MFTXwTDvyPl9oagXs0gGBclY5fKyVTRd2t0j
	52usFAoCiW+q7jmsv2KoY1VLIYzrOVC9tipV61vO3VBzGoYxT6hxm8Wu+L4NRaNYKtQ/Qx/UMpMG6
	kyrs+ZkNxfn7NBwxOxCv03X1uWWVWM7LGBh6zDMKd3LgvM9ae/KvELB1G4cVI7iYswa5N0RNbo4rR
	iCcBvyEQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJI-00000000EAP-3C6u;
	Sun, 20 Sep 2026 18:30:44 +0000
Received: from mail-pz2-x10.google.com ([2607:f8b0:4864:3b::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJC-00000000E08-2nRq
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:42 +0000
Received: by mail-pz2-x10.google.com with SMTP id d2e1a72fcca58-8693af0d7c4so2523297b3a.3
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929038; x=1790533838; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UBOnOOrLTxtHRzBhBZsycN4YkbFFBvPMpRlDpWA+7GA=;
        b=OFi3t7cd/AK4h55UypQdJjF00ZEratpBkq/TRvSfhWQBzmkMAEoGSimtTcdJ4T7+dm
         KoU1uk6MqvTnt1xoLuQtUcD38MC/FpsCMgaGQ7v9+/kDAHgzi5/ktWczBRh11Oqud69d
         /HWB3l45w+NKNiz+POZDBUo06bCOlxY2zWIkHLOJZfClPewa7oWB+rF15Af/kVFlR+Ej
         zfkABVubQG2xWNXbmhlNGLddTNhIpP7uldyMqfy4eFoRJY/0LwZ8YSTauPS5K8ASTHhh
         rdJ4RmbcRm/u5lx+iwPFvoSnhKtro1bN1EOrT/z7k4vVJveol5hFRoiWKsew0Ofdpiot
         FPqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929038; x=1790533838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UBOnOOrLTxtHRzBhBZsycN4YkbFFBvPMpRlDpWA+7GA=;
        b=NG6T1NYxHLBdOOOIcxrmVUTGZyX+SYu6l7PdIvLXxxNyJRVEUPRmZIk6dyktf+ly+l
         tUskEyA4BrnQcgC25NFG9dbN+dIQ1R7buny1x3RniufBhmFzeNKIKaAct1em4MV1tYmA
         0b4L0YAeBlNuiDA0+kONh0viKC52YbD75BARDxidFn9dygG+tAsm8E8QrXhqsRZPGRzG
         +pg5WkS//cWVoskBsn6Ax1Ghj8qBHknZIKTHV98desojUOY2viLKEHBQaMx2/6FxXJ/S
         /ltKsDcHIJdsiusYdPRLcxErDfYZkQ5/qphs7J3h/pYIOTU64AmTDN4PoyvdualIzlxa
         yDtg==
X-Forwarded-Encrypted: i=1; AKwUvBzGw3nvlWwUaZ6zRnh1jS+lIuzyfdyi811Cgr0SRe5EgwMS2VpOpr1vZ13pAoi2hRatBtaKt+Xw4a7W@lists.infradead.org
X-Gm-Message-State: AFuF++lyUqe2IXfvmEjkz2gHzwpXG5JD9aU/r9koF8hyM2u7sYhsFlIj
	rmlZhPOzq4J3paEuBgDJ8ly8dTmQshMMOnamx6f29d5VhKBJgNJQqH7W/y5DgpNS5LA=
X-Gm-Gg: AYBFou3RZTp9X3g+ie9g0f94CKnwbQsbjh7geP5Em8a6LqlUwU78jPhWrMgL8fne/Ut
	z+CMmKrtpEZku76zceue/qzTSTrVhL/lAxxDyDvWeSLm8CXIzTRsQ7lxseLxhwfrDYG9tZqkw6s
	uR7tQBHqSdW9r9j4WppSrYQ4Nt38YI1VKnsnpJUdyqsn8Kno0CNMJFBSmOHwv6XzPvREWF+UxpN
	eDtSfch4eddrO1yNqS1zeFGg+UGj6/agl1+DcyFkfC1YkPqukdMtAHrsIqBu9GEAEV2Awyw59G5
	VV74IPxdOQrhkC/XzVHfYjUB8vB654LED2lyt+7YTeuZ2IOWgn66jNeyJ5hkZVG0q3gI6yM42ql
	Ck6t4gmfFI9Bf0+i1TBzsEKUdJHyKfrhGcIMrD3YsVvFUvHCzxFMaDaBVuwRK0uvUNF1+aHgio0
	rzwaUweeMV15nViytD907BNQoEY4xaXsUerFj2hENeewa55GPWREs4UFlb
X-Received: by 2002:a05:6a20:4386:b0:3da:b761:80c0 with SMTP id adf61e73a8af0-3dd8c424e85mr15235108637.14.1789929037653;
        Sun, 20 Sep 2026 11:30:37 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:37 -0700 (PDT)
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
Subject: [PATCH v6 14/18] nvme-fc: Use CCR to recover controller that hits an error
Date: Sun, 20 Sep 2026 11:28:12 -0700
Message-ID: <20260920182936.2317916-15-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113038_730423_A3E7AF41 
X-CRM114-Status: GOOD (  16.61  )
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
 drivers/nvme/host/fc.c | 42 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 42 insertions(+)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 5a530aa37641..42671cca439f 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -166,6 +166,7 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	admin_tag_set;
 	struct blk_mq_tag_set	tag_set;
 
+	struct work_struct	fencing_work;
 	struct work_struct	ioerr_work;
 	struct delayed_work	connect_work;
 
@@ -990,6 +991,7 @@ static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
 static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
+static void nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl);
 
 static void
 __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
@@ -1870,6 +1872,30 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 	}
 }
 
+static void nvme_fc_fencing_work(struct work_struct *work)
+{
+	struct nvme_fc_ctrl *fc_ctrl =
+			container_of(work, struct nvme_fc_ctrl, fencing_work);
+	struct nvme_ctrl *ctrl = &fc_ctrl->ctrl;
+	unsigned long rem;
+
+	/*
+	 * Tear the association down now so the LLDD can finish unregistering
+	 * the remoteport/localport while the fencing this controller.
+	 */
+	nvme_stop_keep_alive(ctrl);
+	cancel_work_sync(&ctrl->async_event_work);
+	nvme_fc_delete_association(fc_ctrl);
+
+	rem = nvme_fence_ctrl(ctrl);
+	if (rem)
+		dev_info(ctrl->device, "CCR failed, starting error recovery\n");
+
+	nvme_change_ctrl_state(ctrl, NVME_CTRL_FENCED);
+	if (nvme_change_ctrl_state(ctrl, NVME_CTRL_RESETTING))
+		queue_work(nvme_reset_wq, &fc_ctrl->ioerr_work);
+}
+
 static void
 nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
@@ -1950,6 +1976,14 @@ nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 		return;
 	}
 
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_FENCING)) {
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: starting controller fencing %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_wq, &ctrl->fencing_work);
+		return;
+	}
+
 	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
 		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
 			 ctrl->cnum, errmsg);
@@ -2463,6 +2497,12 @@ nvme_fc_ctrl_get(struct nvme_fc_ctrl *ctrl)
 	return kref_get_unless_zero(&ctrl->ref);
 }
 
+static void
+nvme_fc_stop_ctrl(struct nvme_ctrl *nctrl)
+{
+	flush_work(&to_fc_ctrl(nctrl)->fencing_work);
+}
+
 /*
  * All accesses from nvme core layer done - can now free the
  * controller. Called after last nvme_put_ctrl() call
@@ -3428,6 +3468,7 @@ static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.submit_async_event	= nvme_fc_submit_async_event,
 	.delete_ctrl		= nvme_fc_delete_ctrl,
 	.get_address		= nvmf_get_address,
+	.stop_ctrl		= nvme_fc_stop_ctrl,
 	.get_virt_boundary	= nvmf_get_virt_boundary,
 };
 
@@ -3547,6 +3588,7 @@ nvme_fc_alloc_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
+	INIT_WORK(&ctrl->fencing_work, nvme_fc_fencing_work);
 	INIT_WORK(&ctrl->ioerr_work, nvme_fc_ctrl_ioerr_work);
 	spin_lock_init(&ctrl->lock);
 
-- 
2.55.0


