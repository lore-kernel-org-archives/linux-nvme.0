Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3652C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 07:06:44 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8BD8F60E78
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 07:06:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8BD8F60E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=yXOoWcS35X1KfrNWeqQ+b0IDU1Tj0XRaqfC0AVJT5Kw=; b=oyNsgYZI3FAVkH
	2xnH4Sujrdn7rKnj6R+byeR0OORLHZpHY0tXn9S769yHfKgitnZHtK8OgYyJFrwiz8iK2uiKWnGrN
	ciGXTNa+lh7TxUtmryMi8FyfyymArivv2XCZVcmrkvdi5XHH7r84FZZoHfcxFUcYcit5O9d19FFwj
	JOxkF+PvKwPuGqiXv5TvGzWiYYxDduPn6JhnWk7lws/ZB1NW99+wJ7OqIPugjo0rVBuj+/Wo3W0ur
	8SdjnVAcKmqc6ud4POTAhBazxH2w4odQlKSwFQDQMHGquaU5ZMtYof3XcZqv4o9/3LRd1CoCT5wT3
	atx4uP1NqhzSpZP/ST3Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maYLG-00FGl2-Hy; Wed, 13 Oct 2021 07:06:22 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWwF-00Ez3K-Hk; Wed, 13 Oct 2021 05:36:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=neY9ZJPH9MOzXmChpQoZ9vtfCPorKJutFa1ekdF3DV4=; b=PfsnohEdvhV/ruqSbu6iivGJd0
 Zo3djyN81Xn383MmVLbTJS1kEa9ZCXS2mDK7N5D8NmAUj88uBINNyCVjbt3Hz2fQVnR03Zhjiq14G
 7zKHh2mUo689xTR7fXEhFyPZxgwKxVIRy1j43hJzInRINaWAIzmG5d6Ld0VmrNJ+Kq8r9BVg4Cbci
 R/3myVb4K7ohrxlSfIhxqYAmYvFKTO+S1ZDDBa/9e8IX/lkJ4nmXRD2lGIKarWEbMdpJEKTQye58o
 teu82AOgZQfEvAkdOov+/Ln7EN2g7QtqcBdIkCnPq14ddL0H7JCQgOHyHVTLPqcDo9HQcK5qlrTAA
 FSxta/Cg==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWui-0077oT-Pz; Wed, 13 Oct 2021 05:35:26 +0000
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
Subject: [PATCH 21/29] reiserfs: use bdev_nr_sectors instead of open coding it
Date: Wed, 13 Oct 2021 07:10:34 +0200
Message-Id: <20211013051042.1065752-22-hch@lst.de>
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

Use the proper helper to read the block device size and remove two
cargo culted checks that can't be false.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/reiserfs/super.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/reiserfs/super.c b/fs/reiserfs/super.c
index 58481f8d63d5b..6c9681e2809f0 100644
--- a/fs/reiserfs/super.c
+++ b/fs/reiserfs/super.c
@@ -1986,8 +1986,7 @@ static int reiserfs_fill_super(struct super_block *s, void *data, int silent)
 	 * smaller than the filesystem. If the check fails then abort and
 	 * scream, because bad stuff will happen otherwise.
 	 */
-	if (s->s_bdev && s->s_bdev->bd_inode
-	    && i_size_read(s->s_bdev->bd_inode) <
+	if ((bdev_nr_sectors(s->s_bdev) << SECTOR_SHIFT) <
 	    sb_block_count(rs) * sb_blocksize(rs)) {
 		SWARN(silent, s, "", "Filesystem cannot be "
 		      "mounted because it is bigger than the device");
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
