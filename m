Return-Path: <SRS0=YOZe=ER=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A63CAC388F9
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 08:27:41 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EDBE206E3
	for <linux-nvme@archiver.kernel.org>; Wed, 11 Nov 2020 08:27:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="p56L1YWk";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="WGdyaw45"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EDBE206E3
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=gpxIDshYdvps2pkQxuEVJWt6l52pP5kBTXrOzLfwmm4=; b=p56L1YWknacY5mKi4v1aMO1Ef
	b23EFr/gOYhTyYLXX2rjuVrGiVCWYve+wCrtXNjl82MrZQmi2pgx32JBEE73da+pEhIFoiLgkDAbS
	E4QgGx0/CXPcH9m2MTmXVENBJfL/CXrGYAAasGuumtSUKQVgwASiKqwrjNyp4r9w2lzmANTDH8G2v
	9fLYlIxSUwXKDn6LrdOin9anRuFfdf/ZSWILE82Rc+4AkPiuNSEpBaHkVlfJQNk6G0vVrG26Tf+qy
	8pukFBeTBX6GyMdm2rKdb3AsBRVIVie6eV64RLR87ocMYo24GpMv6U9A9CIabbvsb7ZubIBvAh3r0
	VpuwTWGvA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kclTY-00047e-Hr; Wed, 11 Nov 2020 08:27:34 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kclT5-00041S-Bm
 for linux-nvme@merlin.infradead.org; Wed, 11 Nov 2020 08:27:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=stmwFAlkeYayJwqxLAzxAb5snaHT5ewOrHfW4MD4mwk=; b=WGdyaw45qmIaK2SmatQbzEUT8g
 sEQj1d8rAjkxLN2VkCVTmqZPll/LHGpxSV/Ir/IILaWgwYuFt2ICDMLJQCEBXEhKh5VnaPge+eYYF
 IOkQ1MFG821grDHDC93JDllTw4BY36AXV/yFqmryZ3vHvbukA3hGqUm74A8voHvu45uxjEGSyanL7
 IphCk+rTO/osj709X1NFm11SrN6uOCMdFEiCn4af1goiKlpL+OEwTfsYuGysBGdA57IRinYRl+Iz0
 iyGlhXels8NLzlL13cFL+YI5aSIARz+l1EkZoUoEk2NSPyid+0DXdQDDf19mhfxK6pCa6I7Rf7UkB
 L8AvM4RA==;
Received: from [2001:4bb8:180:6600:bcde:334f:863c:27b8] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kclT3-0007Ze-1h; Wed, 11 Nov 2020 08:27:01 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/24] block: remove the call to __invalidate_device in
 check_disk_size_change
Date: Wed, 11 Nov 2020 09:26:35 +0100
Message-Id: <20201111082658.3401686-2-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201111082658.3401686-1-hch@lst.de>
References: <20201111082658.3401686-1-hch@lst.de>
MIME-Version: 1.0
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Justin Sanders <justin@coraid.com>, Mike Snitzer <snitzer@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 linux-nvme@lists.infradead.org, Song Liu <song@kernel.org>,
 dm-devel@redhat.com, drbd-dev@lists.linbit.com, linux-scsi@vger.kernel.org,
 xen-devel@lists.xenproject.org, Ilya Dryomov <idryomov@gmail.com>,
 Jack Wang <jinpu.wang@cloud.ionos.com>,
 Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
 Josef Bacik <josef@toxicpanda.com>, nbd@other.debian.org,
 linux-raid@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 ceph-devel@vger.kernel.org, linux-block@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Minchan Kim <minchan@kernel.org>, linux-fsdevel@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

__invalidate_device without the kill_dirty parameter just invalidates
various clean entries in caches, which doesn't really help us with
anything, but can cause all kinds of horrible lock orders due to how
it calls into the file system.  The only reason this hasn't been a
major issue is because so many people use partitions, for which no
invalidation was performed anyway.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9e84b1928b9401..66ebf594c97f47 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1334,12 +1334,6 @@ static void check_disk_size_change(struct gendisk *disk,
 		i_size_write(bdev->bd_inode, disk_size);
 	}
 	spin_unlock(&bdev->bd_size_lock);
-
-	if (bdev_size > disk_size) {
-		if (__invalidate_device(bdev, false))
-			pr_warn("VFS: busy inodes on resized disk %s\n",
-				disk->disk_name);
-	}
 }
 
 /**
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
