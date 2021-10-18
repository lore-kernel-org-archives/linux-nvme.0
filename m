Return-Path: <SRS0=IkIX=PG=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6D5E1C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:35:01 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2BB796101B
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Oct 2021 10:35:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2BB796101B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=2zn8NhPz2uMutIfYtKOd61bO1SYl+3hcc5qagxR0u/o=; b=XPrKrzQu6Yc7UyZwS76dZPifn/
	qmseO1o1TlNIk7U9aekxhJbkSBNRH9wIzQIvx4X0MXrDzGFZtlkYvXgXqQIt2Fw5fE2NRF/9h3dLK
	awSDn1IvEvJ7V5XRbYpCYwcAJ4eyrPCQBJydhg6TffkVzZHppywhlvaHqSvuXrSLRBwjWDz6VA4sQ
	BP8n94iEHzQfc6EJxEAH8jZ2a4LIYW9/xz/8pzGMqmQ5wcslw9rl5XP7rvf6gqDsj1UaSABnxHHME
	/vlbe/FCljTSXwN1j9LQUdXzgHL6S+HVuvILwdas2wRT8M2Z40uNck/P7dCtr4rYka1MnBAVJ/nEa
	/TWxyOBQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mcPyr-00F2tq-Gs; Mon, 18 Oct 2021 10:34:57 +0000
Received: from [2001:4bb8:199:73c5:c70:4a89:bc61:2] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mcPdC-00EumL-JP; Mon, 18 Oct 2021 10:12:35 +0000
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
 reiserfs-devel@vger.kernel.org
Subject: [PATCH 23/30] squashfs: use bdev_nr_bytes instead of open coding it
Date: Mon, 18 Oct 2021 12:11:23 +0200
Message-Id: <20211018101130.1838532-24-hch@lst.de>
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

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Kees Cook <keescook@chromium.org>
Acked-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/super.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/squashfs/super.c b/fs/squashfs/super.c
index 60d6951915f44..bb44ff4c5cc67 100644
--- a/fs/squashfs/super.c
+++ b/fs/squashfs/super.c
@@ -16,6 +16,7 @@
 
 #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
 
+#include <linux/blkdev.h>
 #include <linux/fs.h>
 #include <linux/fs_context.h>
 #include <linux/fs_parser.h>
@@ -179,8 +180,8 @@ static int squashfs_fill_super(struct super_block *sb, struct fs_context *fc)
 	/* Check the filesystem does not extend beyond the end of the
 	   block device */
 	msblk->bytes_used = le64_to_cpu(sblk->bytes_used);
-	if (msblk->bytes_used < 0 || msblk->bytes_used >
-			i_size_read(sb->s_bdev->bd_inode))
+	if (msblk->bytes_used < 0 ||
+	    msblk->bytes_used > bdev_nr_bytes(sb->s_bdev))
 		goto failed_mount;
 
 	/* Check block size for sanity */
-- 
2.30.2


