Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2A13C3DA6F
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 14:49:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6xDyDWXPDCVXJrHgHjXP6iXooCUH2hOjlzbVNOCVVfI=; b=a1nWlBg1kA8NKjLWE/NNIOEZmU
	/VERTgnIC5iCDAzQRmIQoGGGQviEHxeuCNcYSOdHcU0vIgmF6TuqYwwESD/KYJIX/YaGQ7ObDdU8c
	wGMFEOjMU5yz1TuximEyXRaX/4AxZHnYJR/tON9vnu38r+ebd1fsOTg0qk8BAb3vK1Qm62kRe1VFk
	XmIMuEcjwBtgh6LWo/VRarJ63Eb+LT29ZMY28LvJmAeEERpQPKGOfDoa7eDMamBZpLiBJNkyppLzJ
	UCNvzTeJlxen0chEpIF75VVYiDwQW7DIJnnJ6IfFK6zT8Qs06W33yyE8GgBPuEFoYqVgkHbBh7dFV
	cwk9iwYg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRo-0000000HKTs-0NuP;
	Thu, 18 Jul 2024 14:49:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRi-0000000HKPA-2zBF
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 14:49:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id ED6FA61B94;
	Thu, 18 Jul 2024 14:49:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 643B5C4AF0F;
	Thu, 18 Jul 2024 14:49:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314165;
	bh=lXNqe7FoZcg4GEpSsmI60K4z/cwjTI4y8op/c6L5u/g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=cdh1DrIFmwj/ck+jxZ0MgLiqXJmInWn8jpaKygXGBr0J2ZfR70HVv53F02ZpLgokj
	 3XcpyHi5kpWnbNcnzPiC7JqYv6ezbmW32dM/JfExMUehkJJx8rLKDqPq7M6mFYdoGY
	 FWIoT5R9SFQQX7p/58zRPiyh6wJTCSIJxRN2rMbaWMOOu2DKzW2vXobJkI5R4Be59f
	 Q8oQ1KnzZ2TMVqtjWiSjZMf3SMunhRPc8pu2tVlrfCJRfFyY5HNqGdM63N8iKuDTem
	 duCBfuP/jg9CyDI04/vkCwjRFL7yfapaTAQn9nlt11YJwx9ulLoXLvpWTM/1Ua6Wvy
	 DVeJBgF+f4eUw==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/8] nvme-sysfs: add 'tls_keyring' attribute
Date: Thu, 18 Jul 2024 16:48:56 +0200
Message-Id: <20240718144858.19074-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718144858.19074-1-hare@kernel.org>
References: <20240718144858.19074-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_074926_911210_390D648C 
X-CRM114-Status: GOOD (  11.27  )
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

Add a 'tls_keyring' attribute to display the contents of the
--keyring option from the connect string. Adding this attribute
allows us to recreate the original connect string from sysfs
settings.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 62f03aa530c8..7a7a4ade59db 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -685,6 +685,16 @@ static ssize_t tls_configured_key_show(struct device *dev,
 	return sysfs_emit(buf, "%08x\n", key_serial(key));
 }
 static DEVICE_ATTR_RO(tls_configured_key);
+
+static ssize_t tls_keyring_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *keyring = ctrl->opts->keyring;
+
+	return sysfs_emit(buf, "%s\n", keyring->description);
+}
+static DEVICE_ATTR_RO(tls_keyring);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -717,6 +727,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_TCP_TLS
 	&dev_attr_tls_key.attr,
 	&dev_attr_tls_configured_key.attr,
+	&dev_attr_tls_keyring.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
@@ -756,6 +767,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	    (!ctrl->opts || !ctrl->opts->tls_key ||
 	     strcmp(ctrl->opts->transport, "tcp")))
 		return 0;
+	if (a == &dev_attr_tls_keyring.attr &&
+	    (!ctrl->opts || !ctrl->opts->keyring ||
+	     strcmp(ctrl->opts->transport, "tcp")))
+		return 0;
 #endif
 
 	return a->mode;
-- 
2.35.3


