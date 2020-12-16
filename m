Return-Path: <SRS0=a62X=FU=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C590EC4361B
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 12:24:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6236C230FA
	for <linux-nvme@archiver.kernel.org>; Wed, 16 Dec 2020 12:24:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6236C230FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	References:In-Reply-To:Message-Id:Date:Subject:To:From:MIME-Version:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5lqxWTCSBLmOCdCXLJ6LbTD0rl6Ms5gqjVoN80Nq8/o=; b=FDS8bJj4+8aQY21DCWRxTS0IG
	vt9XHJY7pFvIXJxlSP8B9ysCMZ9VWWrFWzCQ1AR0lT/in5kXeRxKWzwh9JbIw5wIN3hquplsdrh9w
	gUUXcsx7JhCCJflWNVvIXebuujzEZp97GjEz8SBwTBBeV6oh7BFR9R8wTE6weOJzaUz1qQFU+aUQy
	k5/0vhpcXQXb5udUIq7HAUhr55gvyrLeTIuuFf92WcGJlndHiSRpR0FXwEpsMzo4kGItaic6lF29N
	YJzGfgknESajaMCgre6I8pzVOf2hVJeL5CUMx5y97vEKsIhfUZt3cqv1x+akij7CnDJlsnDnZvG/t
	0ui0TWZ3w==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kpVr8-0002yH-4G; Wed, 16 Dec 2020 12:24:34 +0000
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kpVqC-0002TL-7w
 for linux-nvme@lists.infradead.org; Wed, 16 Dec 2020 12:23:39 +0000
Received: by mail-pf1-x433.google.com with SMTP id c12so16468032pfo.10
 for <linux-nvme@lists.infradead.org>; Wed, 16 Dec 2020 04:23:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=broadcom.com; s=google;
 h=mime-version:from:to:cc:subject:date:message-id:in-reply-to
 :references; bh=olNfjhzVuuqPBsnuhHS8h8zvWuu5i5w1JmOw/FfVfxQ=;
 b=RnQDhbcZJFqvDG8xdi6UJyVehj59HeehvT/CCgf3Qc8A5IEpWt/qNaiT4i3bNfcFRb
 9PVM1fehnZoKziH176kUBPK//2uDenSP1MTQ071jMwaD/9pyIDHqzlD8qOFOAUIwy8B5
 nT2FdtpdGRFFt7lRomSX9svR0GLm7fEsEBBjo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :in-reply-to:references;
 bh=olNfjhzVuuqPBsnuhHS8h8zvWuu5i5w1JmOw/FfVfxQ=;
 b=lDPWg1ipxvWG+incBrCCZQwLwTQDX1B8iAOwLN1ru3sW/h+KUh2bCIeFo8cv8uYwxB
 cC9PyPszg37Og7QiXgyqm1UhvkOPsNEILqjIaKwnCq4S+0P6HbIoeVFUVwZMfVXw5rCU
 20BYmNEuifWnw2AFt+1DoZa+UyvQsk4z4pinjor7RuEDfvdzyKIS6STaSse4SEcQCZFF
 5I1MvXN2v8bXkqkQA+5zEmFC/0HXLGghO0xl+OZBi7nU9oHBko4DpEAEhE7EV7j2tZRd
 CEmLdxMdykDeiRkzbYkIzyVDb6uXeQCEt5qmWomA4q5OIPV2c1plnANmZkqNuHHeyNya
 0kxA==
MIME-Version: 1.0
X-Gm-Message-State: AOAM531KkL2n0/H9TFx1H7+/NQZOrha4nVEetuSblnb4mgLkAs9nFmKs
 ZiaFhlqc985/TVmK5tkx09GPtpVGEm0RSpQP5C2VkMz56dernFTZT58IZLINgwS68Vzr+Vuloe4
 jJNFz3eHCA2Ke5SkhOQ==
X-Google-Smtp-Source: ABdhPJyEf7CyZT7C66b/EEx2UbhLas684xVkyY3bnYFihIvUv3c6V2bBlVBT4oIl1Mqa2Ck5fFm4PA==
X-Received: by 2002:aa7:9722:0:b029:19e:2832:4f63 with SMTP id
 k2-20020aa797220000b029019e28324f63mr32005029pfg.58.1608121413898; 
 Wed, 16 Dec 2020 04:23:33 -0800 (PST)
Received: from localhost.localdomain ([192.19.234.250])
 by smtp.gmail.com with ESMTPSA id s7sm2477296pfh.207.2020.12.16.04.23.30
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 16 Dec 2020 04:23:33 -0800 (PST)
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Subject: [PATCH v5 13/16] lpfc: vmid: Timeout implementation for vmid
Date: Wed, 16 Dec 2020 10:59:43 +0530
Message-Id: <1608096586-21656-14-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1608096586-21656-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1608096586-21656-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201216_072337_428582_8EE7D397 
X-CRM114-Status: GOOD (  21.72  )
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
Content-Type: multipart/mixed; boundary="===============8899170544709415711=="
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

--===============8899170544709415711==
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="000000000000a75e2e05b693f1d1"

--000000000000a75e2e05b693f1d1
Content-Type: text/plain; charset="US-ASCII"

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

This patch implements the timeout functionality for the vmid. After the
set time period of inactivity, the vmid is deregistered from the switch.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v5:
No change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 109 +++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_init.c    |  40 ++++++++++++
 2 files changed, 149 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index 2b6b5fc671fe..be71f3a47c95 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -229,6 +229,115 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
 	return;
 }
 
+/**
+ * lpfc_check_inactive_vmid_one - VMID inactivity checker for a vport
+ * @vport: Pointer to vport context object.
+ *
+ * This function checks for idle vmid entries related to a particular vport. If
+ * found unused/idle, it frees them accordingly.
+ **/
+static void lpfc_check_inactive_vmid_one(struct lpfc_vport *vport)
+{
+	u16 i, keep;
+	u32 difftime = 0, r;
+	u64 *lta;
+	int cpu;
+
+	write_lock(&vport->vmid_lock);
+
+	if (!vport->cur_vmid_cnt)
+		goto out;
+
+	/* iterate through the table */
+	for (i = 0; i < LPFC_VMID_HASH_SIZE; ++i) {
+		if (vport->hash_table[i] && (vport->hash_table[i]->flag &
+					     LPFC_VMID_REGISTERED)) {
+			/* check if the particular vmid is in use */
+			/* for all available per cpu variable */
+			for_each_possible_cpu(cpu) {
+				/* if last access time is less than timeout */
+				lta = per_cpu_ptr(
+					vport->hash_table[i]->last_io_time,
+					cpu);
+				if (!lta)
+					continue;
+				difftime = (jiffies) - (*lta);
+				if ((vport->vmid_inactivity_timeout *
+				     JIFFIES_PER_HR) > difftime) {
+					keep = 1;
+					break;
+				}
+			}
+
+			/* if none of the cpus have been used by the vm, */
+			/*  remove the entry if already registered */
+			if (!keep) {
+				/* mark the entry for deregistration */
+				vport->hash_table[i]->flag =
+					LPFC_VMID_DE_REGISTER;
+				write_unlock(&vport->vmid_lock);
+				if (vport->vmid_priority_tagging)
+					r = lpfc_vmid_uvem(vport,
+							   vport->hash_table[i],
+							   false);
+				else
+					r = lpfc_vmid_cmd(vport,
+							  SLI_CTAS_DAPP_IDENT,
+							  vport->hash_table[i]);
+
+				/* decrement number of active vms and mark */
+				/* entry in slot as free */
+				write_lock(&vport->vmid_lock);
+				if (!r) {
+					struct lpfc_vmid *ht =
+							vport->hash_table[i];
+					vport->cur_vmid_cnt--;
+					ht->flag = LPFC_VMID_SLOT_FREE;
+					free_percpu(ht->last_io_time);
+					ht->last_io_time = NULL;
+					vport->hash_table[i] = NULL;
+				}
+			}
+		}
+		keep = 0;
+	}
+ out:
+	write_unlock(&vport->vmid_lock);
+}
+
+/**
+ * lpfc_check_inactive_vmid - VMID inactivity checker
+ * @phba: Pointer to hba context object.
+ *
+ * This function is called from the worker thread to determine if an entry in
+ * the vmid table can be released since there was no IO activity seen from that
+ * particular VM for the specified time. When this happens, the entry in the
+ * table is released and also the resources on the switch cleared.
+ **/
+
+void lpfc_check_inactive_vmid(struct lpfc_hba *phba)
+{
+	struct lpfc_vport *vport;
+	struct lpfc_vport **vports;
+	int i;
+
+	vports = lpfc_create_vport_work_array(phba);
+	if (!vports)
+		return;
+
+	for (i = 0; i <= phba->max_vports; i++) {
+		if ((!vports[i]) && (i == 0))
+			vport = phba->pport;
+		else
+			vport = vports[i];
+		if (!vport)
+			break;
+
+		lpfc_check_inactive_vmid_one(vport);
+	}
+	lpfc_destroy_vport_work_array(phba, vports);
+}
+
 /**
  * lpfc_dev_loss_tmo_handler - Remote node devloss timeout handler
  * @ndlp: Pointer to remote node object.
diff --git a/drivers/scsi/lpfc/lpfc_init.c b/drivers/scsi/lpfc/lpfc_init.c
index 8318dfdc7d87..d1187ec80cb3 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4811,6 +4811,42 @@ lpfc_sli4_fcf_redisc_wait_tmo(struct timer_list *t)
 	lpfc_worker_wake_up(phba);
 }
 
+/**
+ * lpfc_vmid_poll - VMID timeout detection
+ * @ptr: Map to lpfc_hba data structure pointer.
+ *
+ * This routine is invoked when there is no IO on by a VM for the specified
+ * amount of time. When this situation is detected, the VMID has to be
+ * deregistered from the switch and all the local resources freed. The VMID
+ * will be reassigned to the VM once the IO begins.
+ **/
+static void
+lpfc_vmid_poll(struct timer_list *t)
+{
+	struct lpfc_hba *phba = from_timer(phba, t, inactive_vmid_poll);
+	u32 wake_up = 0;
+
+	/* check if there is a need to issue QFPA */
+	if (phba->pport->vmid_priority_tagging) {
+		wake_up = 1;
+		phba->pport->work_port_events |= WORKER_CHECK_VMID_ISSUE_QFPA;
+	}
+
+	/* Is the vmid inactivity timer enabled */
+	if (phba->pport->vmid_inactivity_timeout ||
+	    phba->pport->load_flag & FC_DEREGISTER_ALL_APP_ID) {
+		wake_up = 1;
+		phba->pport->work_port_events |= WORKER_CHECK_INACTIVE_VMID;
+	}
+
+	if (wake_up)
+		lpfc_worker_wake_up(phba);
+
+	/* restart the timer for the next iteration */
+	mod_timer(&phba->inactive_vmid_poll, jiffies + msecs_to_jiffies(1000 *
+							LPFC_VMID_TIMER));
+}
+
 /**
  * lpfc_sli4_parse_latt_fault - Parse sli4 link-attention link fault code
  * @phba: pointer to lpfc hba data structure.
@@ -6657,6 +6693,10 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
 	phba->hbqs[LPFC_ELS_HBQ].hbq_alloc_buffer = lpfc_sli4_rb_alloc;
 	phba->hbqs[LPFC_ELS_HBQ].hbq_free_buffer = lpfc_sli4_rb_free;
 
+	/* for VMID idle timeout if VMID is enabled */
+	if (lpfc_is_vmid_enabled(phba))
+		timer_setup(&phba->inactive_vmid_poll, lpfc_vmid_poll, 0);
+
 	/*
 	 * Initialize the SLI Layer to run with lpfc SLI4 HBAs.
 	 */
-- 
2.26.2


-- 
This electronic communication and the information and any files transmitted 
with it, or attached to it, are confidential and are intended solely for 
the use of the individual or entity to whom it is addressed and may contain 
information that is confidential, legally privileged, protected by privacy 
laws, or otherwise restricted from disclosure to anyone else. If you are 
not the intended recipient or the person responsible for delivering the 
e-mail to the intended recipient, you are hereby notified that any use, 
copying, distributing, dissemination, forwarding, printing, or copying of 
this e-mail is strictly prohibited. If you received this e-mail in error, 
please return the e-mail to the sender, delete it from your computer, and 
destroy any printed copy of it.

--000000000000a75e2e05b693f1d1
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
BCC2ti9CyFOc4MK8sjZ9syFmO16fuXavR25+S2y41dwrDDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcN
AQcBMBwGCSqGSIb3DQEJBTEPFw0yMDEyMTYxMjIzMzRaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZI
AWUDBAEqMAsGCWCGSAFlAwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEK
MAsGCSqGSIb3DQEBBzALBglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEACV8wbRFYRCCF+WGP
IX1QTVTFuutlmEtdOgoAaSentEMcg92bwAWWfolwRzq4wSg0nXo9vr+vFMhlFfU2mEZV8mlvKYat
1g20tGZeUw6OrjmbWU7N8MgkWTBJihJeA+qx6xlwTi8x01f81bQYNKuLeXK4DDG4WQo9teCD8Mf4
KccK7tUFctL2lTxgS2XHcqP/YzAOQ6jNb4zPyGgiFn5DfpqIYSwUAAgr19nE+zBW+IQu9en+2TzN
C5+BESM1ga3rbPJwcSXZ9CsbRkSSBiDZPmQguj8VimeHS95ExOcaURn8lQDXsEfsRZK1UdvnUq6E
K3UmVo4RJ+neu+KOktoHhA==
--000000000000a75e2e05b693f1d1--


--===============8899170544709415711==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme

--===============8899170544709415711==--

