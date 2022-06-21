Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE438C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ddUvWGCPkNgzOXa/PzzHwPS+LeRiuMGyyI+Oqf464wM=; b=TYEQKqfUjLlfmQsGAu2+WNSZ3c
	MiBlZKu3cHYRqbbv6uLnSly25SzKYcB0tKR66JvbKMkJgkEFHsx43/IADLzwNnUqlt+wC5+4SbyRs
	7kreBPoIqsJ5BrITT9IPQNcccvi4PCZFoEDJWy91crwKl+ba3vdqcgsZ2zf5MWxfpcQJo3wTAG23x
	1NSXtsKoL7tY9rEHlI4MTDH+W5E3Ffgkc8U8T/nqEpACcyYnTnaG8nsqnJuezFy5U4A5G1rjt17BO
	BAvxBuOW+C2WMu8S2Z3VMcWqs5S2T+Yx/G4odi0hq3rTJq8DeiEQp8y0Mi9CzcNlURSo+RchwRH93
	dSe6f19g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3ksO-0078A8-Ga; Tue, 21 Jun 2022 20:53:32 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpW-0076V5-DL
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:50:35 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id CB0C5618A6;
	Tue, 21 Jun 2022 20:50:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB47C36AE5;
	Tue, 21 Jun 2022 20:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844631;
	bh=ubsDXvkeA2rUxRYMGsugwHpPN0jkhxvBZaBP/AzP0wg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=Ymo/IUb09ZsVcgyjG3UvQmVpoMGflD2yvspsRxGZsndQ4XPRTC101agxYqe+5orpP
	 nKv+qCpWWNd4OLNprJWqP7BKmk7gy0I3wGPG+8hTrPvf6nK16SPK/YQZIjhHOV4mBJ
	 DYp0U8a5uY5hZYqXom8KSQuIjdddtkPnxmbJXb6eVKi3l6spb3nmV2gCsUQen/SuGc
	 JaJ6iOqainRNip2BCuGAJI98uyYmvMD/SC2Q4e0lkTE1PyTbewcL0Rd+Dx6ShJOtq5
	 U5YgMPWj9ghFNBBG5kiunfj3JBxYCTGoHZqHtFuvXcjgp8Aativx38zCOdiuEJ1uG6
	 nYlgqP5g0beaQ==
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
Subject: [PATCH AUTOSEL 5.17 12/20] nvme-pci: disable write zeros support on UMIC and Samsung SSDs
Date: Tue, 21 Jun 2022 16:50:02 -0400
Message-Id: <20220621205010.250185-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205010.250185-1-sashal@kernel.org>
References: <20220621205010.250185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135034_538496_A9B44121 
X-CRM114-Status: GOOD (  12.73  )
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
index 70dc05c60f2b..d2655cdd46c3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3456,6 +3456,14 @@ static const struct pci_device_id nvme_id_table[] = {
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


