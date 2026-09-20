Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF8EBC982D8
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 18:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVhzIJ0voivWryYWZvH7CE/nJwrk1ooSyz4ZIVHdKLo=; b=4wVTz/PKB0QmPyb/5jVdXRkrlu
	63vCOlNfuRtbgmpW7sVaW+pgkPA2QWt4HQunNDmClQ0CuWpOHztyz7q/peek+gOzmpV2YZAh9Ra1O
	bDpGkzj8Ub1K3/3iKeotL009EDluD3bHt3Z7v6T119yCvTUMxhHBLnTM7oqodaARSYsS3OCCuYFNe
	F2zluRmalLZDpuqb64+EzLUy1CZ3FgL5qa0OVHWgUZxAPTVU+vXDxxbtN5r84ER9ZP41aTumkSdVF
	Vef42RLZnAT9xl7wefNNBf5VWs/vYuwYkRIkaG7W6pHWFX2AY9dMrX2UavCCOjQpdjj8cXHijTbg2
	lZm37VSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJI-00000000E9r-2JMB;
	Sun, 20 Sep 2026 18:30:44 +0000
Received: from mail-pj2-x10.google.com ([2607:f8b0:4864:39::10])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8MJA-00000000Dyb-3vj1
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 18:30:39 +0000
Received: by mail-pj2-x10.google.com with SMTP id d9443c01a7336-2d747f01363so19011875ad.2
        for <linux-nvme@lists.infradead.org>; Sun, 20 Sep 2026 11:30:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1789929036; x=1790533836; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cVhzIJ0voivWryYWZvH7CE/nJwrk1ooSyz4ZIVHdKLo=;
        b=HoUF2UX32bcaVkmTGX3ptkgaGy+NXWCiRh53Ik+Env1FPfHZccKhO2oYnY675Kl53L
         hBmLQKsesCBYyDSp4l+NTjQzp9G8ZWgPwcNEoM3BXlWbpVTty2ehsanzBiqSEj/amBCC
         lt5GpFn2YBXTYJ5paCNaoQSXzMxAhBn+as0TotEgwwH9/w2BN0NDp0PmwFBoZUWjHqJm
         pd6Kat8SXOevfago00awILZop/x0v5qzjq5nqrJ5dO1XDpl6qPV0QudhgZJTpPq1iuj/
         VuNGqsS19IgTQREDIG/bTkyQT6KwYZiJ9HmGTy77K2FVtrO+RHJqhbsmlb/XIlrOaIyv
         +7ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789929036; x=1790533836;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=cVhzIJ0voivWryYWZvH7CE/nJwrk1ooSyz4ZIVHdKLo=;
        b=Y0BPiKV7VyyJ4IzGX/X7b3DV1GXXCj0vIjvjmu8qQAcvzbY4/kzBqJBIn65AoEG4eC
         Xt+hTdu6dWVa3ySjLQzcVwtxqv3MAqj+/w0dZhG1U3l1aMWFKMAaUWvCPLidMQUIQdcq
         Q7W6sz3FiUH1J4h5tLve+F8D2Gbbz5UtCTj/pTqQFIEHRcc5EzrcFcincnAD3/fYSEkm
         kEqki2XiRuwe+PTqxlwIL+6sW6FfASRY47S6ud4n50uYhqTewtZ4mUWy24cvJ+9kQtH7
         Jzq7o5GP+6+MSFW6ZqTQrVsNkvL39VocC/5nenonJMdtYeWZ1iCk/x8eMinda1KhuKVd
         4tAw==
X-Forwarded-Encrypted: i=1; AKwUvBxpYWBz1zud7PRcgWgUTLXcukJBM1JlPDWTLl094o9llgMdyfBGfovRYuEwFKNQ6dMBDlcawfcqPDVk@lists.infradead.org
X-Gm-Message-State: AFuF++lBRsJIu4q55CAgj80uDKNbDWVYaZof0xUxoPHRZz7n66XICJFy
	rCQ23DUL6oAVIY0GkUan37hUA4OX6NU+peHHWX62ytZ4ZsjFttGjwoKm0F3Ol9G0sLs=
X-Gm-Gg: AYBFou3L6jXXKw2c7Lh5oJM7AOGvwpdwapYBO908HeLwtwBn0/jTZqO0V8O0r7Uy0xn
	gMRNfn5uuTaf8GWpOi3kkfsjIet+3Ivb3a4QayxeiIALBGjSSg8vRCJ3FqZSicIdB1rAJ3BJOCt
	yOzBmv53qUj4M3RufoDFsjgERUAUTF5gVMS6QEpZmHdWqO6czILFDqTBzh4Ttgey6y9DNyiDW9Z
	Fu2oOeiQWGQAxmbrkoiq4v6spYVSHLsjA8Em0i5GOCTN4k6zRpb50naTollAk9q9Zc9PkDBgRMF
	hPE+/HVA/nR0ILc5jUdrCVzaKF7y4RVJkZnTyymAGVBDs/miGHf+k9doOBKfEfJv8vphE37m6S6
	Mc4P0/WgZlg8ng0Z9/TyLhU8s6kd4W95FGlA3syYggMjq2Ffb5SVy4R7ZgaWA/g+eCV1B8h+wXK
	41yMYpMOFrio6Hux7bvazSDBqCV2N1dJTuWRu1fnrVJbce4fgWZt8mJUTh
X-Received: by 2002:a17:90b:4ac6:b0:396:65dd:4093 with SMTP id 98e67ed59e1d1-39e54c01efemr13709813a91.14.1789929036238;
        Sun, 20 Sep 2026 11:30:36 -0700 (PDT)
Received: from ceto ([2607:fb90:9c20:5ac0::1d8c])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-144da432647sm20924589c88.5.2026.09.20.11.30.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 11:30:35 -0700 (PDT)
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
Subject: [PATCH v6 13/18] nvme-fc: perform error recovery directly from ioerr_work
Date: Sun, 20 Sep 2026 11:28:11 -0700
Message-ID: <20260920182936.2317916-14-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260920182936.2317916-1-mkhalfella@purestorage.com>
References: <20260920182936.2317916-1-mkhalfella@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_113038_308979_25F4F907 
X-CRM114-Status: GOOD (  23.38  )
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


