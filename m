Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3FB8C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 04:49:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=q+5zhBNTQM7RiEn7rp/Dd2PaSVOnDxQSC2xfkFfWgp0=; b=k+hG7bjc8zGAewok9f+aC0T1v9
	s464pg0Q5B/FVHd05PKrkjRtF4LIMREK7jwxWOShHukA6ZabvOOjLez2tkXyFBQRUsKuqczZyZdBq
	AO6Sd7tDG1X5f5TJEAjROCCClRwTW6CGeCwSYb6OGQxDqrP9Sfy8L0e3Huepz00F+hk53A17HjGt+
	EJa/jO/pIWFr4f/PTOBT6m6E4JaUv7yieOWNOHPRhHe/wt2X2n3bJ7TjJswzZR5xxYFuJTOEaBz89
	ZAhGKGtbF5EJXdtOh315xZX9BX5Ubydn0pxmQJtPtqCg5qYsR3keQ9zUSouyP7Yg0ZOtoVECpejjs
	cneGcj3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neUwZ-00Glci-2y; Wed, 13 Apr 2022 04:49:27 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neUwS-00GlZU-11; Wed, 13 Apr 2022 04:49:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Date: Wed, 13 Apr 2022 06:49:05 +0200
Message-Id: <20220413044905.376785-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220413044905.376785-1-hch@lst.de>
References: <20220413044905.376785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

Qemu unconditionally reports a UUID, which depending on the qemu version
is either all-null (which is incorrect but harmless) or contains a single
bit set for all controllers.  In addition it can also optionally report
a eui64 which needs to be manually set.  Disable namespace identifiers
for Qemu controlles entirely even if in some cases they could be set
correctly through manual intervention.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c45dbe8a7dcd7..9b75abdd4478a 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3410,6 +3410,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_VDEVICE(INTEL, 0x5845),	/* Qemu emulated controller */
 		.driver_data = NVME_QUIRK_IDENTIFY_CNS |
 				NVME_QUIRK_DISABLE_WRITE_ZEROES, },
+	{ PCI_VDEVICE(REDHAT, 0x0010),	/* Qemu emulated controller */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x126f, 0x2263),	/* Silicon Motion unidentified */
 		.driver_data = NVME_QUIRK_NO_NS_DESC_LIST, },
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
-- 
2.30.2


