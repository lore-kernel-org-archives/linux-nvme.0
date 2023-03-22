Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F65EC6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 20:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=35UFLuvbOTOlrty0G66aBoVgFd58yuqq8o8jFwWjoUU=; b=VzyO3iMK0xlZpPXqy2JAcvRCMS
	/d8rYJhaE+6JWeHj+XlFUCB7fWeNjdCiTwIQEv/H8ivMQb7fIAzv68bAJ1jXhBTF10Zf7fYw43a0x
	kDPP7jU3llQev8Dz7CCfHZmWTqifSVhjyiD5z7cPsml5yzhqRG3Pul8wDpaj3968HSAmDMgL687nx
	Eic16mnLV/5CJS90taFyEf23Js+JxhdSS81queBGVxfZIsh9qiWr8ITAjxPPjTIGqruKG7iCrE9xE
	Alvg3brTldJkav2Wlvu9uGHr7YLpzMuqWtN9zOK3V06wVUx3Tpj5lCvFshms5WjMAw2Iu5av7RYSu
	4wPcKhpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pf4dy-00HGN9-03;
	Wed, 22 Mar 2023 20:01:10 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pf4du-00HGKn-0f
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 20:01:08 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id E02AEB81DEE;
	Wed, 22 Mar 2023 20:01:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C011C433EF;
	Wed, 22 Mar 2023 20:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1679515264;
	bh=AQ6nU7SHgrEcWyO/dDeU3DSDaMiK10FMK2chPHbMoog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BdlZ+gwU2/pHkvwm80zox2c7v+qHZHS9edyn7L9nrPFhlhjCp7yThd4hc3cf9U8oi
	 464dXSpIrD7gsj+KepN2ZHtGQgCCEtaDPn60Hes+iVkolxnxUC8oo+PufzOhlPl3nS
	 2ZViN/2uBMebD0IvDwqH7LpWwa0RJg+zSD6Tswja1vx3oVkxZc3fOpGu0GKv8cKaN5
	 Xngo9pXmwDBZ6wgxWizbSIRHf6mN+6ZFjYkpP2pV7dAdnIfy2x9MAM1usQVbqYWfdi
	 cAYtMDSuWra4BxJzklmzLBatsb8TWCtFwtO3QJszNHDOJQCSPjwx18B/ltJsp46SXe
	 vnl4jQNS2BvZg==
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
Subject: [PATCH AUTOSEL 6.1 25/34] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620
Date: Wed, 22 Mar 2023 15:59:17 -0400
Message-Id: <20230322195926.1996699-25-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230322195926.1996699-1-sashal@kernel.org>
References: <20230322195926.1996699-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_130107_322338_4FCD20A2 
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
index 778f94e9a4453..7893b52294553 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3545,6 +3545,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


