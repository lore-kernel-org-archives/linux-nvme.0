Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 992F8C982D8
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UBOnOOrLTxtHRzBhBZsycN4YkbFFBvPMpRlDpWA+7GA=; b=HcoIhNBHv4fcr3PZc2dM/j5AVE
	5Ipw93AiQNVZuuAAxZQsNo38YEjrsoisoWTqzKGighe0u0sPMSO93MJyHHQ8UInq+fyzHuw9LYjrk
	YyfH+RVj6KWNxdtTiDdVSA9pwTfyzLNkbKgYS8ISMCkT/FpQYp0hV0JKykqF76kE+BbX4xh2xYkr/
	+ehQdoKSk9puntMejQ3TkMJizIdXEMwiQMGSSmjJav4vsJoyzNDl2/Yy2g0c7JR/2x0RkQ6F6EpZw
	V5cbV9yTB8kduqi67Atyx8YaGARsEgdSa2Ww+1GfI/qqHsc/6lIYQQIkTHXzjpPNxok3Jy6FRqgru
	0wT4liNw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9C-0000000FHL3-3oXh;
	Fri, 18 Sep 2026 18:17:18 +0000
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d99-0000000FHD0-24sL
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:17 +0000
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc4cacd3409so1111700a12.2
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755435; x=1790360235; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UBOnOOrLTxtHRzBhBZsycN4YkbFFBvPMpRlDpWA+7GA=;
        b=LQu8fUuycY3FFGFcXn3GX5eSgHTqJyrv9agdfMyV1yWxj+4yMnebNBJia3XM33+GJl
         E5u8OigJL4yCo6V5J7DWciWLySX/YLgMUykpS+QuO+qXwD68M0ToQY9bMgPzdw2tPT3K
         +N1BTPdmbcFCE2GbdsH3DuNZNHoEbN0xWQl336VTl6eN09JQeie64el+IIS5Y3qVUt6D
         r6DIBHAdoGsNRAri0BwzbaKXk0RTmYCnT5O7W6UUfQcRuujXOuI5bySSJpHRemWEvJcO
         BOXVNCQlsgCI7CIuU68rJa2QcDdKuGIFibbl5sGB3p9uvxdNqF7rBtfQWF1XZNbWiEEH
         laNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755435; x=1790360235;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=UBOnOOrLTxtHRzBhBZsycN4YkbFFBvPMpRlDpWA+7GA=;
        b=lM48kr+2X0yDeDBHWZ+YBC1CQsH51ov5g4ULXDEpXVL/4MVQhDSuqSQNT2wl21PS7T
         OPJX3tjZQvEGpdH5DmPEvuE0uv6BIaYBbMeuBgLGKP4+AyWJXz7Yh5mJticrTs1ctPV/
         ZXC8N2WKYWGuC8RFpZUnUPDzYc+kPsukvAx1BhFh1jxflYU0CKZsVX69hznAFQ1pippN
         O72bp784crgqt5nYqteeCqlZOrsew3SeoLA42tHGXDC7ydLL+r78Kt1Z07V2UgBjjwUP
         YxYJjN9hyuI9WHEjSw7x0cZCo62t3Ex98uydEhas9jojgeY72Gj9S+0fezemZazrfCbz
         MqBg==
X-Forwarded-Encrypted: i=1; AKwUvBxDjiuHvqVbdLVFG2cn4FxusUVoyZDIPPI1uZtWPlfoCpJgkdtfnFuUHB7DROgLsmbzvOsEiKABJj5P@lists.infradead.org
X-Gm-Message-State: AFuF++mpgxFRylRhOL3xNA6jc6i0gpNQrgVCYXxf8TwL3q/MNOGz2nMY
	vVynoVCR7Nx41hxR3TODCTNLCuiuwfd0cr01gyLU9PFMbWZScEQ0iYosvr2Rw6E2F70=
X-Gm-Gg: AYBFou0olEU4HtUr3y+k2kFg2atMaWB1kqi2Clw+Ck4sRnD+sT5PbvmOaWJI7QSHRIM
	5HVrK8puo+jqe2QJIFbIJ8Hd1rof4Vov3SjEy8K96RSi2crDfRJwTaadnmhX3CUJF1SJbHnIBUE
	3My8hSMAtg7ATIhT1u4rovyGMKphh1nt77OBXIW7FSetMtpMQgvieqQg0qWnTi2sAbKwtv21Znq
	wA7pTCekIabCK2XEaxkcaRypvpdsX2cDrEMwKvdeVUHxNEKmN4UphcCBg+k6IJ7cTJLf9tpqdtD
	EX48UlxleHQlLQE7xA9NDnGMRrU4XG0i2zHu6r3pBqI2cc2v4od3YlCK8OB5DswwvLhrnRk3Hyv
	lnnMEPTiLvhP9IQmSlXRt8fg3urcIc+KKzdQa2IWx2htDP4qlMNY1IdwFSEjBkFxJQb+P040J74
	BVk5K1x0QmMNBYyFNjgXAuoxU407lFn9o2zFEmSEFN6uDtlHgQNsR4/8w6kdNvzuFDgqOT2NfsL
	3fy2rGr6eKABVgTK7CI4Q==
X-Received: by 2002:a17:90b:2686:b0:39e:6c69:9b9c with SMTP id 98e67ed59e1d1-39e6c69b2bemr656537a91.65.1789755434694;
        Fri, 18 Sep 2026 11:17:14 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:14 -0700 (PDT)
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
Subject: [PATCH 14/18] nvme-fc: Use CCR to recover controller that hits an error
Date: Fri, 18 Sep 2026 11:14:14 -0700
Message-ID: <20260918181614.3947933-15-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111715_575074_2530841E 
X-CRM114-Status: GOOD (  16.69  )
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


