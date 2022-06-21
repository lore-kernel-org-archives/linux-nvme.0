Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15C2DC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=5dDyyu8udEzz3GgouQulgbGjsVBkt2vV8w9g/qCOOPY=; b=v26cE4rnG+VnZUHKNEMA0Ninv0
	fj+BTxGzUmWWGyJTUZKa+YrEQteWtq2nWQGKdiH8BPz71QtZJYhMrF//V2/tTNJtlGCvQUV8AezQO
	z3666M43ognTTV2qAa4das2RwbePBXPo5bEGSNbnKg0deufdJq4lqqmBB+bDmgTUtGVYxxBO3qy+a
	SfphbyM31uQpqyA7JstHIQIZsh19ceK0wLDM3Wxt+jKpzs22mT+jwDuAt4U28hAcgCDAagQAETaW3
	57Nzo1CCio4q7ghz1OB/i4bmX5fWFNV0XugCZIBcLVdeSRtck1AmwvY7kfBAX4SgSv9pjV7pMnrrU
	Mu1zr9JA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3krL-0077Yv-PP; Tue, 21 Jun 2022 20:52:27 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpQ-0076SB-Kw
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:50:30 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 439C5618AF;
	Tue, 21 Jun 2022 20:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 14837C3411C;
	Tue, 21 Jun 2022 20:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844627;
	bh=LjDz06T0wPjVN5BW1zCEoJ98B7dQW9Y7mc49ZoBwNy0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=ghxsneW3k+VSe1mAlGsST5URu82YIi8x3sBoICzv7hUGJ08Rf6skNgG0IaoLLkQ+M
	 andgtR3/PgWEvGJVFQg9TA39HxG+ZbCZmLAtIHTI3XOm4erUpBQWlFpYZLFDUldVUO
	 hedh3RDTXmgYHPggzdwyXukZSZ/daaKQuIB5a4WdFLJ0borALCbUjKEovsXF/eSW5A
	 dY0j867/kepUXJ7ySq7kF220opiU5OYMX5R4zMJw1SShWBGwdHOs+bCDZw5NSEaHHe
	 svHXyBNrGcnmoB2+fDzbbBfvnhQDNJ40AekmkgjcF95xSJNBzLKhM2UECeH5U/c2/f
	 wHWyKKcah7i2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.17 09/20] nvme-pci: smi has bogus namespace ids
Date: Tue, 21 Jun 2022 16:49:59 -0400
Message-Id: <20220621205010.250185-9-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621205010.250185-1-sashal@kernel.org>
References: <20220621205010.250185-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_135028_792969_1C989329 
X-CRM114-Status: GOOD (  13.17  )
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

[ Upstream commit c98a879312caf775c9768faed25ce1c013b4df04 ]

Add the quirk.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=216096
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index ce2b3906431c..666746e3bcb6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3419,7 +3419,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
-		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
+		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST |
+				NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_NO_NS_DESC_LIST, },
-- 
2.35.1


