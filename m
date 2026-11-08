Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F082606A320
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=zsXvu6oR;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=DgYpzd9k
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=YVm0hLTen/l7MjbTkGxRRCAEivtbhd4NAn6q7xWAEYg=; b=zsXvu6oRY2n0JE
	kP6qQyt31LlNCB+EpVoomrm+v4YaqKYEjwCI+PuSHkbDa3U+Mwb8ZvfjgqRaBm5PKzPdGv3WQ9ycb
	Yfz+PW2Ah6IlrEg/FCw+JI33X+M1FSQHthoUQOslwRSxhlzoy+pGo3LEZIKskzVZLQoaHx3QNOrUX
	TZ5F5jBwm6jLv5CzraJ4L47LC3GRTJzI/Tj0HZ/G4K0MxdunhYZseIVJcTCSeaW2N51Dd6nznILDX
	NCXCQbNCkMGTg8VmfWcfNYamviEHKg3ZXmKP/QnajCGMQHPYfKwm190B4G/O8aemro3Bq0AgjWUo4
	zBXVPoBDUVoGssid0FNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oK-0000000GcC2-0LRV;
	Sun, 08 Nov 2026 20:48:20 +0000
Received: from out-187.mta0.migadu.com ([2001:41d0:1004:224b::bb] helo=mta0.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oE-0000000Gc05-3rlQ
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:17 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=WSIUiiRUDwnbfq8m1M5V5dJ7+FsoCilapxmskdaABhM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170893; v=1; x=1794775693;
 b=DgYpzd9kCd3Sn+Kt3Bbl5berkg+7XYedvheSZ8rQAp4oo7XAEtIvOmNXOX9huTfNbMkFfUoN
 TBWqsIGXeu7JKy8dRAAMTNxcZrgE71JwKQhAs8nv7wiV6Eo2uZU2REhBcXGwxk+kzPwy6dkkLK7
 Ycw3qhIJkqYBjPkRlSpZSX84=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 512cbddf7a48e872;
	Sun, 08 Nov 2026 20:48:13 +0000
X-Mizu-Trace-ID: 512cbddf7a48e872
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
Subject: [PATCH v9 15/29] scsi-multipath: support iopolicy
Date: Sun,  8 Nov 2026 20:47:19 +0000
Message-ID: <20261108204733.557995-16-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124816_185128_59A05E33 
X-CRM114-Status: GOOD (  13.40  )
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

Add support to set the multipath iopolicy.

The iopolicy member is per scsi_mpath_head structure.

A module param is added so that the default iopolicy may be set.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/scsi_multipath.c | 52 +++++++++++++++++++++++++++++++++++
 include/scsi/scsi_multipath.h |  3 ++
 2 files changed, 55 insertions(+)

diff --git a/drivers/scsi/scsi_multipath.c b/drivers/scsi/scsi_multipath.c
index 092975e0aca1..baf4ca73f8c9 100644
--- a/drivers/scsi/scsi_multipath.c
+++ b/drivers/scsi/scsi_multipath.c
@@ -61,6 +61,23 @@ static const struct kernel_param_ops multipath_param_ops = {
 module_param_cb(multipath, &multipath_param_ops, &scsi_multipath, 0444);
 MODULE_PARM_DESC(multipath, "turn on native multipath support, options: on, off, always");
 
+static enum mpath_iopolicy_e iopolicy = MPATH_IOPOLICY_NUMA;
+
+static int scsi_mpath_set_iopolicy_param(const char *val, const struct kernel_param *kp)
+{
+	return mpath_set_iopolicy(val, &iopolicy);
+}
+
+static int scsi_mpath_get_iopolicy_param(char *buf, const struct kernel_param *kp)
+{
+	return mpath_get_iopolicy(buf, iopolicy);
+}
+
+module_param_call(multipath_iopolicy, scsi_mpath_set_iopolicy_param,
+		scsi_mpath_get_iopolicy_param, &iopolicy, 0644);
+MODULE_PARM_DESC(multipath_iopolicy,
+	"Default multipath I/O policy; 'numa' (default), 'round-robin' or 'queue-depth'");
+
 static int scsi_mpath_unique_lun_id(struct scsi_device *sdev)
 {
 	struct scsi_mpath_device *scsi_mpath_dev = sdev->scsi_mpath_dev;
@@ -101,8 +118,41 @@ static ssize_t scsi_mpath_device_vpd_id_show(struct device *dev,
 }
 static DEVICE_ATTR(vpd_id, S_IRUGO, scsi_mpath_device_vpd_id_show, NULL);
 
+static ssize_t scsi_mpath_device_iopolicy_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct scsi_mpath_head *scsi_mpath_head =
+		container_of(dev, struct scsi_mpath_head, dev);
+	struct mpath_head *mpath_head = &scsi_mpath_head->mpath_head;
+
+	if (!mpath_iopolicy_store(&scsi_mpath_head->iopolicy, buf))
+		return -EINVAL;
+
+	mpath_clear_paths(mpath_head);
+	mpath_schedule_requeue_work(mpath_head);
+	/*
+	 * Ensure requeue work completes, as this work could run later when
+	 * the mpath_head is gone.
+	 */
+	flush_work(&mpath_head->requeue_work);
+	return count;
+}
+
+static ssize_t scsi_mpath_device_iopolicy_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct scsi_mpath_head *scsi_mpath_head =
+		container_of(dev, struct scsi_mpath_head, dev);
+
+	return mpath_iopolicy_show(&scsi_mpath_head->iopolicy, buf);
+}
+
+static DEVICE_ATTR(iopolicy, S_IRUGO | S_IWUSR,
+		scsi_mpath_device_iopolicy_show, scsi_mpath_device_iopolicy_store);
+
 static struct attribute *scsi_mpath_device_attrs[] = {
 	&dev_attr_vpd_id.attr,
+	&dev_attr_iopolicy.attr,
 	NULL
 };
 
@@ -206,6 +256,8 @@ static struct scsi_mpath_head *scsi_mpath_alloc_head(char *vpd_id)
 	if (mpath_head_init(&scsi_mpath_head->mpath_head))
 		goto out_free;
 	scsi_mpath_head->mpath_head.mpdt = &smpdt;
+	scsi_mpath_head->iopolicy = iopolicy;
+	scsi_mpath_head->mpath_head.iopolicy = &scsi_mpath_head->iopolicy;
 
 	strscpy(scsi_mpath_head->vpd_id, vpd_id,
 		SCSI_MPATH_DEVICE_ID_LEN);
diff --git a/include/scsi/scsi_multipath.h b/include/scsi/scsi_multipath.h
index d224a15ce9c2..d6f290b84f7f 100644
--- a/include/scsi/scsi_multipath.h
+++ b/include/scsi/scsi_multipath.h
@@ -25,6 +25,7 @@ struct scsi_mpath_head {
 	struct list_head	entry;
 	struct ida		ida;
 	struct kref		ref;
+	enum mpath_iopolicy_e	iopolicy;
 	struct device		dev;
 	int			index;
 };
@@ -40,6 +41,8 @@ struct scsi_mpath_device {
 
 #define to_scsi_mpath_device(d) \
 	container_of(d, struct scsi_mpath_device, mpath_device)
+#define to_scsi_mpath_head(d) \
+	container_of(d, struct scsi_mpath_head, mpath_head)
 
 int scsi_mpath_dev_alloc(struct scsi_device *sdev);
 void scsi_mpath_dev_release(struct scsi_device *sdev);
-- 
2.43.0


