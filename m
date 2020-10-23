Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F060CC388F9
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 22:28:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D9D120BED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 22:28:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0ROPyMdS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="ghAY+MfV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D9D120BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PvPsJo8apRBcQWWpl0mxbrknQhbmbWQSajA/CbK64S8=; b=0ROPyMdSA6O8juno22Rgkb6mM
	CSugrezaOTWZMLe0svTaS/CihAoyBY/mhnpr2wth6NzuoXfxGK56nzRcdwodYvviloQPkCu7ZqRfj
	WFAJ57FsSAr+eD9Irm9eKGFk+5kK/K9wYmNjn6K8h8XVEIH2Pv2nC8sTUDumLFzZTMC/ZgU9KggwB
	msZU4DaGocBRkHrUD06lWSYKH8dn2Tv+Jg4hlpegBAFJmQ0m6aH3AJ8Jg96qzA2GXfqp7u+0wzSyV
	I89a6v0hMPqhERQIQG8CET9hWa4+44QuC4yAylMscmUUN/7uf+5nXBipDsUKW0Ho0Zh7i48CSakk3
	efNGgGYDQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW5Xb-0006RT-Gj; Fri, 23 Oct 2020 22:28:07 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW5XX-0006PP-7t
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 22:28:04 +0000
Received: by mail-pg1-x542.google.com with SMTP id x13so2449011pgp.7
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 15:28:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version; bh=CURwCmLRRoEdWIm2bY1TlDA/KGbF48tW42qsTaFcrGY=;
 b=ghAY+MfVuX0uMBWjtJ5ScHqW2G0xti3Fbwv+yX9RLCh/PHiPH/thAP/Oqhvu4d4AFw
 8idao0mCq1BYIcgj/oAiAQzWlUmgOZa6g+9F2beS00Okeb44iSeLAlMJNXHi/8DE3NmF
 Zj677M+90Q+tptuK7CJZQ+GOPW1qQHPpNhyuY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version;
 bh=CURwCmLRRoEdWIm2bY1TlDA/KGbF48tW42qsTaFcrGY=;
 b=M2/qKsrH9VM1AmXF1nCvl3lltKMItnthN6AL5H0QeUkM5MWl3H8SBEuF6ZWtbaFUKz
 AhrA1w3hiQLt8FJlyi2r3OiAxjH0k1r0fyWXay99os54zxON25W5dFlNlxs0jyH7tATT
 vbYMAYsfjstQa74aGbGyNgkOOkRK040FD9lsfId+tIuoegARLABgB6A+POhmo+aFQ+ny
 ddd+8Fq/QPZAbAVqHlGf4yCL67NDGp9nyQJtc9ZG/JPialNzX8ZvbDfeoSgRtTA0nUhN
 fcTblJvGLMdyUxquc3gjCaZFX3/qMcW0+CLLn8K8XZ/j49ka3UMOvhmeIt9HQUuO2do7
 jMhg==
X-Gm-Message-State: AOAM531YByixSnYaWT1ZX1z902GlkVQYP0PZMEf1pkQsFBLjW8WY7tzr
 iQ1Mk6QFWQ5MxwRa4rtzGJoRwcwbKrnvvvMThbCis8BV21czTL6OxMQEz+RG5US1MqJoG1iiJbb
 025EKqv8lHs54wpwVC27TeZOBuyPJD0Jr+wSybRZTuAH+eaA5NYEuRM4qO6bFx36aa1pKLsLpR9
 VS6EISygji
X-Google-Smtp-Source: ABdhPJwU9qdaMNSh+u853Riz06dw2f8OvEZcwE6X83jXOd5904FTE6HYYuewI8K/K7287cRaq0uqDQ==
X-Received: by 2002:a63:d946:: with SMTP id e6mr3966418pgj.113.1603492080397; 
 Fri, 23 Oct 2020 15:28:00 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a18sm4109511pjs.27.2020.10.23.15.27.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 15:27:59 -0700 (PDT)
From: James Smart <james.smart@broadcom.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 2/3] nvme-fc: eliminate terminate_io use by
 nvme_fc_error_recovery
Date: Fri, 23 Oct 2020 15:27:51 -0700
Message-Id: <20201023222752.90621-3-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023222752.90621-1-james.smart@broadcom.com>
References: <20201023222752.90621-1-james.smart@broadcom.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_182803_353662_2C8224CC 
X-CRM114-Status: GOOD (  28.22  )
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
Content-Type: multipart/mixed; boundary="===============4573066881929033844=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============4573066881929033844==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000e5b34505b25e178e"

--000000000000e5b34505b25e178e
Content-Transfer-Encoding: 8bit

nvme_fc_error_recovery() special cases handling when in CONNECTING state
and calls __nvme_fc_terminate_io(). __nvme_fc_terminate_io() itself
special cases CONNECTING state and calls the routine to abort outstanding
ios.

Simplify the sequence by putting the call to abort outstanding ios directly
in nvme_fc_error_recovery.

Move the location of __nvme_fc_abort_outstanding_ios(), and
nvme_fc_terminate_exchange() which is called by it, to avoid adding
function prototypes for nvme_fc_error_recovery().

Signed-off-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/host/fc.c | 187 ++++++++++++++++++-----------------------
 1 file changed, 84 insertions(+), 103 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index 9cdb116b545b..ffbfb0533cac 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -2413,27 +2413,97 @@ nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
 	nvme_fc_ctrl_put(ctrl);
 }
 
-static void __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl);
+/*
+ * This routine is used by the transport when it needs to find active
+ * io on a queue that is to be terminated. The transport uses
+ * blk_mq_tagset_busy_itr() to find the busy requests, which then invoke
+ * this routine to kill them on a 1 by 1 basis.
+ *
+ * As FC allocates FC exchange for each io, the transport must contact
+ * the LLDD to terminate the exchange, thus releasing the FC exchange.
+ * After terminating the exchange the LLDD will call the transport's
+ * normal io done path for the request, but it will have an aborted
+ * status. The done path will return the io request back to the block
+ * layer with an error status.
+ */
+static bool
+nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
+{
+	struct nvme_ctrl *nctrl = data;
+	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
+	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
+
+	__nvme_fc_abort_op(ctrl, op);
+	return true;
+}
+
+/*
+ * This routine runs through all outstanding commands on the association
+ * and aborts them.  This routine is typically be called by the
+ * delete_association routine. It is also called due to an error during
+ * reconnect. In that scenario, it is most likely a command that initializes
+ * the controller, including fabric Connect commands on io queues, that
+ * may have timed out or failed thus the io must be killed for the connect
+ * thread to see the error.
+ */
+static void
+__nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
+{
+	/*
+	 * If io queues are present, stop them and terminate all outstanding
+	 * ios on them. As FC allocates FC exchange for each io, the
+	 * transport must contact the LLDD to terminate the exchange,
+	 * thus releasing the FC exchange. We use blk_mq_tagset_busy_itr()
+	 * to tell us what io's are busy and invoke a transport routine
+	 * to kill them with the LLDD.  After terminating the exchange
+	 * the LLDD will call the transport's normal io done path, but it
+	 * will have an aborted status. The done path will return the
+	 * io requests back to the block layer as part of normal completions
+	 * (but with error status).
+	 */
+	if (ctrl->ctrl.queue_count > 1) {
+		nvme_stop_queues(&ctrl->ctrl);
+		blk_mq_tagset_busy_iter(&ctrl->tag_set,
+				nvme_fc_terminate_exchange, &ctrl->ctrl);
+		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
+		if (start_queues)
+			nvme_start_queues(&ctrl->ctrl);
+	}
+
+	/*
+	 * Other transports, which don't have link-level contexts bound
+	 * to sqe's, would try to gracefully shutdown the controller by
+	 * writing the registers for shutdown and polling (call
+	 * nvme_shutdown_ctrl()). Given a bunch of i/o was potentially
+	 * just aborted and we will wait on those contexts, and given
+	 * there was no indication of how live the controlelr is on the
+	 * link, don't send more io to create more contexts for the
+	 * shutdown. Let the controller fail via keepalive failure if
+	 * its still present.
+	 */
+
+	/*
+	 * clean up the admin queue. Same thing as above.
+	 */
+	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
+	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
+				nvme_fc_terminate_exchange, &ctrl->ctrl);
+	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
+}
 
 static void
 nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 {
 	/*
-	 * if an error (io timeout, etc) while (re)connecting,
-	 * it's an error on creating the new association.
-	 * Start the error recovery thread if it hasn't already
-	 * been started. It is expected there could be multiple
-	 * ios hitting this path before things are cleaned up.
+	 * if an error (io timeout, etc) while (re)connecting, the remote
+	 * port requested terminating of the association (disconnect_ls)
+	 * or an error (timeout or abort) occurred on an io while creating
+	 * the controller.  Abort any ios on the association and let the
+	 * create_association error path resolve things.
 	 */
 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
-		__nvme_fc_terminate_io(ctrl);
-
-		/*
-		 * Rescheduling the connection after recovering
-		 * from the io error is left to the reconnect work
-		 * item, which is what should have stalled waiting on
-		 * the io that had the error that scheduled this work.
-		 */
+		__nvme_fc_abort_outstanding_ios(ctrl, true);
+		set_bit(ASSOC_FAILED, &ctrl->flags);
 		return;
 	}
 
@@ -2747,30 +2817,6 @@ nvme_fc_complete_rq(struct request *rq)
 	nvme_fc_ctrl_put(ctrl);
 }
 
-/*
- * This routine is used by the transport when it needs to find active
- * io on a queue that is to be terminated. The transport uses
- * blk_mq_tagset_busy_itr() to find the busy requests, which then invoke
- * this routine to kill them on a 1 by 1 basis.
- *
- * As FC allocates FC exchange for each io, the transport must contact
- * the LLDD to terminate the exchange, thus releasing the FC exchange.
- * After terminating the exchange the LLDD will call the transport's
- * normal io done path for the request, but it will have an aborted
- * status. The done path will return the io request back to the block
- * layer with an error status.
- */
-static bool
-nvme_fc_terminate_exchange(struct request *req, void *data, bool reserved)
-{
-	struct nvme_ctrl *nctrl = data;
-	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
-	struct nvme_fc_fcp_op *op = blk_mq_rq_to_pdu(req);
-
-	__nvme_fc_abort_op(ctrl, op);
-	return true;
-}
-
 
 static const struct blk_mq_ops nvme_fc_mq_ops = {
 	.queue_rq	= nvme_fc_queue_rq,
@@ -3111,60 +3157,6 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 }
 
 
-/*
- * This routine runs through all outstanding commands on the association
- * and aborts them.  This routine is typically be called by the
- * delete_association routine. It is also called due to an error during
- * reconnect. In that scenario, it is most likely a command that initializes
- * the controller, including fabric Connect commands on io queues, that
- * may have timed out or failed thus the io must be killed for the connect
- * thread to see the error.
- */
-static void
-__nvme_fc_abort_outstanding_ios(struct nvme_fc_ctrl *ctrl, bool start_queues)
-{
-	/*
-	 * If io queues are present, stop them and terminate all outstanding
-	 * ios on them. As FC allocates FC exchange for each io, the
-	 * transport must contact the LLDD to terminate the exchange,
-	 * thus releasing the FC exchange. We use blk_mq_tagset_busy_itr()
-	 * to tell us what io's are busy and invoke a transport routine
-	 * to kill them with the LLDD.  After terminating the exchange
-	 * the LLDD will call the transport's normal io done path, but it
-	 * will have an aborted status. The done path will return the
-	 * io requests back to the block layer as part of normal completions
-	 * (but with error status).
-	 */
-	if (ctrl->ctrl.queue_count > 1) {
-		nvme_stop_queues(&ctrl->ctrl);
-		blk_mq_tagset_busy_iter(&ctrl->tag_set,
-				nvme_fc_terminate_exchange, &ctrl->ctrl);
-		blk_mq_tagset_wait_completed_request(&ctrl->tag_set);
-		if (start_queues)
-			nvme_start_queues(&ctrl->ctrl);
-	}
-
-	/*
-	 * Other transports, which don't have link-level contexts bound
-	 * to sqe's, would try to gracefully shutdown the controller by
-	 * writing the registers for shutdown and polling (call
-	 * nvme_shutdown_ctrl()). Given a bunch of i/o was potentially
-	 * just aborted and we will wait on those contexts, and given
-	 * there was no indication of how live the controlelr is on the
-	 * link, don't send more io to create more contexts for the
-	 * shutdown. Let the controller fail via keepalive failure if
-	 * its still present.
-	 */
-
-	/*
-	 * clean up the admin queue. Same thing as above.
-	 */
-	blk_mq_quiesce_queue(ctrl->ctrl.admin_q);
-	blk_mq_tagset_busy_iter(&ctrl->admin_tag_set,
-				nvme_fc_terminate_exchange, &ctrl->ctrl);
-	blk_mq_tagset_wait_completed_request(&ctrl->admin_tag_set);
-}
-
 /*
  * This routine stops operation of the controller on the host side.
  * On the host os stack side: Admin and IO queues are stopped,
@@ -3297,17 +3289,6 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 static void
 __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
 {
-	/*
-	 * if state is CONNECTING - the error occurred as part of a
-	 * reconnect attempt. Abort any ios on the association and
-	 * let the create_association error paths resolve things.
-	 */
-	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
-		__nvme_fc_abort_outstanding_ios(ctrl, true);
-		set_bit(ASSOC_FAILED, &ctrl->flags);
-		return;
-	}
-
 	/*
 	 * For any other state, kill the association. As this routine
 	 * is a common io abort routine for resetting and such, after
-- 
2.26.2


--000000000000e5b34505b25e178e
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgvOsKOHsF7V34AhP2
5t4ldEwwAZDS93UieUIOufTGqGMwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDIzMjIyODAxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBABrbAEw3xd/RVnMEvIDCNW3IXdHDphD2k4KU
RMXzW1Oqp8wp72Qf4xa5MP7SwG+FRlZ2d6Crq4aUSAVj2Bj5iwnMgwNlwgwojt0wmjCu5jAR7Pqy
IaTEBPC9mVqtFxssw1Bd8q87nBoG2MBdpYcCpFvYbx1b/1H5cuv1tybJGvl8QJKtTcMZhCDeX69e
Vfemiu11pr7Tf6RXfPNg4cfFOL3DvDRQQT4ZX6yP/mwUYQaFYO24NgXGVjIcuDztbbaasoasIq4B
XIVDfs5xR5kwO9OMHcY9lVaedV5F3u8R3dVGF7fCtD1JfFKzCaqJBWMGwBCXwn6NSQ1bHnm8PRmY
CKY=
--000000000000e5b34505b25e178e--


--===============4573066881929033844==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============4573066881929033844==--

