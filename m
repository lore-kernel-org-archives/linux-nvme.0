Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B57BC87FC9
	for <linux-nvme@archiver.kernel.org>; Tue, 29 Jul 2025 07:07:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=IJOhVNaWPpihUORt2J/kR1FQ7LdOOZ3rjXkZZvqad8Q=; b=JMzdKr0WJ1k8fHa5gDCc4A1GF2
	rSohFr44yVzlnZQ3r0PxMspJXbL9IXa/FihRsffvkHrNf9zg+sPza/1jm9+LCadywx/SM3jBZizDr
	1g3FZPNM0PTwDSQDHK8PbB2qqE1hZV3Pfjjmq7ounN72Nc0JJ4wv1W6WAj4lsaBBmroLqgpAtEHs9
	2sIuvEsovPXVy2VQm2BCU1EmZVcBteQPFlVcSOw3rXTelFop8QYVqg3GrlIyBVDeKXQ65BmleQ8ho
	BbEEjmQofrXeKriuQYVcP9EsOfBYSnwPOXYq9AqCHxslocJKpERNsHbsp81C6el9RAU2WRgL9c/7J
	1WwjuDbg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQf-0000000G5Sf-1olZ;
	Tue, 29 Jul 2025 07:07:17 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1ugeQa-0000000G5Qh-1y5e
	for linux-nvme@lists.infradead.org;
	Tue, 29 Jul 2025 07:07:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 93F62601DF;
	Tue, 29 Jul 2025 07:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFCB1C4CEEF;
	Tue, 29 Jul 2025 07:07:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1753772831;
	bh=2lbm3XUrf1QaixXY2UQtuyB/uZoBKfj/OUH3fGfuVb8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gbelZB8JwOuFnBkRgd1GkO0nuLt7UiM+tUVRvAQwPojUNu9EGCDDigMGr0LldwB9f
	 M+jNQcqRx4N1JVhNigdhDUuQlrHjpFc6pFoakifqmjapugU8WVpNbzI125Bi+3Vj44
	 YgXZjlvLbrt9r6lxKLR9sfqS2eKR6VZFnKJlGD9DT/jU+ne+BFrB5Y4AGhY08fXp6o
	 og5571meJqk7vYJShALoZyg9YTuLa1AXqeb47ZydTq4CYJVaDQj7gr7jbsOWGP6Y/u
	 ogPjwn7q30iVHODQXdyaKcrnQCtwJlViF5UL7Pu/c1WYXuw5aBM9UEHkkthRIpENxe
	 AU11peJh1rlDA==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 3/6] nvme: add per-namespace iopolicy sysfs attribute
Date: Tue, 29 Jul 2025 09:06:50 +0200
Message-ID: <20250729070653.125258-4-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250729070653.125258-1-hare@kernel.org>
References: <20250729070653.125258-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@kernel.org>

To display iopolicies which are different from the subsystem.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/multipath.c | 14 ++++++++++++++
 drivers/nvme/host/nvme.h      |  1 +
 drivers/nvme/host/sysfs.c     |  7 +++++++
 3 files changed, 22 insertions(+)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 116b2e71d339..696c2f817bed 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -1137,6 +1137,20 @@ static ssize_t numa_nodes_show(struct device *dev, struct device_attribute *attr
 }
 DEVICE_ATTR_RO(numa_nodes);
 
+static ssize_t iopolicy_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct nvme_ns_head *head = disk->private_data;
+	int iopolicy;
+
+	if (nvme_bpf_enabled(head))
+		return sysfs_emit(buf, "bpf(%pUb)\n", &head->bpf_ops->uuid);
+	iopolicy = READ_ONCE(head->subsys->iopolicy);
+	return sysfs_emit(buf, "%s\n", nvme_iopolicy_names[iopolicy]);
+}
+DEVICE_ATTR_RO(iopolicy);
+
 static ssize_t delayed_removal_secs_show(struct device *dev,
 		struct device_attribute *attr, char *buf)
 {
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index f1eb8ae57c84..2aff8df55d1c 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -994,6 +994,7 @@ extern struct device_attribute dev_attr_ana_grpid;
 extern struct device_attribute dev_attr_ana_state;
 extern struct device_attribute dev_attr_queue_depth;
 extern struct device_attribute dev_attr_numa_nodes;
+extern struct device_attribute dev_attr_iopolicy;
 extern struct device_attribute dev_attr_delayed_removal_secs;
 extern struct device_attribute subsys_attr_iopolicy;
 
diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 29430949ce2f..378107cf7a21 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -260,6 +260,7 @@ static struct attribute *nvme_ns_attrs[] = {
 	&dev_attr_ana_state.attr,
 	&dev_attr_queue_depth.attr,
 	&dev_attr_numa_nodes.attr,
+	&dev_attr_iopolicy.attr,
 	&dev_attr_delayed_removal_secs.attr,
 #endif
 	&dev_attr_io_passthru_err_log_enabled.attr,
@@ -297,6 +298,12 @@ static umode_t nvme_ns_attrs_are_visible(struct kobject *kobj,
 		if (nvme_disk_is_ns_head(dev_to_disk(dev)))
 			return 0;
 	}
+	if (a == &dev_attr_iopolicy.attr) {
+		struct gendisk *disk = dev_to_disk(dev);
+
+		if (!nvme_disk_is_ns_head(disk))
+			return 0;
+	}
 	if (a == &dev_attr_delayed_removal_secs.attr) {
 		struct gendisk *disk = dev_to_disk(dev);
 
-- 
2.43.0


