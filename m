Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF241C7EE29
	for <linux-nvme@archiver.kernel.org>; Thu, 25 May 2023 19:50:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k+NY13QwlI1y3olnXB8MLXaEaNbxGUzdMb74E2PHNl4=; b=tYHyLSBkyL8CItA0MbzzQqI862
	owKJZBXtfZARIHvEdZ//GlXli/1JMw+MbG091MOXHDt4Y8J7HbMvff9v8hrFI5ANqUTtjNC2Gmtn3
	kOp+wfn7SCamvsyPxtN/lGjALMoISjv3syoAosQRwCKXJWZY0XeB8qs8h71sflW8W39GgH7ecQEfW
	Zugb9g5vWhxnenCQCAtPeUGzcV6gK2nLZz6tU9c9iVO8yIbO3g+mySq46U+ItaBnmZ88Nodju7W/h
	Gv7W92JPWFCAYVgVzw4PyInL3E2B2BKzu8fQluYXlhfpK61KRD362AWCK3VG6BVuRFTAGMJedk9N5
	PKgmEk+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1q2Gyj-0001Pt-18;
	Thu, 25 May 2023 19:50:29 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1q2FrQ-00HRUC-1K
	for linux-nvme@lists.infradead.org;
	Thu, 25 May 2023 18:38:53 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id EAA496495A;
	Thu, 25 May 2023 18:38:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7449C433EF;
	Thu, 25 May 2023 18:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1685039931;
	bh=Ao7IWSDk1SN50uAgnaH1kOq9uEhjM14rY4f3Ua53Xi4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=A1rrLzOBhjl9TmSDB0RvzOPx4C/4Wpw8Mn+b21b29nsV1CFPr8ctE9uEgdxCi9vVJ
	 MvjZ6bfoiq4p7TmtGFmQl0yndNEKhKwi8N8lSBAgnx0re8qpOIxQewYjd6VC/aFJar
	 owNCh8p+h4gGZsyUlCpN01PCrAlHBeitbjG5eij+OGXjELjFUeos54gSyy1F9MjNjh
	 S23Jzx1TvyXe7N8MiM7xA06SLmxD+IYDRI7T4tU1LtQCv7vLNXm9LIrdJShk69rj4R
	 prwlXvm4/wC4Aa9Hi1D4+MwgCVTtkMlQ0Xx89PZqIxeZD61cwT7i2MkOLGHXHgXei3
	 Tf2QWs1DYVzGA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Daniel Smith <dansmith@ds.gy>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 56/57] nvme-pci: Add quirk for Teamgroup MP33 SSD
Date: Thu, 25 May 2023 14:36:06 -0400
Message-Id: <20230525183607.1793983-56-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230525183607.1793983-1-sashal@kernel.org>
References: <20230525183607.1793983-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230525_113852_488396_783CCD71 
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
index 1ec0ca40604aa..ba4903c86f7ff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3558,6 +3558,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


