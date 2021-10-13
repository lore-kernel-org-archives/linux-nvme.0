Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EA9DC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 07:15:26 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 024C360EDF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 07:15:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 024C360EDF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=wl1v30gXPehghGa1G71intILZU74c8zVJPmLtFe5N08=; b=ux0oovftG0KuBJ
	pH/+Xquhs7r1t2fWF9juQ0k3nz+anhqN6dxZjTgLm6BxeguLuxdfeMGb/5BXhJHCT1sM0/qOIYjEe
	7V+zWW0UVyhzoreevOBiyYt7GXyXog5N5gNrj4GmxU5xQ8wQqcKl/GgYQ+Mh1xXM26MXpCN8u8w9V
	scBkC1MyD2sRj36qwLfkYWmV66apAa0nmBo5Ij0yEiz0pA0izRSRR8ZcRj9NyVvfYmH0pw6ii2rqW
	wYvEiy0E5JhSTQeP3y58KHaZd9Lddjfl/0ZdDaUpSOfCKvdAZwx/cQXjGysliPPNYylGqgXi13EvP
	bdwpMQ3WnQc0s03SmgIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maYTo-00FIcO-3p; Wed, 13 Oct 2021 07:15:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maX2q-00F0ON-Py; Wed, 13 Oct 2021 05:43:16 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=MKwukInBFyTrKs6Aaqva7I1GF564O65mEY1S2Zysf+k=; b=oqNTvlSr0gVAj0cgPWjUWrqx5W
 302GO5JLoORjXACgqvRCalGteDMLyREVnZEUqj7xcXjq/iId0NgEzrSbOh4obQ/4ee5i8l5o4LHIM
 wuROI6BCvi3PT9S4ISVOdom6x+IJvC1vWyuVq0NPvO9jZe22/fFauPkXcii4KKRs5DNXGpYni/AL8
 7HHnxpob34N0OG8teoDCDT7mKUkmCfBE3Z53xu4LPhWgu0mT3MaKEu43GOXtbQZ/0tXbgdi3R0K1w
 t+4AxSmLzZ2HoIZ3ScAlF5AU7pcSW/CSoinAM1YX5U1B5IcEYVGt+llNo1haLmMx3TH1LnU3xsrsR
 xISwV+ig==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maX1B-0078JQ-HS; Wed, 13 Oct 2021 05:41:50 +0000
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
Subject: [PATCH 26/29] jfs: use sb_bdev_nr_blocks
Date: Wed, 13 Oct 2021 07:10:39 +0200
Message-Id: <20211013051042.1065752-27-hch@lst.de>
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

Use the sb_bdev_nr_blocks helper instead of open coding it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/jfs/resize.c | 3 +--
 fs/jfs/super.c  | 3 +--
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/fs/jfs/resize.c b/fs/jfs/resize.c
index 51a8b22e71030..f23445fa4b417 100644
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
index 992870160903d..fecef43f94ae8 100644
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


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
