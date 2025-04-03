Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7014FC3601A
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Apr 2025 14:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xTBoyBjRHuRObuRIHUkNIzwYFm2O0Yy2PrNYop1H/nU=; b=nSi64iAlfJyh3oXZ0I9smBVka7
	LJrd15dCYLgd+3k1d6tDSeL839z5DnAKzzaEdqMrp+eKTS4f1DY2FgYfXs2KVtifvYd9K3G9txLW4
	lAXUkWG0SCAavqQ2OgBJpgCBKFsgs/7bs8wUU9ZE2tAQNtJ/dKJB+RiAG5Qy3Fajs1MeVN3eoR607
	Ch9eLD6qbKXKooMA/jZB/gzcx7LsyvyzKmP4HORb7vZNvVbMflxIzv1svK3PXu92iLBegBefKasys
	Kr2g+UgmyOw/vHJxLkDSukvbPAlxi+wxKpFTMHG6NraDyuxzag91goaZ4P2luwRcF2uxaB30KlZUE
	xvISOZug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LrH-000000097nk-37Wk;
	Thu, 03 Apr 2025 14:47:55 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.1 #2 (Red Hat Linux))
	id 1u0LrF-000000097mZ-3QEW
	for linux-nvme@lists.infradead.org;
	Thu, 03 Apr 2025 14:47:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0FCC1444C7;
	Thu,  3 Apr 2025 14:47:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D40CC4CEE5;
	Thu,  3 Apr 2025 14:47:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743691673;
	bh=DWqC4V9bNkT0HYN8qkyKbjxn38mDTEyJux3DDeUDoZU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EX4TB1hviZTHqD0o/8V1pgpLtgXDAZ+PVqUPmoyenF1TxjmY6NYN0g4MlJeNIASbD
	 nPC3SQvyk5adbG8q5m4A9hrJaycrmE5GGZhyS4zvINpxO1m9PdeQlXoISnQkGc+LZY
	 v5J9fGpn6X7oKL0p6sguAZcnsbq1SCdz99+PzvwCgy2l8mjKkFQFLR0WTLyoVIa3nd
	 tqJOxjvaWapXM7WHezejyMzA8kJ4qup5em+KVK9xRxZDTx8r0TvLZarLLuFlS3uGE/
	 q6EnJgUnbFOM5MRDEXQvvAt2dGUKPPZXD+WwjcMLZg7jIJLMTc4SdAPK/Bp6oElNbi
	 dmRH1s9b3BT/Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	Lennart Poettering <lennart@poettering.net>
Subject: [PATCH 1/2] nvmet: make 'readonly' setting configurable
Date: Thu,  3 Apr 2025 16:47:46 +0200
Message-Id: <20250403144747.43043-2-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250403144747.43043-1-hare@kernel.org>
References: <20250403144747.43043-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250403_074753_871708_0B1E9A8B 
X-CRM114-Status: GOOD (  11.01  )
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

The namespace already has a 'readonly' setting, which is controlled
by the 'write protect' feature. This patch introduces a namespace
configfs attribute 'readonly' to make it settable by the admin.

Suggested-by: Lennart Poettering <lennart@poettering.net>
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/target/configfs.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 00fd6ab046dd..cb03b448ae6d 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -820,6 +820,32 @@ static ssize_t nvmet_ns_resv_enable_store(struct config_item *item,
 }
 CONFIGFS_ATTR(nvmet_ns_, resv_enable);
 
+static ssize_t nvmet_ns_readonly_show(struct config_item *item, char *page)
+{
+	return sysfs_emit(page, "%d\n", to_nvmet_ns(item)->readonly);
+}
+
+static ssize_t nvmet_ns_readonly_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_ns *ns = to_nvmet_ns(item);
+	bool val;
+
+	if (kstrtobool(page, &val))
+		return -EINVAL;
+
+	mutex_lock(&ns->subsys->lock);
+	if (ns->enabled) {
+		pr_err("the ns:%d is already enabled.\n", ns->nsid);
+		mutex_unlock(&ns->subsys->lock);
+		return -EINVAL;
+	}
+	ns->readonly = val;
+	mutex_unlock(&ns->subsys->lock);
+	return count;
+}
+CONFIGFS_ATTR(nvmet_ns_, readonly);
+
 static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_device_path,
 	&nvmet_ns_attr_device_nguid,
@@ -830,6 +856,7 @@ static struct configfs_attribute *nvmet_ns_attrs[] = {
 	&nvmet_ns_attr_buffered_io,
 	&nvmet_ns_attr_revalidate_size,
 	&nvmet_ns_attr_resv_enable,
+	&nvmet_ns_attr_readonly,
 #ifdef CONFIG_PCI_P2PDMA
 	&nvmet_ns_attr_p2pmem,
 #endif
-- 
2.35.3


