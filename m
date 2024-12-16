Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FFC4E77183
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Dec 2024 22:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8twwyk3xGkRO0H4UNJJonbOM06wQyQe6ExuS9KKLDjU=; b=Iy8959yQFVEK8y1M0aoHorJvsC
	bhDlBPqXFGXASAJBfTSNNzJb7mzEuSEx51aS5KD16CZHSqAnlHvxnh8Cb/KCfpVAOhvrGot64QCT0
	c6N5bZKASRhWbQ6uF/5mFzbcADg93CGMfohCzg73odfKIO15sD3UciKnPwLgT7iWvDlmpvKxijUBR
	70lox++yGST2c0/RMFMpDtqI6nYDykTYJzzTvKGBukli6mHRRN261O3RHQmxGZuWIFU2qd/+LUIXR
	RcN8CBegZKNFWCR5B7FWDUnKZg5AI0ibDt94UFv3eSrGeG/G9e9LUlG/B8cE2aeruPZ2hz8vGhitO
	ZNeZGw1w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tNJd8-0000000BZKJ-1wJg;
	Mon, 16 Dec 2024 22:31:58 +0000
Received: from mail.tuxedocomputers.com ([157.90.84.7])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tNJd5-0000000BZIG-3Sy0
	for linux-nvme@lists.infradead.org;
	Mon, 16 Dec 2024 22:31:57 +0000
Received: from wse-pc.fritz.box (p5de4533f.dip0.t-ipconnect.de [93.228.83.63])
	(Authenticated sender: wse@tuxedocomputers.com)
	by mail.tuxedocomputers.com (Postfix) with ESMTPA id 25E5A2FC0055;
	Mon, 16 Dec 2024 23:31:49 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tuxedocomputers.com;
	s=default; t=1734388310;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=8twwyk3xGkRO0H4UNJJonbOM06wQyQe6ExuS9KKLDjU=;
	b=Ls+JEj6qzhr93Ea7kIBFEfNEC3Y4bGt7hN8AbnAdcZIkg2vobRpGiTkKf400ICYsR67jtg
	tbGGYdBQNFELyEB+xi1eL9xhat58x5JEQ7Q++uVXQEU/SsLajl5DHCcJqzLbhhg32nZb8v
	DrIv1fxi2mYsIIpn7JuqUuB4AJZOkLk=
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
Subject: [PATCH v2 1/2] nvme-pci: Add TUXEDO InfinityFlex to Samsung sleep quirk
Date: Mon, 16 Dec 2024 23:28:03 +0100
Message-ID: <20241216223145.135942-1-wse@tuxedocomputers.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241216_143156_293282_912E3AF7 
X-CRM114-Status: GOOD (  11.11  )
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

On the TUXEDO InfinityFlex, a Samsung 990 Evo NVMe leads to a high power
consumption in s2idle sleep (4 watts).

This patch applies 'Force No Simple Suspend' quirk to achieve a sleep with
a lower power consumption, typically around 1.4 watts.

Signed-off-by: Georg Gottleuber <ggo@tuxedocomputers.com>
Cc: stable@vger.kernel.org
Signed-off-by: Werner Sembach <wse@tuxedocomputers.com>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 1a5ba80f1811a..c5ecbda6bd1da 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3143,7 +3143,8 @@ static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 		 * because of high power consumption (> 2 Watt) in s2idle
 		 * sleep. Only some boards with Intel CPU are affected.
 		 */
-		if (dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
+		if (dmi_match(DMI_BOARD_NAME, "DN50Z-140HC-YD") ||
+		    dmi_match(DMI_BOARD_NAME, "GMxPXxx") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PG31") ||
 		    dmi_match(DMI_BOARD_NAME, "PH4PRX1_PH6PRX1") ||
 		    dmi_match(DMI_BOARD_NAME, "PH6PG01_PH6PG71"))
-- 
2.43.0


