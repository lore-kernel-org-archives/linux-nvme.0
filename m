Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07054C27C5E
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:03:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=iK1QR9QRNu7essXbpC7l6LN0JKBlZFz0AM4HitaxnOw=; b=RC63ZKhhwEc0oHTjixN/9oGV7F
	rQ258pmeRsxsQI+6noii336i+gRzoe4zW9ydHCrUKqN3iYCjke1BfkwiIIRfa6zKMJ8qdcl94fHzJ
	uhsR3WaAXmFjNV8LTImkLdnbBOHg1wrrMGw+NSRdd7LrwgFjcuYdyj5yUlvD9zRi8taIrTFZbKcx8
	dx3cQBMiiaQVTwEVgwW3RujqLUyEY5i6TUv1gW9VppOwrIzBvltQHlfNoTQoVsTIQ3KzjavmFXsAM
	iGQW/nT0m6kH/ygQZkpLYFC+lgwWURyvIEJBRdS1XSmoMdLlW4FG86evyqBJ4Op3lN9YS31frJyAV
	/W6TUEgA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpMY-00000005qWU-1XSk;
	Wed, 05 Jun 2024 12:03:30 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpMV-00000005qUy-192F
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:03:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 9E13F61265;
	Wed,  5 Jun 2024 12:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68248C32786;
	Wed,  5 Jun 2024 12:03:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589006;
	bh=EpcOa/PoeA1uayk+/SDygq1AbB+riunm58LMI5D8cdI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=LcbyPvQ7xPMJtEA3kBkYVqzqWWSWzzHTsDemRUN1Us44Y0DnGHkkhl7r6mLs390S2
	 aetz+leXNIPgOFiHezj9O4ty0HzUEJVx9Y7m8eiiB6DAO+mRIJHhpdcfIXWy9ZdWkC
	 ammf9Fa5pTuLyvNK8edSI6/SWrRi7LL4fRvJe248VQspGI4BQcsmBQr1nkS1rXNGIb
	 hcZcvS8PLw/4gZDR0md7ntzdjw3ajE6A16F42qyaN0zOgVvhaJFw3NDWvXUxo5VbDt
	 PU74VBEoXHpP28Rnfll3OLdthQzIc4oxy0i25dNUawNyF8/GLy1zEV5rqPe20hnrpk
	 X6dsx2q/PuQlg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.8 04/18] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Wed,  5 Jun 2024 08:02:54 -0400
Message-ID: <20240605120319.2966627-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120319.2966627-1-sashal@kernel.org>
References: <20240605120319.2966627-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.8.12
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_050327_386867_27883B1A 
X-CRM114-Status: GOOD (  12.44  )
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

From: Kundan Kumar <kundan.kumar@samsung.com>

[ Upstream commit 1bd293fcf3af84674e82ed022c049491f3768840 ]

bio_vec start offset may be relatively large particularly when large
folio gets added to the bio. A bigger offset will result in avoiding the
single-segment mapping optimization and end up using expensive
mempool_alloc further.

Rather than using absolute value, adjust bv_offset by
NVME_CTRL_PAGE_SIZE while checking if segment can be fitted into one/two
PRP entries.

Suggested-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Kundan Kumar <kundan.kumar@samsung.com>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 710043086dffa..102a9fb0c65ff 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -778,7 +778,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.43.0


