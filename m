Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5E20C3ABC3
	for <linux-nvme@archiver.kernel.org>; Tue, 13 May 2025 07:00:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=o+zofNJgGQOoApDMgAM/Tp1NXEIS5Ch/jc6C76yZ/XM=; b=x573W2fuWNJt502Rh/oM4TvYIJ
	E1XQHBv0zl1LJ6eQeYl0tkQQoxauA1x2RrkXN1JPfegrDNBSQRYuMhaUXfhF9R0tt7VkYWsJM0loi
	PkM+8TfrrDvB1qcx/m97+bZ/tRizhfZz5U9CR6WFFjBdle2z2mipBjo1p1W++5lGrAkDenDo+tnzS
	YN1nRvzIWPB10p0YTXuRRii/8F+XBlkAhbWmChXluDvEtHgXA+S7MQlSNDju3tjBbG7RyXDqPnhUU
	CYLqq0hKeEEjF4TyYSL7wg4+c0nEFI9i7Y1kvvzA5BXDws6MUUBFaBE/JPhtCmc2FMDBxuo4lztS8
	CdYepcDA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjcw-0000000BYyU-1Sbd;
	Tue, 13 May 2025 07:00:34 +0000
Received: from 2a02-8389-2341-5b80-3c00-8f88-6e38-56f1.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:3c00:8f88:6e38:56f1] helo=localhost)
	by bombadil.infradead.org with esmtpsa (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uEjcu-0000000BYxh-0wfD;
	Tue, 13 May 2025 07:00:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>
Cc: Caleb Sander Mateos <csander@purestorage.com>,
	Leon Romanovsky <leon@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/7] nvme-pci: don't try to use SGLs for metadata on the admin queue
Date: Tue, 13 May 2025 09:00:17 +0200
Message-ID: <20250513070025.830930-2-hch@lst.de>
X-Mailer: git-send-email 2.47.2
In-Reply-To: <20250513070025.830930-1-hch@lst.de>
References: <20250513070025.830930-1-hch@lst.de>
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

No admin command defined in an NVMe specification supports metadata,
but to protect against vendor specific commands using metadata ensure
that we don't try to use SGLs for metadata on the admin queue, as NVMe
does not support SGLs on the admin queue for the PCI transport.  Do
this by checking if the data transfer has been setup using SGLs as
that is required for using SGLs for metadata.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/nvme/host/pci.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index e6b6b6ee0878..24f5292a349b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -971,7 +971,10 @@ static blk_status_t nvme_pci_setup_meta_mptr(struct nvme_dev *dev,
 
 static blk_status_t nvme_map_metadata(struct nvme_dev *dev, struct request *req)
 {
-	if (nvme_pci_metadata_use_sgls(dev, req))
+	struct nvme_iod *iod = blk_mq_rq_to_pdu(req);
+
+	if ((iod->cmd.common.flags & NVME_CMD_SGL_METABUF) &&
+	    nvme_pci_metadata_use_sgls(dev, req))
 		return nvme_pci_setup_meta_sgls(dev, req);
 	return nvme_pci_setup_meta_mptr(dev, req);
 }
-- 
2.47.2


