Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB375606A334
	for <linux-nvme@archiver.kernel.org>; Sat, 14 Nov 2026 03:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=DkayTWrh;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=o6eFaUyn;
	dkim=pass (2048-bit key) header.d=purestorage.com header.i=@purestorage.com header.a=rsa-sha256 header.s=google2022 header.b=CxXb2xmp
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=qFMz0pc1AFuqa2RNN04ND5/ZelYIOBKWfMxb2sBhDbo=; b=DkayTWrhL2Fn6z
	T5MKl+Fga4r4zTWn4vMjPDX459cfullaftRS0Cu0bqn/PyKAHs3IKVasstRg08M/AoIbmgjTnf6+C
	+kApmoOYr9B6OCj+7R18E36eYiufPJ8VhlDh1A2s19pV9Ngy2iN1HpGHm4RgwZ6Qn0i+uhKmScrQ2
	xD/r+Hf/0dGy9p6IEnkyyJtfQjtcKLUM4IovimM89OVegZWIQ/odcFLt3/HxDlgarB7as1ulOq0g+
	HlBXxgKoRnMcNtdDpZUthkzNSrQWpjiO8kpbBmesVbTJVbGRERXsoO+cSpH4OmWrBgsQVvdRj8Jub
	AjYEHaiqPzYS2b6RAp3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS47e-0000000FCcX-2Gne;
	Sat, 14 Nov 2026 03:08:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS47b-0000000FCYP-2Sfp
	for linux-nvme@bombadil.infradead.org;
	Sat, 14 Nov 2026 03:08:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=qFMz0pc1AFuqa2RNN04ND5/ZelYIOBKWfMxb2sBhDbo=; b=o6eFaUyn4xQ4S14VKt/JIXkgVD
	u46RkZrXBzTayWNKjCZ/NxU6r+MH5yaSot8PkZ9NF3hjbdBpJ7cTfRupOQ0sfZYfnYYhUVTU8sZgu
	tm7Z2tsld0JR8Z4s0dgqvtdd9AW/hBpALPPnm4GWP/yBxNf6v+r5712c0RZQxoEB+7csy4FOQ1yuY
	BbFFnU88nXPuqPnoTdb2CDH49vU++mDkRXP5ULXy1BMrwF+YiJwRAH0CA3gl3nTz8O+y1rfbjuUCh
	ikGSzr9RUS41qc+v0F/wfAnKTWdwOFhfp3FIZz96CelJFhY0RbiliiE4tnypvvYefyXjBqGiSeFl3
	bqEBNayw==;
Received: from mail-dl1-x122e.google.com ([2607:f8b0:4864:20::122e])
	by desiato.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xS45d-0000000C5YJ-3bF4
	for linux-nvme@lists.infradead.org;
	Sat, 14 Nov 2026 03:08:06 +0000
Received: by mail-dl1-x122e.google.com with SMTP id a92af1059eb24-1a8cc11ac42so1554646c88.0
        for <linux-nvme@lists.infradead.org>; Fri, 13 Nov 2026 19:06:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1794625563; x=1795230363; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=qFMz0pc1AFuqa2RNN04ND5/ZelYIOBKWfMxb2sBhDbo=;
        b=CxXb2xmpVoDrWZFELcwsGM5f6w3MzDMsFVYeKy6iChAAVfMCn9N9TrDBDBPG8XU4S1
         Rp0uV+ASiwuovgja9IGJdvwJwkth28+eTlB1OPnU3xu9dGWkV8k6wcVZPKLp84R7mfCz
         M19rTVTMRTSFmIJkHm15eW2/3aBvrIQLL9x88R9nMWJhdVUP0jHxVcBHhhWoS2oUzHzk
         IOWjb5i/kBfM5zHmE56mDC82GuxbcKPm78lnYBy+Hz8ph6NRsLatDtrIHU0iNzykCSv+
         K/03TRVK3jv2piRmukwLXkTxq+qfYKCD8EiYbLw3Mq1FH/ty3MvFhkTKejIyZ02CTD3C
         y9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794625563; x=1795230363;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=qFMz0pc1AFuqa2RNN04ND5/ZelYIOBKWfMxb2sBhDbo=;
        b=nYHF6SNN0FsZBciWVWoQqxU9//5/niQypaHnIcHQWh2bmxP1BRNTt50ndXI3TKU0/L
         tS3e+eXi94bpoL7oO0l2rE4SR2D9SZEkfQlDlCApypa+eos5Ve1EVB0x7FTMgdtWRbcD
         wIy6gLPql7FLdAKsT3yYhsJS/GwCbzydWDtDi193m1yX0+2fGXzxr7OAoWiyta+NQenh
         U64HbeQVYGSidQv32/LGsljHUCZ0FttI6SiTHDnhRKamYf9Lvsql4EP3QisoMg1Uz1Zw
         kBh3JcsaoyFKHGILOTDxAvR/p//NO5MG8/E03mUzemNYzytDHD23CGfCKF8vOq8NxEZU
         GdQA==
X-Forwarded-Encrypted: i=1; AL+hErHInN7+oJFq0wVnwoVdpAwslVxYjS7zQnGZeGWFwWDkjWK2Dx6P1pN8evi7OfKsmAy1t0u9GSs1HaWl@lists.infradead.org
X-Gm-Message-State: APuU4Z/KMQEbgkWsX0XXMHLG58WNwtTAPpC6IKYyyHxkTQcXQPm+6vR2
	LUa6/rlACvDKWW9FhiFx+gg17QFRXxYj17dxDLjhjEsTPslSsirNo855voog4IXtZbY=
X-Gm-Gg: AYBFou1Ni2TXpRjxxArvKhYJrz0x0K4f0S12Rk+hC9eRt1+htauhPF+x2x+VsYJCo9L
	lQpDzFEgcGsywBWPIpkcdx/4qPwx3JjPSGddjHebD4mdwxIhok+l/lzC9aAmxRm7ELvRY44+2DX
	aoCv7ZCYaXUdQQkblzbT/tVw5/zggAHjy/AgGwGkj6THfhaY6LGwtfURKYYcHnXQ+gaX8n5ujDf
	JGBRTVsxigzOuRPLsiHze+C1bvQqHJL8SlEXfkJ9TelCgvq3S4V1PT0bxiNEWRvZICJK3jPXRjW
	9dSkEAZIrYh20WfHLmlx6ZPtp4f/vD76lFEdxOttnDQUUcj8HdeUPAKIZIcvgqYE8UYchQ3Vs/H
	xJ+U8yqI9t0oNvhox67a1BU6lgRhTZm7CLvMohduc1glKOC9wCX+0BxBDfOKI/a8I/axn1eTTtE
	THsFHpVHQVvJkIoJrdZ7Ahg3z+ldC8WpG7mjmWCRPh2kIMyyMii/V1evyvCIiM65YGv0t6FRuHA
	6nZV1X9yhjfwKiJOVfCbTgpRs0NXYgb5P4wEy6FKK1olFC/QqP73Y79D13EeG5E1bVOOwniTeU+
	GwDjdWOhkpy5X3PQ9fT7TVE3gRQc1PoPZZ43N3bK+xV5vUrSW7zKNwP9/nMlbyoEUV1SCReKqA=
	=
X-Received: by 2002:a05:7022:3a85:b0:185:fd0c:4585 with SMTP id a92af1059eb24-1b50312b3b0mr4171060c88.33.1794625562200;
        Fri, 13 Nov 2026 19:06:02 -0800 (PST)
Received: from apollo.purestorage.com ([208.88.152.253])
        by smtp.googlemail.com with ESMTPSA id a92af1059eb24-1b50316e008sm10829382c88.6.2026.11.13.19.06.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 13 Nov 2026 19:06:01 -0800 (PST)
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
Subject: [PATCH v7 12/17] nvme-fc: start error recovery instead of aborting timed out IOs
Date: Fri, 13 Nov 2026 19:04:26 -0800
Message-ID: <20261114030454.2836543-13-mkhalfella@purestorage.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261114030454.2836543-1-mkhalfella@purestorage.com>
References: <20261114030454.2836543-1-mkhalfella@purestorage.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261114_030606_054590_CA8E51B6 
X-CRM114-Status: GOOD (  28.45  )
X-Spam-Note: SpamAssassin invocation failed
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

Aborts issued from the timeout handler run outside the FCCTRL_TERMIO
window, so they are not counted in ctrl->iocnt and
nvme_fc_delete_association() does not wait for them. The association
can be torn down while the LLDD is still working on the abort.

Instead of aborting the timed out command, reset the controller like
the other fabrics transports do. The association teardown aborts the
outstanding IOs, counts the aborts and waits for them to complete.

Count every abort in ctrl->iocnt, not only the ones issued while
FCCTRL_TERMIO is set, and do not reset the count when the teardown
starts. An abort issued before the teardown is then waited for as well.

Only a LIVE controller starts error recovery. In every other state the
association is being set up, being torn down or already gone, so abort
the timed out command from the timeout handler instead and return
BLK_EH_DONE. The command completes through nvme_fc_fcpio_done() once
the LLDD has finished the abort, and the abort is counted so a teardown
that follows waits for it. This matters for a controller being deleted.
The delete path drains the IOs itself and tears the association down in
nvme_fc_delete_ctrl() once the drain is done, and DELETING cannot move
to RESETTING, so without the abort a timed out IO would hang the drain
against a dead target.

The new nvme_fc_start_ioerr_recovery() is the common entry point for IO
timeouts, transport errors reported by nvme_fc_fcpio_done(), Disconnect
LS and connectivity loss. It moves the controller to RESETTING and
queues ioerr_work only if that succeeds, so nothing is ever queued on a
controller that is CONNECTING or being deleted. A Disconnect LS or a
transport error received while CONNECTING is resolved when the inflight
request fails, or times out and is aborted.

ioerr_work still calls nvme_fc_error_recovery(), which returns without
doing anything for a controller that is not LIVE. With the controller
already in RESETTING when the work runs, no recovery takes place yet
and the controller stays in RESETTING. The next patch moves the
recovery into ioerr_work itself and completes the change.

Link: https://lore.kernel.org/all/20250529214928.2112990-1-mkhalfella@purestorage.com/
Signed-off-by: Mohamed Khalfella <mkhalfella@purestorage.com>
---
 drivers/nvme/host/fc.c | 66 ++++++++++++++++++++++++++++++------------
 1 file changed, 47 insertions(+), 19 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 0b9ff50d26ff..c4603be38144 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -227,6 +227,8 @@ static DEFINE_IDA(nvme_fc_ctrl_cnt);
 static struct device *fc_udev_device;
 
 static void nvme_fc_complete_rq(struct request *rq);
+static void nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl,
+					 char *errmsg);
 
 /* *********************** FC-NVME Port Management ************************ */
 
@@ -788,7 +790,7 @@ nvme_fc_ctrl_connectivity_loss(struct nvme_fc_ctrl *ctrl)
 		"Reconnect", ctrl->cnum);
 
 	set_bit(ASSOC_FAILED, &ctrl->flags);
-	nvme_reset_ctrl(&ctrl->ctrl);
+	nvme_fc_start_ioerr_recovery(ctrl, "Connectivity Loss");
 }
 
 /**
@@ -1569,7 +1571,8 @@ nvme_fc_ls_disconnect_assoc(struct nvmefc_ls_rcv_op *lsop)
 	 */
 
 	/* fail the association */
-	nvme_fc_error_recovery(ctrl, "Disconnect Association LS received");
+	nvme_fc_start_ioerr_recovery(ctrl,
+				     "Disconnect Association LS received");
 
 	/* release the reference taken by nvme_fc_match_disconn_ls() */
 	nvme_fc_ctrl_put(ctrl);
@@ -1813,11 +1816,18 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 	unsigned long flags;
 	int opstate;
 
+	/*
+	 * Every abort is counted, not only those issued by the association
+	 * teardown: the teardown waits for iocnt to drop to zero before it
+	 * deletes the hw queues, and an abort issued earlier, by
+	 * nvme_fc_timeout() while deleting or by the CONNECTING recovery
+	 * path, must not still be in progress in the LLDD then.
+	 */
 	spin_lock_irqsave(&ctrl->lock, flags);
 	opstate = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
-	if (opstate != FCPOP_STATE_ACTIVE)
+	if (opstate != FCPOP_STATE_ACTIVE) {
 		atomic_set(&op->state, opstate);
-	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
+	} else {
 		op->flags |= FCOP_FLAGS_TERMIO;
 		ctrl->iocnt++;
 	}
@@ -1856,8 +1866,7 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 
 	if (opstate == FCPOP_STATE_ABORTED) {
 		spin_lock_irqsave(&ctrl->lock, flags);
-		if (test_bit(FCCTRL_TERMIO, &ctrl->flags) &&
-		    op->flags & FCOP_FLAGS_TERMIO) {
+		if (op->flags & FCOP_FLAGS_TERMIO) {
 			if (!--ctrl->iocnt)
 				wake_up(&ctrl->ioabort_wait);
 		}
@@ -1892,6 +1901,19 @@ char *nvme_fc_io_getuuid(struct nvmefc_fcp_req *req)
 }
 EXPORT_SYMBOL_GPL(nvme_fc_io_getuuid);
 
+/*
+ * Start recovery only if this caller can claim it with a state change.
+ */
+static void
+nvme_fc_start_ioerr_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
+{
+	if (nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_RESETTING)) {
+		dev_warn(ctrl->ctrl.device, "NVME-FC{%d}: starting error recovery %s\n",
+			 ctrl->cnum, errmsg);
+		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	}
+}
+
 static void
 nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 {
@@ -2049,9 +2071,8 @@ nvme_fc_fcpio_done(struct nvmefc_fcp_req *req)
 		nvme_fc_complete_rq(rq);
 
 check_error:
-	if (terminate_assoc &&
-	    nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_RESETTING)
-		queue_work(nvme_reset_wq, &ctrl->ioerr_work);
+	if (terminate_assoc)
+		nvme_fc_start_ioerr_recovery(ctrl, "io error");
 }
 
 static int
@@ -2548,24 +2569,32 @@ static enum blk_eh_timer_return nvme_fc_timeout(struct request *rq)
 	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
 	struct nvme_command *sqe = &cmdiu->sqe;
 
-	/*
-	 * Attempt to abort the offending command. Command completion
-	 * will detect the aborted io and will fail the connection.
-	 */
 	dev_info(ctrl->ctrl.device,
 		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d (%s) w10/11: "
 		"x%08x/x%08x\n",
 		ctrl->cnum, qnum, sqe->common.opcode, sqe->fabrics.fctype,
 		nvme_fabrics_opcode_str(qnum, sqe),
 		sqe->common.cdw10, sqe->common.cdw11);
-	if (__nvme_fc_abort_op(ctrl, op))
-		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
+
+	if (nvme_ctrl_state(&ctrl->ctrl) != NVME_CTRL_LIVE) {
+		/*
+		 * The association is being set up, being torn down or is
+		 * already gone, so recovery cannot be started from here.
+		 * Abort the command so the connect or teardown it would
+		 * block can make progress. It completes through
+		 * nvme_fc_fcpio_done() once the LLDD has finished the
+		 * abort, and the abort is counted so a teardown that
+		 * follows waits for it.
+		 */
+		__nvme_fc_abort_op(ctrl, op);
+		return BLK_EH_DONE;
+	}
 
 	/*
-	 * the io abort has been initiated. Have the reset timer
-	 * restarted and the abort completion will complete the io
-	 * shortly. Avoids a synchronous wait while the abort finishes.
+	 * A LIVE controller starts error recovery, which tears the
+	 * association down and completes this request.
 	 */
+	nvme_fc_start_ioerr_recovery(ctrl, "io timeout");
 	return BLK_EH_RESET_TIMER;
 }
 
@@ -3217,7 +3246,6 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	spin_lock_irqsave(&ctrl->lock, flags);
 	set_bit(FCCTRL_TERMIO, &ctrl->flags);
-	ctrl->iocnt = 0;
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	__nvme_fc_abort_outstanding_ios(ctrl, false);
-- 
2.56.0


