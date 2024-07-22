Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18DB8C3DA5D
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jqgkRTbQVNc0+LpOW/gtJs70Js9GNX1zFFG+62/4d4k=; b=R2S4uLfw5lQphLKTHAIgJz5pkU
	TuZfwTGcNYrKSl+GLl0uKdifqeQV1kXxR06Gd0aRiuG3Sv465/Z4v8Rp0K1T+/6tt4aTGUdMNPMX2
	OyUsxajuYNobOfjburHaGKgFAf6nkvI5g5e8OjvPZgSACi9Pu05xqq5pHOKLGxCssPM5urdvXMfh3
	EPimZKpdS6GtJVmfxIPx8TVH1OtsenB6vcH3flcrTfhBT50EPgp+S121Ohq/0RaH3QiccoAgAVhu4
	D51a11/dr+jBOl+BqgxRXyvKayMk3Xf44di9BS5XSWmsdDoLlE1QEACN/REzbQJLO9SIJ1YMjcAFY
	DIn0vUcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkd-00000009SeY-2YWv;
	Mon, 22 Jul 2024 12:02:47 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkY-00000009SZQ-3lq5
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 12:02:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 47EFBCE0B2F;
	Mon, 22 Jul 2024 12:02:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5239EC116B1;
	Mon, 22 Jul 2024 12:02:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721649760;
	bh=DVDlTumNpyvo5KYDrMSn33rVqQOdDset2/+mI22tJGw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iqMZwfk1IR4CgXxJEOe1jGgt1uyESKPpcaG/glkcK1uS9d2CltL+5aA8O3UuPKDmx
	 cyIrHjrjdHiAtlJFEd1rbUofZ5j2GV4gO3O3POhxQJIENhMMBTTTlKiZ/9HE74uMrX
	 FtJ8eiNMem/D7yz0Bu5eEJsSYE46fZ4D+XsztrHsoOilp4utj4qel6n/Y8sLG3qQmY
	 gK9JXjbNvMCRYupBnAujMmglGdAPRjl5udYu2OkTo/k9DpK2gmyZbU7RcSdSsKBOR0
	 rcc2DkT/++TydLyTBrVQ9Z8m9F3KO8FeiF3sY7jPl8SZlNzhj0lHGVrSto7MT9u9YV
	 POwqHETDV24Gw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/9] nvme-sysfs: add 'tls_configured_key' sysfs attribute
Date: Mon, 22 Jul 2024 14:02:23 +0200
Message-Id: <20240722120226.88737-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722120226.88737-1-hare@kernel.org>
References: <20240722120226.88737-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_050243_139552_9504810A 
X-CRM114-Status: GOOD (  13.11  )
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

There is a difference between the negotiated TLS key (which is
always present for a TLS encrypted connection) and the configured
TLS key (which is specified with the --tls_key command line option).
To differentate between these two add a new sysfs attribute
'tls_configured_key' to hold the specified on the command line.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/sysfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index dc7ceb53147f..2055dad7bc63 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -743,8 +743,19 @@ static ssize_t tls_key_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tls_key);
 
+static ssize_t tls_configured_key_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *key = ctrl->opts->tls_key;
+
+	return sysfs_emit(buf, "%08x\n", key_serial(key));
+}
+static DEVICE_ATTR_RO(tls_configured_key);
+
 static struct attribute *nvme_tls_attrs[] = {
 	&dev_attr_tls_key.attr,
+	&dev_attr_tls_configured_key.attr,
 };
 
 static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
@@ -759,6 +770,9 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_tls_key.attr &&
 	    !ctrl->opts->tls)
 		return 0;
+	if (a == &dev_attr_tls_configured_key.attr &&
+	    !ctrl->opts->tls_key)
+		return 0;
 
 	return a->mode;
 }
-- 
2.35.3


