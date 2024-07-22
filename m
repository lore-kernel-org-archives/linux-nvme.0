Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8EBCC3DA59
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 12:02:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=co0ZX5bbGZhvimzNo1uyy+B477CITI8+1mHMW8IVQbU=; b=ei7cuHW8VA2KUvjeG7xulSGWzF
	BHA/qyVt+vha3fTMno4FNd1AL8NE7Wf6syorNvDr5U1h36Xm7CuYeB/BzioNOi4TuEZRLu0DJmzIT
	QGKF1K3Pi/UJ/hUc4+odAzyjrEW6oIbSw+/Zt0zg1MXExW4TpxENQBs5PdEtQEo4JzuSj+5yAz6FT
	rgNunu2NwE8Fk+jhKYloS6lELFjoLHqjUrW1yMeawax1NQ7M1IULfyXaKu1hIaqOu5ZgXRTpYsTZB
	/ccIKxnQGBFfbZfw8Qe6hRcImEir4dveOxiCU/62RclGHpjVdQIbBeMocRubP4ktTBnvpnqIVUqKF
	KW1HDrrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrkf-00000009Sg5-13Gq;
	Mon, 22 Jul 2024 12:02:49 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVrka-00000009SbA-3E5o
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 12:02:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 0E7AFCE0B22;
	Mon, 22 Jul 2024 12:02:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CDDEC4AF0B;
	Mon, 22 Jul 2024 12:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721649762;
	bh=xiFQPKVI/9Cz7VaKbI/606yYVrBWjLeBlJMYW7eKz0Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=l4eXMs8bqT7vXjAjAlV0LuRcBZbM6l48Ww0XmNwIrCvh829W8KW8HXFH78GpF8KqQ
	 VT3dQGQqe7zuuuZq7dwwjAIbNwCxE9XSCM1ULH8BPBSFVndclCITamZdWDkLiXZPXo
	 f+IHlq5SqP7whesittoPIVJMPRK74axuPELLz/y2rZidB75ktB2VlhWtjO77zv+r81
	 IGDYl8xZzaTfEJ3aFbnBpyZxt3cEe2CGEu4jU0NMfzkm0Q+KJZjZiuoq6hJKpnbFAE
	 +bQRPYKpkFD7dDbkiyY67jQopGE8U81rsnfTHtAklLRp0EGCH3tuI38ZTXp8aDhgFY
	 BL9mn2CjP5MMg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/9] nvme-sysfs: add 'tls_keyring' attribute
Date: Mon, 22 Jul 2024 14:02:24 +0200
Message-Id: <20240722120226.88737-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240722120226.88737-1-hare@kernel.org>
References: <20240722120226.88737-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_050245_029287_35BFD840 
X-CRM114-Status: GOOD (  11.93  )
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
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/sysfs.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index 2055dad7bc63..eb345551d6fe 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -753,9 +753,20 @@ static ssize_t tls_configured_key_show(struct device *dev,
 }
 static DEVICE_ATTR_RO(tls_configured_key);
 
+static ssize_t tls_keyring_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *keyring = ctrl->opts->keyring;
+
+	return sysfs_emit(buf, "%s\n", keyring->description);
+}
+static DEVICE_ATTR_RO(tls_keyring);
+
 static struct attribute *nvme_tls_attrs[] = {
 	&dev_attr_tls_key.attr,
 	&dev_attr_tls_configured_key.attr,
+	&dev_attr_tls_keyring.attr,
 };
 
 static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
@@ -773,6 +784,9 @@ static umode_t nvme_tls_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_tls_configured_key.attr &&
 	    !ctrl->opts->tls_key)
 		return 0;
+	if (a == &dev_attr_tls_keyring.attr &&
+	    !ctrl->opts->keyring)
+		return 0;
 
 	return a->mode;
 }
-- 
2.35.3


