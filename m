Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2ADC606A326
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=it4YqRgM;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=hlLC5qu8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=hgQyJUm3fD2hbrVKtDPbJw7PYul+RUHS+0oIlFRIqb8=; b=it4YqRgM00Rz0J
	gRbbMOsymPp2TeczIdjmKzP+EQgjhNUrKkkntA8GyBqHTtOKTYs10MhBg1G4dLmQah/9G0paj1dMX
	QK45p9A/C6Q41FqtRThn7zVUrDhRaVAJqApKtoOfHOt1nkaHA30H1XpGYEajq42iAwd7hPPVYMKxZ
	OIHQqxqKoqAdLxn54tuvLIp2679VBvOcWvFpwBbZ813ctPeJWJrvQ5em+7dEysjBpHit1oFVYwGsE
	NrP2lE99QC/63nsrA69JDOhIun52BRTNH79bQYxRvcm/+lw9vYwwLUCJjLYGa7VVuLgIqpDJzu96e
	9/Dz/fpH+jRcOG9XEstg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oe-0000000Gd2A-4AuP;
	Sun, 08 Nov 2026 20:48:41 +0000
Received: from out-210.mta0.migadu.com ([2001:41d0:1004:224b::d2] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oR-0000000GcPG-44K5
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:38 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=GyT5fWgsqH1g3ZJJxZVOHEbN4qoGZGT9aB6YYU68Beg=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170905; v=1; x=1794775705;
 b=hlLC5qu8chfob7N75gFTXP++Xc4//l+vg8qqxVP8QsxiGPT+E2p7Mf4zgqDrcrZzjezTUv7I
 BBFPEjg71FCprVtZFbjzGpeFxGT543yf3OOaIcLsr9RPcggLzcxnECz/sp2W1zt311vM0ztBlS8
 ANxUnMRqUXtCebswkY4QtxqU=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 6b66009fe5bd4c37;
	Sun, 08 Nov 2026 20:48:25 +0000
X-Mizu-Trace-ID: 6b66009fe5bd4c37
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
Subject: [PATCH v9 27/29] scsi: sd: add mpath_dev file
Date: Sun,  8 Nov 2026 20:47:31 +0000
Message-ID: <20261108204733.557995-28-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124828_208852_B9BF8AC3 
X-CRM114-Status: GOOD (  15.10  )
X-Spam-Score: -2.1 (--)
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

Add a mpath_dev file so that the multipath disk can be looked up from
per-path scsi_disk directory.

The following is an example of this usage:

$ ls -l /dev/sdc
brw-rw----    1 root     disk        8,  32 Feb 24 16:08 /dev/sdc
$ cat /sys/class/scsi_mpath_disk/scsi_mpath_disk0/sdc/multipath/sdc:0/mpath_dev
8:32

This can be used by a util like lsscsi, which would find that the gendisk
for the per-path scsi_disk is missing.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/sd.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 74 insertions(+), 1 deletion(-)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index ab4ce6c2a8dd..8469feb9ba5f 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4124,6 +4124,77 @@ static int sd_mpath_add_disk(struct scsi_disk *sdkp)
 	return 0;
 }
 
+static ssize_t sd_mpath_dev_show(struct device *dev,
+			struct device_attribute *attr, char *page)
+{
+	struct gendisk *gd = dev_to_disk(dev);
+	struct scsi_disk *sdkp = gd->private_data;
+	struct scsi_device *sdev = sdkp->device;
+	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;
+	struct scsi_mpath_head *scsi_mpath_head =
+				scsi_mpath_dev->scsi_mpath_head;
+	struct mpath_head *mpath_head = &scsi_mpath_head->mpath_head;
+	struct sd_mpath_disk *sd_mpath_disk;
+	struct gendisk *disk;
+	char devt_str[13];
+	ssize_t ret = -EINVAL;
+
+	/*
+	 * This attr is for the per-path scsi_disk block device. We need to
+	 * handle the scenario that the multipath disk has been deleted and
+	 * the per-path scsi_disk (and its attr files) is still present.
+	 */
+	mutex_lock(&sd_mpath_disks_lock);
+	sd_mpath_disk = sd_mpath_find_disk(scsi_mpath_head);
+	if (!sd_mpath_disk)
+		goto out_unlock;
+	if (!sd_mpath_disk->disk_count)
+		goto out_put_disk;
+
+	disk = mpath_head->disk;
+	/* A reference to this disk is held through sd_mpath_disk */
+	if (!disk || !test_bit(GD_ADDED, &disk->state))
+		goto out_put_disk;
+	format_dev_t(devt_str, disk_to_dev(disk)->devt);
+	ret = sysfs_emit(page, "%s\n", devt_str);
+out_put_disk:
+	sd_mpath_put_disk(sd_mpath_disk);
+out_unlock:
+	mutex_unlock(&sd_mpath_disks_lock);
+	return ret;
+}
+static DEVICE_ATTR(mpath_dev, 0444, sd_mpath_dev_show, NULL);
+
+static struct attribute *sd_mpath_dev_attrs[] = {
+	&dev_attr_mpath_dev.attr,
+	NULL
+};
+
+static umode_t sd_mpath_dev_attr_is_visible(struct kobject *kobj,
+				struct attribute *attr, int i)
+{
+	struct device *dev = kobj_to_dev(kobj);
+	struct gendisk *gd = dev_to_disk(dev);
+	struct scsi_disk *sdkp = gd->private_data;
+	struct scsi_device *sdev = sdkp->device;
+	struct scsi_mpath_device *scsi_mpath_device = sdev->scsi_mpath_dev;
+
+	if (!scsi_mpath_device)
+		return 0;
+
+	return attr->mode;
+}
+
+static const struct attribute_group sd_mpath_dev_attr_group = {
+	.is_visible = sd_mpath_dev_attr_is_visible,
+	.attrs = sd_mpath_dev_attrs,
+};
+
+static const struct attribute_group *sd_mpath_dev_groups[] = {
+	&sd_mpath_dev_attr_group,
+	NULL
+};
+
 static ssize_t sd_mpath_device_delayed_removal_store(struct device *dev,
 		struct device_attribute *attr, const char *buf, size_t count)
 {
@@ -4405,6 +4476,8 @@ static int sd_mpath_add_disk(struct scsi_disk *sdkp)
 {
 	return 0;
 }
+
+#define sd_mpath_dev_groups NULL
 #endif
 
 /**
@@ -4557,7 +4630,7 @@ static int sd_probe(struct scsi_device *sdp)
 			sdp->host->rpm_autosuspend_delay);
 	}
 
-	error = device_add_disk(dev, gd, NULL);
+	error = device_add_disk(dev, gd, sd_mpath_dev_groups);
 	if (error) {
 		sd_mpath_fail_probe(sdkp);
 		device_unregister(&sdkp->disk_dev);
-- 
2.43.0


