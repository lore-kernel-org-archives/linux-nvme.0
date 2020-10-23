Return-Path: <SRS0=yBWI=D6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EC0BAC5517A
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 22:28:07 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3D4A420BED
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Oct 2020 22:28:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="i56cRIwW";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="LoYHlJUw"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3D4A420BED
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=sCP9YYqfHjpQ7GxLAh+oF5cZGSFFhdOQXKUEZLoq348=; b=i56cRIwWpOQRnBtXArSkJd1JN
	guyn0mkzSLlFNoYijujUb9TA95ZpMfFCUq+/puQ17xF0D+6SEaG03kf/7gUcGiNuqh2JBjgYnd5g3
	rPV1qZO4CRj9Ehnvec3QAPEi5Ny3dkbL/3tM9C8L/ZymBvBOwLrO/S1zPCezuNbnUHvAxsz75SRQB
	KbRdC7K3Jtp3LbfTawdUwFyJ/dnTkORFNGi3gQuwZ1ShCZYsdPBC4WVQByfWO04CkX89CLScxrdy8
	Eu4QruBu165Iy+OtvqluDm4SdBzTY6rglw6k1V1Z/a01zufVB/OI25NQjGYneXT8pwly9Invl6mDT
	L7OVqZBjQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kW5XZ-0006Qk-6J; Fri, 23 Oct 2020 22:28:05 +0000
Received: from mail-pf1-x444.google.com ([2607:f8b0:4864:20::444])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kW5XV-0006P4-Vk
 for linux-nvme@lists.infradead.org; Fri, 23 Oct 2020 22:28:03 +0000
Received: by mail-pf1-x444.google.com with SMTP id f19so2596317pfj.11
 for <linux-nvme@lists.infradead.org>; Fri, 23 Oct 2020 15:28:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version; bh=DvIDlMEP24lLkAPWI2OgCO3kdlL8AmHIcZ4BYmv8vi8=;
 b=LoYHlJUwHoepU7nAFlaK3tgGI0bz9QQ5HBVqiBWIHqjX6q9lOK+LUqlskJyw8Sce54
 6t+364RJTShHHxPIiNXKgioeLw95FR0n59kwcDbEgPCpo6cgLG8Q2irAQF+Q6aGjAMGW
 MyclTacCnlZcsKWvyGvMUNQ6A1KJ44jYcUxdY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version;
 bh=DvIDlMEP24lLkAPWI2OgCO3kdlL8AmHIcZ4BYmv8vi8=;
 b=PfMje9m2sizt9SOsvrF/jhmyyhYgI4QOAW1LuT2/rLlVNjhGyb97cScSANPBDlJClJ
 imJFmsESup9Yps18uWQVOFHBZ42q07Cr5jnydp6a0mNd2GgJ54qqLpF+cPysRxyFOWaT
 X+mC0+ozFHupPJJ2AGEZH6+EreVrREaO66YXvHer7EsIAvAD64n1L3j694mfr7uRkVNA
 2WHtPoNBGbZa2pNFcBaMvUw4qetYyd3ZQss6b4Qqa5UWhALR7dXIeOkQE+RUivFpDLoz
 hkLYoWx6O9u8+eZi7TzVankW7Y+ijjS+xoyp84dPGs0NT+dd1zcuQcnfK06k7Eh301Sk
 yKbQ==
X-Gm-Message-State: AOAM532Q9CqENVCwT7fCiYUZbFtHkgmcwieLFeYfKb1uvP8IVz33PsmP
 5WoZiCYtGljl8RCCfltJqCgOORRRjNgN6rpj45h41JcbblXcPa88DAiqbJk+cNFfarPk9l7j5IG
 JJlHz/FpzqaKfNpsJAL/lGbeW/usrYNAoT5D0Fy3mg4avjRpBpA3XNS3cwjvDF637dGyEmdQugC
 ESZXWjyRbf
X-Google-Smtp-Source: ABdhPJzSKLyZNNxWWURsAhpVPjBIoS4MiHtMVYEuYanc/P5m+BVOIxbAfBPgCJd7alGXENcdxbxx5g==
X-Received: by 2002:a63:d252:: with SMTP id t18mr3358385pgi.300.1603492079173; 
 Fri, 23 Oct 2020 15:27:59 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id a18sm4109511pjs.27.2020.10.23.15.27.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 23 Oct 2020 15:27:58 -0700 (PDT)
From: James Smart <james.smart@broadcom.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH v2 1/3] nvme-fc: remove err_work work item
Date: Fri, 23 Oct 2020 15:27:50 -0700
Message-Id: <20201023222752.90621-2-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201023222752.90621-1-james.smart@broadcom.com>
References: <20201023222752.90621-1-james.smart@broadcom.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201023_182802_050742_A24CEA83 
X-CRM114-Status: GOOD (  17.07  )
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
Content-Type: multipart/mixed; boundary="===============1538573696736219606=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============1538573696736219606==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000d15bd805b25e1702"

--000000000000d15bd805b25e1702
Content-Transfer-Encoding: 8bit

err_work was created to handle errors (mainly io timeout) while in
CONNECTING state. The flag for err_work_active is also unneeded.

Remove err_work_active and err_work.  The actions to abort ios are moved
inline to nvme_error_recovery().

Signed-off-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/host/fc.c | 40 ++++++++++------------------------------
 1 file changed, 10 insertions(+), 30 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index cfb6ef74c742..9cdb116b545b 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -158,7 +158,6 @@ struct nvme_fc_ctrl {
 	u32			cnum;
 
 	bool			ioq_live;
-	atomic_t		err_work_active;
 	u64			association_id;
 	struct nvmefc_ls_rcv_op	*rcv_disconn;
 
@@ -168,7 +167,6 @@ struct nvme_fc_ctrl {
 	struct blk_mq_tag_set	tag_set;
 
 	struct delayed_work	connect_work;
-	struct work_struct	err_work;
 
 	struct kref		ref;
 	unsigned long		flags;
@@ -2415,11 +2413,11 @@ nvme_fc_nvme_ctrl_freed(struct nvme_ctrl *nctrl)
 	nvme_fc_ctrl_put(ctrl);
 }
 
+static void __nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl);
+
 static void
 nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 {
-	int active;
-
 	/*
 	 * if an error (io timeout, etc) while (re)connecting,
 	 * it's an error on creating the new association.
@@ -2428,11 +2426,14 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 * ios hitting this path before things are cleaned up.
 	 */
 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
-		active = atomic_xchg(&ctrl->err_work_active, 1);
-		if (!active && !queue_work(nvme_fc_wq, &ctrl->err_work)) {
-			atomic_set(&ctrl->err_work_active, 0);
-			WARN_ON(1);
-		}
+		__nvme_fc_terminate_io(ctrl);
+
+		/*
+		 * Rescheduling the connection after recovering
+		 * from the io error is left to the reconnect work
+		 * item, which is what should have stalled waiting on
+		 * the io that had the error that scheduled this work.
+		 */
 		return;
 	}
 
@@ -3240,7 +3241,6 @@ nvme_fc_delete_ctrl(struct nvme_ctrl *nctrl)
 {
 	struct nvme_fc_ctrl *ctrl = to_fc_ctrl(nctrl);
 
-	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 	/*
 	 * kill the association on the link side.  this will block
@@ -3351,23 +3351,6 @@ nvme_fc_reset_ctrl_work(struct work_struct *work)
 			ctrl->cnum);
 }
 
-static void
-nvme_fc_connect_err_work(struct work_struct *work)
-{
-	struct nvme_fc_ctrl *ctrl =
-			container_of(work, struct nvme_fc_ctrl, err_work);
-
-	__nvme_fc_terminate_io(ctrl);
-
-	atomic_set(&ctrl->err_work_active, 0);
-
-	/*
-	 * Rescheduling the connection after recovering
-	 * from the io error is left to the reconnect work
-	 * item, which is what should have stalled waiting on
-	 * the io that had the error that scheduled this work.
-	 */
-}
 
 static const struct nvme_ctrl_ops nvme_fc_ctrl_ops = {
 	.name			= "fc",
@@ -3495,7 +3478,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 	ctrl->dev = lport->dev;
 	ctrl->cnum = idx;
 	ctrl->ioq_live = false;
-	atomic_set(&ctrl->err_work_active, 0);
 	init_waitqueue_head(&ctrl->ioabort_wait);
 
 	get_device(ctrl->dev);
@@ -3503,7 +3485,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 
 	INIT_WORK(&ctrl->ctrl.reset_work, nvme_fc_reset_ctrl_work);
 	INIT_DELAYED_WORK(&ctrl->connect_work, nvme_fc_connect_ctrl_work);
-	INIT_WORK(&ctrl->err_work, nvme_fc_connect_err_work);
 	spin_lock_init(&ctrl->lock);
 
 	/* io queue count */
@@ -3596,7 +3577,6 @@ nvme_fc_init_ctrl(struct device *dev, struct nvmf_ctrl_options *opts,
 fail_ctrl:
 	nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_DELETING);
 	cancel_work_sync(&ctrl->ctrl.reset_work);
-	cancel_work_sync(&ctrl->err_work);
 	cancel_delayed_work_sync(&ctrl->connect_work);
 
 	ctrl->ctrl.opts = NULL;
-- 
2.26.2


--000000000000d15bd805b25e1702
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgiD6Jk79yPS2xLO2/
j48sVeJpaCR8mnst7ekXzLl0y84wGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDIzMjIyNzU5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBALx/X1uYgvq00lHnp8BBXauaiD/ZRVNQ+VSw
5+hKafPX8cCQSYm6QGqvcQFqDpZUMlN+RHxnYW9pQaExviZqYP5kLNTDD6gFjcFWt5Ri/27g7k2O
DV7foTsv7bhcrSZdDUDlUGOEOTlLSM2S/3lq4PPKXUpJvMOguOFMVwjxe0TEAZ3WV+NQMRx2jMtV
fBO+G4A396f4zjz7BMleL3jBJ+NsNLZFBHnIujvkmqbfE/oCYGTPfdMNEDhX7BeGspXGcMov88JJ
/IyYFSj7a6Y+OJGn/AgKjYRAT0QTC0z+t94jgyowLKI6TgYljiXjNjbTJY2obahqHNlGNgLT5hjV
85k=
--000000000000d15bd805b25e1702--


--===============1538573696736219606==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1538573696736219606==--

