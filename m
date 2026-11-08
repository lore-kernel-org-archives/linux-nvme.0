Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E8F606A33C
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=XmrscOF6;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=bdtTPFtm
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=3brYAxqIKs7hzrh5Z8CcY1cxO1lYTUq1vxhAu2CJUaQ=; b=XmrscOF6TVwjuH
	+Hp4A3t151HAtpdMxvtP6yjwe48CfH9swXOoTTlBos7ExtjNczwiVhI5OG3eaHWfsrMnFiqTySAZh
	jjVUGtGl1UTuXaqKcI97hE2EpoykGyr985P9juRgT0kVSHA8W7WqYHEu5LH/XVsadms9WhFg2JqCt
	orP4aOqEnnhEDrySfCq2hDkmSxIIYTeUpxSC7EM17R97cxEKiR7FGICu97fDj3zkFrId9InA9GhLb
	6dhSd2vIILgR7YwGTx74pfXHxfuzR/jrmaFDKxuExz6GAcQgLYuNTJjrq2tPi0MLpk19MsnGAXNbX
	n3+gZcaoeO2slb+FinkQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oK-0000000GcCR-17NB;
	Sun, 08 Nov 2026 20:48:20 +0000
Received: from out-90.mta1.migadu.com ([95.215.58.90] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oD-0000000Gbzw-3pem
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:18 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=+gVCO9skWtYMC8Y5tChRIvZEelk+iMaAj3nXdgDCfX0=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170892; v=1; x=1794775692;
 b=bdtTPFtmaQBoQc1uVTZP3uF4O1iJWkqOMSHqib07z0doZwSzLtHQD/fD8ikYAAmQjJt4w8io
 isuNHqUxyxsT8IVadOmZTNDidMTSC0+s9fbIlr5v6AulbgvVzNXQGbxHpLguIqLeGDE4SJRhIRG
 xrh/nT7UWSZ/3++8RJ/sba7s=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id fa92a12345c98661;
	Sun, 08 Nov 2026 20:48:12 +0000
X-Mizu-Trace-ID: fa92a12345c98661
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
	John Garry <john.garry@linux.dev>,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH v9 14/29] scsi-multipath: provide sysfs link from to scsi_device
Date: Sun,  8 Nov 2026 20:47:18 +0000
Message-ID: <20261108204733.557995-15-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124816_299601_1C663F77 
X-CRM114-Status: GOOD (  12.80  )
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

Provide a link in sysfs from a scsi_mpath_device to member scsi_device's.

An example is as follows:
# ls -l /sys/class/scsi_mpath_device/scsi_mpath_device0/multipath/
total 0
lrwxrwxrwx    1 root     root             0 Feb 24 12:01 8:0:0:0 -> ../../../../platform/host8/session1/target8:0:0/8:0:0:0
lrwxrwxrwx    1 root     root             0 Feb 24 12:01 9:0:0:0 -> ../../../../platform/host9/session2/target9:0:0/9:0:0:0

Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_multipath.c | 43 +++++++++++++++++++++++++++++++++++
 drivers/scsi/scsi_sysfs.c     |  5 ++++
 include/scsi/scsi_multipath.h |  8 +++++++
 3 files changed, 56 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 625a72cb73c3..092975e0aca1 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -116,11 +116,54 @@ static bool scsi_multipath_sysfs_group_visible(struct kobject *kobj)
 }
 DEFINE_SIMPLE_SYSFS_GROUP_VISIBLE(scsi_multipath_sysfs)
 
+static struct attribute dummy_attr = {
+	.name = "dummy",
+};
+
+static struct attribute *scsi_mpath_attrs[] = {
+	&dummy_attr,
+	NULL
+};
+
+static const struct attribute_group scsi_mpath_attr_group = {
+	.name           = "multipath",
+	.attrs		= scsi_mpath_attrs,
+	.is_visible     = SYSFS_GROUP_VISIBLE(scsi_multipath_sysfs),
+};
+
 static const struct attribute_group *scsi_mpath_device_groups[] = {
 	&scsi_mpath_device_attrs_group,
+	&scsi_mpath_attr_group,
 	NULL
 };
 
+void scsi_mpath_add_sysfs_link(struct scsi_device *sdev)
+{
+	struct device *target = &sdev->sdev_gendev;
+	struct scsi_mpath_head *scsi_mpath_head =
+		sdev->scsi_mpath_dev->scsi_mpath_head;
+	struct device *source = &scsi_mpath_head->dev;
+	int error;
+
+	error = sysfs_add_link_to_group(&source->kobj, "multipath",
+			&target->kobj, dev_name(target));
+	if (error) {
+		sdev_printk(KERN_INFO, sdev, "Failed to create mpath sysfs link, error=%d\n",
+				    error);
+	}
+}
+
+void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev)
+{
+	struct device *target = &sdev->sdev_gendev;
+	struct scsi_mpath_head *scsi_mpath_head =
+		sdev->scsi_mpath_dev->scsi_mpath_head;
+	struct device *source = &scsi_mpath_head->dev;
+
+	sysfs_remove_link_from_group(&source->kobj, "multipath",
+		dev_name(target));
+}
+
 static const struct class scsi_mpath_device_class = {
 	.name = "scsi_mpath_device",
 	.dev_groups = scsi_mpath_device_groups,
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 5b5de5806385..b5d12b694396 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -1444,6 +1444,9 @@ int scsi_sysfs_add_sdev(struct scsi_device *sdev)
 	transport_add_device(&sdev->sdev_gendev);
 	sdev->is_visible = 1;
 
+	if (sdev->scsi_mpath_dev)
+		scsi_mpath_add_sysfs_link(sdev);
+
 	if (IS_ENABLED(CONFIG_BLK_DEV_BSG)) {
 		sdev->bsg_dev = scsi_bsg_register_queue(sdev);
 		if (IS_ERR(sdev->bsg_dev)) {
@@ -1496,6 +1499,8 @@ void __scsi_remove_device(struct scsi_device *sdev)
 
 		if (IS_ENABLED(CONFIG_BLK_DEV_BSG) && sdev->bsg_dev)
 			bsg_unregister_queue(sdev->bsg_dev);
+		if (sdev->scsi_mpath_dev)
+			scsi_mpath_remove_sysfs_link(sdev);
 		device_unregister(&sdev->sdev_dev);
 		transport_remove_device(dev);
 		device_del(dev);
diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
index 50d422798d83..d224a15ce9c2 100644
--- a/include/scsi/scsi_multipath.h
+++ b/include/scsi/scsi_multipath.h
@@ -49,6 +49,8 @@ void scsi_mpath_remove_device(struct scsi_mpath_device *scsi_mpath_dev);
 void scsi_mpath_get_head(struct scsi_mpath_head *scsi_mpath_head);
 int scsi_mpath_try_get_head(struct scsi_mpath_head *scsi_mpath_head);
 void scsi_mpath_put_head(struct scsi_mpath_head *scsi_mpath_head);
+void scsi_mpath_add_sysfs_link(struct scsi_device *sdev);
+void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev);
 #else /* CONFIG_SCSI_MULTIPATH */
 
 struct scsi_mpath_head {
@@ -87,5 +89,11 @@ static inline
 void scsi_mpath_put_head(struct scsi_mpath_head *scsi_mpath_head)
 {
 }
+static inline void scsi_mpath_add_sysfs_link(struct scsi_device *sdev)
+{
+}
+static inline void scsi_mpath_remove_sysfs_link(struct scsi_device *sdev)
+{
+}
 #endif /* CONFIG_SCSI_MULTIPATH */
 #endif /* _SCSI_SCSI_MULTIPATH_H */
-- 
2.43.0


