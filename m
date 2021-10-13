Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6335FC433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:47:00 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2223360ED4
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:47:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2223360ED4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=ywk2Ipylbxs4rD0tGIwHM4RTei3VV1YArs2JLH9wDgk=; b=DYh7QW6ZtmdGbD
	uWYIb1Ann3nva0IaivaIXN8inbgv9yw3FEhIpfqpmTuixf9Ww25dBgh7TkjwSPNdOxA2nyeiZS2OA
	plAEGv2yTeppaLebf+xJx2ha8SFEvmsR+qxDizJYp22+FHoLa/TRjkjvPvlvR1+UOqpd/fDdeYFbb
	Gtt3UCIPgXFf2lzL8MqIVmYGoPIUD2oB/ky9rKEIGBG0+obbSGcZL7gz9FHWzxI8Q1jenwPI62oqd
	Kg7OZV5x/rrFvU7X5H2Q4fVkVK+1DLri0SCd2vwYUFI9/oTqD/vYaeSrjydCzi282akP+bvN4mYZ+
	2KnDrKPFRBMjnldobhsg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maY2I-00FCci-UA; Wed, 13 Oct 2021 06:46:47 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWll-00EwmU-Vb; Wed, 13 Oct 2021 05:25:37 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=RuQql9PAJvmACL7i0h0xGgkkp1rdpC0kgf+XgcS+6Uc=; b=ZDnfJ4tjhTm9Mn7WDgxDF2q0Ka
 tcVQf+6r7CGUE4Z8KmpJebFSbalpD5/KYotd4fqypU0M78aGqiy0pQaTm52IKG27Z4Au0kTPkOwwo
 gg4bf9iHYK/uAaRdL6Q1ojBwxLmETr7haaRPmz0ih5VYskV7ZVdHHcesAG4GuWbzgCEbT8PIkcCb4
 MGajLqXkZezJCfHWYOi3Swt9cSDtP2d5kfZCurDldYeZxM4GQPfVElexk1xd92Kpv1aYsTExOG6te
 o2iRMSucS2M2zB2QLauGfzkHLJedeSzGjaihUqcMN27wENvi9tRQC/4DJamJ3T0IWaTikE21cJ2AL
 p/h3oWDw==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWkO-0076qI-Ax; Wed, 13 Oct 2021 05:24:43 +0000
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
Subject: [PATCH 12/29] cramfs: use bdev_nr_sectors instead of open coding it
Date: Wed, 13 Oct 2021 07:10:25 +0200
Message-Id: <20211013051042.1065752-13-hch@lst.de>
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
 fs/cramfs/inode.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cramfs/inode.c b/fs/cramfs/inode.c
index 2be65269a987c..3e44cc3ed0543 100644
--- a/fs/cramfs/inode.c
+++ b/fs/cramfs/inode.c
@@ -209,7 +209,7 @@ static void *cramfs_blkdev_read(struct super_block *sb, unsigned int offset,
 		return read_buffers[i] + blk_offset;
 	}
 
-	devsize = mapping->host->i_size >> PAGE_SHIFT;
+	devsize = bdev_nr_sectors(sb->s_bdev) >> (PAGE_SHIFT - SECTOR_SHIFT);
 
 	/* Ok, read in BLKS_PER_BUF pages completely first. */
 	for (i = 0; i < BLKS_PER_BUF; i++) {
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
