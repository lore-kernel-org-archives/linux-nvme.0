Return-Path: <SRS0=Xx51=D2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ACDA6C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:38:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 12C25222C3
	for <linux-nvme@archiver.kernel.org>; Mon, 19 Oct 2020 14:38:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qiNmu4of";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="TeuVH2wJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 12C25222C3
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:MIME-Version:
	Cc:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=aqFMKiiE6R0hU09JvuU+QFTNo7u4eo+/Uc5w0+Zo5To=; b=qiNmu4ofbUjI6yZHCkk+6VwkT
	jPUV4WIJwtJlquixm/rJiq9NmhWeFbt9FL5xw1RNm2eMZAL2D/TGkMr7SCfF5MPFfamvWL4fSwkMy
	lTIw+8AWtx8dn5WetgQgUfZbOQ6UdDgCottMSiMZHqKgTKSk0IuXsOna0bmJN0Cg696tsEoxj6904
	LDEnL11uYjhVJz6MJMXLfQsv8oO2KG4Sr69nl90yLfMjTaIv/gxzT9X07EN2ahfLcUnJIiBFMi7uG
	1s5TkvENjGJHnqTLmpzmzuMmSAOIZikIQZuvMt7wfrZWzFm/f5yYQUMalmcB6UbnGlf4FEfGWIUO9
	cN29Jv57Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kUWIt-0002TC-QF; Mon, 19 Oct 2020 14:38:27 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kUWI3-00022X-2Q
 for linux-nvme@lists.infradead.org; Mon, 19 Oct 2020 14:37:36 +0000
Received: by mail-pg1-x543.google.com with SMTP id y14so52655pgf.12
 for <linux-nvme@lists.infradead.org>; Mon, 19 Oct 2020 07:37:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=EDAonznrzdhWhVTTIYG66YrNbSZDRuLI1UfEUX7z3Yg=;
 b=TeuVH2wJlCpHSVp6K9b+dmnhVkXNgVgD3cCbzoMN6kvvsyjWh9WgKsh8gvwSd+50if
 JxYU/IbqR5xwsKcHSgU/mJGqJKSVdH2gS7uKTFd1xteiRiLBMp2kr0xG/GnKWySiT667
 74OP6webPBfKkynNjueSzuvn3gbmF+lfsVqvU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=EDAonznrzdhWhVTTIYG66YrNbSZDRuLI1UfEUX7z3Yg=;
 b=b7ds0pvreAzxGisupIByW7qaGvWFAt5dXmE8aYvYG4IWZi6IdZQPyFIctXMhn4oYKz
 83KKosbNpK5keAcxT9heeLak9yhZQWR8kspDjTxyHjRpAc5K8qAMtSjNQ2vMUN2fk+lu
 jdpeMpB8+imapM1NlXxpJaqEc5KHtPzkdfbUs3zVw44NDknzjd4H2d3SaocdGDMNUL/J
 RJRLwr8SJFROhTtPMZFrrwJqWulSudv6CKmJxlg56MvhLicQf2L6QA0D7vvCZMMiDsHv
 teI1kFY5mIELtj2QedBdMKdcqVdEuhGy+vzOW9RAUEPFA8PbeL88W27Z05Q9w7oGdW3Q
 0rYw==
X-Gm-Message-State: AOAM533nXtMplaa1zTW0KyJmpXWkvjHPlt5bN0pa8LkR+HcdmbxON1L7
 QkVDSdk5QtqmhrQ9YiTROqI0tA==
X-Google-Smtp-Source: ABdhPJxiA/cKLdrddyjEUWnLQJDE2PB848Y6OnrcpjMxb8Z+F/qRiVlr7OzM6MIVfc9ny9LwHaDPUg==
X-Received: by 2002:a62:1c92:0:b029:15c:aff1:b16f with SMTP id
 c140-20020a621c920000b029015caff1b16fmr11102458pfc.0.1603118253177; 
 Mon, 19 Oct 2020 07:37:33 -0700 (PDT)
Received: from localhost.localdomain ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id kb15sm53377pjb.17.2020.10.19.07.37.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 19 Oct 2020 07:37:32 -0700 (PDT)
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org
Subject: [RFC v2 15/18] lpfc: vmid: Appends the vmid in the wqe before sending
 request
Date: Mon, 19 Oct 2020 13:13:10 +0530
Message-Id: <1603093393-12875-16-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1603093393-12875-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201019_103735_154804_C94D1811 
X-CRM114-Status: GOOD (  15.42  )
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
Content-Type: multipart/mixed; boundary="===============2913615976056887578=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============2913615976056887578==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000008dffd05b2070e1f"

--00000000000008dffd05b2070e1f

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch adds the vmid in wqe before sending out the request.
The type of vmid depends on the configured type and is checked before
being appended.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
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


--00000000000008dffd05b2070e1f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIIQTQYJKoZIhvcNAQcCoIIQPjCCEDoCAQExDzANBglghkgBZQMEAgEFADALBgkqhkiG9w0BBwGg
gg2iMIIE6DCCA9CgAwIBAgIOSBtqCRO9gCTKXSLwFPMwDQYJKoZIhvcNAQELBQAwTDEgMB4GA1UE
CxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNVBAMT
Ckdsb2JhbFNpZ24wHhcNMTYwNjE1MDAwMDAwWhcNMjQwNjE1MDAwMDAwWjBdMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTEzMDEGA1UEAxMqR2xvYmFsU2lnbiBQZXJzb25h
bFNpZ24gMiBDQSAtIFNIQTI1NiAtIEczMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
tpZok2X9LAHsYqMNVL+Ly6RDkaKar7GD8rVtb9nw6tzPFnvXGeOEA4X5xh9wjx9sScVpGR5wkTg1
fgJIXTlrGESmaqXIdPRd9YQ+Yx9xRIIIPu3Jp/bpbiZBKYDJSbr/2Xago7sb9nnfSyjTSnucUcIP
ZVChn6hKneVGBI2DT9yyyD3PmCEJmEzA8Y96qT83JmVH2GaPSSbCw0C+Zj1s/zqtKUbwE5zh8uuZ
p4vC019QbaIOb8cGlzgvTqGORwK0gwDYpOO6QQdg5d03WvIHwTunnJdoLrfvqUg2vOlpqJmqR+nH
9lHS+bEstsVJtZieU1Pa+3LzfA/4cT7XA/pnwwIDAQABo4IBtTCCAbEwDgYDVR0PAQH/BAQDAgEG
MGoGA1UdJQRjMGEGCCsGAQUFBwMCBggrBgEFBQcDBAYIKwYBBQUHAwkGCisGAQQBgjcUAgIGCisG
AQQBgjcKAwQGCSsGAQQBgjcVBgYKKwYBBAGCNwoDDAYIKwYBBQUHAwcGCCsGAQUFBwMRMBIGA1Ud
EwEB/wQIMAYBAf8CAQAwHQYDVR0OBBYEFGlygmIxZ5VEhXeRgMQENkmdewthMB8GA1UdIwQYMBaA
FI/wS3+oLkUkrk1Q+mOai97i3Ru8MD4GCCsGAQUFBwEBBDIwMDAuBggrBgEFBQcwAYYiaHR0cDov
L29jc3AyLmdsb2JhbHNpZ24uY29tL3Jvb3RyMzA2BgNVHR8ELzAtMCugKaAnhiVodHRwOi8vY3Js
Lmdsb2JhbHNpZ24uY29tL3Jvb3QtcjMuY3JsMGcGA1UdIARgMF4wCwYJKwYBBAGgMgEoMAwGCisG
AQQBoDIBKAowQQYJKwYBBAGgMgFfMDQwMgYIKwYBBQUHAgEWJmh0dHBzOi8vd3d3Lmdsb2JhbHNp
Z24uY29tL3JlcG9zaXRvcnkvMA0GCSqGSIb3DQEBCwUAA4IBAQConc0yzHxn4gtQ16VccKNm4iXv
6rS2UzBuhxI3XDPiwihW45O9RZXzWNgVcUzz5IKJFL7+pcxHvesGVII+5r++9eqI9XnEKCILjHr2
DgvjKq5Jmg6bwifybLYbVUoBthnhaFB0WLwSRRhPrt5eGxMw51UmNICi/hSKBKsHhGFSEaJQALZy
4HL0EWduE6ILYAjX6BSXRDtHFeUPddb46f5Hf5rzITGLsn9BIpoOVrgS878O4JnfUWQi29yBfn75
HajifFvPC+uqn+rcVnvrpLgsLOYG/64kWX/FRH8+mhVe+mcSX3xsUpcxK9q9vLTVtroU/yJUmEC4
OcH5dQsbHBqjMIIDXzCCAkegAwIBAgILBAAAAAABIVhTCKIwDQYJKoZIhvcNAQELBQAwTDEgMB4G
A1UECxMXR2xvYmFsU2lnbiBSb290IENBIC0gUjMxEzARBgNVBAoTCkdsb2JhbFNpZ24xEzARBgNV
BAMTCkdsb2JhbFNpZ24wHhcNMDkwMzE4MTAwMDAwWhcNMjkwMzE4MTAwMDAwWjBMMSAwHgYDVQQL
ExdHbG9iYWxTaWduIFJvb3QgQ0EgLSBSMzETMBEGA1UEChMKR2xvYmFsU2lnbjETMBEGA1UEAxMK
R2xvYmFsU2lnbjCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMwldpB5BngiFvXAg7aE
yiie/QV2EcWtiHL8RgJDx7KKnQRfJMsuS+FggkbhUqsMgUdwbN1k0ev1LKMPgj0MK66X17YUhhB5
uzsTgHeMCOFJ0mpiLx9e+pZo34knlTifBtc+ycsmWQ1z3rDI6SYOgxXG71uL0gRgykmmKPZpO/bL
yCiR5Z2KYVc3rHQU3HTgOu5yLy6c+9C7v/U9AOEGM+iCK65TpjoWc4zdQQ4gOsC0p6Hpsk+QLjJg
6VfLuQSSaGjlOCZgdbKfd/+RFO+uIEn8rUAVSNECMWEZXriX7613t2Saer9fwRPvm2L7DWzgVGkW
qQPabumDk3F2xmmFghcCAwEAAaNCMEAwDgYDVR0PAQH/BAQDAgEGMA8GA1UdEwEB/wQFMAMBAf8w
HQYDVR0OBBYEFI/wS3+oLkUkrk1Q+mOai97i3Ru8MA0GCSqGSIb3DQEBCwUAA4IBAQBLQNvAUKr+
yAzv95ZURUm7lgAJQayzE4aGKAczymvmdLm6AC2upArT9fHxD4q/c2dKg8dEe3jgr25sbwMpjjM5
RcOO5LlXbKr8EpbsU8Yt5CRsuZRj+9xTaGdWPoO4zzUhw8lo/s7awlOqzJCK6fBdRoyV3XpYKBov
Hd7NADdBj+1EbddTKJd+82cEHhXXipa0095MJ6RMG3NzdvQXmcIfeg7jLQitChws/zyrVQ4PkX42
68NXSb7hLi18YIvDQVETI53O9zJrlAGomecsMx86OyXShkDOOyyGeMlhLxS67ttVb9+E7gUJTb0o
2HLO02JQZR7rkpeDMdmztcpHWD9fMIIFTzCCBDegAwIBAgIMX/krgFDQUQNyOf+1MA0GCSqGSIb3
DQEBCwUAMF0xCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTMwMQYDVQQD
EypHbG9iYWxTaWduIFBlcnNvbmFsU2lnbiAyIENBIC0gU0hBMjU2IC0gRzMwHhcNMjAwOTA0MDgz
NTI5WhcNMjIwOTA1MDgzNTI5WjCBljELMAkGA1UEBhMCSU4xEjAQBgNVBAgTCUthcm5hdGFrYTES
MBAGA1UEBxMJQmFuZ2Fsb3JlMRYwFAYDVQQKEw1Ccm9hZGNvbSBJbmMuMRowGAYDVQQDExFNdW5l
ZW5kcmEgS3VtYXIgTTErMCkGCSqGSIb3DQEJARYcbXVuZWVuZHJhLmt1bWFyQGJyb2FkY29tLmNv
bTCCASIwDQYJKoZIhvcNAQEBBQADggEPADCCAQoCggEBAMoadg8/B0JvnQVWQZyfiiEMmDhh0bSq
BIThkSCjIdy7yOV9fBOs6MdrPZgCDeX5rJvOw6PJiWjeQQ9RkTJH6WccvxwXugoyspkG/RfFdUKk
t0/bk1Ml9aUobcee2+cC79gyzwpHUjzEpcsx49FskGIxI+n9wybrDhpurtj8mmc1C1sVzKNoIEwC
/eHrCsDnag9JEGotxVVv0KcLXv7N0CXs03bP8uvocms3+gO1K8dasJkc7noMt/i0/xcZnaABWkgV
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
BCCcuKVv419ZiCrAbr1qaaMP5a59N7ZWko+fBYUPSOp/FjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEwMTkxNDM3MzNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAaIL0sbon/q7OQROj
MDIuUBdcbco1KYOhI+XShsHtGbgP+9u1bJlwJMRzUkoq9noQ+Ls6NsNv1hW/gd7qQpmMlJIf35DV
yOlmvwpiQB8blhUpKUcpbA9pnfN2liGvh9ZZ7kTQdinhLs+cW3U4S4Fc41bKGx4uolW2gobjdDcp
0WTq19TrvVQw5MKfTcXwHjjv47HzAYVXy+7TRtWvFdpQBKrirzi4G0Ez95SJoa10lU0lZZ9/rDE3
U7jEfdctzustcj/KZE4gaTGQdXMm7UC2dTmwIj4K7EDvbTNFvZxBu6cj65/tvkpzbCY61Asw9YDQ
k3pe0vJ6KcCK/5ZI5+0YnA==
--00000000000008dffd05b2070e1f--


--===============2913615976056887578==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============2913615976056887578==--

