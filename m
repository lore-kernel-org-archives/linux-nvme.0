Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 914DDC433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 07:11:27 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3017060E78
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 07:11:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3017060E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=Wlz7CgF7+ct9luprlLy+U+ArteKQjECzQQ0pU9YjcQs=; b=vH1Tq3nwysw/Lr
	7LaREjfxZ6BT5nRlAYGk7PZwToXQHhXsnBsSqYfaTdihEYH+dxDzqMOUKpezsrb0gc0Ia3t9A/+aC
	UonrP9ZLa8Xzu/wHcyphoucFi09qp9t/qhdeb/rwfhOXOLbM7I9vh7qn2TfGivDzGDOJAcQc53E/+
	B9pA7Y5qXtHbCaIElbTTVPDJA67WA04ZINl4dWELJSJMPJetGEx6xBn4RV1i8+sRXHqwPPPJWLOau
	2aY35EvuQzYuThTBFyTq+v28fj9ycuAX2PBry37tQaEfewF6rpt5QfUJxYXKTJvV3szK0+kzCufdH
	OGoRTuwK1iO1ElHBEfcw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maYQ1-00FHmt-I2; Wed, 13 Oct 2021 07:11:17 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWzm-00Ezl1-E0; Wed, 13 Oct 2021 05:40:06 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=vUXTd2YdXfDrfy4pbV8SMX7GiwQcZZ3XnEJ9sBFT+FY=; b=H0UVWNgwlojCDOZ0ZDJEHbcabH
 /9k0Jdc+YLFDHne+zfEyDy0jv5BMEE4tSHTVSjq9pY+zz3oa4oUqe8AXLPv3nLRy41ZvHo0BFuSsA
 MaY/EKHh1Bp7Uf1udgCZNNBxreNpTwvrd/EqmRLDQBn6IJi8YRJFbqQmFZeteuySU1Cfmu1NFiTgQ
 2LgWePcSz6O2+8NDUH5I2rp85amag5Y71YZ+7TLQm1/Q0On+c4vchAxkdL8ToRCxOv8PtjjyJ+kWZ
 +hJqPyUbz5GIMW3ia1Y04II/0+/C9L7zroftL5CNXO1fs8k/zQt2HAH6gz3BjvISqqA/tFFfZj+Q+
 u0lN1M/Q==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWyt-00789s-54; Wed, 13 Oct 2021 05:39:26 +0000
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
Subject: [PATCH 24/29] block: add a sb_bdev_nr_blocks helper
Date: Wed, 13 Oct 2021 07:10:37 +0200
Message-Id: <20211013051042.1065752-25-hch@lst.de>
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

Add a helper to return the size of sb->s_bdev in sb->s_blocksize_bits
based unites.  Note that SECTOR_SHIFT has to be open coded due to
include dependency issues for now, but I have a plan to sort that out
eventually.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/genhd.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 082a3e5fd8fa1..6eaef8fa78bcd 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -245,6 +245,12 @@ static inline sector_t get_capacity(struct gendisk *disk)
 	return bdev_nr_sectors(disk->part0);
 }
 
+static inline u64 sb_bdev_nr_blocks(struct super_block *sb)
+{
+	return bdev_nr_sectors(sb->s_bdev) >>
+		(sb->s_blocksize_bits - 9 /* SECTOR_SHIFT */);
+}
+
 int bdev_disk_changed(struct gendisk *disk, bool invalidate);
 void blk_drop_partitions(struct gendisk *disk);
 
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
