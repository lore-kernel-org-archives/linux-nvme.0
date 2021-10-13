Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99CFCC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:36:34 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4FD3260E97
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:36:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4FD3260E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=RT0MQPE0tlVk4YzNSIYWJhpB5k/ANSFcLOD/HnAi86g=; b=vRlKTWu/s/clih
	ZMsAoSYIlIBTidpZsp+J4+VgrI/8o2bxCbqKtEyxSOA8WrLIECYeilI4lZxCLzPkF1LgSZb9e7jGn
	3anoM+fy94bqdSgX4UMAqT0sSE4QbxpWoyZHOtgxKPF8AcNFkcX7tJPC/sNdF57wZvf9XvV9HxM0n
	7/Oou2Pd1P7JRNTN0ORcI29vnk6NGsOD/PJGxd470x/xR3znVa/LEfDxRXPrw7OJ7QvZMmTNcd2Ka
	7CS3uLxVmGXWSl6v8iZDn0R27v8exOSAgSlPVmvY88z5UqOq3CDfAwsi7+a1Gu0v5JGKmtSKLEfF1
	X7NHJym2+sBKJYu5DXag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maXs6-00FAgK-2t; Wed, 13 Oct 2021 06:36:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWfm-00EvF3-OK; Wed, 13 Oct 2021 05:19:26 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=TaHNzTEbIlyf8VXszJ+3gUpeBMoLxyPeY6M0WbLeJoE=; b=E+78EEJ2GHUy8Hk4P4DcOEjmwX
 HIQ2kNmA3WYxpDbTzgmiYyRL2xWCpSEifFW8boMSUF/sGaztAh3FbTDSkpa8miOFEZFNArrh9A/Ki
 peiQ6gNWuohYoOYEJ2aeJhiJkXX+ruL0fTrfijH7xWchqQ4kexPkIoSShXoyh6yHu37hoO2fDKYzY
 +yS55l1rIobhbkKzjv6H80Q2JgO7oc8Y8RPhkmll4qN72NgoDdwUDfEOxrfgtQZOXfF2S8EnoANXq
 9aLLxZ52YRtDKUJr7TbTHvQ6wCqBdpgppsBYsyqry+UY++1dQpz1Bq7l0+coY3Sl5L/KV8yTCbJYt
 jIiTKAGQ==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWek-0076NJ-T3; Wed, 13 Oct 2021 05:18:53 +0000
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
Subject: [PATCH 08/29] fs: use bdev_nr_sectors instead of open coding it in
 blkdev_max_block
Date: Wed, 13 Oct 2021 07:10:21 +0200
Message-Id: <20211013051042.1065752-9-hch@lst.de>
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
 fs/buffer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/buffer.c b/fs/buffer.c
index c615387aedcae..3fb9c5b457ab6 100644
--- a/fs/buffer.c
+++ b/fs/buffer.c
@@ -878,7 +878,7 @@ link_dev_buffers(struct page *page, struct buffer_head *head)
 static sector_t blkdev_max_block(struct block_device *bdev, unsigned int size)
 {
 	sector_t retval = ~((sector_t)0);
-	loff_t sz = i_size_read(bdev->bd_inode);
+	loff_t sz = bdev_nr_sectors(bdev) << SECTOR_SHIFT;
 
 	if (sz) {
 		unsigned int sizebits = blksize_bits(size);
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
