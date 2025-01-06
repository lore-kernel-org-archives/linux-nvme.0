Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D2FEAE77188
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 16:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/+7ZWJ7K9n2bw0Nv4iwbZ+ZO4YH4vnS/XIpeaOnkbII=; b=e/nqQI3D+/lyi8Q1cJA7p0faak
	MPMOMWkHBR/gNuZAvmneRpmWL+J5zlhv/wfzC0eRG/Xi5Y5pxRqzP9ck+SGqk2JcJOgAf5lbU4bsR
	eLKiNFTbo4JAoczyPKHVdZYE/Tu8nytqxtoZpIPfOtsO8N5JkilHT4M4nRema/kiTLEBhJrzvaBsD
	EjpHx9LTHg6LVgCLPYZGkl+5xMHObs70EZjhQblXakKcNMVIYtPzPSGKFHm1F3G8dKjM2Rfn2H8vc
	6nbqI4jMdHI5o8XKTIM4xIFA4UNFSP1XbJplZs0qysunxxjNfF1fOm5k14MVYRZHJYOGAR2VjoWp1
	mEcg/BWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqCr-00000001zXq-1NQV;
	Mon, 06 Jan 2025 16:43:57 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqBK-00000001z41-1k1r
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 16:42:23 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id D9951A419FE;
	Mon,  6 Jan 2025 16:40:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 76CD5C4CED2;
	Mon,  6 Jan 2025 16:42:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181741;
	bh=lTJDTcXnvPTSTl/j45uMusCcXgFltz9HMFI2KWBKckg=;
	h=From:To:Cc:Subject:Date:From;
	b=ZgpK7kH0eGfrLbfxxoZyv0+eoVjJ1gH9IvrmW3KGNdNCBf5wuE8pWXzBtLU+ATz0T
	 fkrxM5MLKR/f5EcCseP8Q2Kwehmwne/Ju6yBL5tTiYZyjWLbYKbskwPTtS2yWtf0DJ
	 ko0tIMezvnMnYBEY4dU3qGlyaNcV/E7OCNOqyUko56bLkLJP50AgrraD5URiXwT8ni
	 DzN5BNQtZRcXy1b9v3ROM6QPIDjrj8OxtshhFz/7V8lapx2rUOlWhkjkOe/5TRrel8
	 E7yj1WRtFzoMxr3Fvb0OfiXv4kdgNUfLFGHgzwAzGhyRqa6PDFkmWuShbdTIFcngfV
	 N++Xu2BWoTNqQ==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:18 -0500
Message-Id: <20250106164219.1122426-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.4.288
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_084222_514654_7381372F 
X-CRM114-Status: GOOD (  10.44  )
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
index 32008d85172b..40afe3d0599d 100644
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


