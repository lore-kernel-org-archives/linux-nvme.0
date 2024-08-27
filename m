Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D88E5C54734
	for <linux-nvme@archiver.kernel.org>; Tue, 27 Aug 2024 10:41:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=O8z0az3FVJk8o0jCJUzYwr7yw2OZPPMX5YYQGX1IePw=; b=A5Df8uOqZ/FRsQa1rmFoLZNcDk
	1Qwk6X+G3Dtzp2xSbOv/STEI+p8xIR0U5tXwVCIQqHE3OmTNylpZgVz9yKvQ3MLboRR5Oe7vCczj2
	xw1+Qftv/fm2cYFlJt1cVkxsOWcVIvD1mO0TBDPg7i6ZIv7TAxXai6O1aSyeoVDx7jFW1rS5U6FmI
	X1Gpf1mWUCj4zdkL5iDzgWy7N+4VxC0Bk7zG/JExWi3hvV5kf+Ns1g1vwAdXQtNi8141dQiTSOzMk
	23NboLSiIci0mfO2Giu5dk/GI7BPM2fZfYYH7AMw/ybhEJUTEZ1KqQTnJzw6Kax4M1whmuWiqweSr
	OTtHoO0g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1site2-0000000Aqs9-02Xa;
	Tue, 27 Aug 2024 10:41:50 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sitdz-0000000Aqr1-057C
	for linux-nvme@lists.infradead.org;
	Tue, 27 Aug 2024 10:41:49 +0000
Received: from wse.fritz.box (p5b164fa4.dip0.t-ipconnect.de [91.22.79.164])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 949BB2FC005F;
	Tue, 27 Aug 2024 12:41:40 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1724755301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=O8z0az3FVJk8o0jCJUzYwr7yw2OZPPMX5YYQGX1IePw=;
	b=qG7YUdX1sLUp1ujY4Od7ahRfqv4wuloFT7a4uNUzyP8/qnJpecziOA0fr0pD8ITJr9C5m9
	dyaqZY5CDKH5ybqjfM9Fh+gg2ca/ywXX1YHgpNA1CYMxRR0+VBHJorVEVuO8gdpBJux3i7
	V4wDhlNdTIQYgDiaSV1z7P4fg7hMmVI=
Authentication-Results: mail.tuxedocomputers.com;
	auth=pass smtp.auth=wse@tuxedocomputers.com smtp.mailfrom=wse@tuxedocomputers.com
From: Werner Sembach <wse@tuxedocomputers.com>
To: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Georg Gottleuber <ggo@tuxedocomputers.com>,
	Werner Sembach <wse@tuxedocomputers.com>,
	linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2] nvme-pci: Add sleep quirk for Samsung 990 Evo
Date: Tue, 27 Aug 2024 12:41:33 +0200
Message-Id: <20240827104134.11697-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240827_034147_526497_460486A2 
X-CRM114-Status: GOOD (  11.01  )
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

From: Georg Gottleuber <ggo@tuxedocomputers.com>

On some TUXEDO platforms, a Samsung 990 Evo NVMe leads to a high
power consumption in s2idle sleep (2-3 watts).

This patch applies 'Force No Simple Suspend' quirk to achieve a
sleep with a lower power consumption, typically around 0.5 watts.

v2: Rebase onto v6.11-rc5

Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
Cc: <stable@vger.kernel.org>
---
 drivers/nvme/host/pci.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6cd9395ba9ec3..48beea7e2f249 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2967,6 +2967,17 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		    dmi_match(DMI_BOARD_NAME, "NS5x_7xPU") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1"))
 			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
+	} else if (pdev->vendor == 0x144d && pdev->device == 0xa80d) {
+		/*
+		 * Exclude Samsung 990 Evo from NVME_QUIRK_SIMPLE_SUSPEND
+		 * because of high power consumption (> 2 Watt) in s2idle
+		 * sleep. Only some boards with Intel CPU are affected.
+		 */
+		if (dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
+		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
+		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
+			return NVME_QUIRK_FORCE_NO_SIMPLE_SUSPEND;
 	}
 
 	/*
-- 
2.34.1


