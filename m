Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C5C7BC43334
	for <linux-nvme@archiver.kernel.org>; Thu, 14 Jul 2022 04:24:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TPviIXjrKOnj3TZvpGTiDmOKSTlMs45cZCuz3s+ODpE=; b=YlqvxcPvRBPTcNB212Pi6MnDly
	U0qjYh1W1aPAN9zpWROlQ3Abco/L8H42eGZygLOVIkHyIWR+rBBFB72bz7V8YPjAYPHvGyQr55qPl
	6uQNVWgvsTEMCKeOuRwWGbAhknYm7IJJ6vv3yQWdkVwiqhMIp0/gw9/hfHIBQ+h7lfF5tB/eWfrPY
	xBghQ+VT8T9X8UlKXABB95q53OJc5Ke2q5JMfy/B00OprX97NqIGrsKo1/effTho2UUQzz1QHA7bF
	mikIbR1qSMfhRCu/mIvbfwlg40uDfLNTgj16uZQZH1wAEYuOO4V0kmrCVUl3l3JaX7itvnVyfJsgN
	rHuRQvcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqOQ-00Ab5l-In; Thu, 14 Jul 2022 04:24:02 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oBqON-00Ab2H-8c
	for linux-nvme@lists.infradead.org; Thu, 14 Jul 2022 04:24:00 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 7FAA161E94;
	Thu, 14 Jul 2022 04:23:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54F28C341CA;
	Thu, 14 Jul 2022 04:23:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1657772638;
	bh=TrRXWrkQMD56R74PiDCIB/2Sib6HRyWtjxg0iqFt938=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WGDAazUjLIzBKqnpKZMSDsDQqiJJOdwqUHhysKqOeu1Qchasu0XtOlZGRj+seRT6T
	 dIg1VCbnJBl/3lYHnjIHu3jB2RhoCOw86gOC941ODt8+fE7V/jA17khvJFumJYudQ0
	 uJkT6DzoajrwHVq/k2JFWVvWRNdno0H3N1PJAO1zIXeLzQzxl2sXcwFdnSNmH5IaQq
	 VK/jZRHXq0mLSHit4ATWgGMCGM/XuDsmHwIxMM8urqSO39z0FiBdTC5f+m+OKjLuNJ
	 9ege8LQFm/hsX7tpN+0zkOND9tRwpgmn2F9S78g/LOoyEicDPljc2chtZBCVF/LuyD
	 511kzsQaH1ViQ==
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
Subject: [PATCH AUTOSEL 5.18 36/41] nvme-pci: phison e16 has bogus namespace ids
Date: Thu, 14 Jul 2022 00:22:16 -0400
Message-Id: <20220714042221.281187-36-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220714042221.281187-1-sashal@kernel.org>
References: <20220714042221.281187-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220713_212359_401329_58566E29 
X-CRM114-Status: GOOD (  12.36  )
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
index fe829377c7c2..ab575fdd8015 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3432,7 +3432,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


