Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21EF2CCA473
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:52:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=kBUAR+AkxdYHy7wGNXe5AFH9MfXGaUoL/9ty1cWiU4g=; b=eEXYTDNN/wzsVkOi81KxMbXooM
	IbF6ltOCPT2g/vgLPKkoBztWiuYmV+mmcs2wxwEvgQXQK5l7TcF41HgLj3d5QyaNNrONZmJkNe5sx
	97WU7pkvOc/k9hAgsEoQ689K+zVoARdR2/1Vw5brwtJyIEK4G20GySSDUFvrwyPlfua56ygDmfqZ+
	7ei7Y1aOMNPV7xuKTZOd9p0IN7CSyoDlGwdh+UPlcWabjMhWmKpz7iG4v3+P8aLpBZ1sLcXYKLNul
	1hFIKookJsZV+te7uhylkdh1taiFOV96xPLs5nBfpsseATqpDkYxIyUD9ooh67OSSuwcAJ4aU+BvK
	Vn4Mpsgw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kr2-0077OF-2E; Tue, 21 Jun 2022 20:52:08 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpP-0076R3-7j
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:50:28 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id C82E9618A8;
	Tue, 21 Jun 2022 20:50:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E952CC341C6;
	Tue, 21 Jun 2022 20:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844626;
	bh=SMwIdoNQZ2ukfF0D9tmm1kHZyOX0865rKIG9/YHqYUk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nyMm6MPWVFImDHgZfljWRTmudo9alTCayaypDySEXjEfe3c0gHKep3uMWJ4JZWRoE
	 Bt2nZtUa30uy4kqub4iW2CKR6e4iwtjX8V1kaUcXtM6Jewbbi+b1HHhOxg6aZHwznc
	 Mptm84CI6C5cz3ZxFEUZLDF/YIVyM0p8l102YY3nMYE0Wt8ahI0ikGfcL4A6bvEwa8
	 xgbfEdeKIaZPed24XNnISG/+XzkRg9RtUTNes82kfGFfdclZbmjj+5ALOl4KB8SrZb
	 Re1DO3KGN8QDJbFZExkvw6tFxTESsAsDkiy/bAERJM9QWBH7oZBERKL1CC/p2rYgQK
	 TRhs4FZzABuCQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.17 08/20] nvme-pci: phison e12 has bogus namespace ids
Date: Tue, 21 Jun 2022 16:49:58 -0400
Message-Id: <20220621205010.250185-8-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205010.250185-1-sashal@kernel.org>
References: <20220621205010.250185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135027_339095_21E0A4D2 
X-CRM114-Status: GOOD (  12.05  )
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

[ Upstream commit 2cf7a77ed5f8903606f4f7833d02d67b08650442 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216049
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 608394a5cf00..ce2b3906431c 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3435,6 +3435,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES|
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	{ PCI_DEVICE(0x1987, 0x5012),	/* Phison E12 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1b4b, 0x1092),	/* Lexar 256 GB SSD */
-- 
2.35.1


