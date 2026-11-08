Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1EA9606A332
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Nov 2026 20:48:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=GlsVRd/Q;
	dkim=pass (1024-bit key, unprotected) header.d=linux.dev header.i=@linux.dev header.a=rsa-sha256 header.s=key1 header.b=C8hpQrZA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=NH++uILCmGMzLfbUG6KWi5pvlPjSfnXwM7WYlgTEACw=; b=GlsVRd/QW7JFFf
	u7PQZ5JnooocUGdTUfFEExkVJs5aHks6LY/2GOIz3ljhLv6N8ixY8IaVKRfaY6mKVjJ/z/dV9oikj
	H0kCjB4oNsrOmEH8sx9/CRVGi4IlJMw+ZKjPcNt8x2960RrWdNppGDyIOam3RpGCVGKfyIneAz84+
	ZsykmwvqwPlOt7isMxD9woJ/LeqUHXfY5QJXGWa9nHq8cUYSs1nMtfHKcRXcE6jNV1+kPaujfU+sI
	tiEkwRPs1QmalqaqkQ5VoDQfjvlxPbKltrHJixGEIG6xSzuVKE0yJsQUYburitOXi6PNJazSkC3ut
	h3hQVe17n39iFeeVZVrQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oY-0000000GclB-33dJ;
	Sun, 08 Nov 2026 20:48:34 +0000
Received: from out-155.mta1.migadu.com ([95.215.58.155] helo=mta1.migadu.com)
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xQ9oP-0000000GcLg-1uiS
	for linux-nvme@lists.infradead.org;
	Sun, 08 Nov 2026 20:48:31 +0000
X-Envelope-To: linux-nvme@lists.infradead.org
DKIM-Signature: a=rsa-sha256; bh=PRPDmf+VsuCuxp7vixvF6VpbQfdLH9H9PmqoKRZH3W4=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1794170903; v=1; x=1794775703;
 b=C8hpQrZAEkeq7E/OeqAxa4Q4ynhVZ57/Xj/R8r8A5PySwT1Zv6HLm2fot6jH0m2BY+6BSCFi
 rNjUZLDKAw4Cqy3OngjfUGvFBvTAvE61LhvVk70K6KPlNl0SnXW6JoIyke10+RqY2VRbImw1DWC
 hqYc+aS2WXAqsG4EFDqk1rWQ=
X-Envelope-To: linux-nvme@lists.infradead.org
Received: by mta10.migadu.com with ESMTPS id 042d4a44635e17aa;
	Sun, 08 Nov 2026 20:48:23 +0000
X-Mizu-Trace-ID: 042d4a44635e17aa
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
Subject: [PATCH v9 25/29] scsi: sd: add multipath disk attr groups
Date: Sun,  8 Nov 2026 20:47:29 +0000
Message-ID: <20261108204733.557995-26-john.garry@linux.dev>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261108204733.557995-1-john.garry@linux.dev>
References: <20261108204733.557995-1-john.garry@linux.dev>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20261108_124825_663176_6255E082 
X-CRM114-Status: UNSURE (   8.93  )
X-CRM114-Notice: Please train this message.
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

Set multipath disk attr groups, which includes delayed disk removal and
everything from mpath_attr_group.

Signed-off-by: John Garry <john.garry@linux.dev>
---
 drivers/scsi/sd.c | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 03617029a552..fb87b1663ad6 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -4021,6 +4021,42 @@ static int sd_format_disk_name(char *prefix, int index, char *buf, int buflen)
 	return 0;
 }
 
+static ssize_t sd_mpath_device_delayed_removal_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct mpath_head *mpath_head = mpath_bd_device_to_head(dev);
+
+	return mpath_delayed_removal_secs_store(mpath_head, buf, count);
+}
+
+static ssize_t sd_mpath_device_delayed_removal_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct mpath_head *mpath_head = mpath_bd_device_to_head(dev);
+
+	return mpath_delayed_removal_secs_show(mpath_head, buf);
+}
+
+static DEVICE_ATTR(delayed_removal_secs, S_IRUGO | S_IWUSR,
+		sd_mpath_device_delayed_removal_show,
+		sd_mpath_device_delayed_removal_store);
+
+static struct attribute *sd_mpath_disk_attrs[] = {
+	&dev_attr_delayed_removal_secs.attr,
+	NULL
+};
+
+static const struct attribute_group sd_mpath_disk_attr_group = {
+	.attrs		= sd_mpath_disk_attrs,
+};
+
+__maybe_unused
+static const struct attribute_group *sd_mpath_disk_attr_groups[] = {
+	&sd_mpath_disk_attr_group,
+	&mpath_attr_group,
+	NULL
+};
+
 /**
  *	sd_probe - called during driver initialization and whenever a
  *	new scsi device is attached to the system. It is called once
-- 
2.43.0


