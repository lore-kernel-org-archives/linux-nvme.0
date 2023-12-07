Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4A69C10F09
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Dec 2023 12:36:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YTz/wSzWbiPlW/ZbbtgrjDWXGH3h66/CMvQCWU6Yy58=; b=jqDVTQ5+hz3WZq8O51xsEZBNI/
	5NuAhWlIClgxauVv3XeYcAmZ90cOR41hFUlM6tzkOTP5ZZNnJS72FlCQlBhqaPLu2hm0cumZPqyb2
	83HuCyyFTDjo7y/W+r/zGbSWMhAsbhcR0PHtf+z/xYwhClpmZdVbhrys4npqqttKUKQhLOtKmoSR3
	ENbQaYysqutE1rWwKcokOyE65DxpRZ/vzHz6t69F0gkwEcW8gNR0vWoLzhQxu4hED23ldm702ZG3e
	U7M0iPjU0r7vmVo7oSr+Y0LZ6qlpSGK5lrpCA8d6BysBOstBCwQl9Waa0sNRJaM3RR5Vbkv6sh8rn
	iF0yCopw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rBDcM-00CnuJ-0H;
	Thu, 07 Dec 2023 12:36:38 +0000
Received: from smtp-out2.suse.de ([195.135.223.131])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rBDcH-00CnrC-0R
	for linux-nvme@lists.infradead.org;
	Thu, 07 Dec 2023 12:36:34 +0000
Received: from imap2.dmz-prg2.suse.org (imap2.dmz-prg2.suse.org [10.150.64.98])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by smtp-out2.suse.de (Postfix) with ESMTPS id F269D1FB50;
	Thu,  7 Dec 2023 12:36:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1701952590; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTz/wSzWbiPlW/ZbbtgrjDWXGH3h66/CMvQCWU6Yy58=;
	b=MDB0aWwJi7iwlxkDMTPbShjzoakO6vtdYqsQpkGt38hQuP/5NnDwoM+dJrie+0sJEHsh6H
	1XsNYMQPU/aQ8Lfw3Z7R4nsRUlp0e4CPClCio5JZm5oVPTV0m1il9ACMRCwCI6w0LpbZ96
	ulFktApFNNcpCkNOOEDLjJt5iSXr4us=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1701952590;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YTz/wSzWbiPlW/ZbbtgrjDWXGH3h66/CMvQCWU6Yy58=;
	b=8Y9R6lWYtfLMB06jUIp89cYnCl52kKtFxLv24DOCgrxn3RF5GTEMLHJQ1bg2Unp0YWx0SK
	iKcWDVWTW45vX+Bw==
Received: from imap2.dmz-prg2.suse.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by imap2.dmz-prg2.suse.org (Postfix) with ESMTPS id DFF21139E3;
	Thu,  7 Dec 2023 12:36:30 +0000 (UTC)
Received: from dovecot-director2.suse.de ([10.150.64.162])
	by imap2.dmz-prg2.suse.org with ESMTPSA
	id s0U9NU68cWX8AgAAn2gu4w
	(envelope-from <dwagner@suse.de>); Thu, 07 Dec 2023 12:36:30 +0000
From: Daniel Wagner <dwagner@suse.de>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	Daniel Wagner <dwagner@suse.de>
Subject: [PATCH v4 2/4] nvme: rename ns attribute group
Date: Thu,  7 Dec 2023 13:36:22 +0100
Message-ID: <20231207123624.29959-3-dwagner@suse.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20231207123624.29959-1-dwagner@suse.de>
References: <20231207123624.29959-1-dwagner@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.10 / 50.00];
	 ARC_NA(0.00)[];
	 RCVD_VIA_SMTP_AUTH(0.00)[];
	 FROM_HAS_DN(0.00)[];
	 TO_DN_SOME(0.00)[];
	 R_MISSING_CHARSET(2.50)[];
	 TO_MATCH_ENVRCPT_ALL(0.00)[];
	 MIME_GOOD(-0.10)[text/plain];
	 REPLY(-4.00)[];
	 BROKEN_CONTENT_TYPE(1.50)[];
	 RCVD_COUNT_THREE(0.00)[3];
	 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
	 RCPT_COUNT_SEVEN(0.00)[7];
	 MID_CONTAINS_FROM(1.00)[];
	 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:email];
	 FUZZY_BLOCKED(0.00)[rspamd.com];
	 FROM_EQ_ENVFROM(0.00)[];
	 MIME_TRACE(0.00)[0:+];
	 RCVD_TLS_ALL(0.00)[];
	 BAYES_HAM(-3.00)[100.00%]
Authentication-Results: smtp-out2.suse.de;
	none
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231207_043633_326359_955EDBE3 
X-CRM114-Status: GOOD (  14.59  )
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

Drop the 'id' part of the attribute group name because we want to expose
non 'id' related attributes via the ns attribute group.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/nvme/host/core.c      |  2 +-
 drivers/nvme/host/multipath.c |  2 +-
 drivers/nvme/host/nvme.h      |  2 +-
 drivers/nvme/host/sysfs.c     | 14 +++++++-------
 4 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 72908e622049..c3270818fa0d 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3669,7 +3669,7 @@ static void nvme_alloc_ns(struct nvme_ctrl *ctrl, struct nvme_ns_info *info)
 	up_write(&ctrl->namespaces_rwsem);
 	nvme_get_ctrl(ctrl);
 
-	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_id_attr_groups))
+	if (device_add_disk(ctrl->device, ns->disk, nvme_ns_attr_groups))
 		goto out_cleanup_ns_from_list;
 
 	if (!nvme_ns_head_multipath(ns->head))
diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 0a88d7bdc5e3..2dd4137a08b2 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -579,7 +579,7 @@ static void nvme_mpath_set_live(struct nvme_ns *ns)
 	 */
 	if (!test_and_set_bit(NVME_NSHEAD_DISK_LIVE, &head->flags)) {
 		rc = device_add_disk(&head->subsys->dev, head->disk,
-				     nvme_ns_id_attr_groups);
+				     nvme_ns_attr_groups);
 		if (rc) {
 			clear_bit(NVME_NSHEAD_DISK_LIVE, &ns->flags);
 			return;
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 1ebe6a9b42c9..32ec7ca30d7c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -870,7 +870,7 @@ int nvme_ns_head_chr_uring_cmd(struct io_uring_cmd *ioucmd,
 int nvme_getgeo(struct block_device *bdev, struct hd_geometry *geo);
 int nvme_dev_uring_cmd(struct io_uring_cmd *ioucmd, unsigned int issue_flags);
 
-extern const struct attribute_group *nvme_ns_id_attr_groups[];
+extern const struct attribute_group *nvme_ns_attr_groups[];
 extern const struct pr_ops nvme_pr_ops;
 extern const struct block_device_operations nvme_ns_head_ops;
 extern const struct attribute_group nvme_dev_attrs_group;
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c6b7fbd4d34d..d682d0a667a0 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -114,7 +114,7 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
-static struct attribute *nvme_ns_id_attrs[] = {
+static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
@@ -127,7 +127,7 @@ static struct attribute *nvme_ns_id_attrs[] = {
 	NULL,
 };
 
-static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
+static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		struct attribute *a, int n)
 {
 	struct device *dev = container_of(kobj, struct device, kobj);
@@ -157,13 +157,13 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 	return a->mode;
 }
 
-static const struct attribute_group nvme_ns_id_attr_group = {
-	.attrs		= nvme_ns_id_attrs,
-	.is_visible	= nvme_ns_id_attrs_are_visible,
+static const struct attribute_group nvme_ns_attr_group = {
+	.attrs		= nvme_ns_attrs,
+	.is_visible	= nvme_ns_attrs_are_visible,
 };
 
-const struct attribute_group *nvme_ns_id_attr_groups[] = {
-	&nvme_ns_id_attr_group,
+const struct attribute_group *nvme_ns_attr_groups[] = {
+	&nvme_ns_attr_group,
 	NULL,
 };
 
-- 
2.43.0


