Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E58B606A331
	for <linux-nvme@archiver.kernel.org>; Wed,  4 Nov 2026 12:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=lists.infradead.org header.i=@lists.infradead.org header.a=rsa-sha256 header.s=bombadil.20210309 header.b=wFZ26u25;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZLi471CA
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=Vq0SiGMeLJwIenodVgGZUYIiDAMpKcytjEsIEBfNJlE=; b=wFZ26u25LnQXEX
	7pbfOgoBW9xs+tq9kbpMB1v90uAoGTMVZ8aiUKcLqBwWt9+IzfSk+pZkQX1VAx+iu5JLGt8CTXL7B
	lz4W8VoDVCnTa/eForEkaDqF1O94uOpuOk5EN+2uOz7pY1AiYpVfYsI5vCBOVOcxlt5Ac+fuDdVK2
	ql+0UWjBSNDlP7qwOcYX91lnMInysa8z1a7Uz0rJycGrRgq7y4NJ6pGDf7KiARVZPdM18ojrLySkJ
	UdrhBaZwnU/A/IXbKZSOxD5SGzFJSHVAKHCQHuxZ0H0I3bnLkK5jb776CvDRlqPJydLsUFfE/yu1l
	XFr64SOx9MlDHryGg65w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZwa-00000005Hic-0oq5;
	Wed, 04 Nov 2026 12:18:20 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.100.1 #2 (Red Hat Linux))
	id 1xOZwZ-00000005HiU-0IQe
	for linux-nvme@lists.infradead.org;
	Wed, 04 Nov 2026 12:18:19 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id CF18C43BBF;
	Wed,  4 Nov 2026 12:18:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1E7B1F0093A;
	Wed,  4 Nov 2026 12:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793794698;
	bh=Vq0SiGMeLJwIenodVgGZUYIiDAMpKcytjEsIEBfNJlE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZLi471CACiKnTdCvn08B7kqta0aEBj2VvHclvkQKyiUocHvz4Wy7xYoK9+WsLhKG/
	 B3g9IWEPBCU4acr3ZWe2bENLCo3Xg+mGBXi7TgardIyGNb3FGqC/IUEn3+4IQfEICh
	 fJFuF5OSfEgkl68Bh+l7tWF7vaitas/L11YQoZ1aKqACgh6cy788XHGrQPRPAHVFoV
	 8zN/vGXtBPPdarcTmZd3eqWBH7qx2y7tcLg7Zu/VZc4o3qxSq09XOvF2zyddDzTYkI
	 CCyDgOz5vdI863KmZH05i8IJpPJlrxeFmHS4gvo9XkD6IkT46ng1ObrfTkC2wIqc0w
	 3MMAJuHYyKMSg==
From: Sasha Levin <sashal@kernel.org>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	Sasha Levin <sashal@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2] nvme-pci: add NVME_QUIRK_DMAPOOL_ALIGN_512 for KIOXIA XG10d
Date: Wed,  4 Nov 2026 07:18:16 -0500
Message-ID: <20261104121816.3726177-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261104090332.GB30750@lst.de>
References: <20261104090332.GB30750@lst.de>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The KIOXIA XG10d reads past the end of a PRP list that completely fills
a 256 byte small pool block. When that block is the last one in its
dmapool page, the read lands on the next page, which usually isn't
mapped. The IOMMU faults it and the controller craps itself:

  arm-smmu-v3 arm-smmu-v3.0.auto: event: F_TRANSLATION client: 0001:09:00.0 sid: 0x20900 ssid: 0x0 iova: 0xff7fe000 ipa: 0x0
  nvme nvme0: controller is down; will reset: CSTS=0xffffffff, PCI_STATUS=0xffff

Filling the block requires a slightly larger write, and those became common
with commit 2e8e30b3cf9f ("Revert "nvme-pci: clamp max_hw_sectors based on
DMA optimized limitation"").

Do what we do for other disks and use 512 byte aligned small pool blocks
for this controller.

Cc: stable@vger.kernel.org # 6.4.x
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 019a1e3cc0a2..2be6d1a9ad4d 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -4430,6 +4430,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		 .driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1344, 0x6004),	/* Micron 4100AT */
 		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
+	{ PCI_DEVICE(0x1e0f, 0x0032),	/* KIOXIA XG10d */
+		.driver_data = NVME_QUIRK_DMAPOOL_ALIGN_512, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
-- 
2.43.0


