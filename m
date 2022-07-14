Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1B1F6C433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 04:26:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=icc4E/psgxjaMWDBCyGZhL2za+Gwh3VwVzaufvUg5PY=; b=Xx6D+LhSd6s4YOaX8a5FgEbDpZ
	PEsmAqdBHD1QEUUDrpWxvt060EpX7MdOoFeP/Ua1Ozs67I+wquQXQIH+DKrGe1b9ibMffZ9wPh9rY
	sD10a+G9bbeyEXPgZ2kCeiJ1hmDzCNn8CqIOabJVkehDy9QlFCdWEbn97hZc0zcZ+Nx8Meo7x8Giu
	onUlCHoTgAN3HHGqrt3YmazSlw1/kVmwAk15noicJ6Sbv/PnFcd9FfPSc4QDZ4bB+bAfLloB+fS70
	XE/omdUdZtrBSJPmpRu7u13bhP/UA8+KGPLgYmkOBi2tgYjJJmorV5khxSOsGCZT/cgISAGa7wodt
	kMWir9Eg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqQY-00AcwT-5P; Thu, 14 Jul 2022 04:26:14 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqQT-00AcsX-Tj
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 04:26:11 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7CA5061EC5;
	Thu, 14 Jul 2022 04:26:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 560ADC385A9;
	Thu, 14 Jul 2022 04:26:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657772769;
	bh=LR5BiutOma/0B/U/EoBoNYPeDfUNWk7C5GzJ7/aCzNI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LELWtHleY4LZgN5UnPFPe/q+szrcgmanKFeALFe4ClyFPe4XD6pK71bUCB/RXz4RQ
	 mDgeALdKa2drFtW0kL8xruzXUQkcIX1tXbCulmh54OMZ6hyp0crEUQf/qyVmJVoqYz
	 Xif70E18y5U20TB9btY0iGWXg2g+1FoIrff3FTi2DiSw1ZVNK85hPTmYCjJbBskMI5
	 J008UyP9RR39OEyXWA5wV/mcvNQNJLAzBatN4BwtKEDz2I0aOz9RadCVr/iiVzewAd
	 7SRxNSvrv8/x2qjRbrV86aL1FHiErFWVzORWmWRs5neApQcAz3qqr2NQwBy9B+XpKu
	 X/9LokPFp1arw==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Chris Egolf <cegolf@ugholf.net>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 14/15] nvme-pci: phison e16 has bogus namespace ids
Date: Thu, 14 Jul 2022 00:25:39 -0400
Message-Id: <20220714042541.282175-14-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714042541.282175-1-sashal@kernel.org>
References: <20220714042541.282175-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_212610_034397_F0D9EBD3 
X-CRM114-Status: GOOD (  12.45  )
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

[ Upstream commit 73029c9b23cf1213e5f54c2b59efce08665199e7 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216049
Reported-by: Chris Egolf <cegolf@ugholf.net>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3622c5c9515f..ce129655ef0a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3234,7 +3234,8 @@ static const struct pci_device_id nvme_id_table[] = {
 				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
-		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
-- 
2.35.1


