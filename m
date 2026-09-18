Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4A58BC982DE
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Sep 2026 18:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVhzIJ0voivWryYWZvH7CE/nJwrk1ooSyz4ZIVHdKLo=; b=ZXRO80Cc8o+Q+q/rvIOIsp7dEP
	5KiDnIis3CUObYbAIgWyfO+9zhM4pZ9wHdx7BJtFwm1bZJQsEuIOC3prUkuKHzAS0Rxyy+u0N6ahC
	236LvorIZAh/FuDfpoSWwtni+eT8RiEwfBr+WQ9G3heTpbv1PHlZO3IZjUD6m2T06JLl4iCwF4S2l
	CGqbyURQR5zVBANqRUgBEWnLZVNHolJsRA2fyUy5utG01Q3vswftdjkC/4qlPoh5Jafjc2H8sBn9I
	o+4vPml1qdyABSpiw/37/YE2WvUOtFybfpcjKWc0IhFVBjyxTHRDRhhoLxj4O8d+MjRvKj/a3xN3i
	AC+kjuzg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d9C-0000000FHJx-2SOC;
	Fri, 18 Sep 2026 18:17:18 +0000
Received: from mail-pz2-x0e.google.com ([2607:f8b0:4864:3b::e])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x7d98-0000000FHBX-3CzB
	for linux-nvme@lists.infradead.org;
	Fri, 18 Sep 2026 18:17:16 +0000
Received: by mail-pz2-x0e.google.com with SMTP id 41be03b00d2f7-cc4c3304784so902023a12.3
        for <linux-nvme@lists.infradead.org>; Fri, 18 Sep 2026 11:17:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789755434; x=1790360234; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVhzIJ0voivWryYWZvH7CE/nJwrk1ooSyz4ZIVHdKLo=;
        b=QyEQ37Dv8guTRADYvnb6aBurxxVoUeTHl09F5z1vC3wcQq3BHbtjTSMm93hC7HE8QQ
         EIm/t/Nh3wwvbgRNT/Sk99XE6sEuocBve3GfGmG7jAMwQwptg/Gr42cbqWaIyQd1UXHj
         LEwAZRc5n47tZk4h3F+D2M3CYP7XCki/w/wNnhEGGlAC8YgzqezI6eNBknF8nVEcz42t
         Abfm5sU6bMEFSCDvjHHEbsLHFLWQu5LGPgk4BZj6kefd+VxM3iRer7JKWLknpZKDjf0P
         tEYUISL/1OpAggBdyZpkENGSmt63SHj5BjV4uRfjT6I5bxIy+5oyXfwbMIkkcBa2gs99
         Vd3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789755434; x=1790360234;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVhzIJ0voivWryYWZvH7CE/nJwrk1ooSyz4ZIVHdKLo=;
        b=NJmPqb+wfXdHqZjto0r/wJLd4e3BlUJ+I/9OXRqUAoe7iJzlKRj8okPeJ/b8ZODlSp
         whWEgoo/7Tb6//pAiLKTk9b9ToRxCiopv7xZEbuzA2ziKQYx4JLT8HsX8hOxWvRip1Ig
         vy4B8d5JAOikcfYy4Ji0Vxnz02Ny27H102VJoNGzJOoAP1od5B+tKGQ12WBKeINYttAu
         AfBhHPjf3yWzG/rV0KolSifTo4vQ0C5tddDmVY4+7MdCHxxw1CIckt0xTK0b43FGgW19
         Lx4HIJY7RtX1izmmX17DhiSruoLV0DF/fFmAZD8F7kFVx1vfG/qStQ47SzekQXXqq0FB
         VfIw==
X-Forwarded-Encrypted: i=1; AKwUvBzF/+oelSKiWeETViDoC+uzvT5rwcdEzoLMLLpS1mzugGblRPeMSio01xBOmnZDnLr0UfdTU/j89lFl@lists.infradead.org
X-Gm-Message-State: AFuF++lcKKlXW+LFGxjAMdclD+pgxYwPu0S1JjJMNGdA5/eII1g0ctpY
	8k8JcXP0bZmATK9EQRvM9YQUF8nKKxsaIZ3ILg8zxa4x9iVUFvgrDG7V3Sgslx02yww=
X-Gm-Gg: AYBFou2Tf2NM+IMW/JtadUKkWOdZQUb+H9XeHMmkeHK+p6GNLIuDQGBnjxkmv8rqZQy
	Qu9dk8JksKQOqJnafTc4qvy5Vz3KtsUZkBhqQ7Rvo3iDXILGlnBYt1c9OqEWlla/xnjVMTaYXDU
	7tU+kX2vfwIU2peYjYnttySH0kMO3MdgWn7R1iK1IQDM6AdN1F2p9KKNpIboV7CHKZWK6zNVNR5
	daRw3/wjSsrN9y5xODFm9AdlLSwMRlmd0SvsF0dS+bDsQfWXL3Nuk5h4foRFlLDNhe1LhajTcdV
	205v9IIVWo5XNxU8igSbT2RTHpLLcwpyG9LU/tz8vW6sp+GxZ9XdSbtZlTCp0eHtMBtlpYYkqDP
	xUHEB+ZlhOW6zBHC6RhY0EzFba6UBZTHOQ5rAkRGWRfmtgc28ps2IqDglJsgntOg82MkDdGltxn
	NstOAGhvlbkaDuUlHkTXpz6UAkR9e6fDcM6IBSJc6dDU6DOqeNTmUo+7J6dX6uswRr6889TGAlY
	Bgc6QGMwsxqFQTnYUvAeQ==
X-Received: by 2002:a17:90b:2784:b0:39e:6a7f:eeec with SMTP id 98e67ed59e1d1-39e6a7ff073mr2104953a91.17.1789755433632;
        Fri, 18 Sep 2026 11:17:13 -0700 (PDT)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id 5a478bee46e88-33c331aeeddsm335107eec.24.2026.09.18.11.17.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 11:17:13 -0700 (PDT)
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
Subject: [PATCH 13/18] nvme-fc: perform error recovery directly from ioerr_work
Date: Fri, 18 Sep 2026 11:14:13 -0700
Message-ID: <20260918181614.3947933-14-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260918181614.3947933-1-mkhalfella@purestorage.com>
References: <20260918181614.3947933-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260918_111714_812883_35991879 
X-CRM114-Status: GOOD (  23.66  )
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

Now that nvme_fc_start_ioerr_recovery() moves the controller to
RESETTING before queueing ioerr_work, the nvme_reset_ctrl() call in
nvme_fc_error_recovery() fails with -EBUSY and no recovery runs.

Do the recovery in the work itself instead: stop the controller, tear
down the association, move to CONNECTING and schedule a reconnect,
same as nvme_fc_reset_ctrl_work(). If the CONNECTING transition fails
the controller is being deleted and the delete path finishes the job.
This is how rdma and tcp structure their error recovery too.

The work now re-checks the controller state when it runs. A work
queued while CONNECTING can execute after the connect succeeded and
the controller went LIVE (a timed out connect command that completes
right after the timeout fires). Claim RESETTING in that case; if that
fails, a concurrent reset or delete owns the controller and will
complete the outstanding IOs.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 96 +++++++++++++++++++++++++++---------------
 1 file changed, 61 insertions(+), 35 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 6181cb7ea8ce..5a530aa37641 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -229,6 +229,8 @@ static struct device *fc_udev_device;
 static void nvme_fc_complete_rq(struct request *rq);
 static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
 					 char *errmsg);
+static void __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl,
+					    bool start_queues);
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -987,7 +989,7 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
-static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
+static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl);
 
 static void
 __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
@@ -1873,8 +1875,44 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 {
 	struct nvme_fc_ctrl *ctrl =
 			container_of(work, struct nvme_fc_ctrl, ioerr_work);
+	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
+
+	/*
+	 * if an error (io timeout, etc) while (re)connecting, the remote
+	 * port requested terminating of the association (disconnect_ls)
+	 * or an error (timeout or abort) occurred on an io while creating
+	 * the controller.  Abort any ios on the association and let the
+	 * create_association error path resolve things.
+	 */
+	if (state == NVME_CTRL_CONNECTING) {
+		__nvme_fc_abort_outstanding_ios(ctrl, true);
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: transport error during (re)connect\n",
+			 ctrl->cnum);
+		return;
+	}
+
+	/*
+	 * Tear the association down only if this work owns recovery via a
+	 * RESETTING claim, or if the delete path is waiting for IOs to
+	 * complete.
+	 */
+	if (state == NVME_CTRL_LIVE &&
+	    nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING))
+		state = NVME_CTRL_RESETTING;
 
-	nvme_fc_error_recovery(ctrl, "transport detected io error");
+	switch (state) {
+	case NVME_CTRL_RESETTING:
+	case NVME_CTRL_DELETING:
+	case NVME_CTRL_DELETING_NOIO:
+		nvme_fc_error_recovery(ctrl);
+		break;
+	default:
+		dev_warn(ctrl->ctrl.device,
+			 "NVME-FC{%d}: error recovery skipped, state %d owns recovery\n",
+			 ctrl->cnum, nvme_ctrl_state(&ctrl->ctrl));
+		break;
+	}
 }
 
 /*
@@ -2533,39 +2571,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 		nvme_unquiesce_admin_queue(&ctrl->ctrl);
 }
 
-static void
-nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
-{
-	enum nvme_ctrl_state state = nvme_ctrl_state(&ctrl->ctrl);
-
-	/*
-	 * if an error (io timeout, etc) while (re)connecting, the remote
-	 * port requested terminating of the association (disconnect_ls)
-	 * or an error (timeout or abort) occurred on an io while creating
-	 * the controller.  Abort any ios on the association and let the
-	 * create_association error path resolve things.
-	 */
-	if (state == NVME_CTRL_CONNECTING) {
-		__nvme_fc_abort_outstanding_ios(ctrl, true);
-		dev_warn(ctrl->ctrl.device,
-			"NVME-FC{%d}: transport error during (re)connect\n",
-			ctrl->cnum);
-		return;
-	}
-
-	/* Otherwise, only proceed if in LIVE state - e.g. on first error */
-	if (state != NVME_CTRL_LIVE)
-		return;
-
-	dev_warn(ctrl->ctrl.device,
-		"NVME-FC{%d}: transport association event: %s\n",
-		ctrl->cnum, errmsg);
-	dev_warn(ctrl->ctrl.device,
-		"NVME-FC{%d}: resetting controller\n", ctrl->cnum);
-
-	nvme_reset_ctrl(&ctrl->ctrl);
-}
-
 static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
@@ -3389,6 +3394,27 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	}
 }
 
+static void
+nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl)
+{
+	nvme_stop_keep_alive(&ctrl->ctrl);
+	flush_work(&ctrl->ctrl.async_event_work);
+
+	/* will block while waiting for io to terminate */
+	nvme_fc_delete_association(ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
+
+	/* Do not reconnect if controller is being deleted */
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
+		return;
+
+	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
+		queue_delayed_work(nvme_wq, &ctrl->connect_work, 0);
+		return;
+	}
+
+	nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
+}
 
 static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.name			= "fc",
-- 
2.55.0


