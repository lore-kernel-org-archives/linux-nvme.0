Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEFFC4332F
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Nov 2022 13:50:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XaFRuyuAWQLKXs82lMqlPI52kvHdbMsiwZzz0MVOz54=; b=ZLvjZdfl/rO1DmbfR6tcTmYTaU
	DSeCVmt8RValR0oZtmkoEIDFa+nYHPo1/aK1zZyJ2U8E0Bzl/EqQbFewUh00AAGBcjh4FJrmkimmZ
	oNX0C0F7YCs/7YwhOdVz4b4S/jeS8CbR3VP0wTvLr54+o1YTHEdR542otljgfTJcAdOhlc8grH39B
	/6nHvp3ycsz+bsme2FBtJE6FTqK2fhHiXiO1c1kYf/9vm6Oro0Smql8l9FBmsf7fsXv0+NKHr/Xnl
	JSUbap3sjF5INJwLxQykV9TECcsxB8x/e+dc0fI7XOcnuR/t5vzpIFi6Mm1t5Aer7S194uLogVrdr
	b21K0upA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouZqt-001Ply-OR; Mon, 14 Nov 2022 13:50:19 +0000
Received: from mo4-p01-ob.smtp.rzone.de ([81.169.146.165])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ouZpp-001Pg9-6l
	for linux-nvme@lists.infradead.org; Mon, 14 Nov 2022 13:49:15 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1668433742;
    s=strato-dkim-0002; d=iokpp.de;
    h=Message-Id:Date:Subject:Cc:To:From:Cc:Date:From:Subject:Sender;
    bh=XaFRuyuAWQLKXs82lMqlPI52kvHdbMsiwZzz0MVOz54=;
    b=sjlHKKS0i50fNiba9s72G3UDHr5J1glruCcTyntjCaJxW7eTqHKquqKXLwPNCUwyTX
    dxsFbDDpWo5DqMHhssNbR3XLT9Fzm+643ZltdvbkBmXplA49zDs2nkwAt3+Azn2uoxiM
    Y+aMgzO88ptwPYDTMxxDvrvSCis3qUwijyFDwfhKmf0Zn85gtXpOwEtUmmaGxVqkQjxL
    m8qilyCLokvfC1r80n5jkg/b2363t51rqle9ZRBiVgnWiSYTX2c9VgQVZQugCL9dWZ3o
    CUBe6loRUI9ltV3MVCtNGn9C1jyG4KSuS1iuelCV2kZkSCusk1eoID3fKohhlvEav2sL
    qHaw==
Authentication-Results: strato.com;
    dkim=none
X-RZG-AUTH: ":LmkFe0i9dN8c2t4QQyGBB/NDXvjDB6pBSedrgBzPc9DUyubU4DD2QzemV2tdlNlNRZBXiUw="
X-RZG-CLASS-ID: mo00
Received: from blinux.micron.com
    by smtp.strato.de (RZmta 48.2.1 AUTH)
    with ESMTPSA id z9cfbfyAEDmw9Qh
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
	(Client did not present a certificate);
    Mon, 14 Nov 2022 14:48:58 +0100 (CET)
From: Bean Huo <beanhuo@iokpp.de>
To: beanhuo@micron.com,
	kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Micron Nitro
Date: Mon, 14 Nov 2022 14:48:52 +0100
Message-Id: <20221114134852.73402-1-beanhuo@iokpp.de>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221114_054913_624714_527BAC18 
X-CRM114-Status: UNSURE (   8.73  )
X-CRM114-Notice: Please train this message.
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

From: Bean Huo <beanhuo@micron.com>

Added a quirk to fix Micron Nitro NVMe reporting duplicate NGUIDs.

Cc: <stable@vger.kernel.org>
Signed-off-by: Bean Huo <beanhuo@micron.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index bcbef6bc5672..5ded5703e06e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3491,6 +3491,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	 { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
+	 { PCI_DEVICE(0x1344, 0x6001),   /* Micron Nitro NVMe */
+		 .driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
-- 
2.25.1


