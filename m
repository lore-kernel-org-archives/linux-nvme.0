Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B98C5519F
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 14:59:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45B8824199
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 14:59:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L7FfrA6s";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iXlgdH+J"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45B8824199
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=b76ulaLzl/qj2GUxE+CdsRYB/dFAPCzdM5B6QrJzVy0=; b=L7FfrA6stCVy4M/u+T9gQYDtf
	7Jr3adEuuQDZ5aKLXbo3V5EQfzyeRO8/u1W1fqjvwjY98K45FOKIc4haTVQIN+tO99UI3j6j+7uGH
	09quKec+p+ZtRAJ+EbXHJVNBqduATtA+2moxc4iq+bnQsm6VEt8Q7YamiAvifTZQ3Ph97BoUZx0/v
	VVS/BO6n6mRSqHocDhjPjQsXhgINc8Iaew4yIfu9XwaE0IZyCWzZPu+kp2/eRNFN9hr77t/PeVkxy
	DhTg4On3ZiMB7jujjJP3UPiKf5iT5Mq/Qs0/HrfxMKyO6VuyTvCXF+HrYYI0w8CwupTwAv7QpFfIa
	gRe2OrU6g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kefyI-0003jw-Va; Mon, 16 Nov 2020 14:59:11 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxb-0003Oe-Gd
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:58:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=79ABHzAqAgUDi+r50gNTM9KzgxZfWtsd0Ks61Se8Jjk=; b=iXlgdH+JkeL6roCvy9N8OmOptV
 1Ll+Te6ItuycUsm1mpg5y8MmMvSDVgOMN0DW4BJjUzEL2YXMUw9FI/gCg+GglIDP+2ssWuLid2fb0
 cJZnJp4fVhOgNW619uL3/Kd6hYd61L2NdpCEsJu2r2sYtsuKn5OWNCme31Wn3/FHGbzcF/v5kYRm2
 JnXQsbwRBlyoUcHtnndvHGCnGiJjghxupsGPmu0u5FKR/+UjbjsAeA9OHsZoDrRaOzkGH06M+kWrS
 F/Df603StVMFLWH3uWTjYYJHcHqMIvbijKLsxzszv3RzSONMJItnrjbuYjjQ6SdDQT1ZrHiZj6i2L
 17QgIiog==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxa-0003md-8r; Mon, 16 Nov 2020 14:58:26 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 12/78] dm: use set_capacity_and_notify
Date: Mon, 16 Nov 2020 15:57:03 +0100
Message-Id: <20201116145809.410558-13-hch@lst.de>
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

Use set_capacity_and_notify to set the size of both the disk and block
device.  This also gets the uevent notifications for the resize for free.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/md/dm.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/md/dm.c b/drivers/md/dm.c
index c18fc25485186d..62ad44925e73ec 100644
--- a/drivers/md/dm.c
+++ b/drivers/md/dm.c
@@ -1971,8 +1971,7 @@ static struct dm_table *__bind(struct mapped_device *md, struct dm_table *t,
 	if (size != dm_get_size(md))
 		memset(&md->geometry, 0, sizeof(md->geometry));
 
-	set_capacity(md->disk, size);
-	bd_set_nr_sectors(md->bdev, size);
+	set_capacity_and_notify(md->disk, size);
 
 	dm_table_event_callback(t, event_callback, md);
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
