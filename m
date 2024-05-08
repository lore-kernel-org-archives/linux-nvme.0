Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5D1AEC04FFE
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 10:24:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=4feMCzRarDS/WGbgt2As6Sn26Tp2oS8a8wYvnW7ISi0=; b=Zqarvar/upSyI/h7Fm99KkWkrM
	9CDQbVT0b7K+k6vrVrmOZRKAS6JTB17BdqhofG5XaRSuc8/oM5eWnYgP4g+8YF+K8uh01Jr4iC0D+
	fyykldpvwp3eJ6KXiKUGQ+0XUyY5VMPpcmgBVNPmUbuoBlcQJtlLl3cE2kPizS14Ix5KQIWPJGq1v
	MnyE1UdPFynjMSaQNyMoi24m430enjtzJCNtzjmgwdtg/GqbJoHfIXO1rUYKr+EybJH1EQHJifYDe
	kVG3RrcOao+kbrq8lq50Mzp+6c7VvgPozBTyL248VkPe8faNOFw+O8c8DwS3FU4TqGNDryZHWmeql
	L9Vc4qkg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eTC-0000000EyWi-0Q0E;
	Wed, 08 May 2024 10:24:18 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSd-0000000Ey7G-0RR0
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:50 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1179E61B4C;
	Wed,  8 May 2024 10:23:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980C7C4AF63;
	Wed,  8 May 2024 10:23:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163821;
	bh=WNkgWFxRfYf8Z/ebCKQaMdmJH/1rl0azN5emNeia2lM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=gmcFjbZcRqFd2wNkBRv7TaXaFVcgUHGmreXIYCKy+qQPwAM2N2TvjVzf4b7Ke9ZPb
	 CDcWeDzNi0KmSjYqajX93Qx2KEsr9lUK52Cs3k3TXXwxfsDwvLkdRfBvtXN8a5UAsS
	 2vwxuKM9PMSv//Rnw2S2XgcT0EwIr4F2CqGJLuqgsTMriemD588g2recmmsTmi+5ZZ
	 sfYZecHRwkdjK4XLfZ4tS2P7OZmMEz0hBrHo8B/UB/i+nEhy21+zcwpXmxvEe4iYD9
	 3ucMwgtqeEetaXp3vDZHoJ1DnHWNWzv/KzmWNjvZi9b67upBfcw/ZOvSmaqW/IlOKa
	 E3oZmTxpEGYyg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 11/19] nvme-sysfs: add 'tls_keyring' attribute
Date: Wed,  8 May 2024 12:22:57 +0200
Message-Id: <20240508102305.108949-12-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240508102305.108949-1-hare@kernel.org>
References: <20240508102305.108949-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032343_549477_2DAF8E1F 
X-CRM114-Status: GOOD (  11.57  )
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
 drivers/nvme/host/sysfs.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/nvme/host/sysfs.c b/drivers/nvme/host/sysfs.c
index e5cd738660b1..462d71e2fbf8 100644
--- a/drivers/nvme/host/sysfs.c
+++ b/drivers/nvme/host/sysfs.c
@@ -689,6 +689,18 @@ static ssize_t tls_configured_key_show(struct device *dev,
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
+	if (!keyring)
+		return 0;
+	return sysfs_emit(buf, "%s\n", keyring->description);
+}
+static DEVICE_ATTR_RO(tls_keyring);
 #endif
 
 static struct attribute *nvme_dev_attrs[] = {
@@ -721,6 +733,7 @@ static struct attribute *nvme_dev_attrs[] = {
 #ifdef CONFIG_NVME_TCP_TLS
 	&dev_attr_tls_key.attr,
 	&dev_attr_tls_configured_key.attr,
+	&dev_attr_tls_keyring.attr,
 #endif
 	&dev_attr_adm_passthru_err_log_enabled.attr,
 	NULL
@@ -759,6 +772,9 @@ static umode_t nvme_dev_attrs_are_visible(struct kobject *kobj,
 	if (a == &dev_attr_tls_configured_key.attr &&
 	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
 		return 0;
+	if (a == &dev_attr_tls_keyring.attr &&
+	    (!ctrl->opts || strcmp(ctrl->opts->transport, "tcp")))
+		return 0;
 #endif
 
 	return a->mode;
-- 
2.35.3


