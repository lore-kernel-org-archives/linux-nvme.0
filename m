Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8AA74C6FD19
	for <linux-nvme@archiver.kernel.org>; Mon, 13 Mar 2023 10:13:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bJgnBI2t0H3VagjF553IP8hkU4EFX8wd21i0HCJKT3k=; b=Aj+X3joLtSh1PYaiEdK7QSZZ62
	82JRkOrMTjAhcNzcX3OGzZB4gmjau/uLRqarHm3EzCj+jx2sFFE5ZlLviFRjH63DFok6u3VaZ56SV
	5zVHkAehulUS5X0QcY+Jf6oOlfz5y6NXntq6WFGTiYRM7fpofbnOH64MC3XpFp3fKNML+1XFWtj71
	rqhqT81WGFVDXH03PV+XuWiVQ/D2ZpeoQ7EYgA+SBdLZbe4dHix/JC6f5lV1sbjnZuXxpSoJY7/UM
	paWwOMNnAX2NAYJhAzk24lZCufiq386U702BaqTANE3Tha8bDMcyQG4QVfGWA90KwdkSfqcRDbBhy
	flXkSdGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbfAw-0057yK-J0; Mon, 13 Mar 2023 10:13:06 +0000
Received: from mout.kundenserver.de ([217.72.192.74])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pbfAs-0057wq-9U
	for linux-nvme@lists.infradead.org; Mon, 13 Mar 2023 10:13:04 +0000
Received: from pgjs ([5.57.193.70]) by mrelayeu.kundenserver.de (mreue108
 [213.165.67.113]) with ESMTPSA (Nemesis) id 1MwQOx-1qRQLN1K21-00sLcw; Mon, 13
 Mar 2023 11:12:40 +0100
Received: (nullmailer pid 18184 invoked by uid 1000);
	Mon, 13 Mar 2023 10:12:39 -0000
From: Philipp Geulen <p.geulen@js-elektronik.de>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>, p.geulen@js-elektronik.de
Subject: [PATCH] nvme-pci: add NVME_QUIRK_BOGUS_NID for Lexar NM620
Date: Mon, 13 Mar 2023 11:11:50 +0100
Message-Id: <20230313101150.18146-1-p.geulen@js-elektronik.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:yFEleEVvt1eewik1V/9PGwghIiwvcDBUME6RxjEGZJn75f/BCsQ
 wXuTyQlmLQQyEsxO//n8KHUeizDkAj8jzZBfBXHZgfyFVD5z16Blslwj1oSQBAVtOvqYxqq
 m6a5yegDXs0W0IzOnuMeZjlnQrSGZR//EOYHiPFNSHDX/BjgTTjCFQ76xtgTmqM9ShUs3Ko
 Bn9j17wW3R6DeTb+nZD+g==
UI-OutboundReport: notjunk:1;M01:P0:XR6d+1g/6pM=;R8Tw4Q/h9zehJDT7IzP5CGNTY/x
 fGhpD11sAUyJchPa5CjzFo1JXQua2zZupJUcBFkf7I8RzW3rAPvoZ9CFXud+CrWXfJrRoMlOG
 oYegtpb9z1GR8ms6q28Dd2u1aUD4riYyw5e5yfIlH3VmY4eMcN0F6m/j5yPFlN47Suy6sagbW
 bp8lx4L5qeUTEX7RjWEcOCUQ8V9TKgbCN4qdKkOgIa9Y4qk83x4F+3sfv5V/VjT11oQLa3kWm
 VvwGTuKJGmiDlY4KGDdkalG/O3VxYSm4oD/PpN/LxPPOWs3aMGSNZkztxy8RCHs15V7rge38h
 +PZwTZuTGglfQVeWZaj+iOeRzZw4//OvjkB0EThQU2CJz8wVtruMPhCFrVp4iEzczsvpoZ1i6
 vRXs/lgr4lo+W3nfYc1S7+BPxKJ5VVjcluJWrpI473OPmm+O+5HiTuYmdaXqEaaOuIc3YUjsO
 xrs4I5c5UCo5TGVgEE3Okh8uFFdYKiTBEurcP7yyWSAYzP2x6fmcGxX1Kgor/Wtql23G8txd3
 JsYkYCzo/6NUgFNLBDCZAlvzCia+MJzOtKi16kteD5e8FJMfnsnL93ulMI20XHFl6jBRDZB6P
 srFJntS+xOfkouo616Fy+HIIzmxQL0IdIgcLyFZgIP87dYypjrTQLBao+K/X9LvmT65dveaLo
 i99ezc/MHQ3QbBnlInNZCNLMj/Lch3g/+jYxbn0MXA==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230313_031302_644997_43BF4AAE 
X-CRM114-Status: GOOD (  10.94  )
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

Added a quirk to fix Lexar NM620 1TB SSD reporting duplicate NGUIDs.

Signed-off-by: Philipp Geulen <p.geulen@js-elektronik.de>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 5b95c94ee40f..bb63afeb0fb1 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3435,6 +3435,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2263), /* Lexar NM610 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1d97, 0x1d97), /* Lexar NM620 */
+		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1d97, 0x2269), /* Lexar NM760 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(PCI_VENDOR_ID_AMAZON, 0x0061),
-- 
2.39.2


