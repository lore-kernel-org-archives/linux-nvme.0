Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5BF12C77B60
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 19:59:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=pOiarAZDdQ90Ul+3JepZ/VP20eIPzKV9Irhvad1HADc=; b=FKV/tHEY68ICxD3DbdysaYkOwL
	iiZu+BILU8XqTNStqliiMTqavEt1ZEQJcWwyDWkCVGUpTU5yvIpQXiSpMqCtoITmpOkQ4atOZDZtB
	nWdW1A5LgaqepSlLhM7QVnuEz7ulT6hHd+j+E8IbsSlWEyJd89IPA6bBSNHv2E2zLQgsH6UX1uuCE
	Jcn+GB4iqskMb9C+8yeoMxwacaM1Mvm1LmZQcK61PRJ2lOdQXfFwXhUBPsIzKwGZKN+DPGRO4qJY+
	3NwpwuYxRH1Fpx0ODZYJdY3W0FSdfW8CPqXUh0cOmAGBFkQQRhTYSap9LRp5DBRLfeysIG1/U38rD
	b2rF/W1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf4c9-00HFoK-1K;
	Wed, 22 Mar 2023 19:59:17 +0000
Received: from ams.source.kernel.org ([145.40.68.75])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf4c5-00HFml-0i
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 19:59:14 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E3ED4B81DE9;
	Wed, 22 Mar 2023 19:59:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A5192C433EF;
	Wed, 22 Mar 2023 19:59:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679515151;
	bh=IWqo4tjk7Tmyt/rIYoN29L/Rx5DZ5uqOoyeX0+fw47M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NCPCGfw3cJxoMj5wO32pXntKM4gSn/Q1DFVJlvd3zFE/VbnNcRu348X/td/Fc52AH
	 d5+DIVI4AH+Mb/VprDVipvuZiVhR5NSUlVfTP3cAzxENPzhzk5zPPDExh6+DPFyEEs
	 0WjATyxJugtWlfbczC0deOpxG8viJqunu34jgF4rReuY3EbvRej5953Yxb0/pOdtnc
	 bhPFXBPxCdybnuZmnC5dVZo/u5OBC8B0nY31c8nIeQt5cqEiAR1+G/EnXHyxf0oCcZ
	 sz6cyCIBNmoNvv1jRdRr+aR43+mcackOiTSqvNPqA1dzi/CFuHbD/2yiCA38w4DpO/
	 UocGnVI9Cc/cg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Philipp Geulen <p.geulen@js-elektronik.de>,
	Chaitanya Kulkarni <kkch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.2 36/45] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620
Date: Wed, 22 Mar 2023 15:56:30 -0400
Message-Id: <20230322195639.1995821-36-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322195639.1995821-1-sashal@kernel.org>
References: <20230322195639.1995821-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_125913_404421_20D0A2EC 
X-CRM114-Status: GOOD (  12.53  )
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

From: Philipp Geulen <p.geulen@js-elektronik.de>

[ Upstream commit b65d44fa0fe072c91bf41cd8756baa2b4c77eff2 ]

Added a quirk to fix Lexar NM620 1TB SSD reporting duplicate NGUIDs.

Signed-off-by: Philipp Geulen <p.geulen@js-elektronik.de>
Reviewed-by: Chaitanya Kulkarni <kkch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 0a77242794d64..e2fa571420018 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3489,6 +3489,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1d97, 0x1d97), /* Lexar NM620 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
-- 
2.39.2


