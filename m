Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2DBCC61CE7
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Jun 2025 04:06:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xCtBAGKG59EPZfZvHI+C9fiapg4PbX4qYwaxgh+NSGs=; b=KpKAqKuvxTbeGl59ATDs229h5D
	H1wQl76RBHn/D0xUfFsReRsk6DVgr8YZ1hUwb18fHnzgl/YKBLmBMSNveYB0RO4fYf0s/RkvIOC/p
	nVkHlxs44zqOlo7xCMX7UGAanL01Vl/Sn/vewTJizVS/ScJfSgYi7LreyQcad2MPgi3CpqRCBPuv0
	FYykZ0DbuOSyfjJBu5R6TfLJdgSbi5isMllgx+/8pw1IL5Np4dsSdss1q05SmgWnWPIe4wH1fSnNK
	BFg41b9hLG5LndCbRhZ3DmP877qH31T9Sor/0K1/3f4onKZoKswBveatCTFvh++aAC/44fBzywVX/
	nW3kwknQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCjn-00000008oCb-28Pu;
	Wed, 11 Jun 2025 04:06:55 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCjl-00000008oCR-3kC6
	for linux-nvme@bombadil.infradead.org;
	Wed, 11 Jun 2025 04:06:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:In-Reply-To:References;
	bh=xCtBAGKG59EPZfZvHI+C9fiapg4PbX4qYwaxgh+NSGs=; b=iv3T9zXw8rzt4nxRm38ZacSSu2
	lyz/zudIC2A3L3mG7rjXcAwNbhewmquN/qP4Wbsk3kZoUNj18bKvx5+THs3WILkgw+/2qlyK6ZyF0
	ryChkDTgxwxDrECFQgTiZ1VW57Td4oNfzrjA6SfEG84As+zhyVZnMnrRFbcbSlOUa18ebsQV9AcPs
	y7EaJpxkVibzcvqIzs/kuZHn3BOJhAXi1f/pOuMl1sy4VUPO+/+8T+scQLPYKQ2N1WfjyU00YvQjl
	xs5o0VGAqIVi7oEQj7SC63l9yrCp6P/VeNMLexWWU5rXskTAWUWe0Pxk27VH1lEb+o36tyjChKl9i
	lsyjQCSQ==;
Received: from 202-142-134-175.ca8e86.mel.static.aussiebb.net ([202.142.134.175] helo=mail.extremenerds.net)
	by desiato.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uPCji-000000026d5-2cRO
	for linux-nvme@lists.infradead.org;
	Wed, 11 Jun 2025 04:06:53 +0000
Received: by mail.extremenerds.net (Postfix, from userid 1001)
	id 2BF8C7A03DF; Wed, 11 Jun 2025 14:06:37 +1000 (AEST)
From: Anj Duvnjak <avian@extremenerds.net>
To: linux-nvme@lists.infradead.org
Cc: Anj Duvnjak <avian@extremenerds.net>
Subject: [PATCH v2] nvme-pci: Mark Seagate FireCuda 530 as IGNORE_DEV_SUBNQN
Date: Wed, 11 Jun 2025 14:06:35 +1000
Message-ID: <20250611040635.3615-1-avian@extremenerds.net>
X-Mailer: git-send-email 2.46.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250611_050651_418904_8464834D 
X-CRM114-Status: UNSURE (   8.44  )
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

Signed-off-by: Anj Duvnjak <avian@extremenerds.net>
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


