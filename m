Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C5F1CAC5BB
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 15:14:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GQ5KKwEcSnEaxddQrZRbh9OlTteuEgGTvYy9E9mMSsI=; b=xL0cIMqTEbLSJL+Mi5X4kBsAy8
	3Ge0kMIYl5/oUHvKwNn+AgExiNKTunLDgx+MBE7kgQ5bLeZPjg0RzklCkao5Lqj05S5QRYIA5BppB
	RP/7O1JOa+kfgFM059FX+MMWxF0/4CGPYEAnN/nooug5tx2ICM6FGahJ9ZNVBwlM282ZzwkSV/Zok
	DvQTGc3AIWebZP5tqN0p8l9Ci4leX8uvWVU9jxnIP5jeiF/fvFYyXAL9MLNRfVWJdJHOSilH3EmBT
	38lYWGj8Iz0p6YVfllTsRtrYY/qRti2IN1g7V5b2ItASEjL5G2eVp8PfMA81kfdvfmGHmXYMQlw9U
	XzhzBDTQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWu-00000008LVw-2rnG;
	Wed, 01 Oct 2025 15:14:08 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWt-00000008LV5-1d79
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 15:14:07 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id C644B611F5;
	Wed,  1 Oct 2025 15:14:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1DAC4CEF5;
	Wed,  1 Oct 2025 15:14:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759331646;
	bh=WNxJkgLVqMAct/iQb9StvMpsaEaTgAl8m9IwuDISVMc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=CSN7g+81zLXY2kNqDfQcE6ld5863FRtaE5XcLVWtmTD1kt3MmGAubq8cUWLSyxW5J
	 8PBqFXouB2JueBzYO/EerT4BUUjuGwarukZD0VICWOvaP8/jVrMMYzAJumn54WY0at
	 5SudFIYXTgPCvAMdeNvCLNLeXvDYK+ER9I8YzeMjqdd3nRgi2ppOOBxkTdgz/Wq7C1
	 mtNaikNLvaMx19DXZZCSQATmQhSoXAu9uIDgGZxl9efDE9Fv1stXj/ilJniZ309R1h
	 ADDoQluaoRyEMNiNKkWi6jAoZgRYx9iyrtYtscYjVSI5mG7K29M7kPfkNVPkZ14Oqf
	 BuWAx8lNse/BQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 3/4] nvme-fabrics: make call to nvme_auth_extract_key() conditional
Date: Wed,  1 Oct 2025 17:13:50 +0200
Message-ID: <20251001151351.121181-4-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001151351.121181-1-hare@kernel.org>
References: <20251001151351.121181-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

nvme_auth_extract_key() is only available if the authentication
code is compiled in, so make it condititional on the config option.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509302359.TL1868ni-lkp@intel.com/
Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/host/fabrics.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/fabrics.c b/drivers/nvme/host/fabrics.c
index 3d4d6d8e88c4..67b2ad5ae0fd 100644
--- a/drivers/nvme/host/fabrics.c
+++ b/drivers/nvme/host/fabrics.c
@@ -1106,6 +1106,7 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 	}
 
 	if (host_secret) {
+#ifdef CONFIG_NVME_HOST_AUTH
 		pr_debug("lookup host identity '%s'\n", host_secret);
 		key = nvme_auth_extract_key(opts->keyring, host_secret,
 					    strlen(host_secret),
@@ -1116,8 +1117,13 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 		pr_debug("using dhchap key %08x\n", key_serial(key));
 		opts->dhchap_key = key;
+#else
+		ret = -EINVAL;
+		goto out;
+#endif
 	}
 	if (ctrl_secret) {
+#ifdef CONFIG_NVME_HOST_AUTH
 		if (!opts->dhchap_key) {
 			ret = -EINVAL;
 			goto out;
@@ -1132,6 +1138,10 @@ static int nvmf_parse_options(struct nvmf_ctrl_options *opts,
 		}
 		pr_debug("using dhchap ctrl key %08x\n", key_serial(key));
 		opts->dhchap_ctrl_key = key;
+#else
+		ret = -EINVAL;
+		goto out;
+#endif
 	}
 
 	if (opts->concat) {
-- 
2.43.0


