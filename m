Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61F7BC369C2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Apr 2025 11:14:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=orN51jsUUuIP+9XGNd3JJDzRFNvaaE17p67/e6L6grA=; b=E/BWjUqZz87hrV4x9Z+KuttDb6
	2hbn139aniD4WuzOY3phQ8UCO4aAkdvETIuq11e1iTuwa8B6lihqtEtkPjvcHw/mBDFJ6OsbDXk6A
	wve7IadBgApq9dLGJZ2l/iK/GvPAyVYMoF7ridZdT4E8YR2tTho/GB2fx9o08/RoAPxdlkK5VhXiU
	OeKXW6jc4JTLApIsOdwVI2Uu98+aF/MKUC+vnNlOKSddptQ9DOownyp12SCS5BTFX9V8yOGr9qPOF
	69TECmOq+txwpc4hcEnafC+0iuj4zPvhIKkxXAep7r9Mfc30LpmQZTEBWKtpnXMccnaj8wA13gcPq
	DtkNo4Mw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8H0a-0000000Gtf5-3nKM;
	Fri, 25 Apr 2025 11:14:16 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u8Fh6-0000000Gbvh-0PFG
	for linux-nvme@lists.infradead.org;
	Fri, 25 Apr 2025 09:50:05 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5F91EA4D119;
	Fri, 25 Apr 2025 09:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CAD1EC4CEE4;
	Fri, 25 Apr 2025 09:50:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745574603;
	bh=1Nwp3yvQVCa3urFV5c7GCuZ2W/wZaQRhUiepaMpxDBM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BBHJHlPiCbrWGnf3RNXFIQJZHUWGPTPt8Iq76ZVfNTmtPshjcdWa605wsRf5bP+Tb
	 Xq3qVnXOjif3tP7dbITqk36kbaxdUSOr+YbhqYxpZ1w/MCs2Tq+ZK6oE4om2OeICe6
	 vm+wFfpoU0jbYypvz2mxJc0V/G6PPES53uIK9S1d+NXLrVwWir4QdvJrg+jdpJeLm1
	 7astF0glNqC58+ItaaYEW0YGK3a6NiEHBqWwgF3kS8W+AsQPCLHXJr77q9jzmUNsnl
	 7knKAX/gQaupmKO1lIhLnDBp7tihDdwx8KWsqeyHfvae8MObhRw90kr+FKYQPLSd6o
	 0onl6HYGLaNBQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 12/12] nvme: Unify Kconfig settings
Date: Fri, 25 Apr 2025 11:49:27 +0200
Message-Id: <20250425094927.102656-13-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20250425094927.102656-1-hare@kernel.org>
References: <20250425094927.102656-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250425_025004_195673_BA4BD840 
X-CRM114-Status: GOOD (  10.77  )
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

As authentication now requires the keyring to be present streamline the
Kconfig setting to always select the same symbols for both host and target.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/Kconfig   | 3 ++-
 drivers/nvme/target/Kconfig | 2 ++
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/Kconfig b/drivers/nvme/host/Kconfig
index e7fb34fdc28b..4873c22d89d1 100644
--- a/drivers/nvme/host/Kconfig
+++ b/drivers/nvme/host/Kconfig
@@ -100,8 +100,9 @@ config NVME_TCP
 config NVME_TCP_TLS
 	bool "NVMe over Fabrics TCP TLS encryption support"
 	depends on NVME_TCP
+	select TLS
 	select NET_HANDSHAKE
-	select KEYS
+	select NVME_KEYRING
 	help
 	  Enables TLS encryption for NVMe TCP using the netlink handshake API.
 
diff --git a/drivers/nvme/target/Kconfig b/drivers/nvme/target/Kconfig
index 28b5229c48e2..14e2a484527c 100644
--- a/drivers/nvme/target/Kconfig
+++ b/drivers/nvme/target/Kconfig
@@ -96,7 +96,9 @@ config NVME_TARGET_TCP
 config NVME_TARGET_TCP_TLS
 	bool "NVMe over Fabrics TCP target TLS encryption support"
 	depends on NVME_TARGET_TCP
+	select TLS
 	select NET_HANDSHAKE
+	select NVME_KEYRING
 	help
 	  Enables TLS encryption for the NVMe TCP target using the netlink handshake API.
 
-- 
2.35.3


