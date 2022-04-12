Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BD6DC433F5
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Apr 2022 06:11:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=GLE+nT+0RsBhuW6v8njzglXBRO0IR6zPk8+hErX4E2Q=; b=v6JfMbZYUyxmLOVjgRNGe2UI4Q
	X7vkqG4snvKEfa1D/l1OP3tV+XDRAr3gJD+xayDMZIafSNF1zSJUQOAMZZyRS25jc3+e3L3NPPm9q
	gC0LVK2WKTi6Qf0zk5norAiuAv3+rq6Cq+bB1goOuWhFrXji9FK+zsmMkBTuGYiyQXAw7cY/ZG3OG
	CbQj13RHXFLVK3ui3KI/uI0/Jjbsr6hXGbB4R2mhkKImBijV1RQMDJ9lkSZ3Dfv5tItLznwvTGURP
	CPWGE/S4vmvAEKqpJzR9ll389KyDPwWBTv6uTza0kAMUrcuURdAD/7jRKwIQ9+N+FRlzSxNT9G5Kr
	Ks3pNE0Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ne9kd-00Boum-Ng; Tue, 12 Apr 2022 06:11:43 +0000
Received: from [2001:4bb8:18e:76f5:73f2:2aba:795d:ae99] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ne9kX-00Bors-66; Tue, 12 Apr 2022 06:11:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Luis Chamberlain <mcgrof@kernel.org>, Klaus Jensen <its@irrelevant.dk>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 3/3] nvme-pci: disable namespace identifiers for Qemu
 controllers
Date: Tue, 12 Apr 2022 08:11:26 +0200
Message-Id: <20220412061126.244414-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220412061126.244414-1-hch@lst.de>
References: <20220412061126.244414-1-hch@lst.de>
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
corretly through manual intervention.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index c386c91483505..b191e7dcf15ca 100644
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


