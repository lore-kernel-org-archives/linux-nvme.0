Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E25C25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:06:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=r0K4fTvnPzRAFMG0nj510QJgSa3rVGTK1BXLHR7RLm4=; b=sVWpxCxf7Os0L8+FYj4m5o2Bct
	7WwGK4Crduw2aWblmal8DMeb3EvT24Tj6iynKgFA/39i482330VKfOfFEwOIG6Gtg3ZyAXywTaZFe
	LQrf1zTCX7WW6IFpC4RHFPV6NCCCVxLXMdU/aYbXyn+7vkbN8wuXIujosFH9rZrZTES4TSnAPQsQK
	mQMynTGqKnhXPxymvjhpbc8bDQfRwTjNb5Y2mTL5w/a7vz07XSQ9WzSLKM7uCpnWuq0HsJRZnO+g7
	2CmUEF4l3wLb1LoW9mlb4HaXTwBrCHsbRHuWqs4c0BeQZRI5kDlH8tXFD5wJXCThUQoQMvcebF3e7
	/Cacc5Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpPI-00000005sGh-2FxC;
	Wed, 05 Jun 2024 12:06:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpPF-00000005sF2-1RT5
	for linux-nvme@bombadil.infradead.org;
	Wed, 05 Jun 2024 12:06:17 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:
	Content-Type:Content-ID:Content-Description;
	bh=r0K4fTvnPzRAFMG0nj510QJgSa3rVGTK1BXLHR7RLm4=; b=FUTeRwNmLbnk7rXqciHvKkN/03
	+3JCYDG4OrHbAZenzJLYyGod9k+5dejNNhGkqNzIxgYCx4Q15diXmh8E0PMdcxUQTqnMxNpxK5F57
	9GX4CPaqCstymcZm8kNzgbZsfdCAKl93Xv3C2XQog4tVzuCtnobKf/mT42/bkSMix/VWV1aaIMNlF
	VZZqPIcybUwLrXj3CORumbo0KpGhW4Tm6Rfmca/aIPYQVNs+rEV6Jn9BwSht0S7o0u6ihvDipg6fx
	qui7b7kSlLLo6FQV0LtV+NKjxrFSV+4zAqiQvGr8MUo4T6QzkkzFboUeejA77O4QNKlFWEKrugAyQ
	3vFeyiaA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpP4-0000000Fmhx-1DQr
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:06:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 1491961853;
	Wed,  5 Jun 2024 12:05:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03E37C32786;
	Wed,  5 Jun 2024 12:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589157;
	bh=B/Kutg+Sc8171faSQp8DlnnumHtFGil0wSZIzhksY/4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=bzsJ5gRF3/BqLhFw6iq1HjSzqbVUOIKnmU3d1I+guxmDl4nIhv3Zw7otHJMXVWmOp
	 1Yr3SZHyThZzxV9Ci9ayoLhenkWplqd8jupWRM59pQpkIdNStJSi5gHQmfZO5YrygC
	 FHkIqO6iri2L+CNwon62tXEI/CoHyR2UTtJtf+e4L+4GsC7byz0aTdKgsME3URoNKK
	 k8ScYI/EqxKDDNXvjDfS8U3Qs2nSaG8AFgcxQQPVlus+41kABGXqSMzZqQ6dE35buE
	 Bf4Nn2/lVx5O+LKJU/mRUsGPc1k0dWHsrmECua+n8sK5e+lOp0DG48BtQtXVQW+oIo
	 vV+wMM6/TZGeQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.10 2/8] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Wed,  5 Jun 2024 08:05:45 -0400
Message-ID: <20240605120554.2968012-2-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120554.2968012-1-sashal@kernel.org>
References: <20240605120554.2968012-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.218
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_130606_969079_25D3BFB4 
X-CRM114-Status: GOOD (  12.39  )
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
index 5242feda5471a..a7131f4752e28 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -844,7 +844,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.43.0


