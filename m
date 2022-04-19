Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B336C43219
	for <linux-nvme@archiver.kernel.org>; Tue, 19 Apr 2022 18:13:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:
	To:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BA6nR0WLcrQpk+q9xPXaVnPIllu0p91Q7Zk+b3+QGHo=; b=Qwmaf1eHbZFaxWIw2x0/MkTbwR
	PqtbjUpBFdnZjkQq5e7dW1Uf9/4jtxa3Ol21xnzjemFmyU/8UgElAS/cmwuHQjH4ItiNLL1PI4cB+
	9eU5BqVa4khInstpQwWwS4kCXmuFcoVOxzeMGmsc9034O8S6NhAFEYrikM9EGCeBpNnqotVFcFH7V
	59lgfLJEhvqShwd7sRzn2FWs6FWZutZQF/r2QKNOYHXRbQbHgPtjWSdeiC7y3KoXXh/4Fqhctks+T
	pkVNteVYD+gOr3HUdHbISm38fU2g3Yzz9hvAFQgSGfFE7JdEy6WL0WZ8h6w1T3++n3rlR1SmYy+5v
	V3vbax5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngsLX-005XpJ-6L; Tue, 19 Apr 2022 18:13:03 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngsL6-005XWz-JA
 for linux-nvme@lists.infradead.org; Tue, 19 Apr 2022 18:12:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 9C43260DBB;
 Tue, 19 Apr 2022 18:12:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD4FC385A7;
 Tue, 19 Apr 2022 18:12:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1650391955;
 bh=YPTj9OOrUeZwZkfCIZpAkWUxMPpzXgHJJrP8oXqzkWs=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=s2JqpdYbvQZBwF6zfc6CaisuaKgZbVcNHYYGr36YaUU61XcJedbzWc0nvQydj+IgV
 kFK/3OMRCCEn89qa9I6JBd3+j8uLzDstumIM1KYpC0xZYSxMmmTlIV/vRwlI0xNH/x
 +JcNM8N9grI1aSs+F9MvFFJyCjPO0aM6lO0CLJL+285HcpG1xEJuNbYQm5K4UNPb+h
 tuaNbT1BFy/eX1cr1qOOSKocYkFAAe1kS/55e4P3IOtNXx70z3cSbCfDYIDJx/n4KI
 Dt4WXQYpaaF90tOYsSAqLXpBzq4shmLXZs70bkw3cNvovlk5tD4lspjIuAzvyQTOYx
 ScnVqZoCu67vA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>,
 =?UTF-8?q?=E9=87=91=E9=9F=AC?= <me@kingtous.cn>,
 Keith Busch <kbusch@kernel.org>, Sasha Levin <sashal@kernel.org>,
 axboe@fb.com, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.17 31/34] nvme-pci: disable namespace identifiers
 for the MAXIO MAP1002/1202
Date: Tue, 19 Apr 2022 14:10:58 -0400
Message-Id: <20220419181104.484667-31-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220419181104.484667-1-sashal@kernel.org>
References: <20220419181104.484667-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220419_111236_858395_C47C2C7F 
X-CRM114-Status: GOOD (  12.71  )
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

From: Christoph Hellwig <hch@lst.de>

[ Upstream commit a98a945b80f8684121d477ae68ebc01da953da1f ]

The MAXIO MAP1002/1202 controllers reports completely bogus Namespace
identifiers that even change after suspend cycles.  Disable using
the Identifiers entirely.

Reported-by: 金韬 <me@kingtous.cn>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Keith Busch <kbusch@kernel.org>
Tested-by: 金韬 <me@kingtous.cn>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6a99ed680915..6be611f49a45 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3443,6 +3443,10 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x2646, 0x2263),   /* KINGSTON A2000 NVMe SSD  */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
+	{ PCI_DEVICE(0x1e4B, 0x1002),   /* MAXIO MAP1002 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e4B, 0x1202),   /* MAXIO MAP1202 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
 		.driver_data = NVME_QUIRK_DMA_ADDRESS_BITS_48, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0065),
-- 
2.35.1


