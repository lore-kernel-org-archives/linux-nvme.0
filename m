Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E4CC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:38:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C844B60FC3
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:38:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C844B60FC3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=86d4JvaCcx/jkGD84woRXiE7L7vKYaJ30NZebD42Uto=; b=1O/yBAq3uqhsSv8iee9seFSIU9
	aSLTa6/pFxUCfIu3njmS/oyO/Xy1if/oV2qUePZ54qsjnkr5wrxgavCFDvfu56fXtNDd2vt2xpL3C
	hJZr5ZAzy1LMmZw5uRHBiSTNk9ABQDfSIvgEor9TqG0j9jW2MUYRxPQwfRjanMYs0IOn3wpnNc1/N
	zQl6OsXKdxrIt7O82v6aXS/NbNdqkouT9BbD54hbPsZYyH8Ri4kuQjMIVnooFSZJgSvwqMGK3XtNb
	GDF0FFwY9G4w4s7hK2FN32e4RdJO2n44Xngcl3K+F7T+rd5Suc41TByaI7uGU2asHgGs4WwMC14CZ
	7D09yeag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcQ2b-00F47k-6o; Mon, 18 Oct 2021 10:38:49 +0000
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcPdN-00Euxf-IO; Mon, 18 Oct 2021 10:12:45 +0000
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
 linux-raid@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-scsi@vger.kernel.org, target-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, jfs-discussion@lists.sourceforge.net,
 linux-nfs@vger.kernel.org, linux-nilfs@vger.kernel.org,
 linux-ntfs-dev@lists.sourceforge.net, ntfs3@lists.linux.dev,
 reiserfs-devel@vger.kernel.org, Dave Kleikamp <dave.kleikamp@oracle.com>
Subject: [PATCH 27/30] jfs: use sb_bdev_nr_blocks
Date: Mon, 18 Oct 2021 12:11:27 +0200
Message-Id: <20211018101130.1838532-28-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211018101130.1838532-1-hch@lst.de>
References: <20211018101130.1838532-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 18 Oct 2021 03:14:03 -0700
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

Use the sb_bdev_nr_blocks helper instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Dave Kleikamp <dave.kleikamp@oracle.com>
---
 fs/jfs/resize.c | 3 +--
 fs/jfs/super.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/resize.c b/fs/jfs/resize.c
index a42dbb0d3d28a..8b9a72ae5efa7 100644
--- a/fs/jfs/resize.c
+++ b/fs/jfs/resize.c
@@ -86,8 +86,7 @@ int jfs_extendfs(struct super_block *sb, s64 newLVSize, int newLogSize)
 		goto out;
 	}
 
-	VolumeSize = i_size_read(sb->s_bdev->bd_inode) >> sb->s_blocksize_bits;
-
+	VolumeSize = sb_bdev_nr_blocks(sb);
 	if (VolumeSize) {
 		if (newLVSize > VolumeSize) {
 			printk(KERN_WARNING "jfs_extendfs: invalid size\n");
diff --git a/fs/jfs/super.c b/fs/jfs/super.c
index 9241caa161163..24cbc9946e01c 100644
--- a/fs/jfs/super.c
+++ b/fs/jfs/super.c
@@ -284,8 +284,7 @@ static int parse_options(char *options, struct super_block *sb, s64 *newLVSize,
 		}
 		case Opt_resize_nosize:
 		{
-			*newLVSize = i_size_read(sb->s_bdev->bd_inode) >>
-				sb->s_blocksize_bits;
+			*newLVSize = sb_bdev_nr_blocks(sb);
 			if (*newLVSize == 0)
 				pr_err("JFS: Cannot determine volume size\n");
 			break;
-- 
2.30.2


