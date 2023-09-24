Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02DAECE7A88
	for <linux-nvme@archiver.kernel.org>; Sun, 24 Sep 2023 13:17:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9AvTPsYt9MTiat9bwcwHqWPBwnRomTe/7RLiZ3YWSsE=; b=mlXo5l4usPFtC1SHG5kHE1DnOI
	pE7GSo63v7dAmz7AD3QXsqCMkZ9VUi0woqVMsoWU4OovmiO00IYZ0dtbJkIuJK3FJPdMZdLh8OAE4
	2FEJg6OcpmS2+CM65p3+874JSq5TcYoqznDX0ANSGwpK4+Gvtg9LYtT/xbvIzsJZzsl64s4jHTWuv
	2U9zx3eGRKtWUPCAbJdK5qf/JdKwhU1BzwbGq5m0N28qKZz8NcGlecgykotA/W1lSV3UyPe8Cal0z
	THogjR66hSf9AnWtHSfeVVfOspsC1S20VaI4dvUqtXHI0p0PYisw5uIoz4rGFr4ungAzHdkGNoL1b
	KSCCZ9iA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qkOzP-00CI5h-1c;
	Sun, 24 Sep 2023 13:17:35 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qkOzM-00CI40-2Q
	for linux-nvme@lists.infradead.org;
	Sun, 24 Sep 2023 13:17:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 4059F60C34;
	Sun, 24 Sep 2023 13:17:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49E8DC433D9;
	Sun, 24 Sep 2023 13:17:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1695561452;
	bh=QbUfRCAME0OFI35Aen84HXcS0Q7RnK2CJu+YfIPSrvY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=e7gd3NaDi+vQtuyIX7L+MbvBCGUi6iEKMT4KgOZbehvp85WmxQ+cCl+dVFtUPMktf
	 17EV4ARiY+0yWnh3bfbOGCMqfLDf3mvmzIVAPAPqpqPYDuVUSeF5Bi9dloDlN/mzJz
	 P3B8qfQgcO1Sf4GspuPRU9Tm+kUaot29uTEMJVaX+9+tL/CCQZ4w6ZbGUdt+7Eqb2q
	 tqNiajgany+MX3SqJNRx+QvYRxbHgRsiKthypvn81KaqBXFFPDe2aagYJ8Hw+9Ah57
	 qreNynRmH1yPmSLXTXZ+ED6AHfmeqOo3sx5vY2RJUmeKRAL1NVhBsHfFSHk+qdtAOn
	 4uZyxxaUlOsKw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Pratyush Yadav <ptyadav@amazon.de>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 35/41] nvme-pci: do not set the NUMA node of device if it has none
Date: Sun, 24 Sep 2023 09:15:23 -0400
Message-Id: <20230924131529.1275335-35-sashal@kernel.org>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230924131529.1275335-1-sashal@kernel.org>
References: <20230924131529.1275335-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.5
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230924_061732_827380_944E20FE 
X-CRM114-Status: GOOD (  11.18  )
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

From: Pratyush Yadav <ptyadav@amazon.de>

[ Upstream commit dad651b2a44eb6b201738f810254279dca29d30d ]

If a device has no NUMA node information associated with it, the driver
puts the device in node first_memory_node (say node 0). Not having a
NUMA node and being associated with node 0 are completely different
things and it makes little sense to mix the two.

Signed-off-by: Pratyush Yadav <ptyadav@amazon.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 2f57da12d9836..347cb5daebc3c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2916,9 +2916,6 @@ static struct nvme_dev *nvme_pci_alloc_dev(struct pci_dev *pdev,
 	struct nvme_dev *dev;
 	int ret = -ENOMEM;
 
-	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
-
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
 		return ERR_PTR(-ENOMEM);
-- 
2.40.1


