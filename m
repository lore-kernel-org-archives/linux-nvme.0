Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F564C677C4
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Jun 2025 22:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ohO/Rt0AVqqcXsB4km84MtFqDpw0q/26ZJrvreTmlEE=; b=OvWUEBXSSZrRqsQKQWLZ4KnUkr
	csC/fLglE+WAgMQ2AH1lnOS/vPU2XK1Iw6sz1qqDDvm6ayQw7DW8otEOfiB73YmAlBUUFHWDrc1Dk
	ZYwtTdQBYO+YixpcoHecQRExbGKrT8ux2aPRI8oMwkJuIO8KMe6tyqwSSjrJImpem88NVjr9jgQTl
	thCKeqEP/gvQIRcGpS/wXe4by1Jebvd8GLxQY1KyqPOomGPTe848TYyJ26ZZFSkaGWWYrEC+deymB
	dS0FqHoUivGDa7NooezMio3TrpSPAscrauaFCWNSmsKL025ve94sPOwcV48aCpeUqD7sftw5CU2sA
	HzY1SZhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP7nS-00000008Ic2-0saH;
	Tue, 10 Jun 2025 22:50:22 +0000
Received: from 202-142-134-175.ca8e86.mel.static.aussiebb.net ([202.142.134.175] helo=mail.extremenerds.net)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uP5Yq-000000081vJ-0sYA
	for linux-nvme@lists.infradead.org;
	Tue, 10 Jun 2025 20:27:09 +0000
Received: by mail.extremenerds.net (Postfix, from userid 1001)
	id 355697A03DF; Wed, 11 Jun 2025 06:27:00 +1000 (AEST)
From: Anj Duvnjak <avian@extremenerds.net>
To: linux-nvme@lists.infradead.org
Cc: Anj Duvnjak <avian@extremenerds.net>
Subject: [PATCH nvme-pci] nvme-pci: Mark Seagate FireCuda 530 as IGNORE_DEV_SUBNQN
Date: Wed, 11 Jun 2025 06:26:54 +1000
Message-ID: <20250610202654.7952-1-avian@extremenerds.net>
X-Mailer: git-send-email 2.46.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250610_132708_406512_A1249356 
X-CRM114-Status: UNSURE (   8.38  )
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

The Seagate FireCuda 530 (PCI ID 1bb1:5018) with firmware versions
SU6SM003 and SU6SM005 reports an invalid SUBNQN field, causing kernel
message:
nvme nvme0: missing or invalid SUBNQN field.

Add the NVME_QUIRK_IGNORE_DEV_SUBNQN to work around this firmware issue.

Tested with both SU6SM003 and SU6SM005 firmware versions.
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 8ff12e415cb5..60f85cdc4fdf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3673,6 +3673,8 @@ static const struct pci_device_id nvme_id_table[] = {
 	{ PCI_DEVICE(0x1bb1, 0x0100),   /* Seagate Nytro Flash Storage */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY |
 				NVME_QUIRK_NO_NS_DESC_LIST, },
+	{ PCI_DEVICE(0x1bb1, 0x5018),   /* Seagate FireCuda 530 NVME SSD */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1c58, 0x0003),	/* HGST adapter */
 		.driver_data = NVME_QUIRK_DELAY_BEFORE_CHK_RDY, },
 	{ PCI_DEVICE(0x1c58, 0x0023),	/* WDC SN200 adapter */
-- 
2.46.3


