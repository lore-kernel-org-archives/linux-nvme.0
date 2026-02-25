Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8ED7FD376A
	for <linux-nvme@archiver.kernel.org>; Wed, 25 Feb 2026 16:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:Date
	:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JstW4CsGx3nvh8BHD4J/2v6QO9Ow8LLoVZjyVIADmFI=; b=neqkn6yYZISIoNFyVtGAd3KK4c
	HMAn8ye2t0avrlCzmepqZZ3uRfCrz/HheGNE9CngwKhvSBsYG1Fo+cFt2NlDmTX//bF1drJpdwu5D
	Lm+pwR6GrLzyI6SW3Gt4tupPmt+4HP+nV8L814DFPYHkEtjXc74cO2oKWvbHQNlvVSfvkbLwlwUuO
	avhD1t9afTqs8zVCjVlw5ARP2g6my3UyPOfqamFcSVLuYvKv/oWI9QMj7D0FYcuGDQvZO3OoUMN9b
	aqE7cKlX7EbWmEBMnoI7ey2TF1z4Ho8asP775UDNCsFuQqBE/cHazKUZJBi6suU8srHCuobZOP0We
	8zhi0glw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHV1-00000004SuW-3zIb;
	Wed, 25 Feb 2026 16:12:31 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vvHUy-00000004SrI-33hg
	for linux-nvme@lists.infradead.org;
	Wed, 25 Feb 2026 16:12:30 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1772035947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JstW4CsGx3nvh8BHD4J/2v6QO9Ow8LLoVZjyVIADmFI=;
	b=GN58T9lvTQDsDi4xU8zXNz9CCZm6yaU+x/7bfD7J73HzujR/KaJB/84wenDUEdFDgortkY
	ZJxNRDNGtgpvLnZ1uGds3Mr2VdckTIsUnfNYAZ7+m9Bq3rTfSC4u/BZk7mE0vYjSFMyklI
	U1xSs/e+t3P4EwqY2fGaOXge9itKLqw=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-605-SjQ3nlA-NC6E1NqEeRcA5A-1; Wed,
 25 Feb 2026 11:12:26 -0500
X-MC-Unique: SjQ3nlA-NC6E1NqEeRcA5A-1
X-Mimecast-MFC-AGG-ID: SjQ3nlA-NC6E1NqEeRcA5A_1772035945
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id DBEF01956095;
	Wed, 25 Feb 2026 16:12:24 +0000 (UTC)
Received: from mlombard-thinkpadt14gen4.rmtit.csb (unknown [10.44.32.217])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id BF4C61800370;
	Wed, 25 Feb 2026 16:12:20 +0000 (UTC)
From: Maurizio Lombardi <mlombard@redhat.com>
To: kbusch@kernel.org
Cc: hch@lst.de,
	hare@suse.de,
	chaitanyak@nvidia.com,
	bvanassche@acm.org,
	linux-scsi@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	James.Bottomley@HansenPartnership.com,
	mlombard@arkamax.eu,
	jmeneghi@redhat.com,
	emilne@redhat.com,
	bgurney@redhat.com
Subject: [PATCH V3 3/3] scsi: Convert async scanning to use the completion chain helper
Date: Wed, 25 Feb 2026 17:12:03 +0100
Message-ID: <20260225161203.76168-4-mlombard@redhat.com>
In-Reply-To: <20260225161203.76168-1-mlombard@redhat.com>
References: <20260225161203.76168-1-mlombard@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 95PnQd1P0DcLFBv5HDjxzL3wf1hq8r1SAMDN736dc_Y_1772035945
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260225_081228_962786_2DAA0BDC 
X-CRM114-Status: GOOD (  17.79  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The asynchronous host scanning logic in scsi_scan.c uses a custom,
open-coded implementation to serialize scans. This involves a manually
managed list of tasks, each with its own completion, to ensure that hosts
are scanned and added to the system in a deterministic order.

Refactors the SCSI async scanning implementation to use the new compl_chain
helper. This simplifies the scsi_scan.c code and makes the serialization
logic more readable.

Signed-off-by: Maurizio Lombardi <mlombard@redhat.com>
---
 drivers/scsi/scsi_priv.h |  2 +-
 drivers/scsi/scsi_scan.c | 68 +++++-----------------------------------
 2 files changed, 9 insertions(+), 61 deletions(-)

diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 7a193cc04e5b..274fdd7edac4 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -132,7 +132,7 @@ extern void scsi_exit_procfs(void);
 
 /* scsi_scan.c */
 void scsi_enable_async_suspend(struct device *dev);
-extern int scsi_complete_async_scans(void);
+void scsi_complete_async_scans(void);
 extern int scsi_scan_host_selected(struct Scsi_Host *, unsigned int,
 				   unsigned int, u64, enum scsi_scan_mode);
 extern void scsi_forget_host(struct Scsi_Host *);
diff --git a/drivers/scsi/scsi_scan.c b/drivers/scsi/scsi_scan.c
index 60c06fa4ec32..f19f2c73f042 100644
--- a/drivers/scsi/scsi_scan.c
+++ b/drivers/scsi/scsi_scan.c
@@ -36,6 +36,7 @@
 #include <linux/async.h>
 #include <linux/slab.h>
 #include <linux/unaligned.h>
+#include <linux/compl_chain.h>
 
 #include <scsi/scsi.h>
 #include <scsi/scsi_cmnd.h>
@@ -112,14 +113,11 @@ MODULE_PARM_DESC(inq_timeout,
 		 "Timeout (in seconds) waiting for devices to answer INQUIRY."
 		 " Default is 20. Some devices may need more; most need less.");
 
-/* This lock protects only this list */
-static DEFINE_SPINLOCK(async_scan_lock);
-static LIST_HEAD(scanning_hosts);
+static DEFINE_COMPL_CHAIN(scanning_hosts);
 
 struct async_scan_data {
-	struct list_head list;
+	struct compl_chain_entry chain_entry;
 	struct Scsi_Host *shost;
-	struct completion prev_finished;
 };
 
 /*
@@ -146,48 +144,10 @@ void scsi_enable_async_suspend(struct device *dev)
  * started scanning after this function was called may or may not have
  * finished.
  */
-int scsi_complete_async_scans(void)
+void scsi_complete_async_scans(void)
 {
-	struct async_scan_data *data;
-
-	do {
-		scoped_guard(spinlock, &async_scan_lock)
-			if (list_empty(&scanning_hosts))
-				return 0;
-		/* If we can't get memory immediately, that's OK.  Just
-		 * sleep a little.  Even if we never get memory, the async
-		 * scans will finish eventually.
-		 */
-		data = kmalloc(sizeof(*data), GFP_KERNEL);
-		if (!data)
-			msleep(1);
-	} while (!data);
-
-	data->shost = NULL;
-	init_completion(&data->prev_finished);
-
-	spin_lock(&async_scan_lock);
-	/* Check that there's still somebody else on the list */
-	if (list_empty(&scanning_hosts))
-		goto done;
-	list_add_tail(&data->list, &scanning_hosts);
-	spin_unlock(&async_scan_lock);
-
 	printk(KERN_INFO "scsi: waiting for bus probes to complete ...\n");
-	wait_for_completion(&data->prev_finished);
-
-	spin_lock(&async_scan_lock);
-	list_del(&data->list);
-	if (!list_empty(&scanning_hosts)) {
-		struct async_scan_data *next = list_entry(scanning_hosts.next,
-				struct async_scan_data, list);
-		complete(&next->prev_finished);
-	}
- done:
-	spin_unlock(&async_scan_lock);
-
-	kfree(data);
-	return 0;
+	compl_chain_flush(&scanning_hosts);
 }
 
 /**
@@ -1960,18 +1920,13 @@ static struct async_scan_data *scsi_prep_async_scan(struct Scsi_Host *shost)
 	data->shost = scsi_host_get(shost);
 	if (!data->shost)
 		goto err;
-	init_completion(&data->prev_finished);
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	shost->async_scan = 1;
 	spin_unlock_irqrestore(shost->host_lock, flags);
 	mutex_unlock(&shost->scan_mutex);
 
-	spin_lock(&async_scan_lock);
-	if (list_empty(&scanning_hosts))
-		complete(&data->prev_finished);
-	list_add_tail(&data->list, &scanning_hosts);
-	spin_unlock(&async_scan_lock);
+	compl_chain_add(&scanning_hosts, &data->chain_entry);
 
 	return data;
 
@@ -2008,7 +1963,7 @@ static void scsi_finish_async_scan(struct async_scan_data *data)
 		return;
 	}
 
-	wait_for_completion(&data->prev_finished);
+	compl_chain_wait(&data->chain_entry);
 
 	scsi_sysfs_add_devices(shost);
 
@@ -2018,14 +1973,7 @@ static void scsi_finish_async_scan(struct async_scan_data *data)
 
 	mutex_unlock(&shost->scan_mutex);
 
-	spin_lock(&async_scan_lock);
-	list_del(&data->list);
-	if (!list_empty(&scanning_hosts)) {
-		struct async_scan_data *next = list_entry(scanning_hosts.next,
-				struct async_scan_data, list);
-		complete(&next->prev_finished);
-	}
-	spin_unlock(&async_scan_lock);
+	compl_chain_complete(&data->chain_entry);
 
 	scsi_autopm_put_host(shost);
 	scsi_host_put(shost);
-- 
2.53.0


