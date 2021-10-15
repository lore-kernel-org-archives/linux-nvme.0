Return-Path: <SRS0=TQUi=PD=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F7BBC433EF
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 13:50:12 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 018D3600D4
	for <linux-nvme@archiver.kernel.org>; Fri, 15 Oct 2021 13:50:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 018D3600D4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=JmkRxhA/wAtqRoJ695vCmDfNj7DKperG4SlvbF9/aQA=; b=cOOnsTjljCxrBjusZdj120EnHR
	Q3FYwg/uxkzPnkkZASpbR6mwZesDUYhBCKIjcBHNtQiTo+VFP91Vh06IlbsHspfpmvhJTWLKb6inJ
	nFnKFE6ULLPJ5JeD3NRxqGJr+h8Am96pEZZF5Owcy9jCVFGzsCi1DWBsP+6JPF9M4sihmuizuzwD0
	itfXQoPSHW34UUjEvx3Z4dQGNSYklPIlf7X/2ZUz4tROjlKcrQGMU/21UldsK6CTgeR/mCx4zAnKM
	RkmuGKcH2WMrAur1pdcAXvO1IAYkFCNDpBuDhRSGwGgJc65B6yUsNNpfWpIrYb8KbNq+zIA3BjAC+
	wlHLO/WA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mbNb6-007Mu1-Hk; Fri, 15 Oct 2021 13:50:08 +0000
Received: from [2001:4bb8:199:73c5:ddfe:9587:819b:83b0] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mbNFE-007DLy-QR; Fri, 15 Oct 2021 13:27:33 +0000
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
Subject: [PATCH 18/30] nfs/blocklayout: use bdev_nr_bytes instead of open
 coding it
Date: Fri, 15 Oct 2021 15:26:31 +0200
Message-Id: <20211015132643.1621913-19-hch@lst.de>
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

Use the proper helper to read the block device size.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/nfs/blocklayout/dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/nfs/blocklayout/dev.c b/fs/nfs/blocklayout/dev.c
index acb1d22907daf..5e56da748b2ab 100644
--- a/fs/nfs/blocklayout/dev.c
+++ b/fs/nfs/blocklayout/dev.c
@@ -252,7 +252,7 @@ bl_parse_simple(struct nfs_server *server, struct pnfs_block_dev *d,
 	d->bdev = bdev;
 
 
-	d->len = i_size_read(d->bdev->bd_inode);
+	d->len = bdev_nr_bytes(d->bdev);
 	d->map = bl_map_simple;
 
 	printk(KERN_INFO "pNFS: using block device %s\n",
@@ -367,7 +367,7 @@ bl_parse_scsi(struct nfs_server *server, struct pnfs_block_dev *d,
 		return PTR_ERR(bdev);
 	d->bdev = bdev;
 
-	d->len = i_size_read(d->bdev->bd_inode);
+	d->len = bdev_nr_bytes(d->bdev);
 	d->map = bl_map_simple;
 	d->pr_key = v->scsi.pr_key;
 
-- 
2.30.2


