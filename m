Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D06D0C433EF
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:52:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=fq7J/M0Q1yY8k5PMtzpeWYXgVy/jLgMe6IokatrB7cs=; b=DiAzQPOTH2sC8mHvxk0KGdeu1j
	wA0ZQJztYVd6mg0LlAYkjpKXzOT15sAPr7ihQfTOieguia27JE2JhSVP/NPiiaOxZX+AT4wKspEF1
	XsHSyUBkndDdQK3ya6/tdaRmfmcW/+yX0/VUFArDt4xyllj3ElFa/YIbuDX0KynC1AMPVND2YLaJL
	Th7KmowVLugGgWAIY5XHUyAN7ukRuyS9YZHZp0Mt9WBqmWa5eztAZfiYuW8pt1RkH5430G5s08hMy
	1eQhzrP+cYSvKpM+moykGZoShZ1F/mTU0Il8/uGWh6+Zc/5ZaTnH3Wj5D98ODYv/uNp4hLwpxCBn+
	VZ/mBmIA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3krc-0077hX-15; Tue, 21 Jun 2022 20:52:44 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpS-0076Sy-DU
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:50:32 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 1F977B81B40;
	Tue, 21 Jun 2022 20:50:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D40C36AE3;
	Tue, 21 Jun 2022 20:50:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844628;
	bh=zpLKCkQY/8KfHNxFiYi9fhfvsQMWTfiFxQihdr9gz+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=h2WZ/SP7202lQiRc+VA3ataLbPN5XFOzpbkMjT37g5hfppypFvmg/PgCNcG1gpBqD
	 tD2mT0S5A424TP22G8KvLxY9rNW5KYY7tR2aucFL4nDNDmYrq2qQV6cmvwsp9MIwsv
	 qqKgkrbeZdtQRNksyYfcESjrBwwX39OHOBScfhUb/C2MKn8Gzgd0HXZ/SqMTXGgdPA
	 Qg6O4NFI2rg4m8ae1tUt9MB12LYz6rV2Af8y84RP+ZDhiof/NyJ1QrN4umFYc8fty9
	 ZFYXr+VPcm+0gmN8bh2zZRfW1/xB1Rk0ti6R++B9XgjRDaH3Rn84cRVhjumqElbr5J
	 /o+eIGqWtkavw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.17 10/20] nvme-pci: sk hynix p31 has bogus namespace ids
Date: Tue, 21 Jun 2022 16:50:00 -0400
Message-Id: <20220621205010.250185-10-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205010.250185-1-sashal@kernel.org>
References: <20220621205010.250185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135030_706028_CC0F99E1 
X-CRM114-Status: GOOD (  12.55  )
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

[ Upstream commit c4f01a776b28378f4f61b53f8cb0e358f4fa3721 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216049
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 666746e3bcb6..5934abc24fb3 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3450,6 +3450,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1c5c, 0x174a),   /* SK Hynix P31 SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1d97, 0x2263),   /* SPCC */
-- 
2.35.1


