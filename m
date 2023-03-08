Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4FA1C678D5
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Mar 2023 16:20:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=hY0nRoNK6CsDJob1A0jYc6DGsjkhEnhZ4KXWeLmNT3Q=; b=P1j9w5fM2Pi6y4JwQTfBWFyQry
	Yz3FSMTKdgnGL6TGMJt2QpRDiGaXsRCVdjcTA0Bhve55cAuAC8VftwF8A9PJRnpxicaCjCaZ60GTG
	Mpc+Jm6gA8dHxjL2xPRR+kG5WSuJc9GPF6cyZS9iC3SW7yLM8SsO9GGCLQbORwS8f7+p9r951kEus
	7F8WoGz7fcUP3coPxGKpbz9tSOwcmt7lR9lu4PNWxTA1i0DzcAeIecQVAbSJQAeUCcaJL7OjOLg2u
	uRwJYoOJ1ki9tV1qUMuos2AmMb2IURczzmV6grk49INbw1QRbsGgLkm3abKlNsHNuQGErYnlx4QiQ
	EZqdIyxQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZwWL-005uAN-Hz; Wed, 08 Mar 2023 16:20:05 +0000
Received: from forward108p.mail.yandex.net ([77.88.28.116])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZwWI-005u87-6a
	for linux-nvme@lists.infradead.org; Wed, 08 Mar 2023 16:20:04 +0000
Received: from sas1-1970a3fc41d8.qloud-c.yandex.net (sas1-1970a3fc41d8.qloud-c.yandex.net [IPv6:2a02:6b8:c08:48a4:0:640:1970:a3fc])
	by forward108p.mail.yandex.net (Yandex) with ESMTP id 575802679E59;
	Wed,  8 Mar 2023 19:19:52 +0300 (MSK)
Received: by sas1-1970a3fc41d8.qloud-c.yandex.net (smtp/Yandex) with ESMTPSA id iJfQDcAc0W21-XUbqcInz;
	Wed, 08 Mar 2023 19:19:51 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mishamosher.com; s=mail;
	t=1678292391; bh=hY0nRoNK6CsDJob1A0jYc6DGsjkhEnhZ4KXWeLmNT3Q=;
	h=Message-Id:Date:Cc:Subject:To:From;
	b=BmqiezmtJ9aCFvMH8zOHhJPFN1pqaXCuqtXWzq8/p+vNS17ZCJVooz1VCxVYigwC3
	 CblmefuWQUPCpgVvozvNCtufkh+XYIepb5tDDXy9JjCWe6Z2b6fS1wAm5wyXUB7JuU
	 CpGnB4E5nhytG7LX48WxExZu96EbIMPASRjBCyBc=
Authentication-Results: sas1-1970a3fc41d8.qloud-c.yandex.net; dkim=pass header.i=@mishamosher.com
From: Elmer Miroslav Mosher Golovin <miroslav@mishamosher.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Elmer Miroslav Mosher Golovin <miroslav@mishamosher.com>,
	stable@vger.kernel.org
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Netac NV3000
Date: Wed,  8 Mar 2023 19:19:29 +0300
Message-Id: <20230308161929.18446-1-miroslav@mishamosher.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230308_082002_466685_6A5AA08E 
X-CRM114-Status: GOOD (  10.24  )
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

Added a quirk to fix the Netac NV3000 SSD reporting duplicate NGUIDs.

Cc: <stable@vger.kernel.org>
Signed-off-by: Elmer Miroslav Mosher Golovin <miroslav@mishamosher.com>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b95c94ee40f..428d3f47760e 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3415,6 +3415,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x2646, 0x501E),   /* KINGSTON OM3PGP4xxxxQ OS21011 NVMe SSD */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_DEVICE(0x1f40, 0x1202),   /* Netac Technologies Co. NV3000 NVMe SSD */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1f40, 0x5236),   /* Netac Technologies Co. NV7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1e4B, 0x1001),   /* MAXIO MAP1001 */
-- 
2.39.2


