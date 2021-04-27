Return-Path: <SRS0=oNUT=JZ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.4 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 443AFC433B4
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 05:45:03 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AD4B7610A5
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Apr 2021 05:45:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AD4B7610A5
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jHn/LcSBVFtiePAa9xWQ1f59f2ZxjVUzZ4Odkh6E7BM=; b=lGmuwKgg0LdV+CAaCb9OjH3NXo
	zKjJ9kB679EJ7h04nt/DPcnlbtTSSPcHtjNXdZuwSIaqrtgyHsfbLVPMY/TaO4ak+yKnKSRPmuqUP
	xtXbGRwtj1V9aIXTnjBF/mFurplLV3j5/QsXudfPWalVp5E1Hmo4mejFP0nwddwJvZAmT9UZpHaqr
	gH7ZV2USD0rbYVx0x6f5pGcKUMA8f2iIpvRUAxTnjZY455+XqQflbfazN3WgjPB6JpfwsFGT1eNZL
	8MmIaIu87GRZ9il4dbRRgrOxW4wBkHh2jXECseRuMxetz//slfYIKhwIjVVwG/ii27QNwi3PvJt4d
	Ijg4lLiQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lbd09-002qfD-Ba; Wed, 28 Apr 2021 05:44:45 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbcrP-002pcd-5A
 for linux-nvme@desiato.infradead.org; Wed, 28 Apr 2021 05:35:43 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=UeCIr8DSDVnmoOkJAJL6ynVN+LrIRuYu7j+WvElSXGo=; b=3W6ZXTXtp3Y05T9PqGJ7OF+c7Q
 wYiJ5hf4/dtuX9VSlSij8ujD43IvSWWz5Q0Q3lXs1tgDBJrjH5jGpYpvgxHtI3xiN+W4ZLj1QyL+i
 wdY5qk+S7jbXzl7TYwS/OBYTntNUFeu9Q6p5OjLvnQte3fwD9HA7Bk+UCk7BcfMj7DETYxKu5ZLO0
 B8CygsYy9HbaDojMKuSraKiRyd+ZoJa4E7IOaaq5qfPD9nKpihui6preeOXYaLcNZAnTVHhBhU7fx
 xLtycteUpQpFb08eN7a8clXGbIaeLVIQdfzKph31/IPQudf8LIEFVIaToV7ZdOfW6Tq9q4XkuHCgh
 3iFBY2xQ==;
Received: from saphodev.broadcom.com ([192.19.11.229]
 helo=relay.smtp-ext.broadcom.com)
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lbcrL-00HBjY-L9
 for linux-nvme@lists.infradead.org; Wed, 28 Apr 2021 05:35:41 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 271F530E76;
 Tue, 27 Apr 2021 22:27:37 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 271F530E76
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1619587660;
 bh=HEiE3XXPi0z8dQ9JWi3z+QWK3HQaKSSVHQD2Lu0RSy4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=k1FhSiGb8xnIAsM7k9U8uJdYcszxjS16aYZif1AK/yMBcaKTnIIVBcVUiAwLMovm0
 1hrDsxmiVhCorXaoQJz+9VKPsPLfzKTulzRIzJWdCFqL8CYGoWq+ulhUJXMWOT8hep
 2D/MCNLQSPk1yKFqDZdKU4j2fS1i9ocHXCBnfDPo=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v10 11/13] lpfc: vmid: Timeout implementation for vmid
Date: Wed, 28 Apr 2021 04:04:55 +0530
Message-Id: <1619562897-14062-12-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1619562897-14062-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210427_223540_288814_8EC95D83 
X-CRM114-Status: GOOD (  25.20  )
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

This patch implements the timeout functionality for the vmid. After the
set time period of inactivity, the vmid is deregistered from the switch.

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v10:
No change

v9:
Modified code for use of hashtable

v8:
Fixed the uninitialized variable

v7:
No change

v6:
Added Forward declarations

v5:
No change

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_hbadisc.c | 105 +++++++++++++++++++++++++++++++
 drivers/scsi/lpfc/lpfc_init.c    |  40 ++++++++++++
 2 files changed, 145 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_hbadisc.c b/drivers/scsi/lpfc/lpfc_hbadisc.c
index f5a898c2c904..7011fb5c08d1 100644
--- a/drivers/scsi/lpfc/lpfc_hbadisc.c
+++ b/drivers/scsi/lpfc/lpfc_hbadisc.c
@@ -72,6 +72,7 @@ static void lpfc_disc_flush_list(struct lpfc_vport *vport);
 static void lpfc_unregister_fcfi_cmpl(struct lpfc_hba *, LPFC_MBOXQ_t *);
 static int lpfc_fcf_inuse(struct lpfc_hba *);
 static void lpfc_mbx_cmpl_read_sparam(struct lpfc_hba *, LPFC_MBOXQ_t *);
+static void lpfc_check_inactive_vmid(struct lpfc_hba *phba);
 
 static int
 lpfc_valid_xpt_node(struct lpfc_nodelist *ndlp)
@@ -236,6 +237,110 @@ lpfc_dev_loss_tmo_callbk(struct fc_rport *rport)
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
+	u16 keep;
+	u32 difftime = 0, r, bucket;
+	u64 *lta;
+	int cpu;
+	struct lpfc_vmid *vmp;
+
+	write_lock(&vport->vmid_lock);
+
+	if (!vport->cur_vmid_cnt)
+		goto out;
+
+	/* iterate through the table */
+	hash_for_each(vport->hash_table, bucket, vmp, hnode) {
+		keep = 0;
+		if (vmp->flag & LPFC_VMID_REGISTERED) {
+			/* check if the particular vmid is in use */
+			/* for all available per cpu variable */
+			for_each_possible_cpu(cpu) {
+				/* if last access time is less than timeout */
+				lta = per_cpu_ptr(vmp->last_io_time, cpu);
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
+				vmp->flag = LPFC_VMID_DE_REGISTER;
+				write_unlock(&vport->vmid_lock);
+				if (vport->vmid_priority_tagging)
+					r = lpfc_vmid_uvem(vport, vmp, false);
+				else
+					r = lpfc_vmid_cmd(vport,
+							  SLI_CTAS_DAPP_IDENT,
+							  vmp);
+
+				/* decrement number of active vms and mark */
+				/* entry in slot as free */
+				write_lock(&vport->vmid_lock);
+				if (!r) {
+					struct lpfc_vmid *ht = vmp;
+
+					vport->cur_vmid_cnt--;
+					ht->flag = LPFC_VMID_SLOT_FREE;
+					free_percpu(ht->last_io_time);
+					ht->last_io_time = NULL;
+					hash_del(&ht->hnode);
+				}
+			}
+		}
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
+static void lpfc_check_inactive_vmid(struct lpfc_hba *phba)
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
index 3032ad094c00..69a8fe919b02 100644
--- a/drivers/scsi/lpfc/lpfc_init.c
+++ b/drivers/scsi/lpfc/lpfc_init.c
@@ -4852,6 +4852,42 @@ lpfc_sli4_fcf_redisc_wait_tmo(struct timer_list *t)
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
@@ -6700,6 +6736,10 @@ lpfc_sli4_driver_resource_setup(struct lpfc_hba *phba)
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
