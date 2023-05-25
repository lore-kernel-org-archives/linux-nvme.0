Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8693EC77B7A
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 18:36:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/ORWpLalwCEl76DxjMpv1/zouOfBYTqkesmKRHyIi+w=; b=CoF0rd3ccOBv5haiTL+HfE2Jx4
	OskXakbs6B81oZd2/mwCFVNYndkdxjegrDpN99IiUcTW96scKVr9vj67HrI9znKUhl7EsOpOMWWyq
	lFxiusIXg0cvhNp436v3wB6FjkLMuYk+NEIBOxVQE+TfmrK9fP89CKS6JrHLFHTOuMoZExe6M2wwH
	Zzmjq/zCPaO4ripyA4GNBm+raMel8nodLy/mtygFScu1GNxDDd3zGLWeYiUsTBFFOlsdScp7fgM4z
	WZLrBfHn+oCPQJba2wPBr2JExjJ5j/X5me6+3XBYnRGteWVOva3RazQIu+YXGAcbGrXrMJrn5oigD
	YeguotDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Fok-00HQUV-2W;
	Thu, 25 May 2023 18:36:06 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Foi-00HQSR-0L
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:36:05 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A234C64900;
	Thu, 25 May 2023 18:36:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9ED2C4339E;
	Thu, 25 May 2023 18:36:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039763;
	bh=8M1QlZJYPuIahW0d56LtS3nUSIIV9445SpQWR8hbXAo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LWRTd+57ia/QKtHbXhZfL4rw9yUzSRJ98HOjvsgcxOuNugfKH3U3hmw72Faq2uUbk
	 K1/2wBiXmrFZfSPXlVNcoD7IaJj2duzBdXuhYNKdkUhNfJ3VzjDt6H9uCNqXxWfDaZ
	 T7KIUbQdNxsfHIw+DQIrNZQB87fpw31nqJ8tpge7Rbcvuj0wHkC70vzpNcGaoh4er+
	 Fx17Flu3+0X3OhVXP373+XH3QaR3dFeYXW88xc8khKxbxQbAFfvlK4Lz+owLNbvuMO
	 kEApHWCTdVCkBngTyyqKat1pV02o8+2Cim9CG55xol20z2kOyGb1H4XlEtWREBLuDD
	 c+FMHj3apeYxw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Smith <dansmith@ds.gy>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.3 66/67] nvme-pci: Add quirk for Teamgroup MP33 SSD
Date: Thu, 25 May 2023 14:31:43 -0400
Message-Id: <20230525183144.1717540-66-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183144.1717540-1-sashal@kernel.org>
References: <20230525183144.1717540-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113604_188082_B407F576 
X-CRM114-Status: GOOD (  12.33  )
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
index a389f1ea0b151..60f51155a6d20 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3449,6 +3449,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


