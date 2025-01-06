Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AA80E7719A
	for <linux-nvme@archiver.kernel.org>; Mon,  6 Jan 2025 16:43:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=0RHuK+zfAmi/py/RTukMQ+RMpar9uDnUrgjX1bmIZNM=; b=CJyYGx/pzMRT8k8Aceq3NQi4gO
	YHJC2C1l9eC4J0+BWaMFIe0RZoKEcbU1TbC8UedCiwOtQKTSFleIEr+W4e12R39oTv+dH0X/MySS1
	mgB1fvo0DHx+chr0C5Nc5vS3f4XuzCJ8lQUyna3YISwlL+scdtoWPWXz7r1WDSa8JFNxutyF3HwzO
	y/XvvmGX495mU290/ER1MWRosIxI38oYz4bYXj7+BbeH2lvdY+wwTsgYXMbq07FYH8E4QokwYB6Mi
	ssUtYL5NHWssDRpkJ1P45qDIOJP61mAebRI2vDK6ZWiMifm1d2ENaO3PwXVk6mGKk4LmPWwWDGt0z
	ie40TarA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqCp-00000001zVe-2cUl;
	Mon, 06 Jan 2025 16:43:55 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tUqBE-00000001z1N-28fr
	for linux-nvme@lists.infradead.org;
	Mon, 06 Jan 2025 16:42:17 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id DAEEF5C47D6;
	Mon,  6 Jan 2025 16:41:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0619C4CED2;
	Mon,  6 Jan 2025 16:42:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736181735;
	bh=FDFv5S+ZzONeY4VnWASKegBbzEBRGsdv1rRlgEW29Js=;
	h=From:To:Cc:Subject:Date:From;
	b=PtXwE3v4TOTkBRgBupVbDx4H9CbEQEkv6UJ86TfhE9W6QWB2DO6+JblhhkEkqX0eo
	 TP+R4oth7qUjwEnk9e/3s+u2Rzo21s5d2PAVQHbL9+XP6P3l+j9rZIaup9UrGG8kxz
	 c5hWqQt1weZmJUIeaY3hnA35u/NNw65QeL5qcQu+Wvns/Vvtp8v8BhlqAPiNY+8j5u
	 PVZjTOh6eFBET5tNQdZAezGjdJ5dn8myjJ/NGVGI7IJR//7Z/3AbDI5gyT+ledaTRC
	 gpk6l9EwXLKTfNElOMx7WlvB2L8aqDJs/19DmnzesiNpWqluMkQ08RmkrR9yQFGcCa
	 Dor/qGGjFolDg==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Luis Chamberlain <mcgrof@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	Sasha Levin <sashal@kernel.org>,
	kch@nvidia.com,
	linux-nvme@lists.infradead.org
Subject: [PATCH AUTOSEL 5.15] nvmet: propagate npwg topology
Date: Mon,  6 Jan 2025 11:42:13 -0500
Message-Id: <20250106164213.1122374-1-sashal@kernel.org>
X-Mailer: git-send-email 2.39.5
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.175
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250106_084216_590075_CE3FF9F5 
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
index 0fc2781ab970..58da949696c2 100644
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


