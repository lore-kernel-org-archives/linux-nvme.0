Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DB7CC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:50:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3GaOsnfBWvDSn592nGvugCGcQ8tlF5QceqqRVvyOVrc=; b=wfISGHOVKZFgRgYgszAqMfw2jB
	10aMSDbFMG1ILzv9+ZuF2KNLB4HmaUyl1wEcwFjR0woRu6JUjxV5pz+oHZhEy9klDp0LiG/73C7Jp
	T+Ne2J3EUsj/NLKnsF4AL+PuaRWoi9XUbQLT8Nu13+tdf0/2kKNRs8bSQHs31srzBdfSHc+fNEP74
	2rXO7XPdwtEmdd5hdldSia27fZRBsbHQaQNEC+2t8MXkbxAj+ddOZN7l7Bnq28MW13Ri/m3roDrSY
	Xvy9N6+jeQa8WdO75Hh843s91p8pm7Jw6a2rAh849ZVd2OVVWzXxl7SQsUYhsTTRoaYG3zVhps5WE
	zJTCDdrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpd-0076aX-31; Tue, 21 Jun 2022 20:50:41 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kow-007686-3D
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:49:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id B879AB81B31;
	Tue, 21 Jun 2022 20:49:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FA28C341C4;
	Tue, 21 Jun 2022 20:49:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844596;
	bh=cX2vaQcjG25rTY4OOOiTSbbjnXa7+ypoNkn+zs28OZE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=rSAVXe1xb+VW4vcdE8CYCPSqyhMj9JOJUnUPmHqPHzpKankE80vQOHJ4Y8uafDRgy
	 /dLwFbwgUQyphSn6tQ47CSjmIugX4pW1DUsDq/3dlt0xEByNkupemJuVes4bj2mXD2
	 rgDmBDQ9pp4IxkUIWhzRrMpumFwrKiOy4IZQmtkTT5rNCITBjx5zjFUfsw0tO19TGb
	 CaXyootWMjo4UR8oBNkNRCgqo+z51LqjvvsnKCk1Tey0VkPrlCHM6uzTRlo8Cam9Zk
	 YR7qsw/OekZ+IQ+eDO0RKLiP0s05cVVk/47BfqsM1Oueu0eiVWN+iYrqlZz67FHkdI
	 pYpt3LY5Kh4Ug==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 13/22] nvme-pci: disable write zeros support on UMIC and Samsung SSDs
Date: Tue, 21 Jun 2022 16:49:19 -0400
Message-Id: <20220621204928.249907-13-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134958_348215_E3EA2130 
X-CRM114-Status: GOOD (  12.62  )
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

From: "rasheed.hsueh" <rasheed.hsueh@lcfc.corp-partner.google.com>

[ Upstream commit 43047e082b90ead395c44b0e8497bc853bd13845 ]

Like commit 5611ec2b9814 ("nvme-pci: prevent SK hynix PC400 from using
Write Zeroes command"), UMIS and Samsung has the same issue:
[ 6305.633887] blk_update_request: operation not supported error,
dev nvme0n1, sector 340812032 op 0x9:(WRITE_ZEROES) flags 0x0
phys_seg 0 prio class 0

So also disable Write Zeroes command on UMIS and Samsung.

Signed-off-by: rasheed.hsueh <rasheed.hsueh@lcfc.corp-partner.google.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 7d5e40f5a993..04de777857aa 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3476,6 +3476,14 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa80b),   /* Samsung PM9B1 256G and 512G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x144d, 0xa809),   /* Samsung MZALQ256HBJD 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1cc4, 0x6303),   /* UMIS RPJTJ512MGE1QDY 512G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1cc4, 0x6302),   /* UMIS RPJTJ256MGE1QDY 256G */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x2262),   /* KINGSTON SKC2000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
-- 
2.35.1


