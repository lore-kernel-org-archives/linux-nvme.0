Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1EC66C3DA5D
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:39:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=y6+sQOW3KX6T43kGyyDkQVBZxhgC3TWiaUeP4a7ayj8=; b=WtF/vDRtkWbOiiwE3+1l6PkwWv
	gUzMT8087spc6pYwHZ3I6ab36wl7j7VCDsci5Ck4YLnuob1I/FeE6zpIZC6KFyZkIMXulTye80q0r
	THZY1876Qun4EPmQHHzSGX3hXpoovXnET0ONsYm5CadXtZ75WrBiKwydpqvfdxCjG+r+QBwKPb5+N
	mODEDeTF5RdE3Dp34l8wDdQQP2eFadtOdK8eFQku3gDPpCiD3QYlRn1nMr0Fac+ThzAIT7RO9ajVl
	R++KLL6aca0AclEjSwgck2GE5KMg6lr0PFWRbVavLwBV54HF8khIQ7bTiOVvMU3rlvrUxDn9gDcYr
	cBV7fQfw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9H-000000026Lr-2JCX;
	Fri, 19 Jul 2024 08:39:31 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9D-000000026HH-0xj8
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:39:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 8C04061C39;
	Fri, 19 Jul 2024 08:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0045EC4AF13;
	Fri, 19 Jul 2024 08:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378366;
	bh=ul2CgpR/EleOy7X9C2v0GoIQQJsVAFLuQcZel8jZ0eY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=eF8vpLtrDM2k1VhaqOTvJE0N9/JVaLDdxci6CeyZLSxowMeWGmXnfuj9hiC6rVQtN
	 O58h2OgpMeqYvkOUUcERgRR3QFJn+U1Q8bO1JBvMWGQw6OKvBjnhVzXwT5O7xRjmaM
	 Dip+7uSalTDBTVKCUiYLoa5f0Zy2bj+tGDzzAxE0MxkeJShScl5qFmNZuEa0ZIhO02
	 JKFKtOjM4/yj/JCQEgKPGuofyA8fdxVZ+c0xvt8FNu886aUvgN8HWQVL7yLmhBqmpN
	 cWzHJykuToo2eqgRe9rBCdvm3UTUxhKgOV34XrP5ixC6hNgfkrC2tLuga9SafzTYqB
	 gvoY4oCwZffYQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 7/9] nvme-sysfs: add 'tls_keyring' attribute
Date: Fri, 19 Jul 2024 10:38:59 +0200
Message-Id: <20240719083901.35399-8-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240719083901.35399-1-hare@kernel.org>
References: <20240719083901.35399-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_013927_354778_4634BBB3 
X-CRM114-Status: GOOD (  11.77  )
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


