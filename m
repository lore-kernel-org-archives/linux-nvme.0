Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09184606A33B
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=lmUUJ9Fp;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=b8nc4Xfa
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=QlNI+CS9C292zxh1KVBjnCmUthmZFrW3aFe7rlr3lPo=; b=lmUUJ9FpR4WPRh
	xKnBnruP/SBqPjvHKGEjq8Usa426Iom9EBq5brSQhAC34GWZI+4og1i7YB9NAx5TXtsMniZpFU645
	JJ7rb6Q+eOfH+fSAbzkDfy6yveh3XNI16DaYjj6c0N3pJopFnO5nYg0Td+0/skxH41+/xI/rbW8hV
	ACpbQl71SxaT4rFgOdJFvgIgFelZWs5CKlvpKDkNUAB38W8smJxe/fkYlBFCEbRDc/GP3cMsR9owd
	c33YsZf7E/lHCN5c/he7RV0YMLMu8DZbDuHIaJW9X2zdWWCcVg/2F2xqVL03fQ46gDgL0t8QlPTbg
	kA02knpwQFf40tPLhqZA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oW-0000000GcfZ-0y8m;
	Sun, 08 Nov 2026 20:48:32 +0000
Received: from out-150.mta1.migadu.com ([95.215.58.150] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oO-0000000GcK3-3DS4
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:30 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=zGxGuv8VhmxQDKGvPD7JkzGiFLkWBpRa5MQ8Ta/vS5c=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170903; v=1; x=1794775703;
 b=b8nc4XfaD2zE8DbGFCdftnKpnKM79s1S1LWN1bvT46Gm6nplIK0R0f26Ib5DDNUnwSM9LzU7
 J84CXShAQEfKd4JRGR3wPiYfdbeoyYDXAf0Ljg49034WfWhOPAsTWDNPnwz+64gfDXZSMtxeX6p
 7TChOIlUVIEP2oFHniESBnYo=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 3caf6acd72947ce7;
	Sun, 08 Nov 2026 20:48:23 +0000
X-Mizu-Trace-ID: 3caf6acd72947ce7
X-Migadu-Flow: FLOW_OUT
From: John Garry <john.garry@linux.dev>
To: james.bottomley@hansenpartnership.com,
	mkp@kernel.org
Cc: hare@suse.com,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	snitzer@kernel.org,
	jmeneghi@redhat.com,
	bmarzins@redhat.com,
	dm-devel@lists.linux.dev,
	hch@lst.de,
	michael.christie@oracle.com,
	John Garry <john.garry@linux.dev>
Subject: [PATCH v9 24/29] scsi: sd: add multipath disk class
Date: Sun,  8 Nov 2026 20:47:28 +0000
Message-ID: <20261108204733.557995-25-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124825_031197_4E30712D 
X-CRM114-Status: GOOD (  16.52  )
X-Spam-Score: -2.8 (--)
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Add a new class, sd_mpath_disk_class, which is the multipath version of
the scsi_disk class.

Structure sd_mpath_disk is introduced to manage the multipath gendisk.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/sd.c | 43 ++++++++++++++++++++++++++++++++++++++++++-
 drivers/scsi/sd.h |  3 +++
 2 files changed, 45 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index dc45df819c42..03617029a552 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -70,6 +70,7 @@
 #include <scsi/scsi_ioctl.h>
 #include <scsi/scsicam.h>
 #include <scsi/scsi_common.h>
+#include <scsi/scsi_multipath.h>
 
 #include "sd.h"
 #include "scsi_priv.h"
@@ -113,6 +114,39 @@ static mempool_t *sd_page_pool;
 static mempool_t *sd_large_page_pool;
 static atomic_t sd_large_page_pool_users = ATOMIC_INIT(0);
 static struct lock_class_key sd_bio_compl_lkclass;
+#ifdef CONFIG_SCSI_MULTIPATH
+struct sd_mpath_disk {
+	struct scsi_mpath_head		*scsi_mpath_head;
+};
+
+static void sd_mpath_disk_release(struct device *dev)
+{
+}
+
+static const struct class sd_mpath_disk_class = {
+	.name = "scsi_mpath_disk",
+	.dev_release = sd_mpath_disk_release,
+};
+
+static int sd_mpath_class_register(void)
+{
+	return class_register(&sd_mpath_disk_class);
+}
+
+static void sd_mpath_class_unregister(void)
+{
+	class_unregister(&sd_mpath_disk_class);
+}
+#else /* CONFIG_SCSI_MULTIPATH */
+static int sd_mpath_class_register(void)
+{
+	return 0;
+}
+
+static void sd_mpath_class_unregister(void)
+{
+}
+#endif
 
 static const char *sd_cache_types[] = {
 	"write through", "none", "write back",
@@ -4474,11 +4508,15 @@ static int __init init_sd(void)
 	if (err)
 		goto err_out;
 
+	err = sd_mpath_class_register();
+	if (err)
+		goto err_out_class;
+
 	sd_page_pool = mempool_create_page_pool(SD_MEMPOOL_SIZE, 0);
 	if (!sd_page_pool) {
 		printk(KERN_ERR "sd: can't init discard page pool\n");
 		err = -ENOMEM;
-		goto err_out_class;
+		goto err_out_mpath_class;
 	}
 
 	err = scsi_register_driver(&sd_template);
@@ -4489,6 +4527,8 @@ static int __init init_sd(void)
 
 err_out_driver:
 	mempool_destroy(sd_page_pool);
+err_out_mpath_class:
+	sd_mpath_class_unregister();
 err_out_class:
 	class_unregister(&sd_disk_class);
 err_out:
@@ -4514,6 +4554,7 @@ static void __exit exit_sd(void)
 		mempool_destroy(sd_large_page_pool);
 
 	class_unregister(&sd_disk_class);
+	sd_mpath_class_unregister();
 
 	for (i = 0; i < SD_MAJORS; i++)
 		unregister_blkdev(sd_major(i), "sd");
diff --git a/drivers/scsi/sd.h b/drivers/scsi/sd.h
index 574af8243016..22438173ea2f 100644
--- a/drivers/scsi/sd.h
+++ b/drivers/scsi/sd.h
@@ -83,6 +83,9 @@ struct zoned_disk_info {
 
 struct scsi_disk {
 	struct scsi_device *device;
+#ifdef CONFIG_SCSI_MULTIPATH
+	struct sd_mpath_disk *sd_mpath_disk;
+#endif
 
 	/*
 	 * disk_dev is used to show attributes in /sys/class/scsi_disk/,
-- 
2.43.0


