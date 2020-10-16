Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B46FBC433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 21:28:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08FCD214DB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 21:28:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JXBEwBXp";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="brgcSZg8"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08FCD214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=6RRJgF9RJ0PDDQQe34Ffp36QVrre7+4ivLp3/mk05og=; b=JXBEwBXpBE66sKYem2l56y8JX
	MvpEqgwcts4ZJNHD7qAFGdZ51DIRaS7bitotMgG0IQVKSXt9/pfUfkOn+XYjqQfO8XJdwoDiDBo25
	Wf3WIEfjsCLrb/8p+4KHjEl8749wFt8ms6y9Bxv8tTljDgQ2c/qtHEPtuOhB4pBTlQ+uRzQA99kEB
	wYZf6x+yMO4rpODu76oLrDOj4lgGBNB3e12tm1MDBfjJvEM8vS642rTrF+CGUMwpV6ZJphv0thlNy
	IhD4oo5Yu60cAeVp8ofEqrpSZ0DCjrmH1RgXAZkgHtW4O9ATpCm03hhtMSX1+tqaZuOXZ3M/EfrSN
	9YCBXl2EQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTXGZ-0007uX-E5; Fri, 16 Oct 2020 21:27:59 +0000
Received: from mail-pl1-x643.google.com ([2607:f8b0:4864:20::643])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTXGU-0007sF-4U
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 21:27:55 +0000
Received: by mail-pl1-x643.google.com with SMTP id b19so1964450pld.0
 for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2020 14:27:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version; bh=pbnDM8GnNJEGCdFZ16xlR7BmY9wa0yUIlYAooS6H9zM=;
 b=brgcSZg8iVfKUWAihgXV4NCT0s9mZieVl0VA3z+XtfveeVq6T+HvJ+MSfGvcRthz4u
 ZRiExZobqeeCnWqZgnr+rV3cdrW4umzWHRWe9UFlyJ/pmEGShL5nxD9rsZA7BwvFvWhY
 P1Ett0X5lZWlPm1caGovScOhQ9IRgL/gLfluk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version;
 bh=pbnDM8GnNJEGCdFZ16xlR7BmY9wa0yUIlYAooS6H9zM=;
 b=AAeBLsQ+xzE1cq6Ep/DrJz58NXTzEpzUURbrr4WH/TgiDu7VJI5xfVh2MehuJf1Z+L
 +f6Z37vyG0ahir/WXWsajFZ8vAyMP2EvWupyMjzRL2MtNpoG2BP1T9NkutiR146eN7mx
 93pdyK7sGWGTeGByEvzuE/8zei6Jwz/aVQN0R+BAAIzPje9cG2ftdN9VAKBSBDskZpk6
 2gneiCuZwsXhAGoiK5fK7sTakgeXgEzarXaZo5H50XQLcG6YKysCf/R0HpeeU2mGONK9
 omVECgp6VJv0EIZG52MT1UHTRuVkLaj6DJGyr6DjHOM53CvE8uUTzPS4S2k4gYF5uFSx
 RO4w==
X-Gm-Message-State: AOAM532izItiLUnG8W/NlW5UTXRvOJ1p+IL05D+koxyAFwuPVqCxkr6F
 y1thcbiywLbUo8FliMGcUxbVSIfL1bIhO1gmJb6YtJ/CaBPusU2qZr2b4q+mGYNgcd/Zfz0dzU3
 YHyAgLNbGg9nG2uVdFKjDePnOZjjANBzO1tO+IW8X+O+NdJUmZqm08xnR72pxB3NEtnTc89XIVb
 6PzIQpDOgn
X-Google-Smtp-Source: ABdhPJyjydTzFmqJiThxORlWlFySoxodthMnlH764dmGIj5BnkbFXM8YmjeDJlWRJM05peyQP9PKJA==
X-Received: by 2002:a17:902:8698:b029:d3:b362:7342 with SMTP id
 g24-20020a1709028698b02900d3b3627342mr5966560plo.50.1602883671165; 
 Fri, 16 Oct 2020 14:27:51 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id k11sm4133394pjs.18.2020.10.16.14.27.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 14:27:50 -0700 (PDT)
From: James Smart <james.smart@broadcom.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 4/4] nvme_fc: track error_recovery while connecting
Date: Fri, 16 Oct 2020 14:27:29 -0700
Message-Id: <20201016212729.49138-5-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016212729.49138-1-james.smart@broadcom.com>
References: <20201016212729.49138-1-james.smart@broadcom.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_172754_256989_F600CC86 
X-CRM114-Status: GOOD (  18.17  )
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
Content-Type: multipart/mixed; boundary="===============3782500220860231817=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============3782500220860231817==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000df23ab05b1d06f58"

--000000000000df23ab05b1d06f58
Content-Transfer-Encoding: 8bit

Whenever there are errors during CONNECTING, the driver recovers by
aborting all outstanding ios and counts on the io completion to fail them
and thus the connection/association they are on.  However, the connection
failure depends on a failure state from the core routines.  Not all
commands that are issued by the core routine are guaranteed to cause a
failure of the core routine. They may be treated as a failure status and
the status is then ignored.

As such, whenever the transport enters error_recovery while CONNECTING,
it will set a new flag indicating an association failed. The
create_association routine which creates and initializes the controller,
will monitor the state of the flag as well as the core routine error
status and ensure the association fails if there was an error.

Signed-off-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/host/fc.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b2f9b3752df7..6352068c0c4a 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -142,7 +142,8 @@ struct nvme_fc_rport {
 
 /* fc_ctrl flags values - specified as bit positions */
 #define ASSOC_ACTIVE		0
-#define FCCTRL_TERMIO		1
+#define ASSOC_FAILED		1
+#define FCCTRL_TERMIO		2
 
 struct nvme_fc_ctrl {
 	spinlock_t		lock;
@@ -2498,6 +2499,7 @@ nvme_fc_error_recovery(struct nvme_fc_ctrl *ctrl, char *errmsg)
 	 */
 	if (ctrl->ctrl.state == NVME_CTRL_CONNECTING) {
 		__nvme_fc_abort_outstanding_ios(ctrl, true);
+		set_bit(ASSOC_FAILED, &ctrl->flags);
 		return;
 	}
 
@@ -3030,6 +3032,8 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 		ctrl->cnum, ctrl->lport->localport.port_name,
 		ctrl->rport->remoteport.port_name, ctrl->ctrl.opts->subsysnqn);
 
+	clear_bit(ASSOC_FAILED, &ctrl->flags);
+
 	/*
 	 * Create the admin queue
 	 */
@@ -3058,7 +3062,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	 */
 
 	ret = nvme_enable_ctrl(&ctrl->ctrl);
-	if (ret)
+	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
 		goto out_disconnect_admin_queue;
 
 	ctrl->ctrl.max_segments = ctrl->lport->ops->max_sgl_segments;
@@ -3068,7 +3072,7 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 	blk_mq_unquiesce_queue(ctrl->ctrl.admin_q);
 
 	ret = nvme_init_identify(&ctrl->ctrl);
-	if (ret)
+	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
 		goto out_disconnect_admin_queue;
 
 	/* sanity checks */
@@ -3113,9 +3117,9 @@ nvme_fc_create_association(struct nvme_fc_ctrl *ctrl)
 			ret = nvme_fc_create_io_queues(ctrl);
 		else
 			ret = nvme_fc_recreate_io_queues(ctrl);
-		if (ret)
-			goto out_term_aen_ops;
 	}
+	if (ret || test_bit(ASSOC_FAILED, &ctrl->flags))
+		goto out_term_aen_ops;
 
 	changed = nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_LIVE);
 
-- 
2.26.2


--000000000000df23ab05b1d06f58
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQghvZXpByQYAzXFSnI
YeO2o0NOb8VwA3C3deFKKoAVHHQwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDE2MjEyNzUxWjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAIKan3a+j4lSuUFK7xUC7Xua2+F5hayeXTf+
d3XR4XxJrv3Cm9y1hv8pMFtV+XSepvhFndFCZ+nbK1dZ80vnuIEbYtSzfA3CTbqImiN5v/GK1WRS
URpxi3mM1gd4efKdthV6l1fy82HclQliw/DVZRR/gXWPnWL12+sj+Si1WJzOq4I2FRA1LyY94Evl
YghcTbTKm/qb4EicQds7NveY3NDqWclosZ34tBwVuPP7qIZD3q1kJJx1I/amEJ/X1w/jxqKaphvM
Jr3IL0i1fB9sO6I0csJqWuXNzWR/OzbHL0lgJOv2zYBYYyZw/1/7iJhiuwxWd1y2L0Tw+OJHOneG
X+0=
--000000000000df23ab05b1d06f58--


--===============3782500220860231817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============3782500220860231817==--

