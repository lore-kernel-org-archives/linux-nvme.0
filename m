Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 994EBC982D8
	for <linux-nvme@archiver.kernel.org>; Sun, 20 Sep 2026 16:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=oHLJgKdjMbeA8Gx0aw9TYsz24zksWrj34XmWCSbyaEs=; b=YVJbWjD0S3O3S8Z5OCjXJIAwS3
	x6AkxMJRZ+Bb/qDh3xxXINcwGCJAZgpyKmik0U/iAN31w1+VHvuGps4RiqdSKDzt3l6CgoPUUxDA4
	Gax+C9nRUkO/uOhnGawd2z9hbukHD5An2C/rAw44WuV02ZMMpAnnRdfvh/flYRJMb7cNaJ4Fhvim+
	2NjHEk3IC3cxZUosmL74coEaE7aTbR0XFfHuhblXfdb1o61p1O3cqxv9h56uMkKv1Iw/duVGVBJes
	QPWF1t7jsvFyxl6ZhHntbc66fBZEzhLzWzTBW58p+IuwArn1p22vPwJjesF25Ch26rzVMOJQV9kmV
	AdpUrqtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8KdA-000000007wA-0aj5;
	Sun, 20 Sep 2026 16:43:08 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8Kd6-000000007uZ-0Rp8
	for linux-nvme@lists.infradead.org;
	Sun, 20 Sep 2026 16:43:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789922582;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=oHLJgKdjMbeA8Gx0aw9TYsz24zksWrj34XmWCSbyaEs=;
	b=NI2h0EHWaCcX4ff1AeEaWD2VcQnQYmR2waYvd57oqZbgWzUxOQmw9IUh1GcUxeTkLEXd9i
	+SKGivQngSc4K5SVn6BYeoDGB8uS53XlQipgqky9LGUXvmIt5Yrp7G5EGZpa7qt79Anw6e
	d/tZ+2Z/QJWiFQBUOBROL/pJV4jBp1E=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-37-StQakqoYOWar88RSt0NyIw-1; Sun,
 20 Sep 2026 12:41:23 -0400
X-MC-Unique: StQakqoYOWar88RSt0NyIw-1
X-Mimecast-MFC-AGG-ID: StQakqoYOWar88RSt0NyIw_1789922482
Received: from mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 01C491956096;
	Sun, 20 Sep 2026 16:41:22 +0000 (UTC)
Received: from loberman-thinkpadp1gen5.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 64E0330001A2;
	Sun, 20 Sep 2026 16:41:20 +0000 (UTC)
From: loberman@redhat.com
To: loberman@redhat.com
Cc: kbusch@kernel.org,
	hch@lst.de,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: add iopolicies sysfs attribute
Date: Sun, 20 Sep 2026 12:40:00 -0400
Message-ID: <20260920164000.45508-1-loberman@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.4
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gOtmMXkCIl5bG6bdM4_Yl4bvAWKmWmsS7F4Ae7Kfrxo_1789922482
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260920_094304_213653_E1E73392 
X-CRM114-Status: GOOD (  16.02  )
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

From: Laurence Oberman <loberman@redhat.com>

The subsystem iopolicy attribute only shows the active policy, so
there is no way to see which policies are available. The block layer
solves this for I/O schedulers by listing all options with the
active one in brackets in queue/scheduler.

Changing the output of iopolicy the same way would break existing
userspace, since nvme-cli compares the value against a bare policy
name. Leave iopolicy unchanged and add a read-only iopolicies
attribute that gives equivalent visibility:

  # cat iopolicies
  [numa] round-robin queue-depth

Signed-off-by: Laurence Oberman <loberman@redhat.com>
Assisted-by: LLM
---
 drivers/nvme/host/multipath.c | 25 +++++++++++++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  1 +
 3 files changed, 27 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..7b282ab05dab 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1085,6 +1085,31 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
 		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
 
+static ssize_t iopolicies_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct nvme_subsystem *subsys =
+		container_of(dev, struct nvme_subsystem, dev);
+	int cur = READ_ONCE(subsys->iopolicy);
+	int i, len = 0;
+
+	/*
+	 * List all available policies with the active one in brackets,
+	 * matching the format of the block layer's "scheduler" attribute.
+	 */
+	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++)
+		len += sysfs_emit_at(buf, len, "%s%s%s%s",
+				     i ? " " : "",
+				     i == cur ? "[" : "",
+				     nvme_iopolicy_names[i],
+				     i == cur ? "]" : "");
+
+	len += sysfs_emit_at(buf, len, "\n");
+	return len;
+}
+
+struct device_attribute subsys_attr_iopolicies = __ATTR_RO(iopolicies);
+
 static ssize_t ana_grpid_show(struct device *dev, struct device_attribute *attr,
 		char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 75e5d5a8a77c..b419c6fc6081 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1098,6 +1098,7 @@ extern struct device_attribute dev_attr_multipath_failover_count;
 extern struct device_attribute dev_attr_io_requeue_no_usable_path_count;
 extern struct device_attribute dev_attr_io_fail_no_available_path_count;
 extern struct device_attribute subsys_attr_iopolicy;
+extern struct device_attribute subsys_attr_iopolicies;
 
 static inline bool nvme_disk_is_ns_head(struct gendisk *disk)
 {
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index abf8edaae371..4c4518b6b7d5 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -1298,6 +1298,7 @@ static struct attribute *nvme_subsys_attrs[] = {
 	&subsys_attr_subsystype.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&subsys_attr_iopolicy.attr,
+	&subsys_attr_iopolicies.attr,
 #endif
 	NULL,
 };
-- 
2.55.0


