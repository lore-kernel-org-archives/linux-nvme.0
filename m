Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8A9C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 14:58:26 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 926332242E
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 14:58:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="izs9Q1D9";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="usuU2sef"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 926332242E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J/PsemygbegCnJ7Or0f85ajlodYdzYxc56huwYB5oFg=; b=izs9Q1D92vSoVT8FoJLnHPav6
	VN908elEp5fZKxqs0AEgjP2rOuee4gT08rxoldtG3gUHtMZuKJzWRsM8rzsO0+LNRhIVX3T8K8fre
	GUiEsNPwwz6gbfEdL3aE++u/nO4Rny+NTQkRvFnFDWSdpXTom/qTYqqgLoUzQXUrNCJXNvb4KSSsb
	cM5cer/hfG30QI3M8mP3nGf854DRAFAWnJ6hSHS9YKAiEq8apuLuEleJA0ENhzJdtrTqtnFs1oWVx
	JsWZT94/YDt6XxaoBy2emfjnq2oYhF2EWaBXtjlcXkS+BZXHv1XXtjLJDa+HHs5t7aw7Jbej1vNZy
	N0XK9KCDw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kefxR-0003L1-Vp; Mon, 16 Nov 2020 14:58:18 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxO-0003JO-Fs
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:58:14 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=82UVn9JDhZ7kcS3JGvYaAt4iz84QDJp/mOdtcI/Npsk=; b=usuU2sefAFYqsEXj3qbul/Q7Un
 CCv9GjY0IirraZHVxERI0VFsNKbIJNWWfb9W2amAmbgPQFz1SQQGP9jucGmGFK5Dmz+uV/dQrh4EZ
 Yz7+inlUGGRZ2SENP6FNBzSsnyPPr/9g2oHpP/gfHR3aZh9bCC9SRkZky62gN2xUhMktrW7I1gC8O
 OlLKrcM8QGapUy4m0OUacF0pEkCV+NYMm0cjABSANyQg80uGZOPlSQK6hRsBvshv4teWYRl87jbJA
 +wqxRblm4gAKo4kgFpaUcUBO3YCWIyQ/tck3EBg4rNw0ym4xMAVhVwQ1xnNmFGgIlSjLbsb6rNNg5
 l7qTv7cQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxL-0003ie-Nn; Mon, 16 Nov 2020 14:58:12 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 01/78] block: remove the call to __invalidate_device in
 check_disk_size_change
Date: Mon, 16 Nov 2020 15:56:52 +0100
Message-Id: <20201116145809.410558-2-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201116145809.410558-1-hch@lst.de>
References: <20201116145809.410558-1-hch@lst.de>
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
 linux-raid@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Stefan Hajnoczi <stefanha@redhat.com>, ceph-devel@vger.kernel.org,
 linux-block@vger.kernel.org, "Martin K. Petersen" <martin.petersen@oracle.com>,
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
Reviewed-by: Hannes Reinecke <hare@suse.de>
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
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
