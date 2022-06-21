Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D1326C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sRx4eX0SsOijcoC1VySSJwBk2IdZlCGsVaa38MiDVOw=; b=nnB5qsdIcL67v5DGdL4Vwqsdlt
	eorbcnz19V+mg9Qug9s059J0RWDTjF3u4o0MCzEHukh5ML+oS51LsJ6itGcjaTml0iFFTY60oUQuG
	XI876jpEMVcYKDF1m29/7K7equ3Moz9eTbEhMxekPjgbVol+CIFUpUFYUWzkcWqJ8haVh6AcEblGo
	nB5Y4YG2/6aAL7zTmlHMAnIR3ZW5vwMRumDR7Cd8KHVj5PvaEsQS5m9MFKPRn1wo+59+TilkfndLY
	VNK3Y+yisSyORBJczQkaFR1K0x4Wp7q0cTRM8I3kwWVk0ZJCVYSTRRwIs0v2atI++CmrMqesyMEvu
	BhngCAgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kuE-00791Q-ET; Tue, 21 Jun 2022 20:55:26 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpp-0076i7-6h
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:50:54 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BE1C66184B;
	Tue, 21 Jun 2022 20:50:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 61FE5C3411C;
	Tue, 21 Jun 2022 20:50:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844652;
	bh=F/Q8v9xOna4LqCh0X9VxEmi6WL3SrcJg/w9zCVR4nzk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Cib0Io00dFaRfZihQSko8Jc3oODIigIWlymexCwa/NDFV3DWKQhGJzppwrgrJQa3j
	 xTt/FptiUk9snCGN+ZTqKL8uk2vYYWCBFuaHMCf0Fe56sDB52CPWkpJwUTYDr8N3Mn
	 bZVcA7MA78TuoJixSAuvKG7r1/i9Isk5LrrvSkQy1Jk/MHMcv+FabjD4vdUKDio06C
	 DcZkIRt/1Xkj8gSjXFlhU01mWb57oEKP+e8eGgDNGknmm9Umvyr13ca5bn3ZrBsQco
	 L9W669aD3/bqJy82ntK0GlUkFiUV3ikeYwFvT7ftnQIQIMGkLk76hRw50ZwVY9gT/W
	 BkHuNI/8Yzpig==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stefan Reiter <stefan@pimaker.at>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 06/17] nvme-pci: add NVME_QUIRK_BOGUS_NID for ADATA XPG GAMMIX S50
Date: Tue, 21 Jun 2022 16:50:29 -0400
Message-Id: <20220621205041.250426-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205041.250426-1-sashal@kernel.org>
References: <20220621205041.250426-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135053_320495_55DACF9E 
X-CRM114-Status: GOOD (  12.56  )
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

From: Stefan Reiter <stefan@pimaker.at>

[ Upstream commit 3765fad508964f433ac111c127d6bedd19bdfa04 ]

ADATA XPG GAMMIX S50 drives report bogus eui64 values that appear to
be the same across drives in one system. Quirk them out so they are
not marked as "non globally unique" duplicates.

Signed-off-by: Stefan Reiter <stefan@pimaker.at>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e0accbf40f49..700857af5b79 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3368,6 +3368,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1cc1, 0x5350),   /* ADATA XPG GAMMIX S50 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.35.1


