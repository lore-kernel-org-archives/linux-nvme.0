Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65402C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:05:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uTSbUqoykV+rBabFSEEhvCwcZAwoR7b04H1OmJ48xzw=; b=1hkuY2ZGGjp5EKebbP5Qd4CiyS
	R9jdW2naYdX4K0F9UOXPtBA18Youbrgw315QgtL/AC2WYFy3qmOatfCtRSOw7ppkHiCt8ujpV9Za/
	2W1Nq/Vp/8W7sczr2M8rE6WKwJa2zEfIVYMrgnCW2CIzD9R8D5ovzUZXWEdqljwwp0lVEQPfncwUR
	UpRMI/egiZNG4pLR0MM5rF9BFUwqFLjtSycKUZBeqbTYMkPG7XrRjMvFbbhK9w1njVa3NmZ0zskne
	VHiXuP5PGRsg6vr0XCL+Lw60daWaINyE52LaGrR9PAXfM68QqkOvCbjgJ5yWWGcDixomeF5b1pp9B
	O09EwEhQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpOf-00000005rrW-2iSn;
	Wed, 05 Jun 2024 12:05:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpOY-00000005rm2-383N
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:05:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id F1FB161857;
	Wed,  5 Jun 2024 12:05:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C4628C4AF0A;
	Wed,  5 Jun 2024 12:05:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589133;
	bh=//SKX54MzotBgE+LBA+Gyqj8vD5W61QkI0xBfJbktjM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=EAQQbUVPDubT99Vb1zdpGue0cPvs64UfH27dlxBWdisyAuElGQZ3cDHceue0YZiAp
	 83sCV6MmKsytyrGWb/qirfDQo8n1zIDv/2fHCDwjF1KpFB2FW50huKibKP+QZLCnWm
	 p+j3FQzBQ+h9UYgZ0mxnODFcqQYj0SHOAqIAQ/An1Dz77I+RBvJ4IqPJ8fCIFpyGGF
	 PIMnrSiz+bnrgsGQeufqCrh9qk6nghDzw8LEJ2SfWvH589UEXIfEvRgN1glroCOfiB
	 6aLzUT9RDr4J7ayf0mFtRdE6TLQA2TLffaweD2ieeMklTHdVjG7MciQ41DuWWSfP9w
	 KYjWUNOy0IpVQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 03/12] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Wed,  5 Jun 2024 08:05:13 -0400
Message-ID: <20240605120528.2967750-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120528.2967750-1-sashal@kernel.org>
References: <20240605120528.2967750-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.160
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_050535_001927_866619A1 
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
index 7bb74112fef37..5a3ba7e390546 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -836,7 +836,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.43.0


