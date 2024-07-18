Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6BF6C3DA63
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 14:49:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iVQbJ0k/ZpL9QoZJP1YIAKikm4N7mLhpAb4QN8tAEF8=; b=o1quHPcvZJieeNg5ehNViG3WT9
	t+xhjlrK4WEuyDrjYYLus5lCfn6p7ZVOzCW6J09x8CvnzVhXpwTM6Ba2aVpGS6wFT5WWHTsC/RChz
	8ofkmh6C+mbWF4eFtHv8qIs4C9IGJzprnsB4xI+7ZJJwouufbG5WinVBuUed/IiS35LyNdGNAkP/h
	mYHe7VHK2hDPvjHHIyDwwCWX+OGSMUMeyakbot96qEGbmUEZZx7KuiVwt1hpyBzllNRlqjgnS0Nox
	AFEKeg9IbVoE2tDBvncKwOIBpSxIiv3Pmw/e6wnG/fn9mmJsz5FjI+vkd7vssSUNVDcIaLrgQ6rpM
	52FM7sGQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRm-0000000HKSJ-2HrF;
	Thu, 18 Jul 2024 14:49:30 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSRg-0000000HKO8-3ZyN
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 14:49:26 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4AE7161B32;
	Thu, 18 Jul 2024 14:49:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B47ACC4AF0D;
	Thu, 18 Jul 2024 14:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721314163;
	bh=PZ01QvDc+z85qfQK1Q8Tc8696mUZCItoBpgFuFc24xc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EP+hyjmp4FQaSmXL4ogrqDBE5k/LncPa9txsJ2jnAdLnJqfAzQ/r1N4pUYj12J0XI
	 JbWqyVNaRrejqArNKVCFY/4fyrUzbcKWVC/4FtP9oxUrxYrhFiVAjcWlbeo6D9rQli
	 oRqzDoY3a8LXWtgnp8Cm3qpVgzdNtHNU6SHMRoT2RLdv0WD8uFbKfSijGYL/brtUIW
	 AoU0dXVX7R5qu+gEs1ZNL4aIIjpfoBftqtnjQZ9xm25jxh/Y7OUe1ciH48K5zlgGdI
	 /4t6FwsGgZVNw6Lv7TV8Zm0Kxysisofm6BjiMehcx+TTAgEQ+pP6yr91GHmNKU19YT
	 wXJTk9dKCtGcA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/8] nvme-sysfs: add 'tls_configured_key' sysfs attribute
Date: Thu, 18 Jul 2024 16:48:55 +0200
Message-Id: <20240718144858.19074-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240718144858.19074-1-hare@kernel.org>
References: <20240718144858.19074-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_074924_963142_5CFF3C1D 
X-CRM114-Status: GOOD (  12.65  )
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
 drivers/nvme/host/sysfs.c | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index c391ad6c5a88..62f03aa530c8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -675,6 +675,16 @@ static ssize_t tls_key_show(struct device *dev,
 	return sysfs_emit(buf, "%08x\n", ctrl->tls_pskid);
 }
 static DEVICE_ATTR_RO(tls_key);
+
+static ssize_t tls_configured_key_show(struct device *dev,
+		struct device_attribute *attr, char *buf)
+{
+	struct nvme_ctrl *ctrl = dev_get_drvdata(dev);
+	struct key *key = ctrl->opts->tls_key;
+
+	return sysfs_emit(buf, "%08x\n", key_serial(key));
+}
+static DEVICE_ATTR_RO(tls_configured_key);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -706,6 +716,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #endif
 #ifdef CONFIG_NVME_TCP_TLS
 	&dev_attr_tls_key.attr,
+	&dev_attr_tls_configured_key.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
@@ -741,6 +752,10 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_tls_key.attr &&
 	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
 		return 0;
+	if (a == &dev_attr_tls_configured_key.attr &&
+	    (!ctrl->opts || !ctrl->opts->tls_key ||
+	     strcmp(ctrl->opts->transport, "tcp")))
+		return 0;
 #endif
 
 	return a->mode;
-- 
2.35.3


