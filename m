Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB2EC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 21:02:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MzYzFTrqURVsSZuxbfKJpmp7DBrLrPRPr9UkN7PhwDM=; b=UeNCqqRupJkeW0H3FTyuI/icVf
	vjOxQ5B0GRJ3IW34OwZGrwCclI4fl3K2KtfQMuGMOPRoJbS4JLAmBy3ym6VUfichlQ5xJI/SWwJ7p
	u8hEcCazElbo+4nYesnLGfOUtUoNLlIz29Rj39atpFrLahbygtc0X1VzAfxDUZy7aSZu7zfVtp7K0
	IXNDFgrZGvWshMKam5XYQZqvv4HEcnkEZPzkFMqRkGzfFTX9dv4z72nZJxhrffld9mzt2J5ABkKW9
	z9YbC7Iuz4b0hwPxlmy5IeyZYvs39zlnnLJZl/ZNtiDydbCinlJ0/mmKgN+bzPUME9xPQ/YvlrZbF
	bsDhoWEw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3l0u-007CDQ-6j; Tue, 21 Jun 2022 21:02:20 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kqA-0076vg-BV
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:51:15 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id BFB3B61856;
	Tue, 21 Jun 2022 20:51:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DC8C341C6;
	Tue, 21 Jun 2022 20:51:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844673;
	bh=wpWPKm77SNgupmJW0iUfC5yFgShXH24OzX4IJWMetxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=DbRJ+/oyseJbIHOPkxXKpPv5nbfA8nNqchLhfVRbT0CikelmJsOEU4jqZr2+lEt4r
	 ChwWwSgYgxmhQ25VNwZImA+8sgbRiigvUoBge5x/ncgWSzAUUXO+bZg6ePtMEQrSZ4
	 dPdr9XLVXUffpqZRbg3XVVCwvBQMY1BFL3fFpvwvKytA+3FClX33VRJ39580qMA54V
	 6j0U7fZ8TFr6Ci+l3IDLoxlajtrXgW+/CdIbj6WNf8XYv/WqLkaKPiPlIXe7Hoo/b/
	 laAuLrcwyyTCVKReWoAi1cOuTsEAp9E2FgbfbXIMUj9F4GW51qqtUF3i+hSTZIYYFh
	 Mp6UX9FmPL6Kw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 06/11] nvme-pci: smi has bogus namespace ids
Date: Tue, 21 Jun 2022 16:51:00 -0400
Message-Id: <20220621205105.250640-6-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205105.250640-1-sashal@kernel.org>
References: <20220621205105.250640-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135114_500694_471D6CDF 
X-CRM114-Status: GOOD (  13.17  )
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

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit c98a879312caf775c9768faed25ce1c013b4df04 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216096
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index b806fb3f0f3a..610cf8c2a6a8 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3226,7 +3226,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
-		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_NO_NS_DESC_LIST, },
-- 
2.35.1


