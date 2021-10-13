Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 367B2C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:57:07 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD4A660720
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:57:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org CD4A660720
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=xW8GNfleTWXkXBjUfXGq1B/g1ux3Fvrz4JW5O5cSh88=; b=LWBxCmkaaZASxe
	gBt8I6+Er/6zGmIkuk8l5yLvAWppIN7JYttftMVSMbQAIk1/ntgzYmnypmGYCLfHr6id7Sg149Qf4
	HCUQMVCi63p1YwssWxQvb6r5LZRW4mOiCT5mKV/FYvBk18yUIZgDZeAQVZQqyCHT/Q3EOb6JBBb1g
	dyYXNc0Wu97UMo3PbB5Dt5gNmfBMqa0SoB3zM5VTyJU0SR9eIq7W0J8ESrfolJ0lMKUpqh/J7u5b+
	WGe+rMUJ+D86n60xg6phPpsE8DsYAHq/FWAb7JFQ1imbvrP+VxirvwYEUQqI1u7LUY2ZDGuVivFXd
	jtr95jV9lVWQAjxdlAZg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maYBw-00FEbb-Rl; Wed, 13 Oct 2021 06:56:45 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWpv-00ExgY-T5; Wed, 13 Oct 2021 05:29:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=2M1Bh6pS+W3syaNlX8bODC9HBAKOfbTmbVbcvNXHzR4=; b=nfOn9SWa/2H3XvGOhq6vyClViq
 h0fvCEPgoATwgRVtD84QzMUYa/JQYdmm+Y7PtHszgvLGDWEsRFswyisrZXfL9gZKGcz31vTcWsrg4
 OGFcJbFKUg8jG8nSrcA/s/A3CTfOLQq15a76d7hTZLSTPE6c/hS9SLhiM9Y9NSEvRFFmEkBIR/ax7
 aae7T6h/4pPtlTXmYjrxWFUFoi0bN7EVeodHmFwyCA0FjT1bfh0cKpBTbyfg6hSUOC7DbPkCehU/T
 uU+Wa8swhAzPzYecQe6K5CLM0DVKE6E2g3Py1H/dkd6WQ4Bz2n+TKcDpwOgGIgp+pA/ZOt9odqWEx
 uLcffQYA==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWoV-0077HW-Fk; Wed, 13 Oct 2021 05:28:59 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Coly Li <colyli@suse.de>, Mike Snitzer <snitzer@redhat.com>,
 Song Liu <song@kernel.org>, David Sterba <dsterba@suse.com>,
 Josef Bacik <josef@toxicpanda.com>, "Theodore Ts'o" <tytso@mit.edu>,
 OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
 Dave Kleikamp <shaggy@kernel.org>,
 Ryusuke Konishi <konishi.ryusuke@gmail.com>,
 Anton Altaparmakov <anton@tuxera.com>,
 Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
 Kees Cook <keescook@chromium.org>,
 Phillip Lougher <phillip@squashfs.org.uk>, Jan Kara <jack@suse.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 drbd-dev@lists.linbit.com, linux-bcache@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-mtd@lists.infradead.org,
 linux-nvme@lists.infradead.org, linux-scsi@vger.kernel.org,
 target-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 jfs-discussion@lists.sourceforge.net, linux-nfs@vger.kernel.org,
 linux-nilfs@vger.kernel.org, linux-ntfs-dev@lists.sourceforge.net,
 ntfs3@lists.linux.dev, reiserfs-devel@vger.kernel.org
Subject: [PATCH 16/29] jfs: use bdev_nr_sectors instead of open coding it
Date: Wed, 13 Oct 2021 07:10:29 +0200
Message-Id: <20211013051042.1065752-17-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211013051042.1065752-1-hch@lst.de>
References: <20211013051042.1065752-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-Mailman-Approved-At: Tue, 12 Oct 2021 22:54:01 -0700
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/jfs/resize.c | 2 +-
 fs/jfs/super.c  | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/jfs/resize.c b/fs/jfs/resize.c
index bde787c354fcc..51a8b22e71030 100644
--- a/fs/jfs/resize.c
+++ b/fs/jfs/resize.c
@@ -199,7 +199,7 @@ int jfs_extendfs(struct super_block *sb, s64 newLVSize, int newLogSize)
 	txQuiesce(sb);
 
 	/* Reset size of direct inode */
-	sbi->direct_inode->i_size =  i_size_read(sb->s_bdev->bd_inode);
+	sbi->direct_inode->i_size = bdev_nr_sectors(sb->s_bdev) << SECTOR_SHIFT;
 
 	if (sbi->mntflag & JFS_INLINELOG) {
 		/*
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 9030aeaf0f886..992870160903d 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -551,7 +551,7 @@ static int jfs_fill_super(struct super_block *sb, void *data, int silent)
 		ret = -ENOMEM;
 		goto out_unload;
 	}
-	inode->i_size = i_size_read(sb->s_bdev->bd_inode);
+	inode->i_size = bdev_nr_sectors(sb->s_bdev) << SECTOR_SHIFT;
 	inode->i_mapping->a_ops = &jfs_metapage_aops;
 	inode_fake_hash(inode);
 	mapping_set_gfp_mask(inode->i_mapping, GFP_NOFS);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
