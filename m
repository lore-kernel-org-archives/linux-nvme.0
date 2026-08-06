Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21910C56205
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2026 15:28:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Cc:To:In-Reply-To:References
	:Message-Id:Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:
	From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7egV66Tw5ttS7qfHXMMaP6De90WE2iRR/lOw02WA/es=; b=BxT0PNJOsqWaMq2SOxBG240gCL
	QSRKa20ZYFa/IsV7sTP7Ylg6CcCnseUzRP8TUF+1wV9YNZnSpoIOQtueF/eEtSNM/1GjjNT5QuUz1
	sbONbnJZiel+DM0A722MLKgZkKoRSmPmZt6ar9CkF/LrFuyEHXIRwmG6EboKahj2INFTJXvAzmI1H
	VdEYEzUgqJetS0oZnG7Zoby1CBqYLtPT7tUQUYskNjGFd8/Th0b1R/Cj64SHFkNU3ryVlGFe4TEi7
	ttOzGn8br4CDSl4j2wpk97/pBJKR0c9+3b2v+R+qCp+uHnPSRE37Yy6Hg6jPZOk3jSQnGxcF84C8b
	RkuKKsKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01a-000000065Gn-2nt2;
	Thu, 06 Aug 2026 15:28:50 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1ws01Y-000000065Dv-1JbY;
	Thu, 06 Aug 2026 15:28:48 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id B679343803;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 84F7CC4AF0B;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1786030127;
	bh=rnfZSyqO5SxgLMFGkmg/ZiNzhEcvBz3iBs6yNUTN09k=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=cXLO/y2iBrkRJpz1HlXGXMF5tqD4vP6yXuiJ5N/JA9d3ES3IW3qZBa4G4qlMFW0IN
	 ANUJkZ7UyC4KE/SvOjgAnzsVTfywDMkOI1suFMLiML7oSFrApabMBQSOY4+H5cBen3
	 SMk2OgF/eoZO0kRL4aevw/IZT+lg3yxU50P4xN9YZXOONHft97Zfz3j/8F8b9PJpPs
	 U9NdZt76eGqNU72tvTaOpzHs8MhJOHfphKj9tFXjTxeRy7L5bRobDl6/IQhdBclc1x
	 7Jr7yLihREEHH+zS90U5MWzjLeLZ2btqvHnbMgLuN439+QemAVNCfepEopBhWXKkTE
	 GKn0kp0X/h5IQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FDD8C5AC7C;
	Thu,  6 Aug 2026 15:28:47 +0000 (UTC)
From: Sven Peter <sven@kernel.org>
Date: Thu, 06 Aug 2026 17:27:36 +0200
Subject: [PATCH 4/6] nvme: Add a quirk for page aligned admin queue buffers
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260806-b4-nvme-fwabi-v1-4-bde19ce8db04@kernel.org>
References: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
In-Reply-To: <20260806-b4-nvme-fwabi-v1-0-bde19ce8db04@kernel.org>
To: Janne Grunau <j@jannau.net>, Neal Gompa <neal@gompa.dev>, 
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>, 
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, 
 Arnd Bergmann <arnd@arndb.de>
Cc: asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org, 
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Sven Peter <sven@kernel.org>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2136; i=sven@kernel.org;
 h=from:subject:message-id;
 bh=rnfZSyqO5SxgLMFGkmg/ZiNzhEcvBz3iBs6yNUTN09k=;
 b=owGbwMvMwCXmIlirolUq95LxtFoSQ1bJCq1E/91fzvDpvbrK9eVqntrGnKjps5NrFtdxfDy5a
 I3sj0t8HaUsDGJcDLJiiizb99ubPnn4RnDppkvvYeawMoEMYeDiFICJfHJm+Gf3On25DI/Ixa5f
 X4tCNr8yD+f50fPxgtROpovBzW1Sd0wZ/ie/4RQPl78t8tNZ/4W6Ye6eiPmrrz6cN38H27VrDle
 WrucCAA==
X-Developer-Key: i=sven@kernel.org; a=openpgp;
 fpr=A1E3E34A2B3C820DBC4955E5993B08092F131F93
X-Endpoint-Received: by B4 Relay for sven@kernel.org/default with
 auth_id=407
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

Apple controllers seem to require any queue buffers on the admin queue
to be aligned to the NVMe controller page size. Weirdly, this constraint
does not apply to the i/o queue where any alignment is fine. This has
always been required on pre-M1 controllers and is required starting with
macOS 15 firmware or post-M4 controllers again. On M1/M2/M3 we only got
away with this because there was a chicken bit to disable this
requirement. Let's add a quirk that enforces this alignment.

Signed-off-by: Sven Peter <sven@kernel.org>
---
 drivers/nvme/host/core.c | 5 ++++-
 drivers/nvme/host/nvme.h | 7 +++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 453c1f0b2dd0..b76f4e4d8850 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2071,7 +2071,10 @@ static void nvme_set_ctrl_limits(struct nvme_ctrl *ctrl,
 	lim->max_integrity_segments = ctrl->max_integrity_segments;
 	lim->virt_boundary_mask = ctrl->ops->get_virt_boundary(ctrl, is_admin);
 	lim->max_segment_size = UINT_MAX;
-	lim->dma_alignment = 3;
+	if (is_admin && (ctrl->quirks & NVME_QUIRK_ADMIN_PAGE_ALIGN))
+		lim->dma_alignment = NVME_CTRL_PAGE_SIZE - 1;
+	else
+		lim->dma_alignment = 3;
 }
 
 static bool nvme_update_disk_info(struct nvme_ns *ns, struct nvme_id_ns *id,
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index 824651cc898d..957ded0c6f53 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -178,6 +178,11 @@ enum nvme_quirks {
 	 * Align dma pool segment size to 512 bytes
 	 */
 	NVME_QUIRK_DMAPOOL_ALIGN_512		= (1 << 22),
+
+	/*
+	 * Admin queue DMA buffers must be page aligned
+	 */
+	NVME_QUIRK_ADMIN_PAGE_ALIGN		= (1 << 23),
 };
 
 static inline char *nvme_quirk_name(enum nvme_quirks q)
@@ -229,6 +234,8 @@ static inline char *nvme_quirk_name(enum nvme_quirks q)
 		return "broken_msi";
 	case NVME_QUIRK_DMAPOOL_ALIGN_512:
 		return "dmapool_align_512";
+	case NVME_QUIRK_ADMIN_PAGE_ALIGN:
+		return "admin_page_align";
 	}
 
 	return "unknown";

-- 
2.55.0



