Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9A0EC47090
	for <linux-nvme@archiver.kernel.org>; Tue,  6 Dec 2022 09:51:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZR/WEmyORNl4+dCOzQXacbHLUmSfG062t9MTGJmDbJw=; b=yYC78ntUbaBU3fSS/V2QdBRFcM
	DSKCFfyjOF6uC+sIQhFmIHwgq9kVTV+k4GEHlPCQzjzT19QIKndW0G9Np8o+DVR27ZIU+x+/l3zac
	v+pQ/tm8ZhDzUeCgh1jiGvS9FWR9w99shJKLY78gSfyZlztbkEwyAIkXzIFCgT0EAfXNrBh4xCPCy
	eEKjzetYXlwn9+oqX/vMqVj4hk9Qt+YIKGw2/8WBOlrXkew+Jcy50pNwQ/NZUFvBSWFefSrl0fS6W
	Uyg3vHSlwsT7D5e0oZ/4N3V3A5VhmZUC/EF4rsGyK1QNBiaJ108y7tpIUybjzbono8huPUTaYJFqZ
	0xkip0vA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2UbU-006TtH-LT; Tue, 06 Dec 2022 09:51:08 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2Uaq-006TMo-HH
	for linux-nvme@lists.infradead.org; Tue, 06 Dec 2022 09:50:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id 13C0E615FF;
	Tue,  6 Dec 2022 09:50:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA13C433B5;
	Tue,  6 Dec 2022 09:50:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1670320226;
	bh=pyepUv49aHr5CnGlPCA68LWtVIZxRoRXDWdIBzwsVOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=qTiMGEmQ+AOaJaqAW2iNdQXejm+7e/cfce5HAxChl46VKWBX5cUh6Cok8z/u93dGE
	 tEmy7ILEmZrpGlwaV+NubWsz/97NUOyC6BW5q6sYndk7K6Cl7y2dKBvJnXWKY4hU7C
	 2jXP2gzv42ZRU2lPnwO1gXKMcOBZMaXCiU7wRzJnRd5vF7txDOogMDFL5Ik262LIET
	 cM3bY8euxhXBn+CdHgjEjon7vzF6kdsqJn3RrxP85Cp8OMM9Nnsjp2IK/2OplC12SY
	 J4AnPXneMjYnoPliqkyxWzKj78HXS9RtbIQzWXZ0PVN8EQEZvVgRQvwSijyR6mCjul
	 BJhdZTcrMjr3A==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Lei Rao <lei.rao@intel.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	axboe@fb.com,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15 12/12] nvme-pci: clear the prp2 field when not used
Date: Tue,  6 Dec 2022 04:49:54 -0500
Message-Id: <20221206094955.987437-12-sashal@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20221206094955.987437-1-sashal@kernel.org>
References: <20221206094955.987437-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221206_015028_683020_C160A80B 
X-CRM114-Status: GOOD (  13.31  )
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

From: Lei Rao <lei.rao@intel.com>

[ Upstream commit a56ea6147facce4ac1fc38675455f9733d96232b ]

If the prp2 field is not filled in nvme_setup_prp_simple(), the prp2
field is garbage data. According to nvme spec, the prp2 is reserved if
the data transfer does not cross a memory page boundary, so clear it to
zero if it is not used.

Signed-off-by: Lei Rao <lei.rao@intel.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/pci.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 772bdc6845fb..d49df7123677 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -814,6 +814,8 @@ static blk_status_t nvme_setup_prp_simple(struct nvme_dev *dev,
 	cmnd->dptr.prp1 = cpu_to_le64(iod->first_dma);
 	if (bv->bv_len > first_prp_len)
 		cmnd->dptr.prp2 = cpu_to_le64(iod->first_dma + first_prp_len);
+	else
+		cmnd->dptr.prp2 = 0;
 	return BLK_STS_OK;
 }
 
-- 
2.35.1


