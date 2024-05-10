Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BB7AC25B74
	for <linux-nvme@archiver.kernel.org>; Fri, 10 May 2024 10:29:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qeVh9hwRTnH/UTfI3SB0rZGCljf81ba2XcNxWe7m3ZQ=; b=RPCyzYj2bFzCC89DpbaF3zsebP
	9uGG6oKzqmD5p/yrRyKyB1QCrddHBFuZvRjzhlXUrCfUvsoLAXIx15WQG1XKOlAy1KF4S5IzNPsH+
	bemwvrTurprRFo6rsRkbYKnk2cN93tNyK3c6tIRcYG/yihJifUrj1kr1tUcjVUAreVniOOEspZVVn
	m/mMxYM4orBJ5QzetWmEvZKfeDi6igZqMwvSy4CblcEe2/KNx8jwRmmeOMd4woolzTrILKz/wzyvW
	DwMl44Z5a/jjqSIdl9Oa96gVDI2WHfU+1APWRKgiXny8Kz2B0qcOed4zHvRlS+kcqR+l+D1xi+YKH
	eea1U+bg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVY-00000004s0c-3OeX;
	Fri, 10 May 2024 10:29:44 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s5NVS-00000004rwV-15jl
	for linux-nvme@lists.infradead.org;
	Fri, 10 May 2024 10:29:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id AF99F61E9D;
	Fri, 10 May 2024 10:29:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDFA2C2BD11;
	Fri, 10 May 2024 10:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715336977;
	bh=SfTqYqjeY1DMHHy8PsIgRfckqhfnwz8Z8GXownPO+64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=irQ3S8OzolMWOpoNPU6k4yiLO+Q3uFep0TbWy9iN+uKud3i3oLTy/d+Fs1L9Ry2qW
	 CPKvLYHiPOChuU8PhajLs/58GCJG5iNVewUu1De+RDeST80RSrDqZBBu2SpcYgbdCH
	 FSfvC5uUToWdmFwUKymeLImDLsB2XvEpLfSwlGKP497VX5s1YHe0iozvbDMTfJE8wk
	 fCQARAptqSgb1AhS6B6abOuz79J/lr7zvdGVKou4wA8WwzIM5mrGdg7YzEkkUd1lKh
	 WfzojuBhuKlmmxK2flrLxMAPU9H184vuUBUyVxbC71B93pa+FjITd+7q1NcLNFlldi
	 IlT4/VyH8zRkg==
From: hare@kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Matthew Wilcox <willy@infradead.org>,
	Pankaj Raghav <kernel@pankajraghav.com>,
	Luis Chamberlain <mcgrof@kernel.org>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCH 3/5] block/bdev: lift restrictions on supported blocksize
Date: Fri, 10 May 2024 12:29:04 +0200
Message-Id: <20240510102906.51844-4-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20240510102906.51844-1-hare@kernel.org>
References: <20240510102906.51844-1-hare@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240510_032938_487555_89149665 
X-CRM114-Status: GOOD (  14.26  )
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

From: Hannes Reinecke <hare@suse.de>

We now can support blocksizes larger than PAGE_SIZE, so lift
the restriction.

Signed-off-by: Hannes Reinecke <hare@suse.de>
---
 block/bdev.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index b8e32d933a63..d37aa51b99ed 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -146,8 +146,8 @@ static void set_init_blocksize(struct block_device *bdev)
 
 int set_blocksize(struct block_device *bdev, int size)
 {
-	/* Size must be a power of two, and between 512 and PAGE_SIZE */
-	if (size > PAGE_SIZE || size < 512 || !is_power_of_2(size))
+	/* Size must be a power of two, and larger than 512 */
+	if (size < 512 || !is_power_of_2(size))
 		return -EINVAL;
 
 	/* Size cannot be smaller than the size supported by the device */
@@ -170,7 +170,7 @@ int sb_set_blocksize(struct super_block *sb, int size)
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


