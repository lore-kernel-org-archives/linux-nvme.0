Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF1FFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 13:36:56 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B19E76115C
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 13:36:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org B19E76115C
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3V9fbTJuZDj71a+9mtkBQXQRRqP9hAgnu+ZIhkaADhI=; b=b3NfncoZOsVpCaA/+1+oGa1L1U
	FitKvUYnZu67HQqap6y3HIga72ZKaLhvnW5c5wljK8v5FM3mB0Y+ZDxApgFr2QcOy79/yQ26EKwzx
	CR6Urc7yYzWF5xAuyixS8Jj7TjomdK7wU7/FMfwfm9qaLEwi+0+ng48InZ7vcW2mmzLgiz0iLivyF
	kU+lrh96mAYr63VSeYNOW/XUsQAw7ixDuZ3siPDApxHZvCtjGZPZpszFljS/7/KYLkL8SY+wTdRmt
	veX0vB22l038iauZ712DrZwpicpMPYpRP9wwhXH/LwwH4qPU2uqpbE7akoj5aOa2h1CE1G3HOgb4o
	DnVUXDFw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbNOI-007Hjs-9l; Fri, 15 Oct 2021 13:36:54 +0000
Received: from [2001:4bb8:199:73c5:ddfe:9587:819b:83b0] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbNEZ-007Ce6-3w; Fri, 15 Oct 2021 13:26:51 +0000
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
Subject: [PATCH 02/30] block: add a bdev_nr_bytes helper
Date: Fri, 15 Oct 2021 15:26:15 +0200
Message-Id: <20211015132643.1621913-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211015132643.1621913-1-hch@lst.de>
References: <20211015132643.1621913-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 15 Oct 2021 06:36:25 -0700
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

Add a helpe to query the size of a block device in bytes.  This
will be used to remove open coded access to ->bd_inode.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/genhd.h | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/include/linux/genhd.h b/include/linux/genhd.h
index 082a3e5fd8fa1..f67db3c5a04b3 100644
--- a/include/linux/genhd.h
+++ b/include/linux/genhd.h
@@ -235,9 +235,14 @@ static inline sector_t get_start_sect(struct block_device *bdev)
 	return bdev->bd_start_sect;
 }
 
+static inline sector_t bdev_nr_bytes(struct block_device *bdev)
+{
+	return i_size_read(bdev->bd_inode);
+}
+
 static inline sector_t bdev_nr_sectors(struct block_device *bdev)
 {
-	return i_size_read(bdev->bd_inode) >> 9;
+	return bdev_nr_bytes(bdev) >> SECTOR_SHIFT;
 }
 
 static inline sector_t get_capacity(struct gendisk *disk)
-- 
2.30.2


