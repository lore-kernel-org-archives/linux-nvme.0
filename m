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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 787E8C4741F
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 11:17:53 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EBF6E2068D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Nov 2020 11:17:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uIXLnqE/";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="GlSadi8K"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EBF6E2068D
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:MIME-Version:
	Cc:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ywLSZ5/nRqkZMdLyFoc0ZVvZyORTzMr8Y5t/ADhU8rI=; b=uIXLnqE/xBhdKUJqIBuZg2PNK
	MPi7u/iWaStr7WUAUGUZos1vDg62V7hKzb8zzUQMLQftAkj6RgdT2rm48B589zvKtTYtAFvlhKYgF
	OYGxaub20qdDTBFD647o3zZJBB/LdAByaSmRhoA3gjk1yF5ByTn3wRdsYKzMhovHyHUPJAerEcz9V
	nfcDVk/GZKg7+f+4JEYt4X0lVOPYHNmqHdFo/PvF1Foh6cUZZy0JxaGsMP0cnkfX4gPsLAzqce0XR
	OUvnUTeMQ11N7BkyY2xbTmWOvN4iZQgOQUI8wxXLSgqQEW5bcPcsZuhzm8eA7jJN/iMN8bWkeaHYJ
	neUn6lR0Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kc5BE-0007Ik-JP; Mon, 09 Nov 2020 11:17:48 +0000
Received: from mail-pg1-x543.google.com ([2607:f8b0:4864:20::543])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kc5B8-0007Fd-9A
 for linux-nvme@lists.infradead.org; Mon, 09 Nov 2020 11:17:43 +0000
Received: by mail-pg1-x543.google.com with SMTP id r186so6898508pgr.0
 for <linux-nvme@lists.infradead.org>; Mon, 09 Nov 2020 03:17:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references;
 bh=CM3+bYku1LLwrx5iOhFpARsGmeWmYnsOkKqDgl0Fmy4=;
 b=GlSadi8KWrwDijsGP2sLCl7uWNsoG1K8zlzB/GAujjr2OzXc6uJVC3+oUFtx1nn3up
 vIxsJIOcwaSXpBnhvsAfYqW94q0Nrn4vfVkJ1dLeIIVuho7Mi86ZYViZ3qSJPyC1jOnZ
 Hvsy7x2Ek7T/fgL4DAAr6p52KeJ76gncwD9t8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references;
 bh=CM3+bYku1LLwrx5iOhFpARsGmeWmYnsOkKqDgl0Fmy4=;
 b=PtxavCVpT4jcklRhHS5qnuyZZ4BpN1EyguHL9UKXUaA8WkMjs+v2Y3sj4Zn8eeZETT
 8CUUWpWubj0nSZ6btUiJL9GtnpI516dlaOBgLKLLLxm/gHF5hhU5KvRUHDcXuoJcak/x
 iXzywb8fyYn7gAYXM8WJausLG4wYHh/NpplH7/duKkn6TKU8Z4acfKlpOSjonYbp4hzo
 nwNgdqH0/rcusYH0jSnMHNtBEmhr7gHcG0nI+5if7fqXjdR63K73qmsqLlx2gRtuukMA
 EuV3IRO71SoibdMAOTtrrnowQWIhxETESa5YLNkbHnPo8ab9B86bZhbUwBHZZYh2ubz3
 Rrhw==
X-Gm-Message-State: AOAM530lDtwVCpxe/0TZzOTkkK02uqj9iJAcH/rOpB7jwdlF10SDMYmE
 bwXvSQ2G4zPEDUixamG20lcLOQ==
X-Google-Smtp-Source: ABdhPJz5fDBhOa5KNZVG+1hZsWWzU5v08QtIsZHrl6WOkksoR3U0r5dGmD0MkwtRO69296e14c4/qA==
X-Received: by 2002:a17:90a:1992:: with SMTP id
 18mr13170226pji.67.1604920660136; 
 Mon, 09 Nov 2020 03:17:40 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id k9sm10889364pfp.68.2020.11.09.03.17.37
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 09 Nov 2020 03:17:39 -0800 (PST)
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org
Subject: [PATCH v4 04/19] lpfc: vmid: Add the datastructure for supporting
 VMID in lpfc
Date: Mon,  9 Nov 2020 09:53:50 +0530
Message-Id: <1604895845-2587-5-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1604895845-2587-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201109_061742_403253_2C812D43 
X-CRM114-Status: GOOD (  15.14  )
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
Content-Type: multipart/mixed; boundary="===============5785463875779873327=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============5785463875779873327==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000db09f005b3aab5d7"

--000000000000db09f005b3aab5d7

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch adds the primary datastructures needed to implement VMID in lpfc
driver. It maintains the capability, current state, hash table for the
vmid/appid along with other information.

Signed-off-by: Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
Removed unused variable.
---
 drivers/scsi/lpfc/lpfc.h | 97 ++++++++++++++++++++++++++++++++++++++++
 1 file changed, 97 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc.h b/drivers/scsi/lpfc/lpfc.h
index 549adfaa97ce..8f0062d2b891 100644
--- a/drivers/scsi/lpfc/lpfc.h
+++ b/drivers/scsi/lpfc/lpfc.h
@@ -303,6 +303,63 @@ struct lpfc_stats {
 struct lpfc_hba;
 
 
+#define LPFC_VMID_TIMER   300	/* timer interval in seconds. */
+
+#define LPFC_MAX_VMID_SIZE      256
+#define LPFC_COMPRESS_VMID_SIZE 16
+
+union lpfc_vmid_io_tag {
+	u32 app_id;	/* App Id vmid */
+	u8 cs_ctl_vmid;	/* Priority tag vmid */
+};
+
+#define JIFFIES_PER_HR	(HZ * 60 * 60)
+
+struct lpfc_vmid {
+	u8 flag;
+#define LPFC_VMID_SLOT_FREE     0x0
+#define LPFC_VMID_SLOT_USED     0x1
+#define LPFC_VMID_REQ_REGISTER  0x2
+#define LPFC_VMID_REGISTERED    0x4
+#define LPFC_VMID_DE_REGISTER   0x8
+	u8 host_vmid[LPFC_MAX_VMID_SIZE];
+	union lpfc_vmid_io_tag un;
+	u64 io_rd_cnt;
+	u64 io_wr_cnt;
+	u8 vmid_len;
+	u8 delete_inactive; /* Delete if inactive flag 0 = no, 1 = yes */
+	u32 hash_index;
+	u64 __percpu *last_io_time;
+};
+
+#define lpfc_vmid_is_type_priority_tag(vport)\
+	(vport->vmid_priority_tagging ? 1 : 0)
+
+#define LPFC_VMID_HASH_SIZE     256
+#define LPFC_VMID_HASH_MASK     255
+#define LPFC_VMID_HASH_SHIFT    6
+
+struct lpfc_vmid_context {
+	struct lpfc_vmid *vmp;
+	struct lpfc_nodelist *nlp;
+	u8 instantiated;
+};
+
+struct lpfc_vmid_priority_range {
+	u8 low;
+	u8 high;
+	u8 qos;
+};
+
+struct lpfc_vmid_priority_info {
+	u32 num_descriptors;
+	struct lpfc_vmid_priority_range *vmid_range;
+};
+
+#define QFPA_EVEN_ONLY 0x01
+#define QFPA_ODD_ONLY  0x02
+#define QFPA_EVEN_ODD  0x03
+
 enum discovery_state {
 	LPFC_VPORT_UNKNOWN     =  0,    /* vport state is unknown */
 	LPFC_VPORT_FAILED      =  1,    /* vport has failed */
@@ -442,6 +499,9 @@ struct lpfc_vport {
 #define WORKER_RAMP_DOWN_QUEUE         0x800	/* hba: Decrease Q depth */
 #define WORKER_RAMP_UP_QUEUE           0x1000	/* hba: Increase Q depth */
 #define WORKER_SERVICE_TXQ             0x2000	/* hba: IOCBs on the txq */
+#define WORKER_CHECK_INACTIVE_VMID     0x4000	/* hba: check inactive vmids */
+#define WORKER_CHECK_VMID_ISSUE_QFPA   0x8000	/* vport: Check if qfpa need */
+						/* to issue */
 
 	struct timer_list els_tmofunc;
 	struct timer_list delayed_disc_tmo;
@@ -452,6 +512,8 @@ struct lpfc_vport {
 #define FC_LOADING		0x1	/* HBA in process of loading drvr */
 #define FC_UNLOADING		0x2	/* HBA in process of unloading drvr */
 #define FC_ALLOW_FDMI		0x4	/* port is ready for FDMI requests */
+#define FC_ALLOW_VMID		0x8	/* Allow VMID IO's */
+#define FC_DEREGISTER_ALL_APP_ID	0x10	/* Deregister all vmid's */
 	/* Vport Config Parameters */
 	uint32_t cfg_scan_down;
 	uint32_t cfg_lun_queue_depth;
@@ -470,9 +532,36 @@ struct lpfc_vport {
 	uint32_t cfg_tgt_queue_depth;
 	uint32_t cfg_first_burst_size;
 	uint32_t dev_loss_tmo_changed;
+	/* VMID parameters */
+	u8 lpfc_vmid_host_uuid[LPFC_COMPRESS_VMID_SIZE];
+	u32 max_vmid;	/* maximum VMIDs allowed per port */
+	u32 cur_vmid_cnt;	/* Current VMID count */
+#define LPFC_MIN_VMID	4
+#define LPFC_MAX_VMID	255
+	u32 vmid_inactivity_timeout;	/* Time after which the VMID */
+						/* deregisters from switch */
+	u32 vmid_priority_tagging;
+#define LPFC_VMID_PRIO_TAG_DISABLE	0 /* Disable */
+#define LPFC_VMID_PRIO_TAG_SUP_TARGETS	1 /* Allow supported targets only */
+#define LPFC_VMID_PRIO_TAG_ALL_TARGETS	2 /* Allow all targets */
+	unsigned long *vmid_priority_range;
+#define LPFC_VMID_MAX_PRIORITY_RANGE    256
+#define LPFC_VMID_PRIORITY_BITMAP_SIZE  32
+	u8 vmid_flag;
+#define LPFC_VMID_IN_USE		0x1
+#define LPFC_VMID_ISSUE_QFPA		0x2
+#define LPFC_VMID_QFPA_CMPL		0x4
+#define LPFC_VMID_QOS_ENABLED		0x8
+#define LPFC_VMID_TIMER_ENBLD		0x10
+	struct fc_qfpa_res *qfpa_res;
 
 	struct fc_vport *fc_vport;
 
+	struct lpfc_vmid *vmid;
+	struct lpfc_vmid *hash_table[LPFC_VMID_HASH_SIZE];
+	rwlock_t vmid_lock;
+	struct lpfc_vmid_priority_info vmid_priority;
+
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	struct dentry *debug_disc_trc;
 	struct dentry *debug_nodelist;
@@ -925,6 +1014,13 @@ struct lpfc_hba {
 	struct nvmet_fc_target_port *targetport;
 	lpfc_vpd_t vpd;		/* vital product data */
 
+	u32 cfg_max_vmid;	/* maximum VMIDs allowed per port */
+	u32 cfg_vmid_app_header;
+#define LPFC_VMID_APP_HEADER_DISABLE	0
+#define LPFC_VMID_APP_HEADER_ENABLE	1
+	u32 cfg_vmid_priority_tagging;
+	u32 cfg_vmid_inactivity_timeout;	/* Time after which the VMID */
+						/*  deregisters from switch */
 	struct pci_dev *pcidev;
 	struct list_head      work_list;
 	uint32_t              work_ha;      /* Host Attention Bits for WT */
@@ -1168,6 +1264,7 @@ struct lpfc_hba {
 	struct list_head ct_ev_waiters;
 	struct unsol_rcv_ct_ctx ct_ctx[LPFC_CT_CTX_MAX];
 	uint32_t ctx_idx;
+	struct timer_list inactive_vmid_poll;
 
 	/* RAS Support */
 	struct lpfc_ras_fwlog ras_fwlog;
-- 
2.26.2


--000000000000db09f005b3aab5d7
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
BCCO7BFjXzFAURuWv3vwP9gVDtAqsn+ChBE1HDvQkbUS+DAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDExMDkxMTE3NDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYobVFaabmJ7MmYFM
4vNGt71zfzM92y406ovRR+tZO6lXDK8ro/zGetxkv+PonI07/1wquzxItVTjrq3kznXDJXUJKN6A
6RlCVe1mPLKsZ0qNw6mWbXYmwE10LB50GtRtTbOeZMaizmeIyX5I7jLQriqSfvaUoo7lb0cAKDOo
7JdPKo4OtXQbwv+obKvniSDH780jhFmx+jeQj3nCoYcAOUaWPltSbcXO6gIPDiJhOod2/VGa4i9Z
ZIU+EzM3tqg5RlTmSStwYWFldMjuUz2iKL5O6wn55IFYLyITTmeRZpZca4wDpxbIqbKaL6t6xLwH
Prk0H7BGA35yp9K5wwYcJQ==
--000000000000db09f005b3aab5d7--


--===============5785463875779873327==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============5785463875779873327==--

