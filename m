Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC8B4C43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 20:50:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=DM9JoHSbB8x3tRluF72dmAba/wn0tMzdoH3Vo7dQbh0=; b=fYEyUajUa4wK/AsXr51MpM4ZFN
	dluiqI4jrPUfcuq607aoA1U/7KDjczvLcvKq8PQkUlticB7pKF0mO6f4gVVKFoDRGAhOU8aa7rXsJ
	9vIKbzx8wsNoknn0nhMUzaPE6PxR06fZix6hn55VNZZoywBXq1bZWuoQlIYG1q2l6qIJ7pekNJmxv
	6t6a9BGhd/vGKd0YOoamu3DoeWjNCLoNMcQ3BRZPzLSXpSkayMFzA6gsnlyQqiE6Ymnf+Epx1e5Tt
	HMtgm/VvK2HWBQCDYjxQRXCRRXA9XBz0xNhlDTWunctWZZApZwVm+SXYaonnfMzymf6t8QiSh90XO
	SK8Z33iw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kpC-0076IL-FC; Tue, 21 Jun 2022 20:50:14 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3kou-00765l-J0
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 20:49:58 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 6990561884;
	Tue, 21 Jun 2022 20:49:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3826EC3411C;
	Tue, 21 Jun 2022 20:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1655844592;
	bh=o9ka0BQwNnLsVyQViUO2LojYyCDJ+t64ufBsUO4vjU4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iCNDO/fB1+zTFYT7N3Zwb18JEXqElw4aASrZrlw/sWjBYaTbtYcD+K9RVLN59+QKE
	 mIs4GpWhBxlARVU45tdM5WBFZJTTB8gKKY7jNblURcJSUF3I/kygQb3FwGErWSdXHI
	 9QNq72JjP6L1F6Zh9cCe8pF7JZyd/bCqn5IduvtlaxOUnM/l3R955dRsx8QUqvr5go
	 SrVtYXX3kyK0GNAsTdKORWFNvDCQobmwBISBuYI15eU4GkxYpGgIc+1vV/bt86uXFG
	 xG2NlTD6+m+HByvy+oT59UxaEZLGCnzBXQsQtkakoN4B4Cz1gYKHzZ9JYBnkfEwDDC
	 HBgxJxWWW4AmQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.18 10/22] nvme-pci: smi has bogus namespace ids
Date: Tue, 21 Jun 2022 16:49:16 -0400
Message-Id: <20220621204928.249907-10-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220621204928.249907-1-sashal@kernel.org>
References: <20220621204928.249907-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_134956_728595_E46CF82F 
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
index a14f204b07c1..6c862259b381 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3439,7 +3439,8 @@ static const struct pci_device_id nvme_id_table[] = {
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


