Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78B2BC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 28 Jun 2022 02:22:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nsoV+2+N46t0WtltdCv8Sq+EnfzA49iJLV99S+ubJ/o=; b=W56pA0Jh+b7E2MAARFGBAFS3I3
	TGnGtWtLYI5RBQhw/C+QTpWAW/YpXomPtSCeOshn2ba1JqlhHrE2fjeiF8xkNUQccMc4CY28eurds
	5UEN0RAmi88tKNnldBZjfSucW9O5jhHLdAmzjxtYrKl71UsyW5FPrVrtHcquqL04LqxTsg3cOvty6
	4Urj3hd8h1t//7gu5cSGiNK2wu9Zb2w9Mm2zjBloeEKc8z5GL2vtjJ66QGmkNb9+uPq6S69lsuU3y
	YANjXOtWcbNndufDEEfW5HToeszNICrIF/8Bot0cDAoa/W+1Z1eAUH+cDpNMbgoec/c1fUdV50nKW
	2V9emvtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o60s3-003gP5-2U; Tue, 28 Jun 2022 02:22:31 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o60qa-003fSH-AD
	for linux-nvme@lists.infradead.org; Tue, 28 Jun 2022 02:21:01 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sin.source.kernel.org (Postfix) with ESMTPS id D8364CE1E29;
	Tue, 28 Jun 2022 02:20:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E373C341CB;
	Tue, 28 Jun 2022 02:20:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1656382856;
	bh=m39DnLMFvF/zTka2kp9IJefHGcU3SBJbyVByCA/gd1U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=L11be+W/19mkZaXvt2wJFa/KcPNm3YrgCA5AMCCfEjfZmb8y3FGEKuQR3P0dpWTAh
	 JY0+JSCma2lKrCu3UeVtLY5YexTsB+Odjb56YUiqW1g6kQeEAfK9C9DzMsect662+B
	 WpU/iRoiNnXCXq9EIEL2w5w7XhZ0sn8PzxMM8Z/E1w+8VqCu5mha9fyC7xRRda5i0L
	 9HB4Px97aF5fbf2nrov8dWxzCK+RNr3BueRujE3vH54DLTQGDVRRAHmQKZOJ0QSA3V
	 o+JXsQt0nndxDWEbIUeAWv0PsW7C+JFlUhcNUcTVYjk2IRA7G+qYV+xauMorGkSpVD
	 ZXKCXHneZCYpA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Leo Savernik <l.savernik@aon.at>,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 51/53] nvme: add a bogus subsystem NQN quirk for Micron MTFDKBA2T0TFH
Date: Mon, 27 Jun 2022 22:18:37 -0400
Message-Id: <20220628021839.594423-51-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220628021839.594423-1-sashal@kernel.org>
References: <20220628021839.594423-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_192100_599235_21A82239 
X-CRM114-Status: GOOD (  13.44  )
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

From: Leo Savernik <l.savernik@aon.at>

[ Upstream commit 41f38043f884c66af4114a7109cf540d6222f450 ]

The Micron MTFDKBA2T0TFH device reports the same subsysem NQN for
all devices.  Add a quick to ignore it.

Signed-off-by: Leo Savernik <l.savernik@aon.at>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 17aeb7d5c485..e69d0135d74e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3441,6 +3441,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1cc1, 0x8201),   /* ADATA SX8200PNP 512GB */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS |
 				NVME_QUIRK_IGNORE_DEV_SUBNQN, },
+	 { PCI_DEVICE(0x1344, 0x5407), /* Micron Technology Inc NVMe SSD */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN },
 	{ PCI_DEVICE(0x1c5c, 0x1504),   /* SK Hynix PC400 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x15b7, 0x2001),   /*  Sandisk Skyhawk */
-- 
2.35.1


