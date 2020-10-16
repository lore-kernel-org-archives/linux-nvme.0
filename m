Return-Path: <SRS0=oO1v=DX=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69B65C433DF
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 21:27:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B0BC7214DB
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Oct 2020 21:27:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="JwBuUWbf";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="axB7una1"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B0BC7214DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=i077GmCQ40dlawh/WzthMOVfWqTOim4MERCS5O3s4HI=; b=JwBuUWbft3OUPoTgTP5FPWZOx
	EfAzHIs9MPEi6nRdXmqhurQ5HLz4vaCqZSdea7ykBjQ3iPENrRlsSCbNmQgWvPDgU1CpgFfSx3uWd
	Gzcnzx2tE8QbE5mecL0gZqNVozeMuPito75y29gaZxWWW/BSuwClNVglHy7ZKZGKD+GP37vTptzvw
	ZzVBmFAgglwu6ty1R7yLpmfzZ+Sltzwao4mt5MSb+E72ArVESIRJ6YwlUrUpLraZeBMP5PAvIpXQh
	cYLLoz0hoHRsIGEb6hu9ZwDGHJEWlVSy3Yfq/P/SG5ciapg1z15ykNaM/GB45k5BDn857EqpIBlkq
	t41drenpQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kTXGW-0007tG-03; Fri, 16 Oct 2020 21:27:56 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kTXGR-0007r6-Lx
 for linux-nvme@lists.infradead.org; Fri, 16 Oct 2020 21:27:53 +0000
Received: by mail-pg1-x542.google.com with SMTP id b23so2183586pgb.3
 for <linux-nvme@lists.infradead.org>; Fri, 16 Oct 2020 14:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version; bh=m2uvNHVvgBiBpdDCVlFtb4AJafZc/ozU/F2bmhNlwRA=;
 b=axB7una1esAIP9vuJ78D4Zh738uvPwfdrVR6TBP8z6XjZhhquCzXMFQb2LosRirMBv
 Fcj71xNJ1ZCuRxwUgpAVTiV4suMOGUg6QD+7dRp+ok/bJapKg/tCOeySMSOreclbZLBm
 j57SL7VizbCDgIjMx6eYi6R/n+Nr1Hby1IJXY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version;
 bh=m2uvNHVvgBiBpdDCVlFtb4AJafZc/ozU/F2bmhNlwRA=;
 b=QmRd3yA3mm/PulIvYabeUqIM6115S9/2zAzclsfZG5nm857jRStcJF1ex8llG/ebU4
 /FZzFkQm67Zn9JJOc8jIBmukCi3jajNNrRFOoXCW2Gs1m+DN34KyQmjj5LUoJbaRO2IO
 k2ck4squTXbdkvia0+B+dALDsUTM3xqUAoMeTysAbjVfbJb2rStpFdz6Taq4SYbtZMzl
 HzQXCb8EKf4r4asUyLH94str9i4MrhJcRYMCcAyAtdNSAfDpwHvMemmjD5vch0QlAe5H
 ieMqfgleVDyB62x0WL7SSHfJ7LPEPs/k8AC27HGF02Jn2CrIJq/aRqRO9tr76H3oPUTW
 qi8w==
X-Gm-Message-State: AOAM532H1FD+QUpfN07HtCYHboty79LcJgNJgxBcVBsHaNabYkXcId2+
 5/uVQ9Pb0igifrBLd3wU0OJ3vN+J4rdmgILH5qNw/P0st3KimcUxUsq5BpZV2TH4dn8C1G75JYd
 EoAg0/+wLmVbrtmsGYlj6QnT7xoLFd3jVTaXoleHlikQJCVvVrYj4XgNcXbDpYTNyqG/36M4YBY
 lQmzW/oYdp
X-Google-Smtp-Source: ABdhPJx8QNqAeLHqb5Cu38VIKx0SHG8JaxgRVJY0mLrdoZyPcl49/y4K/Zup2O6wLSvQQXIJJopbbA==
X-Received: by 2002:a63:3f8d:: with SMTP id m135mr4714466pga.234.1602883668422; 
 Fri, 16 Oct 2020 14:27:48 -0700 (PDT)
Received: from localhost.localdomain ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id k11sm4133394pjs.18.2020.10.16.14.27.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 16 Oct 2020 14:27:47 -0700 (PDT)
From: James Smart <james.smart@broadcom.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH 3/4] nvme-fc: remove nvme_fc_terminate_io()
Date: Fri, 16 Oct 2020 14:27:28 -0700
Message-Id: <20201016212729.49138-4-james.smart@broadcom.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201016212729.49138-1-james.smart@broadcom.com>
References: <20201016212729.49138-1-james.smart@broadcom.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201016_172751_787370_182842C9 
X-CRM114-Status: GOOD (  14.80  )
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
Content-Type: multipart/mixed; boundary="===============1748397941070523935=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============1748397941070523935==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000b6268705b1d06f28"

--000000000000b6268705b1d06f28
Content-Transfer-Encoding: 8bit

__nvme_fc_terminate_io() is now called by only 1 place, in reset_work.
Consoldate and move the functionality of terminate_io into reset_work.

In reset_work, rather than calling the create_association directly,
schedule the connect work element to do its thing. After scheduling, flush
the connect work element to continue with semantic of not returning until
connect has been attempted at least once.

Signed-off-by: James Smart <james.smart@broadcom.com>
---
 drivers/nvme/host/fc.c | 49 ++++++++++++++----------------------------
 1 file changed, 16 insertions(+), 33 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index d65a4a9f4808..b2f9b3752df7 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -3279,49 +3279,32 @@ nvme_fc_reconnect_or_delete(struct nvme_fc_ctrl *ctrl, int status)
 }
 
 static void
-__nvme_fc_terminate_io(struct nvme_fc_ctrl *ctrl)
+nvme_fc_reset_ctrl_work(struct work_struct *work)
 {
-	/*
-	 * For any other state, kill the association. As this routine
-	 * is a common io abort routine for resetting and such, after
-	 * the association is terminated, ensure that the state is set
-	 * to CONNECTING.
-	 */
+	struct nvme_fc_ctrl *ctrl =
+		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
 
-	nvme_stop_keep_alive(&ctrl->ctrl);
+	nvme_stop_ctrl(&ctrl->ctrl);
 
 	/* will block will waiting for io to terminate */
 	nvme_fc_delete_association(ctrl);
 
-	if (ctrl->ctrl.state != NVME_CTRL_CONNECTING &&
-	    !nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
+	if (!nvme_change_ctrl_state(&ctrl->ctrl, NVME_CTRL_CONNECTING))
 		dev_err(ctrl->ctrl.device,
 			"NVME-FC{%d}: error_recovery: Couldn't change state "
 			"to CONNECTING\n", ctrl->cnum);
-}
-
-static void
-nvme_fc_reset_ctrl_work(struct work_struct *work)
-{
-	struct nvme_fc_ctrl *ctrl =
-		container_of(work, struct nvme_fc_ctrl, ctrl.reset_work);
-	int ret;
-
-	__nvme_fc_terminate_io(ctrl);
 
-	nvme_stop_ctrl(&ctrl->ctrl);
-
-	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE)
-		ret = nvme_fc_create_association(ctrl);
-	else
-		ret = -ENOTCONN;
-
-	if (ret)
-		nvme_fc_reconnect_or_delete(ctrl, ret);
-	else
-		dev_info(ctrl->ctrl.device,
-			"NVME-FC{%d}: controller reset complete\n",
-			ctrl->cnum);
+	if (ctrl->rport->remoteport.port_state == FC_OBJSTATE_ONLINE) {
+		if (!queue_delayed_work(nvme_wq, &ctrl->connect_work, 0)) {
+			dev_err(ctrl->ctrl.device,
+				"NVME-FC{%d}: failed to schedule connect "
+				"after reset\n", ctrl->cnum);
+		} else {
+			flush_delayed_work(&ctrl->connect_work);
+		}
+	} else {
+		nvme_fc_reconnect_or_delete(ctrl, -ENOTCONN);
+	}
 }
 
 
-- 
2.26.2


--000000000000b6268705b1d06f28
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
rbJ+nCPBux48wjANBglghkgBZQMEAgEFAKCB1DAvBgkqhkiG9w0BCQQxIgQgkOZA8ueJFEleGkBm
GjC5qXE6iMDIR1HbTkCli0KmS2cwGAYJKoZIhvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0B
CQUxDxcNMjAxMDE2MjEyNzQ5WjBpBgkqhkiG9w0BCQ8xXDBaMAsGCWCGSAFlAwQBKjALBglghkgB
ZQMEARYwCwYJYIZIAWUDBAECMAoGCCqGSIb3DQMHMAsGCSqGSIb3DQEBCjALBgkqhkiG9w0BAQcw
CwYJYIZIAWUDBAIBMA0GCSqGSIb3DQEBAQUABIIBAM2xCpXFYLMJNnZcang0X3KFHHLFrHN3+cED
JA5cju3sBtXpU/+GFo2TGkEzwbDKf6vWUb1m2li9O/vJgLgKjHyq+R6KQLQYtF1SC8zbsVt0r5/k
MNuBoyiTd77/TuTAFzkoEvTP1kcNae/2fZfTG56F0J8sv4GuMVuG/QfevIjcV+X7zUBOznmPRW12
tbk9+5eJj0wZSZg6YrLj3OoBtqTkeidVVXQhUZ5xxvRftprl+yHO5gKRQ9ZtSB+iQVPWZ29+vZUi
hnbIfIs7BI4lLywXVAcECrwlNawpF5rxELCJPtaK2UbC2GhN1p2i7wIbLCp6I8kqD7nLxvY40YT9
/z0=
--000000000000b6268705b1d06f28--


--===============1748397941070523935==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============1748397941070523935==--

