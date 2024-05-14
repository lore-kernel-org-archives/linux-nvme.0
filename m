Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1D88EC04FFE
	for <linux-nvme@archiver.kernel.org>; Tue, 14 May 2024 17:39:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6dSljREdEkV+6+4+7MPxUP7RmG9gytwLH9+mZo5kvlk=; b=ynyHr1iBnO3F/q3yb6XCbmjNGn
	VvUZI4c7mSb0lOzAvAEBbGPk6uFNe7TfN6dcjAirBWXZzeLdmVlOnNk+Efplfvijij3c2g82U56ru
	sfV3+PQLARSAyPnMXUDVAAYo8q54Y6K3uYwWRbCiSvVJz4jdKyHC8AJ3C3JoXpHXI/JDiIIN/8G94
	3N7OJobAhZMHQH5sX4VGypFkFz5j5rllu0Xv2K5BdN1ddsF3RK1LW5kg8X678aSQeAmJL4cdNXBnj
	BvdU+L0y5kRarnRKfJ+Og+y+lAw7LpLDTlv+ObqrgT1E0Xcj/cEuPOFmjU8NkwUTzi1g1J/WJSl9w
	k3iwtFQA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7i-0000000GgMc-23tz;
	Tue, 14 May 2024 17:39:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s6w7a-0000000GgEp-2eZq
	for linux-nvme@lists.infradead.org;
	Tue, 14 May 2024 17:39:28 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 285856123A;
	Tue, 14 May 2024 17:39:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52E12C2BD11;
	Tue, 14 May 2024 17:39:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715708365;
	bh=2MLs8aaNGq+Z9BPfM3fqM3TE7Pu96U6iUhQcyxpAkm8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=iysJzMaR5lswnCwhLkr1ZR9+Vqdq/KQOX48aG7GIum/4RIFSOG8pPPV09UFL/iN6g
	 wl5OuHTINhxJjJhdZ9ueImaQzD+9nGuHStjWbHAi+n9aIMx7jLKJXgHjP/YnIdac8P
	 58VVJITm3d+2gEc3vDHfLJS1/nlhwi0zeHIqtpfbQllvK5wmTd4CSdMPoW796mHnG9
	 l4nGZKqMdb/UbSV7FIAH1TcyrgayMvvHfSzsr5C6OiaVsw1sOXtoWXdtdRlQ2dJ33m
	 xGg8qwbyJNEGGExp4F7klBP0YMudQeJVEaSPCrFnWTTdiKCAt6X2iNqqvjLvOQiiUL
	 FmqbTTd7bySBw==
From: Hannes Reinecke <hare@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: Matthew Wilcox <willy@infradead.org>,
	Luis Chamberlain <mcgrof@kernel.org>,
	Pankaj Raghav <p.raghav@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCH 5/6] block/bdev: lift restrictions on supported blocksize
Date: Tue, 14 May 2024 19:38:59 +0200
Message-Id: <20240514173900.62207-6-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240514173900.62207-1-hare@kernel.org>
References: <20240514173900.62207-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240514_103927_119005_91048E8A 
X-CRM114-Status: GOOD (  12.72  )
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

We now can support blocksizes larger than PAGE_SIZE, so lift
the restriction.

Signed-off-by: Hannes Reinecke <hare@kernel.org>
---
 block/bdev.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index bd2efcad4f32..f092a1b04629 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -148,8 +148,9 @@ static void set_init_blocksize(struct block_device *bdev)
 
 int set_blocksize(struct block_device *bdev, int size)
 {
-	/* Size must be a power of two, and between 512 and PAGE_SIZE */
-	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
+	/* Size must be a power of two, and between 512 and MAX_PAGECACHE_ORDER*/
+	if (get_order(bs) > MAX_PAGECACHE_ORDER || size < 512 ||
+	    !is_power_of_2(size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
@@ -174,7 +175,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
 	if (set_blocksize(sb->s_bdev, size))
 		return 0;
 	/* If we get here, we know size is power of two
-	 * and it's value is between 512 and PAGE_SIZE */
+	 * and it's value is larger than 512 */
 	sb->s_blocksize = size;
 	sb->s_blocksize_bits = blksize_bits(size);
 	return sb->s_blocksize;
-- 
2.35.3


