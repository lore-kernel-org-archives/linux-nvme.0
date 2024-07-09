Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D864EC2BD09
	for <linux-nvme@archiver.kernel.org>; Tue,  9 Jul 2024 16:23:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=n/+WSrBa2zaO2/mdAjTb7TiEsXNYX5uPNM7mO6IYsFM=; b=l7CYox8cXYDBROjjvFmstgL5UI
	wGQU4hpF7XLlX3fBOi2nbL1jtQuyFxPsAq3Rn1fscaJdvZmmiBy4JYvlNPU5EiHk/sCJ+eMLpnaJM
	7GTkJXd+m1a22ZzAOMuiJOVRZuKqUbJbYvOaFP93SVCQND18cABPdMuC5w0VyRrgPRRT/5qYJpdSU
	u4xyndpFX9nFzIt67dvDhFTUbrT/09fF6yZFsfm7qCGt2OdGGDMeOGwroxQGE2WRkTa9IHXsEgp4N
	KTCgiyr6c2Hx4uRifE8OiKLQupYlsm9zNyENEsxlvtsfzDoH9fKcO0iTpUcCBdXzmweO2fItHQzKw
	AZHvCFOA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRDcN-00000007vGY-268e;
	Tue, 09 Jul 2024 16:23:03 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sRDcK-00000007vEj-1LEY
	for linux-nvme@lists.infradead.org;
	Tue, 09 Jul 2024 16:23:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 57DB5CE12DC;
	Tue,  9 Jul 2024 16:22:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89448C3277B;
	Tue,  9 Jul 2024 16:22:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720542178;
	bh=Zm95n2SGEqjmTMk4Bs/Y4+y12KbObHhx/cFrv7TCRBI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=NNnl8BDtZc5B+snuwAOmf4v4zzr0As6sfL+xhk5VEkjOpTlf5wedbRRnqcGhro1Rx
	 P2B7E6lJUk1VZRZG/ZxofnZmt6Tfn6BMDzAra/KJFNCKGzChuKOtpaJp4y3vTTvzVO
	 OMh4/WTY3qND0AINMmn+OWTv2sxOkIbiN7WdhHqrqZniIyXtR+7q1Tc2Rzm0LYzoZo
	 z0nPHl71gPeG0QXMIiK8l4xn7d2pWFnKQv4GR17McroH5CLOkKNtxhCp/L5lb/A+u5
	 lkQ8cL21yc+MnG/larMLYNFkNprim4fvfmvXfZM5MI+HbT6yx0NsEZz/jXIuwTHu4o
	 hBNqA7pWMxyxg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Boyang Yu <yuboyang@dapustor.com>,
	Kanchan Joshi <joshi.k@samsung.com>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 15/33] nvme: fix NVME_NS_DEAC may incorrectly identifying the disk as EXT_LBA.
Date: Tue,  9 Jul 2024 12:21:41 -0400
Message-ID: <20240709162224.31148-15-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240709162224.31148-1-sashal@kernel.org>
References: <20240709162224.31148-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.38
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240709_092300_554842_C1182CDB 
X-CRM114-Status: GOOD (  10.82  )
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

From: Boyang Yu <yuboyang@dapustor.com>

[ Upstream commit 9570a48847e3acfa1a741cef431c923325ddc637 ]

The value of NVME_NS_DEAC is 3,
which means NVME_NS_METADATA_SUPPORTED | NVME_NS_EXT_LBAS. Provide a
unique value for this feature flag.

Fixes 1b96f862eccc ("nvme: implement the DEAC bit for the Write Zeroes command")
Signed-off-by: Boyang Yu <yuboyang@dapustor.com>
Reviewed-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/nvme.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index fd67240795e3a..21c24cd8b1e8a 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -485,7 +485,7 @@ static inline bool nvme_ns_head_multipath(struct nvme_ns_head *head)
 enum nvme_ns_features {
 	NVME_NS_EXT_LBAS = 1 << 0, /* support extended LBA format */
 	NVME_NS_METADATA_SUPPORTED = 1 << 1, /* support getting generated md */
-	NVME_NS_DEAC,		/* DEAC bit in Write Zeores supported */
+	NVME_NS_DEAC = 1 << 2,		/* DEAC bit in Write Zeores supported */
 };
 
 struct nvme_ns {
-- 
2.43.0


