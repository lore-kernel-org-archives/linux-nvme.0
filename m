Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18AB4C369B2
	for <linux-nvme@archiver.kernel.org>; Mon, 14 Apr 2025 13:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=dRZbPNgh6H79Rwhs41OwkdDFEtRj0spCjzrmdqEIN8k=; b=VxwtTNlGbsIonD1C7jEfv+M5go
	Fw+6/vtA2hOmknvNmJhuaMPZSeX04dfLU1K542UHYKqYo4aBPa0W9fxQa7ZkusV7PGGva9rPubszp
	6/R64IJy+T4hVO5IsKw+5QoRAmKsn/1lFyLvlpVqcKWAUS8ihzp2PB3yjQL2LbY3W358QAkkMc6FN
	lKkB+K6k//XS3+C/K0xA9tHOuonKqv6oMUV/M9+Kja9W57/p1xAxVFh9mLEEgCBLPbZ0h7z63dJ59
	lsTTgJuoE9EL911RTPCif2QcvSpSV+erPBRFx3M50IB9cbT7YgUHKQz8ydNATKbnxFOnxT8Cw7h16
	TNXjD9hg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jpy-000000027b1-2X0G;
	Mon, 14 Apr 2025 13:26:58 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1u4Jpv-000000027ZB-1QtU
	for linux-nvme@lists.infradead.org;
	Mon, 14 Apr 2025 13:26:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2036E4359D;
	Mon, 14 Apr 2025 13:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC91AC4CEE9;
	Mon, 14 Apr 2025 13:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1744637214;
	bh=3mmWf7aL2pXLiP/H5JF5mbA92xb7zwsGt3ckJCNigyM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=BZ+Sjidy3r1jI83G4iRLZ2lnrsspoVeYJbBif4HpO7EN9fNG3T850QejrxwjFvzXZ
	 RkOBhyoA1jFrtBMndDmgd/vxVRrOiXHxo/7oLjMFM+A/P7VL9eD0wSyOy39KUCfABc
	 onGGDRwn6rDGzvgF+qGpgIkhNLHIpGlytq70kVS2zEm6LCNOYlXpBhmb0r27xeH5og
	 AB6eaPK/FIRAQVQYpCiXYimzr4UtHfFtTlSv8sFMMhhpFYe7KKC6cZ1eTppuzDi2yh
	 qW1kBLXKv1Aa30s+V6NmnlNHKi5FrSGSbAnP1gXq0xF1kn9eYMFkQZ8h7P3sHqXy+o
	 PMQ9848a3jSKQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Uday Shankar <ushankar@purestorage.com>,
	Christoph Hellwig <hch@lst.de>,
	Sasha Levin <sashal@kernel.org>,
	kbusch@kernel.org,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.14 18/34] nvme: multipath: fix return value of nvme_available_path
Date: Mon, 14 Apr 2025 09:25:54 -0400
Message-Id: <20250414132610.677644-18-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250414132610.677644-1-sashal@kernel.org>
References: <20250414132610.677644-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.14.2
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250414_062655_401828_C6021634 
X-CRM114-Status: GOOD (  10.91  )
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

From: Uday Shankar <ushankar@purestorage.com>

[ Upstream commit e3105f54a51554fb1bbf19dcaf93c4411d2d6c8a ]

The function returns bool so we should return false, not NULL. No
functional changes are expected.

Signed-off-by: Uday Shankar <ushankar@purestorage.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/multipath.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index 2a76355650830..f39823cde62c7 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -427,7 +427,7 @@ static bool nvme_available_path(struct nvme_ns_head *head)
 	struct nvme_ns *ns;
 
 	if (!test_bit(NVME_NSHEAD_DISK_LIVE, &head->flags))
-		return NULL;
+		return false;
 
 	list_for_each_entry_srcu(ns, &head->list, siblings,
 				 srcu_read_lock_held(&head->srcu)) {
-- 
2.39.5


