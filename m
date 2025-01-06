Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EE4D1E77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 16:42:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=lDkMaTLgwjLJD3zGtn4hJf6KSWIJaWqmyoEhZsFcj8o=; b=LcOF+k7WTvdfmVJVpw263+kf4x
	YprNhtLNGm+qgQJSyGwije4dnC2dAvipqqux6VyMreDz/wb+tz37ivBhrfZyBjFwYDLY97sOK2ewA
	HRcDg7d/W/qcHwMvLkObg1q2BDU3Dm467UFnOih3EHNFxz1E2lzrJGWoKwjm51Xv5jPNSmeQcHrxT
	luGaIqog/GOsW6Y2pLXhdSwYxDlTuPKrgXiRl4LRvriTBimZcqw2SO8xdRX9qU/TiGkfbDAZ9yhqj
	Zw626sYwsZuofyp2RVKNOVJPdXB+XW6OWWpc4WnyWWy0/XyplZg3pcRKcjx5HM9x1k/z/odcCBCYf
	tY3WuR+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqBe-00000001z8o-0Vxq;
	Mon, 06 Jan 2025 16:42:42 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqAw-00000001yvm-1NyD
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 16:41:59 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 39A115C5A88;
	Mon,  6 Jan 2025 16:41:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4F1C4CEDF;
	Mon,  6 Jan 2025 16:41:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181717;
	bh=IrRyC4vaKupjSeMIXcC2XYvj4LGYPCKIgeq7EPoSVcU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=QEw9qgxj8/vtHfFp44ozx6N74SzNixU559+ichH6dq5WrO74A4CDCdkOPwJWSwRZt
	 M8a9PRaXh8mgat1abC1RWEwFoLs9WBqgMFz8RlAthrul97c8Vf2qFI7u94cgMaVDBZ
	 T/hBpHiiy5olY/Wf8D1aTaOOiRjFL94ni9kQ+UHQ22GECABlEF1UbtqRj/27reItSd
	 U215Y9j32Ui4THenhatqB4Ga/Vcdagw31ltKte8diPdpO7JTtXgSpRnTIUmbIT4Eh/
	 pyNosAqn4JNn67GrGS54Orz6b8NuJkp0B7LEt+M6ymucBzCYFx2Duzp+UjjCk5lfhx
	 Dn1wLYDzzQuYA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.12 5/8] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:41:05 -0500
Message-Id: <20250106164138.1122164-5-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106164138.1122164-1-sashal@kernel.org>
References: <20250106164138.1122164-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.12.8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_084158_411905_65E719EE 
X-CRM114-Status: GOOD (  10.83  )
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

From: Luis Chamberlain <mcgrof@kernel.org>

[ Upstream commit b579d6fdc3a9149bb4d2b3133cc0767130ed13e6 ]

Ensure we propagate npwg to the target as well instead
of assuming its the same logical blocks per physical block.

This ensures devices with large IUs information properly
propagated on the target.

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/target/io-cmd-bdev.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/target/io-cmd-bdev.c b/drivers/nvme/target/io-cmd-bdev.c
index 0bda83d0fc3e..eaf31c823cbe 100644
--- a/drivers/nvme/target/io-cmd-bdev.c
+++ b/drivers/nvme/target/io-cmd-bdev.c
@@ -36,7 +36,7 @@ void nvmet_bdev_set_limits(struct block_device *bdev, struct nvme_id_ns *id)
 	 */
 	id->nsfeat |= 1 << 4;
 	/* NPWG = Namespace Preferred Write Granularity. 0's based */
-	id->npwg = lpp0b;
+	id->npwg = to0based(bdev_io_min(bdev) / bdev_logical_block_size(bdev));
 	/* NPWA = Namespace Preferred Write Alignment. 0's based */
 	id->npwa = id->npwg;
 	/* NPDG = Namespace Preferred Deallocate Granularity. 0's based */
-- 
2.39.5


