Return-Path: <SRS0=pbEM=JE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DATE_IN_PAST_06_12,
	DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 839CBC433ED
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 06:10:42 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0D5B560FE9
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Apr 2021 06:10:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0D5B560FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:MIME-Version:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:Cc:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=SYgduVY3kzfObplg3Ovf0DkuYXRB7SN7GtebwHX3lN4=; b=jhMRwlOb6x7AI8MKYO80VurAqJ
	RR/xd0It30Lke87xlvp+4Rda/MXVLFZKtWLT2aTsP8lapO5g3Cv0HgNEfsROL++sQCau89qFHJBpD
	Y/cjLlHGt4nJtN1yq0+IdwT6EimjuCfiatw8YovBSBmCIz4o6N1A4mWM+iNuWjlYsGsHXzvyilfcv
	rXLxir3fZKK8KdxE6OP82k1GBps/hAsCKj4yDS0Tyl8B8qfogpupSUSQt7VxhbLnpLg2bcpEkwcsC
	jJmzjUvffc3bjIBl/JK8lEsJbNpHioRk70Mj0FrEG4nqWBsMYZ6GGSqF1wt4J3XJ8hOY5JM+wJ/XC
	N2HnNaRw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lU1OT-004BWL-HU; Wed, 07 Apr 2021 06:10:25 +0000
Received: from relay.smtp-ext.broadcom.com ([192.19.232.172])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lU1Ly-004BAl-SJ
 for linux-nvme@lists.infradead.org; Wed, 07 Apr 2021 06:08:01 +0000
Received: from localhost.localdomain (unknown [10.157.2.20])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by relay.smtp-ext.broadcom.com (Postfix) with ESMTPS id 906502259D;
 Tue,  6 Apr 2021 22:59:16 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 relay.smtp-ext.broadcom.com 906502259D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=broadcom.com;
 s=dkimrelay; t=1617775158;
 bh=4C5IS2e0KQPiF5oEYpi3DaAz2UMy5ixyX4Vr0W/oL/4=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=OrfrIzzisZrut1qBneaVn4lxhZlNUC6Gh4l4hNZy7HMV9SqgmUc0vXQjQ2PlwjEo6
 hYinsaEkoIr3i+V/sWDahLdd78Tl99GHMsXInC+m8yNjkLd3tzcuGWM5luNMywWMZm
 72nZQJwadZ/OnvZ7u9Bt4Idjy6FROR+bWg4kyhgE=
From: Muneendra <muneendra.kumar@broadcom.com>
To: linux-block@vger.kernel.org, linux-scsi@vger.kernel.org, tj@kernel.org,
 linux-nvme@lists.infradead.org, hare@suse.de
Cc: jsmart2021@gmail.com, emilne@redhat.com, mkumar@redhat.com,
 Gaurav Srivastava <gaurav.srivastava@broadcom.com>
Subject: [PATCH v9 08/13] lpfc: vmid: Functions to manage vmids
Date: Wed,  7 Apr 2021 04:36:32 +0530
Message-Id: <1617750397-26466-9-git-send-email-muneendra.kumar@broadcom.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
References: <1617750397-26466-1-git-send-email-muneendra.kumar@broadcom.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210407_070752_876661_9ACCA910 
X-CRM114-Status: GOOD (  22.48  )
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

This patch contains the routines to save, retrieve and remove the vmids
from the data structure. A hash table is used to save the vmids and
the corresponding UUIDs associated with the application/VMs.

Signed-off-by: Gaurav Srivastava  <gaurav.srivastava@broadcom.com>
Signed-off-by: James Smart <jsmart2021@gmail.com>

---
v9:
Added changes for implementing kernel based hashtable

v8:
Added correct return value and error codes

v7:
No change

v6:
Added Forward declarations and functions to static

v5:
Changed Return code to non-numeric/Symbol

v4:
No change

v3:
No change

v2:
Ported the patch on top of 5.10/scsi-queue
---
 drivers/scsi/lpfc/lpfc_scsi.c | 118 ++++++++++++++++++++++++++++++++++
 1 file changed, 118 insertions(+)

diff --git a/drivers/scsi/lpfc/lpfc_scsi.c b/drivers/scsi/lpfc/lpfc_scsi.c
index 0868cb38d5b0..f81178464436 100644
--- a/drivers/scsi/lpfc/lpfc_scsi.c
+++ b/drivers/scsi/lpfc/lpfc_scsi.c
@@ -28,6 +28,7 @@
 #include <asm/unaligned.h>
 #include <linux/t10-pi.h>
 #include <linux/crc-t10dif.h>
+#include <linux/blk-cgroup.h>
 #include <net/checksum.h>
 
 #include <scsi/scsi.h>
@@ -86,6 +87,14 @@ static void
 lpfc_release_scsi_buf_s3(struct lpfc_hba *phba, struct lpfc_io_buf *psb);
 static int
 lpfc_prot_group_type(struct lpfc_hba *phba, struct scsi_cmnd *sc);
+static void
+lpfc_put_vmid_in_hashtable(struct lpfc_vport *vport, u32 hash,
+			   struct lpfc_vmid *vmp);
+static void lpfc_vmid_update_entry(struct lpfc_vport *vport, struct scsi_cmnd
+				   *cmd, struct lpfc_vmid *vmp,
+				   union lpfc_vmid_io_tag *tag);
+static void lpfc_vmid_assign_cs_ctl(struct lpfc_vport *vport,
+				    struct lpfc_vmid *vmid);
 
 static inline unsigned
 lpfc_cmd_blksize(struct scsi_cmnd *sc)
@@ -5145,6 +5154,115 @@ void lpfc_poll_timeout(struct timer_list *t)
 	}
 }
 
+/*
+ * lpfc_get_vmid_from_hastable - search the UUID in the hash table
+ * @vport: The virtual port for which this call is being executed.
+ * @hash: calculated hash value
+ * @buf: uuid associated with the VE
+ * Returns the vmid entry associated with the UUID
+ * Make sure to acquire the appropriate lock before invoking this routine.
+ */
+struct lpfc_vmid *lpfc_get_vmid_from_hastable(struct lpfc_vport *vport,
+					      u32 hash, u8 *buf)
+{
+	struct lpfc_vmid *vmp;
+
+	hash_for_each_possible(vport->hash_table, vmp, hnode, hash) {
+		if (memcmp(&vmp->host_vmid[0], buf, 16) == 0)
+			return vmp;
+	}
+	return NULL;
+}
+
+/*
+ * lpfc_put_vmid_from_hastable - put the VMID in the hash table
+ * @vport: The virtual port for which this call is being executed.
+ * @hash - calculated hash value
+ * @vmp: Pointer to a VMID entry representing a VM sending IO
+ *
+ * This routine will insert the newly acquired vmid entity in the hash table.
+ * Make sure to acquire the appropriate lock before invoking this routine.
+ */
+static void
+lpfc_put_vmid_in_hashtable(struct lpfc_vport *vport, u32 hash,
+			   struct lpfc_vmid *vmp)
+{
+	hash_add(vport->hash_table, &vmp->hnode, hash);
+}
+
+/*
+ * lpfc_vmid_hash_fn - creates a hash value of the UUID
+ * @vmid: uuid associated with the VE
+ * @len: length of the vmid string
+ * Returns the calculated hash value
+ */
+int lpfc_vmid_hash_fn(const char *vmid, int len)
+{
+	int c;
+	int hash = 0;
+
+	if (len == 0)
+		return 0;
+	while (len--) {
+		c = *vmid++;
+		if (c >= 'A' && c <= 'Z')
+			c += 'a' - 'A';
+
+		hash = (hash + (c << LPFC_VMID_HASH_SHIFT) +
+			(c >> LPFC_VMID_HASH_SHIFT)) * 19;
+	}
+
+	return hash & LPFC_VMID_HASH_MASK;
+}
+
+/*
+ * lpfc_vmid_update_entry - update the vmid entry in the hash table
+ * @vport: The virtual port for which this call is being executed.
+ * @cmd: address of scsi cmmd descriptor
+ * @vmp: Pointer to a VMID entry representing a VM sending IO
+ * @tag: VMID tag
+ */
+static void lpfc_vmid_update_entry(struct lpfc_vport *vport, struct scsi_cmnd
+				   *cmd, struct lpfc_vmid *vmp,
+				   union lpfc_vmid_io_tag *tag)
+{
+	u64 *lta;
+
+	if (vport->vmid_priority_tagging)
+		tag->cs_ctl_vmid = vmp->un.cs_ctl_vmid;
+	else
+		tag->app_id = vmp->un.app_id;
+
+	if (cmd->sc_data_direction == DMA_TO_DEVICE)
+		vmp->io_wr_cnt++;
+	else
+		vmp->io_rd_cnt++;
+
+	/* update the last access timestamp in the table */
+	lta = per_cpu_ptr(vmp->last_io_time, raw_smp_processor_id());
+	*lta = jiffies;
+}
+
+static void lpfc_vmid_assign_cs_ctl(struct lpfc_vport *vport,
+				    struct lpfc_vmid *vmid)
+{
+	u32 hash;
+	struct lpfc_vmid *pvmid;
+
+	if (vport->port_type == LPFC_PHYSICAL_PORT) {
+		vmid->un.cs_ctl_vmid = lpfc_vmid_get_cs_ctl(vport);
+	} else {
+		hash = lpfc_vmid_hash_fn(vmid->host_vmid, vmid->vmid_len);
+		pvmid =
+		    lpfc_get_vmid_from_hastable(vport->phba->pport, hash,
+						vmid->host_vmid);
+		if (pvmid)
+			vmid->un.cs_ctl_vmid = pvmid->un.cs_ctl_vmid;
+		else
+			vmid->un.cs_ctl_vmid = lpfc_vmid_get_cs_ctl(vport);
+	}
+}
+
 /**
  * lpfc_queuecommand - scsi_host_template queuecommand entry point
  * @shost: kernel scsi host pointer.
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
