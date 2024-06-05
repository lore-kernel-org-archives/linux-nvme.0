Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE9CBC25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:04:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cVoT7s5SVbpRF+GzaPBy2dPKt42BiJM3YaDGoT8ofYc=; b=GPYjk23TDVzCnLUJJIWDv5j0UM
	jDJ6FcsQ+rqx0JmBSnmkHevGjDnfSXT0ZdoWk9tkQtlb/kG9ElrxOCUDArNLD19VzatFVPuxfIJLU
	bu8FgpdwXym6klUe/AU3k0QHJFB5dNdtQ9o2OEYu0uld/knO5YUPRFoUi4LcymStI1mBOV4luY98O
	WqU3+8cgbRJjx0ZoNl4pwBH2HLrNCviYgMHiCKfI7ytHtKMEFpptc40sZf2yBQ2340EXjctJESm1t
	bxV1NomTYv8L+UX3gg2gloLb6EGNcAPtNxGmaC8P62D/C4qkM8gxOttIInu/say4Z7DpwRyV/ruad
	Jcj2i7wA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpNN-00000005qzz-38Ru;
	Wed, 05 Jun 2024 12:04:21 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpNK-00000005qwm-08Zr
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:04:19 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 44431CE17B3;
	Wed,  5 Jun 2024 12:04:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9D1F7C4AF07;
	Wed,  5 Jun 2024 12:04:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589055;
	bh=Boibbb9MNlFAY3AzByrj3P2rw8iStYw4ORPbIwyS/c0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=IT0qW2clnHKAm7ZvKCl0SfnJbZA2gJQGI00KDl4na6pfBy9ngbTYH4M1PN2Sqzpb7
	 9hfkbY+tDp+UGD4xNl4g9kWxJalvErDSyCFx75d5lr50SDGMUYwWxHj1bGieK570iN
	 XqtoXxDBNyp3EKAfeV1BB0hJQOIvWWw6EZjd2fEXNLBP1P/WnGR2bqBT3CkQA0RNg0
	 25S+z/+4GTyuber/NlnyMT3a5SvlG7H2p55rufhoXFpbbSYDg3HKF4Atg9Dt4TsZg5
	 Rs4kGkFB6TLN1xa1uMseG4PqW+FCahuGWOVvtRGgzUwEXZL+y0eFFHA9BTV18zcigc
	 55Tm0zcHHrgzA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 04/18] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Wed,  5 Jun 2024 08:03:43 -0400
Message-ID: <20240605120409.2967044-4-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120409.2967044-1-sashal@kernel.org>
References: <20240605120409.2967044-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.32
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_050418_358538_46033EC8 
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
index e47172bd84efe..8eac383e18f3a 100644
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


