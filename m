Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FD5BC4167D
	for <linux-nvme@archiver.kernel.org>; Sun, 29 Oct 2023 22:57:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XVRa/paZjY4JI6D5R2GtaW6ggxUs6/91ZTchEqwug8k=; b=DwvOzpJM9T5GbbNkpbKmgMiXGR
	k+ehJxXkOC4ZUR3OmUqcwTAPKiDYLu12Mcdmyb4r3nLroHTE3dHWplg3/l2BRfH0iE4MvwqeQncPc
	NG6yD6nmzDl3KbmtcMRfioY1ffXgS5xwsHRORBT1qhJ1zqAGtb8PPm8lVsRkGjjIc8HcDw3RiobqO
	Yy4RBSKNQ7ZOEUUEbxG6kIjYr8Im2y/MQkYe+5cLhFtXecblXAJbqAU1YWA+5vr8+mxYujQGMZODV
	QZMC4KQbTM8CHvENXPYI5qamRCgeo22Y/m/GA3YDgJOkLxH+ukLlPTLU7cd3RVr5ztSzV9S1Xd2pF
	w5SiC+YA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEiR-002Dwi-1c;
	Sun, 29 Oct 2023 22:57:07 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qxEiO-002Dw2-3A
	for linux-nvme@lists.infradead.org;
	Sun, 29 Oct 2023 22:57:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 5D6C3CE1197;
	Sun, 29 Oct 2023 22:57:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FE9C433AD;
	Sun, 29 Oct 2023 22:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1698620222;
	bh=havvXX1A3BkDIs9BfHus35uF0tNKO/3fYel0i7hDJaM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BaJ3XRfUAJkLqqJ0kCDiR5yPykXIT7TvqrjAHWkSg7kVuX0eaqPEvDRTghJMzRrzx
	 rxepF6NAU7qOMrRxYBS9nQ0Y0EpzCHJgffHvNoP+wbj/Q5tYgiymkOfBkRne4boVDZ
	 Oky/crIfyKCdqVU38jTG91bai7vaZlZQUo5h64+kLGVx+3pFbvBc8jLO0tomvsoSnN
	 q6PLCknKKavCDJ699Nx6KZy2LVnXTDHMEH/qcJg7y6OIqjC7kB9ptz4u3coyziTbq2
	 gk09M+a6lTA6DA1Plfd8MGo174YkoC9q+7bkC3zXa1GM7YN/bH1HND8UER4C8SBeaw
	 jwXIOK0CGiQrQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	welsh@cassens.com,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.5 49/52] nvme-pci: add BOGUS_NID for Intel 0a54 device
Date: Sun, 29 Oct 2023 18:53:36 -0400
Message-ID: <20231029225441.789781-49-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231029225441.789781-1-sashal@kernel.org>
References: <20231029225441.789781-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.5.9
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231029_155705_188925_79B24B61 
X-CRM114-Status: UNSURE (   9.93  )
X-CRM114-Notice: Please train this message.
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

[ Upstream commit 5c3f4066462a5f6cac04d3dd81c9f551fabbc6c7 ]

These ones claim cmic and nmic capable, so need special consideration to ignore
their duplicate identifiers.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=217981
Reported-by: welsh@cassens.com
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 347cb5daebc3c..3f0c9ee09a12b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3329,7 +3329,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x0a54),	/* Intel P4500/P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES |
-				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+				NVME_QUIRK_IGNORE_DEV_SUBNQN |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_VDEVICE(INTEL, 0x0a55),	/* Dell Express Flash P4600 */
 		.driver_data = NVME_QUIRK_STRIPE_SIZE |
 				NVME_QUIRK_DEALLOCATE_ZEROES, },
-- 
2.42.0


