Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88ADFC25B76
	for <linux-nvme@archiver.kernel.org>; Wed,  5 Jun 2024 12:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Vrz1fvQadYiC+SY8YnuUfgl9ld2enR46gqTyNgvjZBY=; b=R9iqa/OM+XaAAii5cPrODKgTLZ
	rOTL/cSVPmiJW4Xfk9RyaPcxapGdHBJnelLSHQ2haHm3GyRdg1YvjX3V2E4PYkbuhnrLA5OzUat+o
	tfl2VcMOrEuezEHbvN7iocaQlbZDC13iuJVPFWgpK8K0Tr6b0EPM6carAilZcRkt2x80ltX4un+pt
	7wViNdeg4cFF5gvK6j1Cj1/nYmpcWYmn1UxfSRS/ZoAPnr7UDjD8ZCpHzYpBCEP06lt+1c1fg5PLA
	/GiqKQyM/n83DjQIB19aaFYDkXPTfdv7yEMhRuhTaSWCHlrfkMZnavdRzwoEVKMvGbyOgpFwmNGbe
	rHEO9mNQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpO4-00000005rTn-3am4;
	Wed, 05 Jun 2024 12:05:04 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sEpO0-00000005rR3-3YTS
	for linux-nvme@lists.infradead.org;
	Wed, 05 Jun 2024 12:05:02 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 119506188F;
	Wed,  5 Jun 2024 12:05:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 00A01C32786;
	Wed,  5 Jun 2024 12:04:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717589099;
	bh=B0k5s6buZQwPBJm0xzZLzHx/9pO9n+AEcUzQ/fkRK88=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=VNNQ8w73Ql4nrJ0cgbCU/RgrgjqLtlhHM6LkwoOv0Mpk2Hw1GxgT+P0Exb1w+dxuG
	 2SgtTJx805IpzBA45MRc7xwMILnHAOddtlPmG+xQRoEYbr8bjQXp3NbOZ1oxEE/Rb5
	 oNh1a3ZZfvGi6+9fjcRwy5dd/OpAmLNxo2MTSi+XQUyZWifWkSKDbe9OQLuYHr+InF
	 T4mP8WdCWgPNGdy4oTQLNykWVv/zywgW6dOjUO1KjG0onpc3m0IY/HlQVBWPAEUU0y
	 FcP03EmPpXsjlyIKxfeKwHF+az/hFLFSNbevLroQg1EaZzawBN064yiJGdEkL5VQE6
	 HNVOOKdhziQpg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Kundan Kumar <kundan.kumar@samsung.com>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.1 03/14] nvme: adjust multiples of NVME_CTRL_PAGE_SIZE in offset
Date: Wed,  5 Jun 2024 08:04:36 -0400
Message-ID: <20240605120455.2967445-3-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240605120455.2967445-1-sashal@kernel.org>
References: <20240605120455.2967445-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.92
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240605_050501_070871_D8DEAA0F 
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
index 5ff09f2cacab7..32e89ea853a47 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -824,7 +824,8 @@ static blk_status_t nvme_map_data(struct nvme_dev *dev, struct request *req,
 		struct bio_vec bv = req_bvec(req);
 
 		if (!is_pci_p2pdma_page(bv.bv_page)) {
-			if (bv.bv_offset + bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
+			if ((bv.bv_offset & (NVME_CTRL_PAGE_SIZE - 1)) +
+			     bv.bv_len <= NVME_CTRL_PAGE_SIZE * 2)
 				return nvme_setup_prp_simple(dev, req,
 							     &cmnd->rw, &bv);
 
-- 
2.43.0


