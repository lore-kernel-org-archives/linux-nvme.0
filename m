Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70DEFC433F5
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Apr 2022 10:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=XsMkrhNnmUK4aCiYJMBNcbn8l4M2ci7iXmQ5+qICTIU=; b=2VwXTdsO/e2oDK1+EHvhHC1wI4
	tYgBTSv1kekfFmEr+YnpE1CciGV+soenE/sMQO0nIOGF4FqnKlAE2rfajAJB/FtUzNAJ3p4pbBHzQ
	L2rbLJ1O7Cq5zrLwOQcT6znj9MGP9YEVUy1ZmNia0zDRFfqIAtrz9MG720b4kZp6fs7Fg7rRBMk9+
	GecDYQ5ObFedfOK2fFEtSJc66Oz2wuk9qPQ6S/CxQDy3EAaH4Jnukr8+X2w/W6u87ImQK8mnBJFz+
	PuCEGGdGoq5xoxikBGN1o5YUjXiQIxxBqKroByvmBPhFQHq8Hphx22LxXJGINNEjkU4wtZLN5Z0ma
	jdYJtk9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nk1Hm-0065xG-CC; Thu, 28 Apr 2022 10:22:10 +0000
Received: from todd.t-8ch.de ([2a01:4f8:c010:41de::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nk1FF-0064UJ-Vi
 for linux-nvme@lists.infradead.org; Thu, 28 Apr 2022 10:19:36 +0000
From: =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=weissschuh.net;
 s=mail; t=1651141165;
 bh=HDPmPUonfLA18N3RXFt5kVLnPCi7amyMZQTy67dXQwc=;
 h=From:To:Cc:Subject:Date:From;
 b=P8aClK6Y0g1CHjYNxqx8xMgauuxlIqa6OfRoobMHCHTXG9xjBjjn8tiNM8DUx5OnE
 xamrBg2R/Lo2vMt/tzrqJ69VyX4+jmZLqlQIZp1qaTrhe8F0DFWiOcweVmwLhLY/2p
 0upI/wdk01BVAItbB9EvqqedIndHQaK88SmPSiW4=
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 linux-kernel@vger.kernel.org
Cc: linux-nvme@lists.infradead.org,
 =?UTF-8?q?Thomas=20Wei=C3=9Fschuh?= <linux@weissschuh.net>
Subject: [PATCH] nvme-pci: fix host memory buffer allocation size
Date: Thu, 28 Apr 2022 12:19:22 +0200
Message-Id: <20220428101922.14216-1-linux@weissschuh.net>
X-Mailer: git-send-email 2.36.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=ed25519-sha256; t=1651141162; l=1214; s=20211113;
 h=from:subject; bh=HDPmPUonfLA18N3RXFt5kVLnPCi7amyMZQTy67dXQwc=;
 b=OiwSDn/v0nel5RXEG7W+KHVEVkvgcbHiVXm+yYEAd5FC4Uc0EuTF1Bc4BT4EmxhFl3URAIeaUSar
 WqhLdmDgADR5QqlPiuV66HUNIO7gCIYQd5x4wifwMCtLXLp4B9q9
X-Developer-Key: i=linux@weissschuh.net; a=ed25519;
 pk=9LP6KM4vD/8CwHW7nouRBhWLyQLcK1MkP6aTZbzUlj4=
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220428_031934_233911_25F8E1A8 
X-CRM114-Status: UNSURE (   8.81  )
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

We want to allocate the smallest possible amount of buffers with the
largest possible size (1 buffer of size "hmpre").

Previously we were allocating as many buffers as possible of the smallest
possible size.
This also lead to "hmpre" to not be satisifed as not enough buffer slots
where available.

Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
---

Also discussed at https://lore.kernel.org/linux-nvme/f94565db-f217-4a56-83c3-c6429807185c@t-8ch.de/

 drivers/nvme/host/pci.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 3aacf1c0d5a5..0546523cc20b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2090,7 +2090,7 @@ static int __nvme_alloc_host_mem(struct nvme_dev *dev, u64 preferred,
 
 static int nvme_alloc_host_mem(struct nvme_dev *dev, u64 min, u64 preferred)
 {
-	u64 min_chunk = min_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
+	u64 min_chunk = max_t(u64, preferred, PAGE_SIZE * MAX_ORDER_NR_PAGES);
 	u64 hmminds = max_t(u32, dev->ctrl.hmminds * 4096, PAGE_SIZE * 2);
 	u64 chunk_size;
 

base-commit: 46cf2c613f4b10eb12f749207b0fd2c1bfae3088
-- 
2.36.0


