Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A4AFC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 07:13:24 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 424BD600D4
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 07:13:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 424BD600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=q3R+GM8UrZTDp3FHIOMwkV/f4BqLByzWehvQRA9ZcsM=; b=CkOHZCE1IljmhH
	hX3B4FJ/7e3krkg2cwWZYD9P18PamnS17MzVxdibLMeVUvMRPRWihmwTDv3iWs8GCJen3aZoR9MZA
	aMT6k2naWKIhgorEe1sWcO8WNbPWyowqvUCbMyTcmVj5M46GGXSsR6zVM+X2+f31fuZ95+ZQEoaeZ
	Q7o9DYC9vu48fiCpjjdgpKIQH66qD1eKxgHSwfGxQyB+qnTFRiWEjHKXcDkd2n5jRECCSpcq9cmVN
	E+xV/KMenGb2rSLWsHLj+lEPDjhJ7GBhByKKhTUAnVaP14MNkON6nx5UbuRnt3mbhqVraniojZJOB
	QeFMvZc4kPC7RCX6Q8rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maYRo-00FIBE-3u; Wed, 13 Oct 2021 07:13:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maX1D-00F035-87; Wed, 13 Oct 2021 05:41:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=kwfQLb7O9l96WELHgKkQp9uAWAHVStsZsqmvY42uDo4=; b=Js2OVKVfiBuoQhUaPUfmkclx7M
 vrcm9EA/k/58MnCVYR8evsjUq/8YSxHWrce4AslfsXGvyvTdhhqIyGJPATvDxpqQoD9IScte+hEkz
 DnB3FboglDfnuxse6DhZbT7kv4ybTwHy3r7ZExgrRfNsTj/EtZ/9HExURYmOO5GKGASY9oD12P8bt
 oLK99Yr3VXl9XkDp+Wc1ZhWpJWTkh33e4joQUxjU/cGOr5BdZGSsLck2z425Mw/QlOZ43bY9ROw+f
 Tq43ONvwIFJHr+HX+y1s/mwjBNvb8CC05HJyiYVwEqZEtf52eABp80sHiXOw2OyQ26fsS7F3Q7HqZ
 7cPBt4fA==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWzm-0078GH-5A; Wed, 13 Oct 2021 05:40:38 +0000
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
Subject: [PATCH 25/29] ext4: use sb_bdev_nr_blocks
Date: Wed, 13 Oct 2021 07:10:38 +0200
Message-Id: <20211013051042.1065752-26-hch@lst.de>
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
 fs/ext4/super.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 0775950ee84e3..3dde8be5df490 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -4468,7 +4468,7 @@ static int ext4_fill_super(struct super_block *sb, void *data, int silent)
 		goto cantfind_ext4;
 
 	/* check blocks count against device size */
-	blocks_count = sb->s_bdev->bd_inode->i_size >> sb->s_blocksize_bits;
+	blocks_count = sb_bdev_nr_blocks(sb);
 	if (blocks_count && ext4_blocks_count(es) > blocks_count) {
 		ext4_msg(sb, KERN_WARNING, "bad geometry: block count %llu "
 		       "exceeds size of device (%llu blocks)",
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
