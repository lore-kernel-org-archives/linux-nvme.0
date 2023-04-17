Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D186C77B70
	for <linux-nvme@archiver.kernel.org>; Mon, 17 Apr 2023 13:03:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6OHYx4FbqYIHqyrbj7uwWyUTNqsb1/hgDqOAuyASX3M=; b=tfGJeRShWGUpBVDRnOL6xHGpZT
	0u8YduC0LZ4phVBHbm+oUwVkpnClrz8pAzfR8pSln1e7RJxJwpLT4mxAhe5jhFJjEQ4d9ikvr9zYP
	HNWUpJcmKBPI7PDZZvXuNjHNUmmjZJTWR4EgvlxMjNNQmFpSlFo+EHV02vvcw3NvIchMmwcaCKO5e
	055fA4USt0TLKUsFzMwNMGwraGBjPqPK/ZyD14WL1iQSi4sLCRKq9SQoJdGTQl8Cin4NHodv1Xq1W
	mZ2Rlgp3e99ECMu6AbWkXhVF+I5zdLCieM/yTG8Mj8atvJT3jeeQ3SFT9gKCHuCZeoMao/KYb/u9e
	EAc6v4bw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1poOW8-00GIGb-22;
	Mon, 17 Apr 2023 13:03:36 +0000
Received: from smtp-out1.suse.de ([2001:67c:2178:6::1c])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1poOVo-00GHuy-0J
	for linux-nvme@lists.infradead.org;
	Mon, 17 Apr 2023 13:03:21 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 7DD9421A8D;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1681736584; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OHYx4FbqYIHqyrbj7uwWyUTNqsb1/hgDqOAuyASX3M=;
	b=wNilDRgm+v7xzTo8bgriIVdxAPi7yC4/gY7fT87O/LRNigRusSj+QOtNOo9izaJUKy//n6
	Eip4+Of754hIZLwFTU4lc8oAxt4BtuG/OHPFa2T7ou8zp5Seb52qFb7e8bq6rKmtq3V52Z
	pjSp/s5ZWKh/27QyfueBxWGKW8CTh58=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1681736584;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6OHYx4FbqYIHqyrbj7uwWyUTNqsb1/hgDqOAuyASX3M=;
	b=isiIUSId9h3O29ICeCaOeZ2S7UgJbXDMDbO9IOBQLNAHcZHhw/RdhDHZEv3Rv/RsDx/ksh
	zIEaMLf6/c+DOcCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 6EA7F2C166;
	Mon, 17 Apr 2023 13:03:04 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 6B0C451C25BE; Mon, 17 Apr 2023 15:03:04 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Chuck Lever <chuck.lever@oracle.com>,
	kernel-tls-handshake@lists.linux.dev,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 18/18] nvmet-tcp: add configfs attribute 'param_keyring'
Date: Mon, 17 Apr 2023 15:03:02 +0200
Message-Id: <20230417130302.86274-19-hare@suse.de>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20230417130302.86274-1-hare@suse.de>
References: <20230417130302.86274-1-hare@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230417_060316_296026_477946E6 
X-CRM114-Status: GOOD (  12.04  )
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

Add a configfs attribute to list and change the default keyring.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 drivers/nvme/target/configfs.c | 45 ++++++++++++++++++++++++++++++++++
 1 file changed, 45 insertions(+)

diff --git a/drivers/nvme/target/configfs.c b/drivers/nvme/target/configfs.c
index 49b407702ad5..493f5524c922 100644
--- a/drivers/nvme/target/configfs.c
+++ b/drivers/nvme/target/configfs.c
@@ -309,6 +309,47 @@ static ssize_t nvmet_param_pi_enable_store(struct config_item *item,
 CONFIGFS_ATTR(nvmet_, param_pi_enable);
 #endif
 
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+static ssize_t nvmet_param_keyring_show(struct config_item *item,
+		char *page)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+
+	if (!port->keyring)
+		return sprintf(page, "\n");
+	return snprintf(page, PAGE_SIZE, "%s\n",
+			port->keyring->description);
+}
+
+static ssize_t nvmet_param_keyring_store(struct config_item *item,
+		const char *page, size_t count)
+{
+	struct nvmet_port *port = to_nvmet_port(item);
+	struct key *keyring;
+	unsigned int keyring_id;
+	int ret;
+
+	if (nvmet_is_port_enabled(port, __func__))
+		return -EACCES;
+
+	ret = kstrtou32(page, 0, &keyring_id);
+	if (ret) {
+		pr_err("Invalid keyring id '%s'\n", page);
+		return ret;
+	}
+	keyring = key_lookup(keyring_id);
+	if (IS_ERR(keyring)) {
+		pr_err("Invalid keyring '%08x'\n", keyring_id);
+		return PTR_ERR(keyring);
+	}
+	key_put(port->keyring);
+	port->keyring = keyring;
+	return count;
+}
+
+CONFIGFS_ATTR(nvmet_, param_keyring);
+#endif
+
 static ssize_t nvmet_addr_trtype_show(struct config_item *item,
 		char *page)
 {
@@ -412,6 +453,7 @@ static ssize_t nvmet_addr_tsas_store(struct config_item *item,
 		pr_err("TLS is not supported\n");
 		return -EINVAL;
 	}
+
 	if (!port->keyring) {
 		pr_err("TLS keyring not configured\n");
 		return -EINVAL;
@@ -1858,6 +1900,9 @@ static struct configfs_attribute *nvmet_port_attrs[] = {
 	&nvmet_attr_param_inline_data_size,
 #ifdef CONFIG_BLK_DEV_INTEGRITY
 	&nvmet_attr_param_pi_enable,
+#endif
+#ifdef CONFIG_NVME_TARGET_TCP_TLS
+	&nvmet_attr_param_keyring,
 #endif
 	NULL,
 };
-- 
2.35.3


