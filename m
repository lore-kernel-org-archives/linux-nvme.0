Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3841AC82543
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:02:21 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD76522453
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:02:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="zuchlKNp";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gtGrbYoF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD76522453
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=J9oaXuaMDpcasEnC8zQ4Oj80BJTSJUuN5T0kTtgIBKU=; b=zuchlKNpQs9c07NDEWKr+LpU4
	usQvNlU8rj2p2Ias5mUPxQjJqLkh4am7WwkljE61KELLi+fQXlVDIG9OhlWxyeK76LVOXw2fNe8V5
	i+KMvYWsXfGT8KggPIxdKsQydvhyTuWFFw6CBrSHxtin8eGogqGx6I0Q9AI0w8XBHnDvWVAkOu42c
	RvcLQ2lSQ9qqT1nL2CdXaek79BHHW7VP4sFJjbpj1PNaGKGk9khBeHdt/5lWcW4MAdD1C01Mru9WD
	zbhQs/188U59ptFyFbTjHbnyoWZAg4IkoPT14MSDFQuGKxM/AuP21k6Z2x+L7Y8U9UZre6R9hNZr3
	LMCM8qoIw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg1G-0005C5-SG; Mon, 16 Nov 2020 15:02:14 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxs-0003W9-0L
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:58:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=oHer8RhXp63g2o7G9aHUvzNO/U6So+wGZ90GcOP+Dmc=; b=gtGrbYoF3IfV2RkEJ0q/yjRhPm
 u76YggegzqwLDaW2wmtp0guycHd1DdJJXPC3l6bTCvZCUYePgzv3dFWOHEUXPC4So8yc5A2gvS4tR
 Hy1VCX8Q73aU1KV7sS6JXYB1g1s3pqYGejG2zrJp4z+yeUQPmcBPT4l540gRaJENO1IAv7EZfB7Lb
 lyoF7Dy4LZPRSHsVYIhEZuzqHRyruSHYZCLAQq9fL+cQKB4NITwomCUWwED4eV5+fsaYLCNOmHJqM
 0gddd4nl/e3/vrSUtpbS5Ut7YYhzUYZW8brx5egS7KnCoMTgxDAyPhKVlNw9lvJjh85+Rt/sRchjX
 rDNgymUw==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxq-0003ro-7G; Mon, 16 Nov 2020 14:58:42 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/78] block: unexport revalidate_disk_size
Date: Mon, 16 Nov 2020 15:57:14 +0100
Message-Id: <20201116145809.410558-24-hch@lst.de>
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

revalidate_disk_size is now only called from set_capacity_and_notify,
so drop the export.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 66ebf594c97f47..d8664f5c1ff669 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1362,7 +1362,6 @@ void revalidate_disk_size(struct gendisk *disk, bool verbose)
 		bdput(bdev);
 	}
 }
-EXPORT_SYMBOL(revalidate_disk_size);
 
 void bd_set_nr_sectors(struct block_device *bdev, sector_t sectors)
 {
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
