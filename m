Return-Path: <SRS0=nBdQ=IC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 863DAC4332D
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:34:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 061B764F11
	for <linux-nvme@archiver.kernel.org>; Thu,  4 Mar 2021 12:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 061B764F11
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BeyD+3aLRDDqFMZKCDl0QRsnxJaEWUp2zFcO08hozAE=; b=YRtKK9D4PYcsSEYKG2M7HAfspg
	nHooYP0x3isR2iVLwAy0A3DqHCBqWouvH/A7r4Cu/jP1+ir1a67EpAlKbkd9+cA1Iq1K8b6l2++G7
	9Q5GtchuvE04QL8bFBOjHd3V1rTYlAKgbayDqdQxJJVOg3CwUOpT8dLC4AXYrJo2ONdRHYwthonIi
	jVkdf2zxSG/n2fAFcpjgfDbAVuDKPtcPyOPcAHaDFwCrKqYsUiGMCCEtslt37SB1hiADrAjcGMTXo
	hHY4wrOvY6vf/s3nbTvwf7vRK9t2IstE0YgSXZNCMz5qpzH0TLO5KLtAqpkgbP989R2hMph3DkT+/
	kIpEatWA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lHnBa-008czO-TA; Thu, 04 Mar 2021 12:34:35 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.221.30])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lHn99-008cSu-Oo
 for linux-nvme@lists.infradead.org; Thu, 04 Mar 2021 12:32:09 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 16BF224349;
 Thu,  4 Mar 2021 04:20:03 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 16BF224349
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1614860403;
 bh=hXRI6fzdSSHNp0x9+XvsZ6BXqPJgOTPGlnUVo/cVWy0=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=soUsMNQqYbZ3qlFG0U2kWVECcpzfIefpyxPahnUo0RMDSwx6FNceF5llB5+ii638N
 W5bFqI8aOuoXKFeXwEP1UGS72bu86pxiO9kgVQHVF0l/3F/CsPpr/tczAM936Aew/Z
 948tQAkddqbGpnt/ZGhIiwq2aTP56kdkRYFlX1n4=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v8 15/16] lpfc: vmid: Introducing vmid in io path.
Date: Thu,  4 Mar 2021 10:57:25 +0530
Message-Id: <1614835646-16217-16-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1614835646-16217-1-git-send-email-muneendra.kumar@broadcom.com>
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Gaurav Srivastava <gaurav.srivastava@broadcom.com>

The patch introduces the vmid in the io path. It checks if the vmid is
enabled and if io belongs to a vm or not and acts accordingly. Other
supporing APIs are also included in the patch.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v8:
Added proper error codes
updated logic while handling vmid

v7:
No change

v6:
No change

v5:
No change

v4:
No change

v3:
Replaced blkcg_get_app_identifier with blkcg_get_fc_appid

v2:
Ported the patch on top of 5.10/scsi-queue
Added a fix for issuing QFPA command which was not included in the
last submit
---
 drivers/scsi/lpfc/lpfc_scsi.c | 168 ++++++++++++++++++++++++++++++++++
 1 file changed, 168 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index b71602878559..dc0d09d4b22a 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -5279,6 +5279,154 @@ static void lpfc_vmid_assign_cs_ctl(struct lpfc_vport *vport,
 	}
 }
 
+/*
+ * lpfc_vmid_get_appid- get the vmid associated with the uuid
+ * @vport: The virtual port for which this call is being executed.
+ * @uuid: uuid associated with the VE
+ * @cmd: address of scsi cmmd descriptor
+ * @tag: VMID tag
+ * Returns status of the function
+ */
+static int lpfc_vmid_get_appid(struct lpfc_vport *vport, char *uuid, struct
+			       scsi_cmnd * cmd, union lpfc_vmid_io_tag *tag)
+{
+	struct lpfc_vmid *vmp = NULL;
+	int hash, len, rc, i;
+	u8 pending = 0;
+
+	/* check if QFPA is complete */
+	if (lpfc_vmid_is_type_priority_tag(vport) && !(vport->vmid_flag &
+	      LPFC_VMID_QFPA_CMPL)) {
+		vport->work_port_events |= WORKER_CHECK_VMID_ISSUE_QFPA;
+		return -EAGAIN;
+	}
+
+	/* search if the uuid has already been mapped to the vmid */
+	len = strlen(uuid);
+	hash = lpfc_vmid_hash_fn(uuid, len);
+
+	/* search for the VMID in the table */
+	read_lock(&vport->vmid_lock);
+	vmp = lpfc_get_vmid_from_hastable(vport, hash, uuid);
+	read_unlock(&vport->vmid_lock);
+
+	/* if found, check if its already registered  */
+	if (vmp  && vmp->flag & LPFC_VMID_REGISTERED) {
+		lpfc_vmid_update_entry(vport, cmd, vmp, tag);
+		rc = 0;
+	} else if (vmp && (vmp->flag & LPFC_VMID_REQ_REGISTER ||
+			   vmp->flag & LPFC_VMID_DE_REGISTER)) {
+		/* else if register or dereg request has already been sent */
+		/* Hence vmid tag will not be added for this IO */
+		rc = -EBUSY;
+	} else {
+		/* else, start the process to obtain one as per the */
+		/* switch connected */
+		write_lock(&vport->vmid_lock);
+		vmp = lpfc_get_vmid_from_hastable(vport, hash, uuid);
+
+		/* while the read lock was released, in case the entry was */
+		/* added by other context or is in process of being added */
+		if (vmp && vmp->flag & LPFC_VMID_REGISTERED) {
+			lpfc_vmid_update_entry(vport, cmd, vmp, tag);
+			write_unlock(&vport->vmid_lock);
+			return 0;
+		} else if (vmp && vmp->flag & LPFC_VMID_REQ_REGISTER) {
+			write_unlock(&vport->vmid_lock);
+			return -EBUSY;
+		}
+
+		/* else search and allocate a free slot in the hash table */
+		if (vport->cur_vmid_cnt < vport->max_vmid) {
+			for (i = 0; i < vport->max_vmid; ++i) {
+				vmp = vport->vmid + i;
+				if (vmp->flag == LPFC_VMID_SLOT_FREE) {
+					vmp = vport->vmid + i;
+					break;
+				}
+			}
+		} else {
+			write_unlock(&vport->vmid_lock);
+			return -ENOMEM;
+		}
+
+		if (vmp && (vmp->flag == LPFC_VMID_SLOT_FREE)) {
+			/* Add the vmid and register  */
+			if (lpfc_put_vmid_in_hashtable(vport, hash, vmp)) {
+				write_unlock(&vport->vmid_lock);
+				return -ENOMEM;
+			}
+			vmp->vmid_len = len;
+			memcpy(vmp->host_vmid, uuid, vmp->vmid_len);
+			vmp->io_rd_cnt = 0;
+			vmp->io_wr_cnt = 0;
+			vmp->flag = LPFC_VMID_SLOT_USED;
+
+			vmp->delete_inactive =
+			    vport->vmid_inactivity_timeout ? 1 : 0;
+
+			/* if type priority tag, get next available vmid */
+			if (lpfc_vmid_is_type_priority_tag(vport))
+				lpfc_vmid_assign_cs_ctl(vport, vmp);
+
+			/* allocate the per cpu variable for holding */
+			/* the last access time stamp only if vmid is enabled */
+			if (!vmp->last_io_time)
+				vmp->last_io_time =
+				    __alloc_percpu(sizeof(u64),
+						   __alignof__(struct
+							       lpfc_vmid));
+
+			/* registration pending */
+			pending = 1;
+		} else {
+			rc = -ENOMEM;
+		}
+		write_unlock(&vport->vmid_lock);
+
+		/* complete transaction with switch */
+		if (pending) {
+			if (lpfc_vmid_is_type_priority_tag(vport))
+				rc = lpfc_vmid_uvem(vport, vmp, true);
+			else
+				rc = lpfc_vmid_cmd(vport,
+						   SLI_CTAS_RAPP_IDENT,
+						   vmp);
+			if (!rc) {
+				write_lock(&vport->vmid_lock);
+				vport->cur_vmid_cnt++;
+				vmp->flag |= LPFC_VMID_REQ_REGISTER;
+				write_unlock(&vport->vmid_lock);
+			}
+		}
+
+		/* finally, enable the idle timer once */
+		if (!(vport->phba->pport->vmid_flag & LPFC_VMID_TIMER_ENBLD)) {
+			mod_timer(&vport->phba->inactive_vmid_poll,
+				  jiffies +
+				  msecs_to_jiffies(1000 * LPFC_VMID_TIMER));
+			vport->phba->pport->vmid_flag |= LPFC_VMID_TIMER_ENBLD;
+		}
+	}
+	return rc;
+}
+
+/*
+ * lpfc_is_command_vm_io - get the uuid from blk cgroup
+ * @cmd:Pointer to scsi_cmnd data structure
+ * Returns uuid if present if not null
+ */
+static char *lpfc_is_command_vm_io(struct scsi_cmnd *cmd)
+{
+	char *uuid = NULL;
+
+	if (cmd->request) {
+		if (cmd->request->bio)
+			uuid = blkcg_get_fc_appid(cmd->request->bio);
+	}
+	return uuid;
+}
+
 /**
  * lpfc_queuecommand - scsi_host_template queuecommand entry point
  * @shost: kernel scsi host pointer.
@@ -5304,6 +5452,7 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	int err, idx;
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	uint64_t start = 0L;
+	u8 *uuid = NULL;
 
 	if (phba->ktime_on)
 		start = ktime_get_ns();
@@ -5431,6 +5580,25 @@ lpfc_queuecommand(struct Scsi_Host *shost, struct scsi_cmnd *cmnd)
 	}
 
 
+	/* check the necessary and sufficient condition to support VMID */
+	if (lpfc_is_vmid_enabled(phba) &&
+	    (ndlp->vmid_support ||
+	     phba->pport->vmid_priority_tagging ==
+	     LPFC_VMID_PRIO_TAG_ALL_TARGETS)) {
+		/* is the IO generated by a VM, get the associated virtual */
+		/* entity id */
+		uuid = lpfc_is_command_vm_io(cmnd);
+
+		if (uuid) {
+			err = lpfc_vmid_get_appid(vport, uuid, cmnd,
+				(union lpfc_vmid_io_tag *)
+					&lpfc_cmd->cur_iocbq.vmid_tag);
+			if (!err)
+				lpfc_cmd->cur_iocbq.iocb_flag |= LPFC_IO_VMID;
+		}
+	}
+
+	atomic_inc(&ndlp->cmd_pending);
 #ifdef CONFIG_SCSI_LPFC_DEBUG_FS
 	if (unlikely(phba->hdwqstat_on & LPFC_CHECK_SCSI_IO))
 		this_cpu_inc(phba->sli4_hba.c_stat->xmt_io);
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
