Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2C41C3DA70
	for <linux-nvme@archiver.kernel.org>; Fri, 19 Jul 2024 08:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=L5P1+L0T74/ciBqss/M2+fErQO9ymGpPksHLVAx3ILQ=; b=cHiUx1pSCYG2sBBpKeFkUgFH3q
	dYK/x3aLv9b6U3yX2OETxkbGbDAyTk62zdd9MYYNoB97aafgaR4FHdMOh80dcRlH1rmOKvIu3/kqF
	3c5Hr2YiLiS5jpr7kBjJ0TfAIZkz5uW5HI5KEMRrEE9wpSTGlcrAQ30AkdF83lJScwb56GyA5JCxB
	/HL3ZzngGLrJfPyI6az3gYDpvUb3sXKX/0KwP7PvPnwtct1ATl7L8CoVp3J2uyW5lpO3CemR+Idav
	V+iCRfbOT9vmkOC3Af+/xVrF65kKxf1v8I+hqRouMXBXo6Pj/BFDeQhgJ60uBNtucb6fdMF5J/lNO
	SxW4I4VQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9J-000000026Nf-1TVS;
	Fri, 19 Jul 2024 08:39:33 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUj9D-000000026Gq-27on
	for linux-nvme@lists.infradead.org;
	Fri, 19 Jul 2024 08:39:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 4B178CE1B17;
	Fri, 19 Jul 2024 08:39:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37CDCC32782;
	Fri, 19 Jul 2024 08:39:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721378364;
	bh=6xWoWkQ5VjGwOO0zaDkrbdT3+DO+IBIXI7cwOzFZeo0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uD2cIWX2oKzLlUUfFAzX0PfBTc6rN/b1qrIN7X5s9udc2z1/B41BcxNMgO78dNAIt
	 DUMeZyfh1BN7sfQNdC7dutetioBlzxp/TBTOMFHXtQy7MSu1xDjDKy6oeN46Sxuet5
	 p5pgloQvSVDvkXYJz6SLXiIVjRfBX9YpaZ6l1sFGa38lAb+X7wQSX7UOm2iF7edjQK
	 NEHJg0F0B0Dp5+LYTvpavJfE7QFnFEhNyfp6Ah8vEUxcB4BYnwmvhNgtebD+JnOI2/
	 JdbEBRKcAToR1W/pMhdgthMkUUK72Sj3j9gz3s0MYVXxCFbj+wsGeCUKy2W8RKcOCZ
	 OMJIx3HtYu5ug==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 6/9] nvme-sysfs: add 'tls_configured_key' sysfs attribute
Date: Fri, 19 Jul 2024 10:38:58 +0200
Message-Id: <20240719083901.35399-7-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240719083901.35399-1-hare@kernel.org>
References: <20240719083901.35399-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240719_013927_818214_4802D382 
X-CRM114-Status: GOOD (  13.05  )
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


