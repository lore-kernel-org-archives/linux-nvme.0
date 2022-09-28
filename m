Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 63205C32771
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Sep 2022 09:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Eo4Y/zHxd/8NVJanIem9n8hnJ5CPTUuVUmFRr+Zy+XA=; b=UxBhHAetxTBwS0FM6AsyiwGMs9
	sBBSTIwQvNEcp2HDSDeZ8avUQlb6aajCI51Ha2zfjkLvLmvvK2mKZRMYr+31b5P9PkGPvUbSLwl4W
	mhaNnGylEQPyBtU07KiHDUhVIwJ7EXDJ6d69H8oGhgXKbN2UlkNVCAhCKWuVPamp6JE5v49P6lgCQ
	KBTl9lLz4GnWXRdIJHgnja4A7qKl2txY7ZNM6XLVqOxXckCHAKO7kzI2vmOy+086F+Yw3Ekrqyqev
	KAYoXtX4UbPZmUGDElYr5levNodB8nUueyzRaXdpMi+QZbSJ2NeerYzBJxwwLsFh3879EVPaLh6iv
	UslZUjNg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odTdR-00FLEk-4d; Wed, 28 Sep 2022 09:45:45 +0000
Received: from xry111.site ([2001:470:683e::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1odTXS-00FHnp-Nc
	for linux-nvme@lists.infradead.org; Wed, 28 Sep 2022 09:39:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=xry111.site;
	s=default; t=1664357967;
	bh=3PAIiBxy0R6ZHl7Muf1mC94HPv5MJphBBSwkAzfvJiY=;
	h=From:To:Cc:Subject:Date:From;
	b=GcG7mjvawlKMxdLIpN17QOWMCe5ewhQj98CJGvOySPm5bfEsyIbt5EU9rF65dfUM2
	 LwG3cobkGZjxj0Tt7kYBNVca1vYTdTYKhwEYJwPB3uClzFpC/yjiSst9YRLOKTXOud
	 aOlhJ8ySoftPReLjyUYO2LnS9lkEjl0BqOBMmdLk=
Received: from xry111-x57s1.. (unknown [124.115.222.149])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (P-384) server-digest SHA384)
	(Client did not present a certificate)
	(Authenticated sender: xry111@xry111.site)
	by xry111.site (Postfix) with ESMTPSA id D7374667F1;
	Wed, 28 Sep 2022 05:39:24 -0400 (EDT)
From: Xi Ruoyao <xry111@xry111.site>
To: linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Jens Axboe <axboe@fb.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Ning Wang <ningwang35@outlook.com>,
	Xi Ruoyao <xry111@xry111.site>,
	Chang Feng <flukehn@gmail.com>
Subject: [PATCH] nvme-pci: avoid the deepest sleep state on ZHITAI TiPro5000 SSDs
Date: Wed, 28 Sep 2022 17:39:13 +0800
Message-Id: <20220928093913.45905-1-xry111@xry111.site>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220928_023935_134943_B9B1E4DB 
X-CRM114-Status: GOOD (  10.67  )
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

ZHITAI TiPro5000 SSDs has the same APST sleep problem as its cousin,
TiPro7000.  The quirk for TiPro7000 has been added in
commit 6b961bce50e4 ("nvme-pci: avoid the deepest sleep state on
ZHITAI TiPro7000 SSDs"), use the same quirk for TiPro5000.

The ASPT data from "nvme id-ctrl /dev/nvme1":

vid       : 0x1e49
ssvid     : 0x1e49
sn        : ZTA21T0KA2227304LM
mn        : ZHITAI TiPlus5000 1TB
fr        : ZTA09139
[...]
ps    0 : mp:6.50W operational enlat:0 exlat:0 rrt:0 rrl:0
         rwt:0 rwl:0 idle_power:- active_power:-
ps    1 : mp:5.80W operational enlat:0 exlat:0 rrt:1 rrl:1
         rwt:1 rwl:1 idle_power:- active_power:-
ps    2 : mp:3.60W operational enlat:0 exlat:0 rrt:2 rrl:2
         rwt:2 rwl:2 idle_power:- active_power:-
ps    3 : mp:0.0500W non-operational enlat:5000 exlat:10000 rrt:3 rrl:3
         rwt:3 rwl:3 idle_power:- active_power:-
ps    4 : mp:0.0025W non-operational enlat:8000 exlat:45000 rrt:4 rrl:4
         rwt:4 rwl:4 idle_power:- active_power:-

Reported-and-tested-by: Chang Feng <flukehn@gmail.com>
Signed-off-by: Xi Ruoyao <xry111@xry111.site>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 98864b853eef..65481d1975cc 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -3513,6 +3513,8 @@ static const struct pci_device_id nvme_id_table[] = {
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
 	{ PCI_DEVICE(0x1dbe, 0x5236),   /* ADATA XPG GAMMIX S70 */
 		.driver_data = NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1e49, 0x0021),   /* ZHITAI TiPro5000 NVMe SSD */
+		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0x1e49, 0x0041),   /* ZHITAI TiPro7000 NVMe SSD */
 		.driver_data = NVME_QUIRK_NO_DEEPEST_PS, },
 	{ PCI_DEVICE(0xc0a9, 0x540a),   /* Crucial P2 */
-- 
2.37.3


