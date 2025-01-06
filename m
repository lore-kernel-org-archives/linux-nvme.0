Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C869AE77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 16:43:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=psx8KoAn2XUJSx4Kn6g0UJepMC2ySr0w/SJlmWl0PnQ=; b=Gt7FUHHQ3YphhXW7FmMocOOPTJ
	ODX6bBgKylvD8PkFA08Td3Pgf804Yf0x4VQidJ37HNpVW+mF+rvdrOM6LrH/HAMCnmkm75rDHXswD
	ecV2xqr7kLxb6FAlQ9PU3oWubkh0uze/5+zIYXsMW6gSVgHKo20kk3E6b8oTNeGQta5zOYtFfDQeV
	i+psr5m3OmQHXpNwPzqtm2rnMOVQGiy8e6BJvcDX9tzAFe9+h7KMb4YZ7/VzSp6LuCwJqYTVamJIO
	Nwl7G0gABBy41/+8auj7PHW6uWZOgWw9n+AEvSAyCN3bTyX5OE27LZE0BUaGiIyrJTHaDQrkZc0SM
	zezMJf9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqCo-00000001zUj-1UCg;
	Mon, 06 Jan 2025 16:43:54 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqB9-00000001yzM-0FYJ
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 16:42:12 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 690EEA41A34;
	Mon,  6 Jan 2025 16:40:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03010C4CEDF;
	Mon,  6 Jan 2025 16:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181730;
	bh=+YjIooULW7nVYb671ov5Ko92zYnxSU3aZvoSxy+Y+ao=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=uNQBuJYxOxguILmq2+mTvkcbkGIKt69no+UoliWrPnNlDDAt6JcjDGiim9PFhtTL8
	 ioK0XkWM30MMHAd/PgYFO48cEKxiNw8whr9MWUbMF+qqr3mZJWXWXzJ1dVX5lBHbp9
	 EMU4YFOxfx1W51gKglzEjNP52jIeSSaU0IOMJwTalxWtsYtc9g0ZkkpldQ4l556oTn
	 T40ZnTkdAHbK2sEc0KTWhe68p36eNT9ywFaaQoYglNHJxG+MVQDQP038cEhyWebcx+
	 AA+fTbsZU4XYG9pRNQdSK9SAhc7t0vlC43WS0lhk/Hzv3PAHkGzD+fjHCoTx4qF5CH
	 44o4ggUX85rfA==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 6.6 2/2] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:05 -0500
Message-Id: <20250106164206.1122310-2-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20250106164206.1122310-1-sashal@kernel.org>
References: <20250106164206.1122310-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.6.69
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_084211_156682_A02C6203 
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
index 468833675cc9..c0b342cc93db 100644
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


