Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83092C982ED
	for <linux-nvme@archiver.kernel.org>; Mon, 21 Sep 2026 14:44:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:content-type:
	Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HspPAkUWPJYUnFk1Gelq9h29eoIKCRNbV1dk3dGm5fw=; b=2k7CR6ZOYPLD6IBTanXlQOQ6uo
	9iokRrJVT3ybGTQjA3EYGURf1He35XGTgsNOnW+ZjyaYiFMhvOyD9sO3gJRYCusXvoNrtP6EUKqr0
	qHhW5xkhQsNwcM+5+nV6IPQJXsYiMvETFVe8T6th8hfS4kes1TfSnoC8YEYT76vg7i3nF1IhjRLhJ
	S++nu7C358ww2wcc0owyRBCw14uy+svxYVNUTTOvoojk6XUGylHiCogRHULOTsRhgfSAAVZLUbjmp
	xy1zCrE5ta7doQzfymCa9JCF5ZsixGqRcKxWo78fk5gMzlZ1ndj64Qg+wwSNj44MqisVfRPc7VivA
	MsrnH0hA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fFS-00000002R3a-1axn;
	Mon, 21 Sep 2026 14:44:02 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x8fFP-00000002R2d-1f7N
	for linux-nvme@lists.infradead.org;
	Mon, 21 Sep 2026 14:44:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790001837;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=HspPAkUWPJYUnFk1Gelq9h29eoIKCRNbV1dk3dGm5fw=;
	b=a1h4Lg7+PjuMGcx7M1htOCVWBRXdPUNMqREPOxs39mX5FpMJLmsx1zHfMHFxU7RwvZpVe7
	+DcrzcO9wUtW4aWSP2YbguHVlGWXuDaWo0ma9/wYSQRtwUY7GfQMKqUY8rbkV3EC4jNnbi
	HR/M3HC3XTsdsXvST28n0MFJlyjq4UQ=
Received: from mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-650-ecAmiN-BOd6xxrVz_ZphJQ-1; Mon,
 21 Sep 2026 10:43:53 -0400
X-MC-Unique: ecAmiN-BOd6xxrVz_ZphJQ-1
X-Mimecast-MFC-AGG-ID: ecAmiN-BOd6xxrVz_ZphJQ_1790001832
Received: from mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.95])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-03.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6DAF8193533A;
	Mon, 21 Sep 2026 14:43:52 +0000 (UTC)
Received: from loberman-thinkpadp1gen5.redhat.corp (headnet05.pony-001.prod.iad2.dc.redhat.com [10.2.32.117])
	by mx-prod-int-10.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 3AF3A214;
	Mon, 21 Sep 2026 14:43:50 +0000 (UTC)
From: loberman@redhat.com
To: linux-nvme@lists.infradead.org
Cc: hch@lst.de,
	kbusch@kernel.org,
	sagi@grimberg.me,
	Laurence Oberman <loberman@redhat.com>
Subject: [PATCH v2] nvme-multipath: add iopolicies sysfs attribute
Date: Mon, 21 Sep 2026 10:43:47 -0400
Message-ID: <20260921144347.49620-1-loberman@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.6 on 10.30.177.95
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: zl0dZ0TpV6u9CJ12ud7JMAbf25VOe2W8ixk1R3mVwWU_1790001832
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260921_074359_955013_FE5A374D 
X-CRM114-Status: GOOD (  13.79  )
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
there is no way to see which policies are available.

Changing the output of iopolicy would break existing userspace,
since nvme-cli compares the value against a bare policy name. Leave
iopolicy unchanged and add a read-only iopolicies attribute that
lists the available policies:

  # cat iopolicies
  numa round-robin queue-depth

The current policy is still read from iopolicy.

Signed-off-by: Laurence Oberman <loberman@redhat.com>
Assisted-by: Claude:claude-sonnet-5
---
v2:
  - Drop the [ ] notation and list plain policy names (Christoph)

 drivers/nvme/host/multipath.c | 15 +++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  1 +
 3 files changed, 17 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 75dbb58286a3..ea7d0c59587b 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1085,6 +1085,21 @@ static ssize_t nvme_subsys_iopolicy_store(struct device *dev,
 SUBSYS_ATTR_RW(iopolicy, S_IRUGO | S_IWUSR,
 		      nvme_subsys_iopolicy_show, nvme_subsys_iopolicy_store);
 
+static ssize_t iopolicies_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	int i, len = 0;
+
+	for (i = 0; i < ARRAY_SIZE(nvme_iopolicy_names); i++)
+		len += sysfs_emit_at(buf, len, "%s%s", i ? " " : "",
+				     nvme_iopolicy_names[i]);
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


