Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 26E7EC7EE2F
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:41:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cF4irAiNjDYM2+G6+6OsLtSQExZtGJrE1nsdw2d7tC0=; b=SX/8qgt5AF4+yJEyHQDepYhpQW
	48i7nz5UyYSVhqVXP0lfcpNmKmDGdkWEPAHgIZ2WxaGprWVIhVON5P56UtNYoTfYr5eOzGel6YHSO
	AWd9KwdHB7H/k7Vl19Je7uJKstwe8GQOvm4R80hTBJFk6fI6QBVclXSVFOCzgZQpCBUCpY9m5d0aE
	O5Fb1c9RAoRsXPZqbKWM06kXPKMICnlaceR8n5edTyjmxwzzihKb3ewYex6z30ZNYJ01nDWXpKb2K
	7cgZ0oLxu1UdlrKyU8lisvl89Dt3L0+3hu915/DYI/GpQEQVkf2yUiS0SfwvMX1tNp9gUiqZrBTd7
	QncTIfKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FtY-00HSAh-0l;
	Thu, 25 May 2023 18:41:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FtV-00HS8R-1E
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:41:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id F1EDB6493D;
	Thu, 25 May 2023 18:41:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97313C4339B;
	Thu, 25 May 2023 18:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685040060;
	bh=ghF2GthllgTMSiopveFp2DYgReYP68XguoNsg36BQQ8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ZDXFKHwazEqEq2qsepi7vW9/VWfLbCOJVz828Zni0CrfZUS7KAK3/khycDNL7x0fb
	 gMgINZSXmzdJ7dLS2CjXw4dtNA05K8/+hdfDTjIh6SyTG9djtYqp7AHWYzOwFIHxLv
	 sRrbmeTzL+ZtRpn75OpDPs8L79yoGy+dxuC24tZg3fCTW1O4G5DAqaXe5NZo78wEff
	 dRM4iGCVXFDXpMclwpmgxGbcyt2Tb53kWKZbX62jzzCt9nKXq2+NnM7qn1aMNAPZXd
	 hgGPJqsIy4FgNP6tLoycidVzu0DDEs5cfYxkABW/niSg/q/xyUPzmDqU8fZv05V7qa
	 WWa3q6wki0kVA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Smith <dansmith@ds.gy>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 43/43] nvme-pci: Add quirk for Teamgroup MP33 SSD
Date: Thu, 25 May 2023 14:38:54 -0400
Message-Id: <20230525183854.1855431-43-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183854.1855431-1-sashal@kernel.org>
References: <20230525183854.1855431-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_114101_460234_D9605515 
X-CRM114-Status: GOOD (  12.31  )
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

From: Daniel Smith <dansmith@ds.gy>

[ Upstream commit 0649728123cf6a5518e154b4e1735fc85ea4f55c ]

Add a quirk for Teamgroup MP33 that reports duplicate ids for disk.

Signed-off-by: Daniel Smith <dansmith@ds.gy>
[kch: patch formatting]
Signed-off-by: Chaitanya Kulkarni <kch@nvidia.com>
Tested-by: Daniel Smith <dansmith@ds.gy>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e284511ca6670..d04c06e07fbb2 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3407,6 +3407,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4b, 0x1602), /* HS-SSD-FUTURE 2048G  */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x10ec, 0x5765), /* TEAMGROUP MP33 2TB SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.39.2


