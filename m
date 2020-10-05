Return-Path: <SRS0=0roG=DM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05086C4727E
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 09:43:10 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A72382083B
	for <linux-nvme@archiver.kernel.org>; Mon,  5 Oct 2020 09:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p9rh3PyT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A72382083B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:References:In-Reply-To:Message-Id:Date:Subject:To:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7ZmDSyoBhovdMDTbSCwRcf614mBUDhCC5lzGlvEe96g=; b=p9rh3PyTHwz+T10Ed3Y39eN3Fk
	fGP9emdx6OvIDejQGjTBSRN5WD7clVd8jgPPQCyL5OA6f0L2tAds0XAM4WYr3EyvnfzWUCnfafrhl
	4xRIMHUmytvOHok6XG0GpVIKgHFapv6zsvpLBkoJ32kFJo7qCTQTeGftPDjutohabrryC1vTDdM1N
	DQa8EvBv55A0Fg/MXcOTNiVvAZvtF5fsIHO/bTvakPsTT/1QAprUKW94uRNqNfA6vywca1d5IzeNK
	nErYiAbvOY5kN8TfZFinWm31/x6R3CNYRy0qjqq+1X1/xrkguv9KWZI/QVMgqQ81d/sC6bsOoCYoh
	a/U9Ag/Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kPN1P-0004Dh-Mx; Mon, 05 Oct 2020 09:43:07 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kPN1I-0004BC-MF
 for linux-nvme@lists.infradead.org; Mon, 05 Oct 2020 09:43:03 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 4E91EAF32;
 Mon,  5 Oct 2020 09:42:58 +0000 (UTC)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] nvme: add 'queue_if_no_path' sysfs attribute
Date: Mon,  5 Oct 2020 11:42:56 +0200
Message-Id: <20201005094256.49358-4-hare@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20201005094256.49358-1-hare@suse.de>
References: <20201005094256.49358-1-hare@suse.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201005_054300_916240_2F910CF5 
X-CRM114-Status: GOOD (  17.35  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-nvme@lists.infradead.org, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <keith.busch@wdc.com>, Hannes Reinecke <hare@suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Add a sysfs attribute 'queue_if_no_path' to allow the admin to
view and modify the 'queue_if_no_path' flag.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/host/core.c | 34 ++++++++++++++++++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79b88b4c448f..87589f0adea3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -3349,12 +3349,42 @@ static ssize_t nsid_show(struct device *dev, struct device_attribute *attr,
 }
 static DEVICE_ATTR_RO(nsid);
 
+static ssize_t queue_if_no_path_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+
+	return sprintf(buf, "%s\n",
+		       test_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags) ?
+		       "on" : "off");
+}
+
+static ssize_t queue_if_no_path_store(struct device *dev,
+		struct device_attribute *attr, const char *buf, size_t count)
+{
+	struct nvme_ns_head *head = dev_to_ns_head(dev);
+	int queue_if_no_path, err;
+
+	err = kstrtoint(buf, 10, &queue_if_no_path);
+	if (err)
+		return -EINVAL;
+
+	else if (queue_if_no_path <= 0)
+		clear_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
+	else
+		set_bit(NVME_NSHEAD_QUEUE_IF_NO_PATH, &head->flags);
+	return count;
+}
+static DEVICE_ATTR(queue_if_no_path, S_IRUGO | S_IWUSR,
+	queue_if_no_path_show, queue_if_no_path_store);
+
 static struct attribute *nvme_ns_id_attrs[] = {
 	&dev_attr_wwid.attr,
 	&dev_attr_uuid.attr,
 	&dev_attr_nguid.attr,
 	&dev_attr_eui.attr,
 	&dev_attr_nsid.attr,
+	&dev_attr_queue_if_no_path.attr,
 #ifdef CONFIG_NVME_MULTIPATH
 	&dev_attr_ana_grpid.attr,
 	&dev_attr_ana_state.attr,
@@ -3381,6 +3411,10 @@ static umode_t nvme_ns_id_attrs_are_visible(struct kobject *kobj,
 		if (!memchr_inv(ids->eui64, 0, sizeof(ids->eui64)))
 			return 0;
 	}
+	if (a == &dev_attr_queue_if_no_path.attr) {
+		if (dev_to_disk(dev)->fops == &nvme_fops)
+			return 0;
+	}
 #ifdef CONFIG_NVME_MULTIPATH
 	if (a == &dev_attr_ana_grpid.attr || a == &dev_attr_ana_state.attr) {
 		if (dev_to_disk(dev)->fops != &nvme_fops) /* per-path attr */
-- 
2.16.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
