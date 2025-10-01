Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2616ACAC5BB
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Oct 2025 15:14:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=aQ1dRrgwWoNjqf7keQGjvBoVRyauNY2Ej5HN9dZXHr0=; b=XgEUb0osQSMUUlHnCbAfldDZYB
	JycAzRJAdl4AtBiLAztiDReU8d1aq1bzxLDn3mNzAWYEZ984kkRcDU6nFjYTx58Ka8YJ+WNlWbsMR
	wstG2mXDJa3LJy2vvF8tqSLWawA/lgAiqspdJ4EB4s/eAEhq+TNPF2AT1uPsxzdWiJswmOoYDAS0F
	3sYNxE6s2Op1mQQWAkfYrdJTfvtzo6pFx2B50MLDH4cfotGhYB7S1h6YW0cmbEtHHCogJoQamLtGd
	L1wsQ7bf6MDOrJUFkmA7+H9XILNkRHhe8V/C9rPhZL+QDzMZvZIYB0jh5VbINdmirZy8AASkYrzUV
	X6+f0gRg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWr-00000008LTs-262o;
	Wed, 01 Oct 2025 15:14:05 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v3yWp-00000008LSF-0Pxw
	for linux-nvme@lists.infradead.org;
	Wed, 01 Oct 2025 15:14:04 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id C91DE43678;
	Wed,  1 Oct 2025 15:14:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EC66C4CEF5;
	Wed,  1 Oct 2025 15:14:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759331642;
	bh=oFacma2stAn6spCCFW6rBwojUKxWKsd12adH5BqLejw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Xbt8KryTOcc4xA6kVXF/8r8EBMtUfnjzyY44D6AYTA0zwMEJpIFL4VDyGy8Aw2DL6
	 mLxwgR0oqWMXxt4qL2qFv/ks4rkVzRgVHlNbcqdZ4VyOGHoHwu8oCb/KqMBNxN5tKr
	 8/BV3LsZbhBWdIq69Ecqc5Gv27lavbaCdQsVFVbKVrbrzhRV/1a34Ns3N0kpNIRPdH
	 YonucWYJxyh6bkJg7rQGdl0JoqtJxGOLvhsrBXA1+8WiHfUT/8xvg0J7DJK98/vxdM
	 32RAK14U8sh5l1apSbYLeAnVPEIPBWY6Meya2C4ZvqVL6Eq3ZyFQqGBhINMyPfy6nG
	 L3BR5AWR8/58g==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>,
	kernel test robot <lkp@intel.com>
Subject: [PATCH 1/4] nvme-keyring: use correct format specifier
Date: Wed,  1 Oct 2025 17:13:48 +0200
Message-ID: <20251001151351.121181-2-hare@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251001151351.121181-1-hare@kernel.org>
References: <20251001151351.121181-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251001_081403_159561_72B50CE9 
X-CRM114-Status: GOOD (  11.89  )
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

Use correct format specifier for pr_debug.

Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202509302151.WHyjRfcE-lkp@intel.com/

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 drivers/nvme/common/keyring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/common/keyring.c b/drivers/nvme/common/keyring.c
index a58c93c6d495..1de07e8a8f73 100644
--- a/drivers/nvme/common/keyring.c
+++ b/drivers/nvme/common/keyring.c
@@ -340,7 +340,7 @@ static int nvme_dhchap_psk_preparse(struct key_preparsed_payload *prep)
 		keylen = 70;
 		break;
 	default:
-		pr_debug("%s: Invalid data length %lu\n", __func__, datalen);
+		pr_debug("%s: Invalid data length %zu\n", __func__, datalen);
 		prep->payload.data[0] = NULL;
 		prep->quotalen = 0;
 		return -EINVAL;
-- 
2.43.0


