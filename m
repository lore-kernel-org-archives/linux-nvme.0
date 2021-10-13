Return-Path: <SRS0=KS3B=PB=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48C03C433EF
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:51:43 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1A79B600D3
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Oct 2021 06:51:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1A79B600D3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=z+/qf4ZP4Tac/sCHoQj70tORkSzWUW2S7hufMLTRhMk=; b=Id7hh3ijw7OcEn
	eq5exj/eXpgjJG+2Eao2Z6DkM+VzLrVYv6xza6YaFc4Gpl0I/IBsjCo2WSUBbFcVM7Vol6ADjnq8L
	3bfw0XB746eG/YI9OdX+/SMdr0FFj/lTLuRIUtjExqZhX+EKR8tO+Am4L2E4RLUzKFMICNrW5KGxZ
	/FmD9Xc76XipYycEmGZ1P7a4DhJR2YkQA2WODDWzTpG2NQYFyj+mVzF4jztlyZCUaiLGF1vImQS4g
	lKkPQ9uXPcimh90RS+B9EFAFAYdwuTTdpWIOQJu3IT4rSyWspgFEPVp/bTln3YVoeEgrrsKJorQvs
	yuaZ1jHn7AJm75TQ9Zug==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1maY6s-00FDXZ-B3; Wed, 13 Oct 2021 06:51:30 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWnl-00ExDi-DV; Wed, 13 Oct 2021 05:27:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=ThhwJoeorMicfGUoJpj8bDFZXXZ2Sru2bDJViO7vTu8=; b=LCiRvxWM1CTaMWKxh92Deomiwf
 AY9T2YY1wAWxayl0vHnI1Q7mpxaX7UvIsbVjgD5F5J0/8Qm83whK+tQBPPPd8pmhB0O4eGWD4XqfT
 c51RkGegU087jx0bEhd8pTkptR/xVbI1krXiYhhsCMIgD4nHHZeeyW9HDn7opQL1nNlHC+MWFxmZj
 O53LeicK40qW4KmNGbDlJiMfRDGAw1iqHT+q8MOwN7FIAQVaGPNnSrsAg3Oezji+43Uw1qYjdH5Lx
 A2knf7KchBs3lZTE5z1hpj3gY1+JYG/FFOQsWofs+2X44MCi4XFeV63rKedqfr82Gv2DcvsEarZbm
 idOFCkQg==;
Received: from 089144212063.atnat0021.highway.a1.net ([89.144.212.63]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1maWmy-00775i-Fe; Wed, 13 Oct 2021 05:27:05 +0000
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
Subject: [PATCH 14/29] hfs: use bdev_nr_sectors instead of open coding it
Date: Wed, 13 Oct 2021 07:10:27 +0200
Message-Id: <20211013051042.1065752-15-hch@lst.de>
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
 fs/hfs/mdb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/hfs/mdb.c b/fs/hfs/mdb.c
index cdf0edeeb2781..5beb826524354 100644
--- a/fs/hfs/mdb.c
+++ b/fs/hfs/mdb.c
@@ -36,7 +36,7 @@ static int hfs_get_last_session(struct super_block *sb,
 
 	/* default values */
 	*start = 0;
-	*size = i_size_read(sb->s_bdev->bd_inode) >> 9;
+	*size = bdev_nr_sectors(sb->s_bdev);
 
 	if (HFS_SB(sb)->session >= 0) {
 		struct cdrom_tocentry te;
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
