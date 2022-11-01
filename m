Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2813AC433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  1 Nov 2022 11:30:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=9xYYvMky9AW7T1I6jnxoEaeypVe5yswTAoSs48TBh5E=; b=L97oTMVzaEYXkb5e30/Gz3Dd81
	GZEVlMkJe0nXGkTX4KcMUYml+u2gLD0ylhKDSBeI0Ery94LlRKNymZQuXapwnn6b8FqF8xBvdfEwo
	8e2f5J8SEetJSm2tPrswVxZOIlfAYW2uWP7Um0AhyFukNUNC9i1Zg5pl4vmJsBidQoBZ5JFfKnwfB
	RQEz+o1mfb1vn6mTxBzYGaDxkJp+gVmnBNDERMLET8QQ7sphT8/OUpiz+tfxgwRoF6GHrVgt8l7QI
	4IAlQDIoQkdx329DX97hMShcnOwZOIjyxZqHDbFPGjkHNWut9dvr4JAulR4uy5CctmhuXXhTUaAY4
	/FpIjp7Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oppT4-004cEi-Rb; Tue, 01 Nov 2022 11:30:06 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oppSH-004bdA-NG
	for linux-nvme@lists.infradead.org; Tue, 01 Nov 2022 11:29:19 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 553CCB81CCB;
	Tue,  1 Nov 2022 11:29:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 715EEC433B5;
	Tue,  1 Nov 2022 11:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1667302154;
	bh=tOpZeKAOJMh58ZPuvY2dDkisClZLVE+pnygsqxNEdmk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=FO/cX53WLCtwLVcdQbsY5lT8dORSED6svu0TI/u02wM2a5uLVtn0aLETaH0yzGOLq
	 Zp0MbOQw0tl0izwAhUXNhmiPPiAWa3awIgl3Ds2X36KmXqkZ0g8QBz23gsVazCWbYh
	 Q9VB7udVIi70PriOikxez5BCFMr/Mx+RIf/hLgwgTb6+8nF/rxOV1gKNOlPPMghmqx
	 nItxm1m5B1FbKLvdFepj9wZkfb1m5gfNETVeOgrmOepLEcIpJcKQznbGEJvcg8wt9K
	 WkLbPqujlm1kOb5/1Kq9X06mdOWjh0lx7Xx2r5sveb/i/PAu6LcAMq7g0YgrS7aoSD
	 frZpUlbmQyVyQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Xander Li <xander_li@kingston.com.tw>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.0 31/34] nvme-pci: disable write zeroes on various Kingston SSD
Date: Tue,  1 Nov 2022 07:27:23 -0400
Message-Id: <20221101112726.799368-31-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221101112726.799368-1-sashal@kernel.org>
References: <20221101112726.799368-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221101_042917_937727_2AE9793E 
X-CRM114-Status: GOOD (  12.37  )
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

From: Xander Li <xander_li@kingston.com.tw>

[ Upstream commit ac9b57d4e1e3ecf0122e915bbba1bd4c90ec3031 ]

Kingston SSDs do support NVMe Write_Zeroes cmd but take long time to
process.  The firmware version is locked by these SSDs, we can not expect
firmware improvement, so disable Write_Zeroes cmd.

Signed-off-by: Xander Li <xander_li@kingston.com.tw>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 57cc2bb5b1a2..554468ea5a2a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3508,6 +3508,16 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x2646, 0x5018),   /* KINGSTON OM8SFP4xxxxP OS21012 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x5016),   /* KINGSTON OM3PGP4xxxxP OS21011 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501A),   /* KINGSTON OM8PGP4xxxxP OS21005 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501B),   /* KINGSTON OM8PGP4xxxxQ OS21005 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
+		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
-- 
2.35.1


