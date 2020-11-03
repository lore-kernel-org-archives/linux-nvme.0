Return-Path: <SRS0=7iC9=EJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88C50C2D0A3
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 14:14:06 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12AB922226
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Nov 2020 14:14:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3f5PUuu9";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="SrXE74T6"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12AB922226
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:MIME-Version:
	Cc:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aUgsBCtW4V9S4uNceGFwTgFFAMveHhsKipQB9RXbLkk=; b=3f5PUuu91lBvSUfLrr9N4yt3u
	7K56aFzS4tPbY7aNQdTrqGoLVzLk/k3Yz5xV7ccv6IsTN+lgE84MUYk2y2vbkSQ4RmgktMg8cEzwb
	I18ti+YwmVWXxd6Iuw0KUjEJT89U1JpF36/bLI5CAqiKiNfjiOVFtN1ZNvKY5O1G9iWoUeXFEiRDy
	MyL2CWrsjXYjWUn5hZUt8ZKZi68QVdAOamv43f6ECD7PF3USO+nwPVyr/WQc6ETYasAGHAnDJOoBd
	6LTni1t6T2i0N44KmDn7w3nPf8iBUDVF8FnX+xJaNSZF2p/V6zI4DezRsjydUlcusbfC1wzgOr5pX
	OgO0yOiIQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kZx4O-0002tk-0I; Tue, 03 Nov 2020 14:13:56 +0000
Received: from mail-pg1-x542.google.com ([2607:f8b0:4864:20::542])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kZx3C-0002Kd-6Z
 for linux-nvme@lists.infradead.org; Tue, 03 Nov 2020 14:12:45 +0000
Received: by mail-pg1-x542.google.com with SMTP id h6so13782125pgk.4
 for <linux-nvme@lists.infradead.org>; Tue, 03 Nov 2020 06:12:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=OR5O8f418MW8c8jzYHk2+l0vms3yu4Qt5ibweNBoWlY=;
 b=SrXE74T6mp04gkD/muKdoq8a0JLQw3BbEoLiZFYWuNDol5yn74JKWA9sjr2RefMTsU
 A5qOG+ZBV2tGqQDoNEoKto2+zxaPqgN9rkcMBwwJhuMQqq9l73DoFBFTSOFJefsCH49J
 bJsf4Ase1IZQqQYpn8prd3nbiKQHERyppG1LE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=OR5O8f418MW8c8jzYHk2+l0vms3yu4Qt5ibweNBoWlY=;
 b=aGhAnKyg5016Jxoa4Nflszwb0spUkeVq6/5+WKvJZ7gcbR6xqqu8weFOSo6oPW5F82
 cEaXTqLtDnSz820JtIwpKwoK7JFrJP5r/v1K+g7lPxYLlGSw6htb99271pTl/fU5J3+m
 9SXYN/ktzknBqXrgCbe6JQZhWSjKYwPq6qbvRjW/ZMt0n1TbcNnlYOv9ZKJB9fuxnqP2
 x586dDG5RKyOMDgpIXEiuOUOsJ0MU9F5Bdc35RT2QBmnupqfZG/5MkSM6RVJ3gMbH7Yl
 00VZmL1aHIxWPNYCiurw36sHGbCRGBFQRseX60sIEfUL1a3K591bkg92WokskLbZj4ec
 GW4Q==
X-Gm-Message-State: AOAM530tyVYnljDJVb4gp+abG281AbrHcnKG4GJRsAM4YqWCGG7fHDFu
 3mQkgV+NArAPT+EcWcMJDZMvRw==
X-Google-Smtp-Source: ABdhPJz5AeX10bJg5MFG0Sh3NyrxUxtZ83RPqM+rmjqvoHzb9JkMkFTbqtmtXvQNrOWWYqcRAtohfg==
X-Received: by 2002:a17:90a:4295:: with SMTP id
 p21mr4121679pjg.217.1604412760401; 
 Tue, 03 Nov 2020 06:12:40 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id t19sm3596691pgv.37.2020.11.03.06.12.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 03 Nov 2020 06:12:39 -0800 (PST)
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v3 15/19] lpfc: vmid: Appends the vmid in the wqe before
 sending request
Date: Tue,  3 Nov 2020 12:48:19 +0530
Message-Id: <1604387903-20006-16-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604387903-20006-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1604387903-20006-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201103_091243_952676_E686D5C5 
X-CRM114-Status: GOOD (  13.81  )
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
Cc: pbonzini@redhat.com, jsmart2021@gmail.com, mkumar@redhat.com,
 emilne@redhat.com, Gaurav Srivastava <gaurav.srivastava@broadcom.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2549242328893412194=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============2549242328893412194==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ac5a8b05b3347485"

--000000000000ac5a8b05b3347485

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch adds the vmid in wqe before sending out the request.
The type of vmid depends on the configured type and is checked before
being appended.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_sli.c | 56 +++++++++++++++++++++++++++++++++++-
 1 file changed, 55 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/lpfc/lpfc_sli.c b/drivers/scsi/lpfc/lpfc_sli.c
index 51b99b7beaf9..53dbd6a3f460 100644
--- a/drivers/scsi/lpfc/lpfc_sli.c
+++ b/drivers/scsi/lpfc/lpfc_sli.c
@@ -3724,7 +3724,7 @@ lpfc_sli_sp_handle_rspiocb(struct lpfc_hba *phba, struct lpfc_sli_ring *pring,
 
 		if (irsp->ulpStatus) {
 			/* Rsp ring <ringno> error: IOCB */
-			lpfc_printf_log(phba, KERN_WARNING, LOG_SLI,
+			lpfc_printf_log(phba, KERN_ERR, LOG_SLI,
 					"0328 Rsp Ring %d error: "
 					"IOCB Data: "
 					"x%x x%x x%x x%x "
@@ -9625,6 +9625,8 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 				*pcmd == ELS_CMD_RSCN_XMT ||
 				*pcmd == ELS_CMD_FDISC ||
 				*pcmd == ELS_CMD_LOGO ||
+				*pcmd == ELS_CMD_QFPA ||
+				*pcmd == ELS_CMD_UVEM ||
 				*pcmd == ELS_CMD_PLOGI)) {
 				bf_set(els_req64_sp, &wqe->els_req, 1);
 				bf_set(els_req64_sid, &wqe->els_req,
@@ -9756,6 +9758,24 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 			ptr = &wqe->words[22];
 			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
 		}
+
+		/* add the VMID tags as per the switch */
+		if (iocbq->iocb_flag & LPFC_IO_VMID) {
+			union lpfc_wqe128 *wqe128;
+
+			if (phba->pport->vmid_priority_tagging) {
+				bf_set(wqe_ccpe, &wqe->fcp_iwrite.wqe_com, 1);
+				bf_set(wqe_ccp, &wqe->fcp_iwrite.wqe_com,
+				       (iocbq->vmid_tag.cs_ctl_vmid));
+				/* Bit 0 must be 0 */
+			} else {
+				wqe128 = (union lpfc_wqe128 *)wqe;
+				bf_set(wqe_appid, &wqe->fcp_iwrite.wqe_com, 1);
+				bf_set(wqe_wqes, &wqe128->fcp_iwrite.wqe_com,
+				       1);
+				wqe128->words[31] = iocbq->vmid_tag.app_id;
+			}
+		}
 		break;
 	case CMD_FCP_IREAD64_CR:
 		/* word3 iocb=iotag wqe=payload_offset_len */
@@ -9820,6 +9840,23 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 			ptr = &wqe->words[22];
 			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
 		}
+
+		/* add the VMID tags as per the switch */
+		if (iocbq->iocb_flag & LPFC_IO_VMID) {
+			union lpfc_wqe128 *wqe128;
+
+			if (phba->pport->vmid_priority_tagging) {
+				bf_set(wqe_ccpe, &wqe->fcp_iread.wqe_com, 1);
+				bf_set(wqe_ccp, &wqe->fcp_iread.wqe_com,
+				       (iocbq->vmid_tag.cs_ctl_vmid));
+				/* Bit 0 must be 0 */
+			} else {
+				wqe128 = (union lpfc_wqe128 *)wqe;
+				bf_set(wqe_appid, &wqe->fcp_iread.wqe_com, 1);
+				bf_set(wqe_wqes, &wqe128->fcp_iread.wqe_com, 1);
+				wqe128->words[31] = iocbq->vmid_tag.app_id;
+			}
+		}
 		break;
 	case CMD_FCP_ICMND64_CR:
 		/* word3 iocb=iotag wqe=payload_offset_len */
@@ -9877,6 +9914,23 @@ lpfc_sli4_iocb2wqe(struct lpfc_hba *phba, struct lpfc_iocbq *iocbq,
 			ptr = &wqe->words[22];
 			memcpy(ptr, fcp_cmnd, sizeof(struct fcp_cmnd));
 		}
+
+		/* add the VMID tags as per the switch */
+		if (iocbq->iocb_flag & LPFC_IO_VMID) {
+			union lpfc_wqe128 *wqe128;
+
+			if (phba->pport->vmid_priority_tagging) {
+				bf_set(wqe_ccpe, &wqe->fcp_icmd.wqe_com, 1);
+				bf_set(wqe_ccp, &wqe->fcp_icmd.wqe_com,
+				       (iocbq->vmid_tag.cs_ctl_vmid));
+				/* Bit 0 must be 0 */
+			} else {
+				wqe128 = (union lpfc_wqe128 *)wqe;
+				bf_set(wqe_appid, &wqe->fcp_icmd.wqe_com, 1);
+				bf_set(wqe_wqes, &wqe128->fcp_icmd.wqe_com, 1);
+				wqe128->words[31] = iocbq->vmid_tag.app_id;
+			}
+		}
 		break;
 	case CMD_GEN_REQUEST64_CR:
 		/* For this command calculate the xmit length of the
-- 
2.26.2


--000000000000ac5a8b05b3347485
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
J/4V6ms/nIUi+/4vPYjckYUbRzkXm1/X0IyUfpp5cgdrFn9jBIk69fQGAUEhnVvwcXnHWotYxZFd
Xew5Fz0CAwEAAaOCAdMwggHPMA4GA1UdDwEB/wQEAwIFoDCBngYIKwYBBQUHAQEEgZEwgY4wTQYI
KwYBBQUHMAKGQWh0dHA6Ly9zZWN1cmUuZ2xvYmFsc2lnbi5jb20vY2FjZXJ0L2dzcGVyc29uYWxz
aWduMnNoYTJnM29jc3AuY3J0MD0GCCsGAQUFBzABhjFodHRwOi8vb2NzcDIuZ2xvYmFsc2lnbi5j
b20vZ3NwZXJzb25hbHNpZ24yc2hhMmczME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsG
AQUFBwIBFiZodHRwczovL3d3dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAA
MEQGA1UdHwQ9MDswOaA3oDWGM2h0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NwZXJzb25hbHNp
Z24yc2hhMmczLmNybDAnBgNVHREEIDAegRxtdW5lZW5kcmEua3VtYXJAYnJvYWRjb20uY29tMBMG
A1UdJQQMMAoGCCsGAQUFBwMEMB8GA1UdIwQYMBaAFGlygmIxZ5VEhXeRgMQENkmdewthMB0GA1Ud
DgQWBBR6On9cEmlB2VsuST951zNMSKtFBzANBgkqhkiG9w0BAQsFAAOCAQEAOGDBLQ17Ge8BVULh
hsKhgh5eDx0mNmRRdhvTJnxOTRX5QsOKvsJGOUbyrKjD3BTTcGmIUti9HmbqDe/3gRTbhu8LA508
LbMkW5lUoTb8ycBNOKLYhNE8UEOY8jRTUtMEhzT6NJDEE+1hb3kSGfArrrF3Z8pRYiUUhcpC5GKL
9KsxA+DECRfSGfXJJQSq6nEZUGKhz+dz5CV1s8UIZLe9HEEfyJO4eRP+Fw9X16cthAbY0kpVnAvT
/j45FAauY/h87uphdvSb5wC9v5w4VO0JKs0yNUjyWXg/RG+6JCvcViLFLAlRCLrcRcVaQwWZQ3YB
EpmWnHflnrBcah5Ozy137DGCAm8wggJrAgEBMG0wXTELMAkGA1UEBhMCQkUxGTAXBgNVBAoTEEds
b2JhbFNpZ24gbnYtc2ExMzAxBgNVBAMTKkdsb2JhbFNpZ24gUGVyc29uYWxTaWduIDIgQ0EgLSBT
SEEyNTYgLSBHMwIMX/krgFDQUQNyOf+1MA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEi
BCDK059IZvSJhPNFeuo5yDenIGYWaQYzO/jlqffIf6HFWjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMDMxNDEyNDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAnbi+cAx3syFW1kkc
Usy+w5GWTc5MXjXGIpyGWFy/43krRZryoEfw3WFQeof91GGG24kQdIHWNPP6ZYamQTMS8xI58RkJ
W5v5yiiniN9ZDbOi7+VivfibFcF25KWTpo5NHtnt2fBo7MvYI9VaZ80fr8odt2HTqNtMHi8k/ZMd
sqLS90yvesWDTay7geHHtSVGuJowPPlPNHhQzuvQ4Hqn79Tx61FWj0Jee7fPIoO/yHtLGUw3FtXa
/pmviCPCzlA9qZwdm0m01IaGTznqtDUItMaKhJLYNJ9YLRDAFIKa1yjzy2HNtVbUjQEGm1zs8Afc
8ldlMBOxHc/vnhg4XXSQ6g==
--000000000000ac5a8b05b3347485--


--===============2549242328893412194==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2549242328893412194==--

