Return-Path: <SRS0=mxs5=EP=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	T_TVD_MIME_NO_HEADERS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F07B2C388F7
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 11:19:38 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6964A20679
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 11:19:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="r/kREcLS";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="J75Y+f1o"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6964A20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:MIME-Version:
	Cc:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=qZljexDTFmPnXk+TFxDPAfMTxiYL1jp6JTAxZTtVR3M=; b=r/kREcLSTUH0jJQRqyQCZmnAp
	BpE/zbXHXJxK3XZ3sGF/+9g5fz+C+rddiYkrWu8gGygIS6fURJIUmcwthnMkdMLm2WDi1JzCFNVO4
	bJfI3DI8Lj/w9OJcFnq2aG25wN3dhLeyNVlhg0zS36gm2VnKtBnzDqcxkP6aW+a2lmA7C4KpwU5Jz
	KxA3hAwyG5OOJzaF7ej5Bv9iPy6gpXif1ovlR4LCM2kw05+5O2v2mwzuO4ydDaalD+6K60JQc88Cu
	Xx70c10KhAwYp+yo/crsHb59rce1qWWNz1b2K5OrTZUgNXbWKds5oOn4M9PQ7yzo+I1Z8qX0B1h+u
	OAm4Za1Gg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc5Cu-00085i-Vf; Mon, 09 Nov 2020 11:19:33 +0000
Received: from mail-pf1-x441.google.com ([2607:f8b0:4864:20::441])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc5Bh-0007XQ-2W
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 11:18:19 +0000
Received: by mail-pf1-x441.google.com with SMTP id c20so7850795pfr.8
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 03:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=AnlJm4TLCu99rsrq1ze1cPn9kCRChsfthhnybz+6Xcs=;
 b=J75Y+f1oLK5PxXw7d2IaUXb09JVFmMXd9czw31tN2hXaljvDqKzUMH0owXi6PVZaYU
 7U3yJcbSB+aCIYqDw9yQCEWcE0Bf1JFbmtmfqlsfxFtyTpZazqbsNo3GeoR+bbwjY+mE
 iwYn248Nnlo6mgbczmYVw/CWEbRFDWbSFoF5I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=AnlJm4TLCu99rsrq1ze1cPn9kCRChsfthhnybz+6Xcs=;
 b=GlNrVFBxp2cvLQJ/PGXOavMxTBd8Lt5U2C3BWcfmxRoc//umKQI1wh05CmTEDLkQdT
 C7ZDOb1s48A0PSA1JVKhi8a8axO9zk37woCQdqB9ec87HgyX/g31DgFkrpd7gjw8taLB
 YUQF0bHVsbx+XMiCNNaah/algTdscuDvydmYZCXA3ttpY4Uos3LhIDHHeZB+hmVyWMW3
 jBP9zFrR005G5WmAHlVyis0iWfEmtNBrqOhqc46HBWWdYM+EOcW7MVt5xkELzDUd8hWr
 PtcuXxaSPTkmSoo3WHkOGMAVIVqrplymG1BaA0Y9DwbvTI5Q/YuvPc6sgm1rC8OEOYUV
 +1sw==
X-Gm-Message-State: AOAM532wtuY5/2Bc8i9CyaWSn8xIAgChRDP5ZLKcwqhAAarzcooFxTfv
 6zPfaeysIurLo3volAAh/PZVTA==
X-Google-Smtp-Source: ABdhPJyAwdCYEX8wA6cmf/jzu+U9NCfv3pEHJDk0C5LRndBHHNT2/lKG6eIwVYoFY//BulOt5a4JFg==
X-Received: by 2002:a17:90a:de15:: with SMTP id
 m21mr12952870pjv.180.1604920694891; 
 Mon, 09 Nov 2020 03:18:14 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id k9sm10889364pfp.68.2020.11.09.03.18.11
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Nov 2020 03:18:13 -0800 (PST)
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v4 14/19] lpfc: vmid: Implements CT commands for appid.
Date: Mon,  9 Nov 2020 09:54:00 +0530
Message-Id: <1604895845-2587-15-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_061817_239809_5D31FD42 
X-CRM114-Status: GOOD (  20.59  )
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
Content-Type: multipart/mixed; boundary="===============0632751506680083440=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============0632751506680083440==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000ee02b905b3aab7cd"

--000000000000ee02b905b3aab7cd

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

The patch implements CT commands for registering and deregistering the
appid for the application. Also, a small change in decrementing the ndlp
ref counter has been added.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
Removed redundant code due to changes since last submit
---
 drivers/scsi/lpfc/lpfc_ct.c | 249 ++++++++++++++++++++++++++++++++++++
 1 file changed, 249 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_ct.c b/drivers/scsi/lpfc/lpfc_ct.c
index c201686d3815..691f78340f26 100644
--- a/drivers/scsi/lpfc/lpfc_ct.c
+++ b/drivers/scsi/lpfc/lpfc_ct.c
@@ -3406,3 +3406,252 @@ lpfc_decode_firmware_rev(struct lpfc_hba *phba, char *fwrevision, int flag)
 	}
 	return;
 }
+
+void
+lpfc_cmpl_ct_cmd_vmid(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		      struct lpfc_iocbq *rspiocb)
+{
+	struct lpfc_vport *vport = cmdiocb->vport;
+	struct lpfc_dmabuf *inp = cmdiocb->context1;
+	struct lpfc_dmabuf *outp = cmdiocb->context2;
+	struct lpfc_sli_ct_request *ctcmd = inp->virt;
+	struct lpfc_sli_ct_request *ctrsp = outp->virt;
+	u16 rsp = ctrsp->CommandResponse.bits.CmdRsp;
+	struct app_id_object *app;
+	u32 cmd, hash;
+	struct lpfc_vmid *vmp;
+	u8 *data = outp->virt;
+	int i;
+
+	cmd = be16_to_cpu(ctcmd->CommandResponse.bits.CmdRsp);
+	if (cmd == SLI_CTAS_DALLAPP_ID)
+		lpfc_ct_free_iocb(phba, cmdiocb);
+
+	if (lpfc_els_chk_latt(vport) || rspiocb->iocb.ulpStatus) {
+		if (cmd != SLI_CTAS_DALLAPP_ID)
+			return;
+	}
+	/* Check for a CT LS_RJT response */
+	if (rsp == be16_to_cpu(SLI_CT_RESPONSE_FS_RJT)) {
+		if (cmd != SLI_CTAS_DALLAPP_ID)
+			lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+					 "3306 VMID FS_RJT Data: x%x  %x %x\n",
+				 cmd, ctrsp->ReasonCode, ctrsp->Explanation);
+		if ((cmd != SLI_CTAS_DALLAPP_ID) ||
+		    (ctrsp->ReasonCode != SLI_CT_UNABLE_TO_PERFORM_REQ) ||
+		    (ctrsp->Explanation != SLI_CT_APP_ID_NOT_AVAILABLE)) {
+			/* If DALLAPP_ID failed retry later */
+			if (cmd == SLI_CTAS_DALLAPP_ID)
+				vport->load_flag |= FC_DEREGISTER_ALL_APP_ID;
+			return;
+		}
+	}
+
+	switch (cmd) {
+	case SLI_CTAS_RAPP_IDENT:
+		app = (struct app_id_object *)(RAPP_IDENT_OFFSET + data);
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "6712 RAPP_IDENT app id %d  port id %x id\n"
+				 "len %d\n", be32_to_cpu(app->app_id),
+				 be32_to_cpu(app->port_id),
+				 app->obj.entity_id_len);
+
+		if (app->obj.entity_id_len == 0 || app->port_id == 0)
+			return;
+
+		hash = lpfc_vmid_hash_fn(app->obj.entity_id,
+					 app->obj.entity_id_len);
+		vmp = lpfc_get_vmid_from_hastable(vport, hash,
+						  app->obj.entity_id);
+		if (vmp) {
+			vmp->un.app_id = be32_to_cpu(app->app_id);
+			vmp->flag |= LPFC_VMID_REGISTERED;
+			vmp->flag &= ~LPFC_VMID_REQ_REGISTER;
+			/* Set IN USE flag */
+			vport->vmid_flag |= LPFC_VMID_IN_USE;
+		} else {
+			lpfc_printf_vlog(vport, KERN_DEBUG,
+					 LOG_DISCOVERY, "6901 No entry found\n"
+					 "%s hash %d\n", app->obj.entity_id,
+					 hash);
+		}
+		break;
+	case SLI_CTAS_DAPP_IDENT:
+		app = (struct app_id_object *)(DAPP_IDENT_OFFSET + data);
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "6713 DAPP_IDENT app id %d  port id %x",
+				 cpu_to_be32(app->app_id),
+				 cpu_to_be32(app->port_id));
+		break;
+	case SLI_CTAS_DALLAPP_ID:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "8856 Deregistered all app ids");
+		for (i = 0; i < phba->cfg_max_vmid; i++) {
+			vmp = &vport->vmid[i];
+			if (vmp->flag != LPFC_VMID_SLOT_FREE)
+				memset(vmp, 0, sizeof(struct lpfc_vmid));
+		}
+		for (i = 0; i < LPFC_VMID_HASH_SIZE; i++)
+			vport->hash_table[i] = NULL;
+		vport->load_flag |= FC_ALLOW_VMID;
+		break;
+	default:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "8857 Invalid command code");
+	}
+}
+
+/**
+ * lpfc_vmid_cmd - Build and send a FDMI cmd to the specified NPort
+ * @vport: pointer to a host virtual N_Port data structure.
+ * @ndlp: ndlp to send FDMI cmd to (if NULL use FDMI_DID)
+ * cmdcode: FDMI command to send
+ * mask: Mask of HBA or PORT Attributes to send
+ *
+ * Builds and sends a FDMI command using the CT subsystem.
+ */
+int
+lpfc_vmid_cmd(struct lpfc_vport *vport,
+	      int cmdcode, struct lpfc_vmid *vmid)
+{
+	struct lpfc_hba *phba = vport->phba;
+	struct lpfc_dmabuf *mp, *bmp;
+	struct lpfc_sli_ct_request *ctreq;
+	struct ulp_bde64 *bpl;
+	u32 size;
+	u32 rsp_size;
+	u8 *data;
+	struct lpfc_vmid_rapp_ident_list *rap;
+	struct lpfc_vmid_dapp_ident_list *dap;
+	u8 retry = 0;
+	struct lpfc_nodelist *ndlp;
+
+	void (*cmpl)(struct lpfc_hba *phba, struct lpfc_iocbq *cmdiocb,
+		     struct lpfc_iocbq *rspiocb);
+
+	ndlp = lpfc_findnode_did(vport, FDMI_DID);
+	if (!ndlp || !NLP_CHK_NODE_ACT(ndlp))
+		return 0;
+
+	cmpl = lpfc_cmpl_ct_cmd_vmid;
+
+	/* fill in BDEs for command */
+	/* Allocate buffer for command payload */
+	mp = kmalloc(sizeof(*mp), GFP_KERNEL);
+	if (!mp)
+		goto vmid_free_mp_exit;
+
+	mp->virt = lpfc_mbuf_alloc(phba, 0, &mp->phys);
+	if (!mp->virt)
+		goto vmid_free_mp_virt_exit;
+
+	/* Allocate buffer for Buffer ptr list */
+	bmp = kmalloc(sizeof(*bmp), GFP_KERNEL);
+	if (!bmp)
+		goto vmid_free_bmp_exit;
+
+	bmp->virt = lpfc_mbuf_alloc(phba, 0, &bmp->phys);
+	if (!bmp->virt)
+		goto vmid_free_bmp_virt_exit;
+
+	INIT_LIST_HEAD(&mp->list);
+	INIT_LIST_HEAD(&bmp->list);
+
+	lpfc_printf_vlog(vport, KERN_INFO, LOG_DISCOVERY,
+			 "0218 VMID Request Data: x%x x%x x%x",
+			 vport->fc_flag, vport->port_state, cmdcode);
+	ctreq = (struct lpfc_sli_ct_request *)mp->virt;
+	data = mp->virt;
+	/* First populate the CT_IU preamble */
+	memset(data, 0, LPFC_BPL_SIZE);
+	ctreq->RevisionId.bits.Revision = SLI_CT_REVISION;
+	ctreq->RevisionId.bits.InId = 0;
+
+	ctreq->FsType = SLI_CT_MANAGEMENT_SERVICE;
+	ctreq->FsSubType = SLI_CT_APP_SEV_Subtypes;
+
+	ctreq->CommandResponse.bits.CmdRsp = cpu_to_be16(cmdcode);
+	rsp_size = LPFC_BPL_SIZE;
+	size = 0;
+
+	switch (cmdcode) {
+	case SLI_CTAS_RAPP_IDENT:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "1329 RAPP_IDENT for %s", vmid->host_vmid);
+		ctreq->un.PortID = cpu_to_be32(vport->fc_myDID);
+		rap = (struct lpfc_vmid_rapp_ident_list *)
+			(DAPP_IDENT_OFFSET + data);
+		rap->no_of_objects = cpu_to_be32(1);
+		rap->obj[0].entity_id_len = vmid->vmid_len;
+		memcpy(rap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
+		size = RAPP_IDENT_OFFSET +
+			sizeof(struct lpfc_vmid_rapp_ident_list);
+		retry = 1;
+		break;
+
+	case SLI_CTAS_GALLAPPIA_ID:
+		ctreq->un.PortID = cpu_to_be32(vport->fc_myDID);
+		size = GALLAPPIA_ID_SIZE;
+		break;
+
+	case SLI_CTAS_DAPP_IDENT:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "1469 DAPP_IDENT for %s", vmid->host_vmid);
+		ctreq->un.PortID = cpu_to_be32(vport->fc_myDID);
+		dap = (struct lpfc_vmid_dapp_ident_list *)
+			(DAPP_IDENT_OFFSET + data);
+		dap->no_of_objects = cpu_to_be32(1);
+		dap->obj[0].entity_id_len = vmid->vmid_len;
+		memcpy(dap->obj[0].entity_id, vmid->host_vmid, vmid->vmid_len);
+		size = DAPP_IDENT_OFFSET +
+			sizeof(struct lpfc_vmid_dapp_ident_list);
+		vmid->flag &= ~LPFC_VMID_REGISTERED;
+		retry = 1;
+		break;
+
+	case SLI_CTAS_DALLAPP_ID:
+		ctreq->un.PortID = cpu_to_be32(vport->fc_myDID);
+		size = DALLAPP_ID_SIZE;
+		break;
+
+	default:
+		lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+				 "7062 VMID cmdcode x%x not supported",
+				 cmdcode);
+		goto vmid_free_all_mem;
+	}
+
+	ctreq->CommandResponse.bits.Size = cpu_to_be16(rsp_size);
+
+	bpl = (struct ulp_bde64 *)bmp->virt;
+	bpl->addrHigh = putPaddrHigh(mp->phys);
+	bpl->addrLow = putPaddrLow(mp->phys);
+	bpl->tus.f.bdeFlags = 0;
+	bpl->tus.f.bdeSize = size;
+
+	/* The lpfc_ct_cmd/lpfc_get_req shall increment ndlp reference count
+	 * to hold ndlp reference for the corresponding callback function.
+	 */
+	if (!lpfc_ct_cmd(vport, mp, bmp, ndlp, cmpl, rsp_size, retry))
+		return 0;
+
+	/* Decrement ndlp reference count to release ndlp reference held
+	 * for the failed command's callback function.
+	 */
+	lpfc_nlp_put(ndlp);
+
+ vmid_free_all_mem:
+	lpfc_mbuf_free(phba, bmp->virt, bmp->phys);
+ vmid_free_bmp_virt_exit:
+	kfree(bmp);
+ vmid_free_bmp_exit:
+	lpfc_mbuf_free(phba, mp->virt, mp->phys);
+ vmid_free_mp_virt_exit:
+	kfree(mp);
+ vmid_free_mp_exit:
+
+	/* Issue FDMI request failed */
+	lpfc_printf_vlog(vport, KERN_DEBUG, LOG_DISCOVERY,
+			 "0244 Issue FDMI request failed Data: x%x", cmdcode);
+	return 1;
+}
-- 
2.26.2


--000000000000ee02b905b3aab7cd
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
BCC18Er6hdLaKpH4Ismr8jiLrYvxFw0hJhMaLmCuRgw/RjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMDkxMTE4MTVaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAXA0WPUTmMVbMcv6Q
nL3xJYKrhbNsA3Ikjh90cZ4b0Iwfe07iMdrnPWH3AzrtPmo7LuqSGfJQ5TSDGwpY3N65VLOdPxQt
TwLUfkulR8OkcrzBeTs4Qui2sbg1vdp8tanIbCG36WLz1BigkVVE/H7gn1Dzq8tZdyidfnmzAOqE
Nt5mRHuDdjuXz66RLZojuOHOSVbU4X8z9MwqEyVGJBR29NmutXFyv1h4G5HMmhGyRzNagELC4FEO
ucKnm3Bgpil8kzyjZH4VtSalrxvQWwAYID7cwtheNyA3xy/g4fLDWHq0/zCuL6dQLXVY88n6oT4y
g4pPD0FzEnFMsB8X0fcr0Q==
--000000000000ee02b905b3aab7cd--


--===============0632751506680083440==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============0632751506680083440==--

