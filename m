Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1AEA606B6D9
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:06:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=ABM/Zvc8;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=b+rcMXF/
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=6Kt4gHC2HJ09c/nL6A82Y14Zxmi4ppAhLgPppqiWQz0=; b=ABM/Zvc8M0s0JC
	4Dy553pMxIRenABYE5YDJucV1q1ZHrMqjQQaRuAod4WPa5xg2GjOyZi78t1xPie6vwcMb7bLyiJOX
	+V4zTcocbK2FQqo0Bm6r7qGx3QnGRuF8zhWrzkYTWkyC82IXiQzjI1YrHDM8IBc6Jg3ge13+7Etst
	3fRc975lq3IUgA6PnS52LvU3bP5MnqhjvHY1cmrP8Bx1QHpMxfUlIbYksiaBTpeAQ+5obj1Xa5en3
	dp0Q5kkjaMNHymGJ/3u1R8HGJchAOc8tGghO8WMTj9TwpT55CEFZokhcEH73N+r4JLhWCQrV9WrMe
	sZikOz203kAd3L/BgFvQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45u-0000000FAXJ-0Y35;
	Sat, 14 Nov 2026 03:06:22 +0000
Received: from mail-dl1-x1230.google.com ([2607:f8b0:4864:20::1230])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45c-0000000FA2f-3OCp
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:06:15 +0000
Received: by mail-dl1-x1230.google.com with SMTP id a92af1059eb24-1b3ada81853so1560186c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625564; x=1795230364; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6Kt4gHC2HJ09c/nL6A82Y14Zxmi4ppAhLgPppqiWQz0=;
        b=b+rcMXF/E+kCZoWKdUXkrRRNiCCilW7VYVhpBip9l0HwVQLBlIzAQSw7fF1+SE7oSD
         nHg1cPOA91UilalH5E66xTKojfJrrFSK5kYZpznj+/2F53hV1jhn75lGnx18NgMDWnbA
         +fyyEoXaSLPhevQDPitKM0b8J8feADtvp0o7pp50h1dhPgI/XVqdPBGW7fxYEA9tol+A
         fPfA41ecVJJUj24Yl357xBN/b2CVtZQ8ZIdj4YS8LXo8vPh1DntUra/BZBrvw7cpiGtk
         50kFsUszZSGvbKrdK7U7ToPceNxNFUpLWozLHlwwGiUyWg/nPJLcNzUAYWelobluNTi0
         H+nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625564; x=1795230364;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=6Kt4gHC2HJ09c/nL6A82Y14Zxmi4ppAhLgPppqiWQz0=;
        b=ahLchZRati+gIi68lvVrK8aZ4+rV4UmxpoXbSHKS6YX5F4MfWOwxa7ghTuRQpvJuKD
         b5uy/Ee+JDbus4KeniAa1SMGP2TZ76bp1ksMKQLx8nm8G8WmQknZ4jOqBCjaRxHS07UF
         u2aOJG5UEzO1dDd3srlI/6JE4cFGmDAEPqXsN4dIKx/IMiihLhKglNFQLJCau5Zxsn3D
         ee4vVZGDUuDN0RGYXbE4tKfnHJmlIeAGvD0rpRW5hvDI66+ZNlJEFnkHVOg0D6wXfSnY
         vPRmlCpGS06Tol7f5lcOUjLfFnkmgkSb7IFt0AipTxy21Cx50p5Li3ICWA51N/dqtffI
         s5nw==
X-Forwarded-Encrypted: i=1; AL+hErFT8MGcjZqc6x9qT7UgYkZFT64VMgUhZwUASIZIJ53J67QREwF0et/t2gN2beTj4jS86ID7KHQeh+26@lists.infradead.org
X-Gm-Message-State: APuU4Z/Gy6Yj6bVBBS4VMvHXWo7ndAetUDlCcouvBRGsgzMkVzE5Fbjq
	9gkEO5Xb9mSBtScHADrdDY4QSTAaz68SpPPeccLkapGsZ/FvgkudP7AIU5/JDBe0grY=
X-Gm-Gg: AYBFou1FXITmdUa6qZF9s86wENiMPr9ZPivmwBw2in3dB+Ft/yh5PkKUeVk4D0nBiQv
	vV72UF1jPyb+/BU1ZFVYCIoqZkofvk4V4ks4x1VMFxQpouEEJdmUsuDvKGZWa/p2dzDbli02UaC
	gIeTf9zrYf3V6BpkSobJ6vuwLfLuPPdRgOnV6CooMey64h9XreCXylOCRnoc1Ylv6zHKUQyBv0V
	4Iix2vbvLY64LkUPEnzUzFqlChSqQf7uq9WuXQQGag3twZc4AJ3HcHkEZRxVSTTzJXut10ih4WL
	W6EuauElsKe0Xnyr8ZnvgCadfa/zSnnaSIHOc9ZaJ2GkuFjJyAzQ1tLEy6FcaLIA1z73Xz48M7I
	IFcOSoetZb3xhKVnCB7L1ZQ8lhwYlOEISskILvmQMdUNWa2sJoEf2bjq4ayrngJJLTvNLOnLtc/
	GgKSpIfMz7rvGXR7RuBs3HXVkD927ar+D05VXy5+sWh3hdWmuRnCZx7pkhZ9RfEV3bZA8HKEjPg
	GWsDedJ+5abUnVLA+Wj+lzhf7Q6vjaV6d0XuiC6uckY27YwVW4aKtNVo/N0REj2dZg+iN9SyWcm
	jmWTIJeVCR9DlM/FH6sjAYgzfyLWlVFffvlPQwzJSKgmCx+SZvcS
X-Received: by 2002:a05:7022:f20f:b0:1b3:b53e:b4cd with SMTP id a92af1059eb24-1b5031003e7mr4831204c88.21.1794625563708;
        Fri, 13 Nov 2026 19:06:03 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.06.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:06:03 -0800 (PST)
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
	Daniel Wagner <dwagner@suse.de>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v7 13/17] nvme-fc: perform error recovery directly from ioerr_work
Date: Fri, 13 Nov 2026 19:04:27 -0800
Message-ID: <20261114030454.2836543-14-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261113_190607_626111_9F4E32C4 
X-CRM114-Status: GOOD (  20.24  )
X-Spam-Score: -2.1 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Now that nvme_fc_start_ioerr_recovery() moves the controller to
RESETTING before queueing ioerr_work, the nvme_reset_ctrl() call in
nvme_fc_error_recovery() fails with -EBUSY and no recovery runs.

Do the recovery in the work itself instead: stop the keep-alive and
the AEN submission, tear down the association so that any command a
core work item is waiting on is aborted at once, stop the controller,
move to CONNECTING and schedule a reconnect. If the CONNECTING
transition fails the controller is being deleted and the delete path
finishes the job. This is how rdma and tcp structure their error
recovery too.

The work is only ever queued right after a successful transition to
RESETTING, so when it runs it owns the controller: a reset or a
firmware activation holding RESETTING cannot be in progress at the
same time, and the work does not need to re-check the state.

Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 57 ++++++++++++++++--------------------------
 1 file changed, 21 insertions(+), 36 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index c4603be38144..0ba621649afe 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -229,6 +229,8 @@ static struct device *fc_udev_device;
 static void nvme_fc_complete_rq(struct request *rq);
 static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
 					 char *errmsg);
+static void __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl,
+					    bool start_queues);
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -987,7 +989,8 @@ fc_dma_unmap_sg(struct device *dev, struct scatterlist *sg, int nents,
 static void nvme_fc_ctrl_put(struct nvme_fc_ctrl *);
 static int nvme_fc_ctrl_get(struct nvme_fc_ctrl *);
 
-static void nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg);
+static void nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl);
+static void nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status);
 
 static void
 __nvme_fc_finish_ls_req(struct nvmefc_ls_req_op *lsop)
@@ -1880,7 +1883,23 @@ nvme_fc_ctrl_ioerr_work(struct work_struct *work)
 	struct nvme_fc_ctrl *ctrl =
 			container_of(work, struct nvme_fc_ctrl, ioerr_work);
 
-	nvme_fc_error_recovery(ctrl, "transport detected io error");
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
 }
 
 /*
@@ -2528,39 +2547,6 @@ __nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
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
@@ -3399,7 +3385,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 	}
 }
 
-
 static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.name			= "fc",
 	.module			= THIS_MODULE,
-- 
2.56.0


