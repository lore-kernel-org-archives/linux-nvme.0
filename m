Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7701FC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:28:47 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DF37160E97
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:28:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org DF37160E97
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=unOcCLB/Y+X7QsPCROrYgNx+ufEsYQijHr4gZfoxjqc=; b=gh+lDnwsqpB6eV
	FyUy5n3JCxEwJCZYP8govJjynIwHO8DP7SH4h+uVZuZaUt0AhB4OXRJBrxhB2om+aPrQcoJQV4Hry
	yaAi2aWetbtqzg+GvCkUbQsgYMJ0JjHoXpDjWO8gwGLLcO00Oca3yzlH0EsnoCvISTEKCN5Q6bJt0
	754ZLv46UDlYzfR9VjSEaQ3+JooPKu9sonTLuv42C8RaWm34L6kWJtvCYjvsLZ9qCjY4s5elBwT6t
	t4GtyblKzo5PN4FPiM9r8pwAaTKUkJobqxJRQKNsbFi5H8sZd2yxtnM5U1PF3iTNhoH1iHqIgiDry
	ajPXKMYyBkr+65y3DKcg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maXkW-00F9FG-5J; Wed, 13 Oct 2021 06:28:24 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWZq-00EtNT-0P; Wed, 13 Oct 2021 05:13:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=g8zwkRt9/f1ewG9ciisUGRCziOVySw93pi5vyPemNAI=; b=nWIotL3QSRoDmvAA3o9BLxIx6i
 t4tgYxkL2iWa6feU3mcKjViBgV628kEI3j5cp2HTfHI5qbb5tmwpSC/812qJ+tIpOC0+6ZXF0Yhk1
 5/9uLY7Z9un8Zx+wYevMd9WgJEXEPd+jf99pZpD/NqPCzIY0yzkTDeFs/A7NObgO/TsPUlUm00azm
 jzgcK41A7UnRgzQeKy8vk7Tjr/8htqPY0cCKS9erTgbsPAmZcQk05o5++x3yiFcAox9+NsbnoYLD2
 XgiNG4Ra1ckwDmXmBiQEy6lDOHyfYSyUX1y5l6wMULdMarhxHkj1ybNbPpIss3/EZnwhnweR8ESQO
 YWkbaoTA==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWZ8-0075yH-Vb; Wed, 13 Oct 2021 05:12:50 +0000
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
Subject: [PATCH 02/29] drbd: use bdev_nr_sectors instead of open coding it
Date: Wed, 13 Oct 2021 07:10:15 +0200
Message-Id: <20211013051042.1065752-3-hch@lst.de>
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
 drivers/block/drbd/drbd_int.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/drbd/drbd_int.h b/drivers/block/drbd/drbd_int.h
index 5d9181382ce19..75fda53eed8cf 100644
--- a/drivers/block/drbd/drbd_int.h
+++ b/drivers/block/drbd/drbd_int.h
@@ -1826,8 +1826,7 @@ static inline sector_t drbd_md_last_sector(struct drbd_backing_dev *bdev)
 /* Returns the number of 512 byte sectors of the device */
 static inline sector_t drbd_get_capacity(struct block_device *bdev)
 {
-	/* return bdev ? get_capacity(bdev->bd_disk) : 0; */
-	return bdev ? i_size_read(bdev->bd_inode) >> 9 : 0;
+	return bdev ? bdev_nr_sectors(bdev) : 0;
 }
 
 /**
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
