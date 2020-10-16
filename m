Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD772C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 21:06:40 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 038AD21655
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 21:06:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="aPGch8/X";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="MaitKvLp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 038AD21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
	References:List-Owner; bh=Z1oEfAKW4DSC+fDVBgssYTCf6pXwTQQGFJrWEiv2li8=; b=aPG
	ch8/X/biGjsO1Ht/Zi6y/oY+ovHoujx44hmThIHil9Qj46iX7dRDuczUtHGH6AENCcxDjksOwHjPf
	aFD3ELN59eQM5x5mBRdrYVliFY48QVeZ7wh+0k0TOrMqAxmiBuhDcK26sWcWrwjFIBDElwYYH6TKH
	tCl5hCLn0Banp0HBE0Xv1+0moeI8wbhbODHnFaNLk+YqNta/zEJKV9V6HID7khQkI3TU/L3tvASPU
	fXmdsba7bxCTwQnmzLcLZrRNrf5aB+0MSeU13dS2Tkc4Pat1t4UhQjgqoq904YZO1NUNDNi/NgH2L
	rrYIk+WozShjstLHLyTlf6gJxO0Mzug==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTWvt-0005ld-To; Fri, 16 Oct 2020 21:06:37 +0000
Received: from mail-pj1-x1042.google.com ([2607:f8b0:4864:20::1042])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTWvr-0005kr-9H
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 21:06:36 +0000
Received: by mail-pj1-x1042.google.com with SMTP id gm14so2026043pjb.2
 for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2020 14:06:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:mime-version;
 bh=tFvKswsUbTn6WWpmNfeJ5+CEyF42nMfKpTB7uX/9bL0=;
 b=MaitKvLp0I6HbJyN+ZEvanU93wYW5YLi6HgaHK6jTrMJ1YM6VqAIVUfXtM7BZ2Lbvr
 0ebgzz8206UX1MrajEWkYyluf88JE34R1EKBLE2ZNivRY7gvaFQ9HrBaU3Q3lyPirCI4
 osPk4iSvRljmYo1vEf2TVCq7l4ATVJ12tvd6U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version;
 bh=tFvKswsUbTn6WWpmNfeJ5+CEyF42nMfKpTB7uX/9bL0=;
 b=CgMCxEw5oZk/PTNPrEZvyrxiKOuFguSNQ8PIjJay8g3ABH2CBVIID4iHCGSxgJBiVh
 s8W7Ur+n4VctdMKGhe2d735+2wz1zbUe9U5YOSgXpz9WjkMRKjsfmjqQ8I85JyuXlfwV
 3Jb33YjgXWDF5IE5Gi5q2hBkHvG6TtsXwgZj2P+46HobWa3LLqJmxdTT0y9LfkLdrUi7
 sWxNOyAQAL+kwxMrTPJIAevGL76RvQi6YmLGoQnwXq12ONIfi6rTOfeXRbPjLHUGRpU5
 LwnydQNWXr5YDgDOgKwV45XKWh+AFaq+XRi39aQ4rY5NQgmROppkpJRyCoSvk83N+W8B
 aLbQ==
X-Gm-Message-State: AOAM530c0xOascsik+raE35uylTF1oFs80pChzP4ZC1/qFPjaneK1y1i
 rDp+BY8ajUyRJyfWtMo7aDb4SJut1jhqtjFJdwyabwppY5aaChcTxYfQCF7O2wYYtB1LyrFNc1D
 HUPxJ6ficS4IE9Mv0RXL9U/BnJAhGPpInwWFivI3zDJz+0fQz0tG0LBoGYCsVP6WTqbjaIgXFlO
 P0wqxA/O5r
X-Google-Smtp-Source: ABdhPJywEbVSgUuyHOj+7ZGT3ebq7nkMmsm6DjlD8OEl2Tpdh1xjHl0z/y3JLrKt/V8SSeKiYM9YRQ==
X-Received: by 2002:a17:90b:19c9:: with SMTP id
 nm9mr5836637pjb.6.1602882392445; 
 Fri, 16 Oct 2020 14:06:32 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id d8sm3763099pjr.46.2020.10.16.14.06.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 14:06:31 -0700 (PDT)
From: James Smart <james.smart@broadcom.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-fc: fix io timeout to abort io
Date: Fri, 16 Oct 2020 14:06:27 -0700
Message-Id: <20201016210627.48595-1-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_170635_341535_DC0BDEFD 
X-CRM114-Status: GOOD (  26.29  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: James Smart <james.smart@broadcom.com>
Content-Type: multipart/mixed; boundary="===============1158245417883861863=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============1158245417883861863==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a946b905b1d02399"

--000000000000a946b905b1d02399
Content-Transfer-Encoding: 8bit

Currently, an io timeout unconditionally invokes nvme_fc_error_recovery()
which checks for LIVE or CONNECTING state. If live, the routine resets
the controller which initiates a reconnect - which is valid. If CONNECTING,
err_work is scheduled. Err_work then calls the terminate_io routine, which
also checks for CONNECTING and noops any further action on outstanding io.
The result is nothing happened to the timed out io. As such, if the
command was dropped on the wire, it will never timeout/complete, and the
connect process will hang.

Change the behavior of the io timeout routine to unconditionally abort the
io. Io completion handling will note that an io failed due to an abort and
will terminate the connection/association as needed. If the abort was
unable to happen, continue with a call to nvme_fc_error_recovery(). To
ensure something different happens in nvme_fc_error_recovery() rework it
so at it will abort all ios on the association to force a failure.

As io aborts now may occur outside of delete_association, counting for
completion must be wary and only count those aborted during
delete_association when TERMIO is set on the controller.

Signed-off-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/host/fc.c | 108 ++++++++++++++++++++++++++---------------
 1 file changed, 69 insertions(+), 39 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index f002522146e2..c81ebe94d8fe 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -1837,8 +1837,10 @@ __nvme_fc_abort_op(struct nvme_fc_ctrl *ctrl, struct nvme_fc_fcp_op *op)
 	opstate = atomic_xchg(&op->state, FCPOP_STATE_ABORTED);
 	if (opstate != FCPOP_STATE_ACTIVE)
 		atomic_set(&op->state, opstate);
-	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags))
+	else if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
+		op->flags |= FCOP_FLAGS_TERMIO;
 		ctrl->iocnt++;
+	}
 	spin_unlock_irqrestore(&ctrl->lock, flags);
 
 	if (opstate != FCPOP_STATE_ACTIVE)
@@ -1874,7 +1876,8 @@ __nvme_fc_fcpop_chk_teardowns(struct nvme_fc_ctrl *ctrl,
 
 	if (opstate == FCPOP_STATE_ABORTED) {
 		spin_lock_irqsave(&ctrl->lock, flags);
-		if (test_bit(FCCTRL_TERMIO, &ctrl->flags)) {
+		if (test_bit(FCCTRL_TERMIO, &ctrl->flags) &&
+		    op->flags & FCOP_FLAGS_TERMIO) {
 			if (!--ctrl->iocnt)
 				wake_up(&ctrl->ioabort_wait);
 		}
@@ -2446,15 +2449,20 @@ nvme_fc_timeout(struct request *rq, bool reserved)
 {
 	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(rq);
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
+	struct nvme_fc_cmd_iu *cmdiu = &op->cmd_iu;
+	struct nvme_command *sqe = &cmdiu->sqe;
 
 	/*
-	 * we can't individually ABTS an io without affecting the queue,
-	 * thus killing the queue, and thus the association.
-	 * So resolve by performing a controller reset, which will stop
-	 * the host/io stack, terminate the association on the link,
-	 * and recreate an association on the link.
+	 * Attempt to abort the offending command. Command completion
+	 * will detect the aborted io and will fail the connection.
 	 */
-	nvme_fc_error_recovery(ctrl, "io timeout error");
+	dev_info(ctrl->ctrl.device,
+		"NVME-FC{%d.%d}: io timeout: opcode %d fctype %d w10/11: "
+		"x%08x/x%08x\n",
+		ctrl->cnum, op->queue->qnum, sqe->common.opcode,
+		sqe->connect.fctype, sqe->common.cdw10, sqe->common.cdw11);
+	if (__nvme_fc_abort_op(ctrl, op))
+		nvme_fc_error_recovery(ctrl, "io timeout abort failed");
 
 	/*
 	 * the io abort has been initiated. Have the reset timer
@@ -2726,6 +2734,7 @@ nvme_fc_complete_rq(struct request *rq)
 	struct nvme_fc_ctrl *ctrl = op->ctrl;
 
 	atomic_set(&op->state, FCPOP_STATE_IDLE);
+	op->flags &= ~FCOP_FLAGS_TERMIO;
 
 	nvme_fc_unmap_data(ctrl, rq, op);
 	nvme_complete_rq(rq);
@@ -3090,26 +3099,19 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	return ret;
 }
 
+
 /*
- * This routine stops operation of the controller on the host side.
- * On the host os stack side: Admin and IO queues are stopped,
- *   outstanding ios on them terminated via FC ABTS.
- * On the link side: the association is terminated.
+ * This routine runs through all outstanding commands on the association
+ * and aborts them.  This routine is typically be called by the
+ * delete_association routine. It is also called due to an error during
+ * reconnect. In that scenario, it is most likely a command that initializes
+ * the controller, including fabric Connect commands on io queues, that
+ * may have timed out or failed thus the io must be killed for the connect
+ * thread to see the error.
  */
 static void
-nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
+__nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
 {
-	struct nvmefc_ls_rcv_op *disls = NULL;
-	unsigned long flags;
-
-	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
-		return;
-
-	spin_lock_irqsave(&ctrl->lock, flags);
-	set_bit(FCCTRL_TERMIO, &ctrl->flags);
-	ctrl->iocnt = 0;
-	spin_unlock_irqrestore(&ctrl->lock, flags);
-
 	/*
 	 * If io queues are present, stop them and terminate all outstanding
 	 * ios on them. As FC allocates FC exchange for each io, the
@@ -3127,6 +3129,8 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 		blk_mq_tagset_busy_iter(&ctrl->tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
+		if (start_queues)
+			nvme_start_queues(&ctrl->ctrl);
 	}
 
 	/*
@@ -3143,13 +3147,34 @@ nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
 
 	/*
 	 * clean up the admin queue. Same thing as above.
-	 * use blk_mq_tagset_busy_itr() and the transport routine to
-	 * terminate the exchanges.
 	 */
 	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
 	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
 				nvme_fc_terminate_exchange, &ctrl->ctrl);
 	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
+}
+
+/*
+ * This routine stops operation of the controller on the host side.
+ * On the host os stack side: Admin and IO queues are stopped,
+ *   outstanding ios on them terminated via FC ABTS.
+ * On the link side: the association is terminated.
+ */
+static void
+nvme_fc_delete_association(struct nvme_fc_ctrl *ctrl)
+{
+	struct nvmefc_ls_rcv_op *disls = NULL;
+	unsigned long flags;
+
+	if (!test_and_clear_bit(ASSOC_ACTIVE, &ctrl->flags))
+		return;
+
+	spin_lock_irqsave(&ctrl->lock, flags);
+	set_bit(FCCTRL_TERMIO, &ctrl->flags);
+	ctrl->iocnt = 0;
+	spin_unlock_irqrestore(&ctrl->lock, flags);
+
+	__nvme_fc_abort_outstanding_ios(ctrl, false);
 
 	/* kill the aens as they are a separate path */
 	nvme_fc_abort_aen_ops(ctrl);
@@ -3263,22 +3288,27 @@ static void
 __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
 {
 	/*
-	 * if state is connecting - the error occurred as part of a
-	 * reconnect attempt. The create_association error paths will
-	 * clean up any outstanding io.
-	 *
-	 * if it's a different state - ensure all pending io is
-	 * terminated. Given this can delay while waiting for the
-	 * aborted io to return, we recheck adapter state below
-	 * before changing state.
+	 * if state is CONNECTING - the error occurred as part of a
+	 * reconnect attempt. Abort any ios on the association and
+	 * let the create_association error paths resolve things.
 	 */
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING) {
-		nvme_stop_keep_alive(&ctrl->ctrl);
-
-		/* will block will waiting for io to terminate */
-		nvme_fc_delete_association(ctrl);
+	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
+		__nvme_fc_abort_outstanding_ios(ctrl, true);
+		return;
 	}
 
+	/*
+	 * For any other state, kill the association. As this routine
+	 * is a common io abort routine for resetting and such, after
+	 * the association is terminated, ensure that the state is set
+	 * to CONNECTING.
+	 */
+
+	nvme_stop_keep_alive(&ctrl->ctrl);
+
+	/* will block will waiting for io to terminate */
+	nvme_fc_delete_association(ctrl);
+
 	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING &&
 	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
-- 
2.26.2


--000000000000a946b905b1d02399
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
AanDaJF6fE9TEzbfn5AWgVgHkbqS3VY3Gq05xkLhRugDQ60IGwT29K1B+wGfcujKSaalhQIDAQAB
o4IBzzCCAcswDgYDVR0PAQH/BAQDAgWgMIGeBggrBgEFBQcBAQSBkTCBjjBNBggrBgEFBQcwAoZB
aHR0cDovL3NlY3VyZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NwZXJzb25hbHNpZ24yc2hhMmcz
b2NzcC5jcnQwPQYIKwYBBQUHMAGGMWh0dHA6Ly9vY3NwMi5nbG9iYWxzaWduLmNvbS9nc3BlcnNv
bmFsc2lnbjJzaGEyZzMwTQYDVR0gBEYwRDBCBgorBgEEAaAyASgKMDQwMgYIKwYBBQUHAgEWJmh0
dHBzOi8vd3d3Lmdsb2JhbHNpZ24uY29tL3JlcG9zaXRvcnkvMAkGA1UdEwQCMAAwRAYDVR0fBD0w
OzA5oDegNYYzaHR0cDovL2NybC5nbG9iYWxzaWduLmNvbS9nc3BlcnNvbmFsc2lnbjJzaGEyZzMu
Y3JsMCMGA1UdEQQcMBqBGGphbWVzLnNtYXJ0QGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEF
BQcDBDAfBgNVHSMEGDAWgBRpcoJiMWeVRIV3kYDEBDZJnXsLYTAdBgNVHQ4EFgQUUXCHNA1n5KXj
CXL1nHkJ8oKX5wYwDQYJKoZIhvcNAQELBQADggEBAGQDKmIdULu06w+bE15XZJOwlarihiP2PHos
/4bNU3NRgy/tCQbTpJJr3L7LU9ldcPam9qQsErGZKmb5ypUjVdmS5n5M7KN42mnfLs/p7+lOOY5q
ZwPZfsjYiUuaCWDGMvVpuBgJtdADOE1v24vgyyLZjtCbvSUzsgKKda3/Z/iwLFCRrIogixS1L6Vg
2JU2wwirL0Sy5S1DREQmTMAuHL+M9Qwbl+uh/AprkVqaSYuvUzWFwBVgafOl2XgGdn8r6ubxSZhX
9SybOi1fAXGcISX8GzOd85ygu/3dFqvMyCBpNke4vdweIll52KZIMyWji3y2PKJYfgqO+bxo7BAa
ROYxggJvMIICawIBATBtMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNh
MTMwMQYDVQQDEypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMCDH5i
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgGNpN+Vhap9XAyAW0
Lc3nTmFAlgpWkeTb741MMaG6gKkwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDE2MjEwNjMzWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAEL2MGRtWza+KIGu0X9wza5/vO4JBMXDrUe/
1hFH0BzimKgvGbbtRWcigwyIolqdN+4jQPR5bhFnDcKtIRFtJBOmoulULBLYGq+xCgnYW+boMIpU
uXsQyA8TIH3+6OxRp7MzfnkfynvuZ3bMofAhtHcJuHI7bgyWC9EMHeCrYOnWBP2jWDbwyJh93gj3
frc/mvhWkNN75ieSPz63tqVROax0uSD8uWeg6dtWkoDz/vph9JC6Er2l/l1T+2NnkZDr5lWnF26D
CpZBUPRdP19p6QSfunCt2xIPc5w0JWqbV3J7luwHJLkpRTPJ2eEgIyL3VuSlxUXOF+hq90PjHf/5
uao=
--000000000000a946b905b1d02399--


--===============1158245417883861863==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1158245417883861863==--

