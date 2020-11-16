Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01E92C82541
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:02:44 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B3C1E217A0
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:02:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DSEe+e1c";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="oYdX9nzK"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B3C1E217A0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=x1SwzzK696y867TXed8tl98UOlR4Pze0hbolpQ4wE8M=; b=DSEe+e1cz62tTVTEb6ASJhJYW
	9y+ORH97TqyWHEOjXOFHCHfKQCYcPHR3/OwxTtWvgJTXX+XPahhDTZSKyYnGLI9jragHWqD0p7RrT
	KbXmAbcDQVy4NSBthb+cDv3mjXOwETiYk8YLikDpMKn+QPF02pCMFZXB60+qJnKLlKgCsbVU/MePP
	4EAZsku8R+BGM3FH5YL6hgN+x5Pjbs7+4R6pkIoIScqPV3QIo/sMKfQJV7YzungW7NNu7WMbJkPpq
	3qsnO9PxJL+5GboJjO4Uv+kvEM4a4oI2IkvPkv3VSLXgubVjDzalc39bjYOL9Mnqn1D0ib3OSOEST
	xUYduHIig==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1keg1b-0005Lx-Lk; Mon, 16 Nov 2020 15:02:35 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxw-0003YO-6Y
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:58:48 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=9xKkbsaYgLwhE10hNLQkbULUUrvPvOI5lAnm4OXLvPs=; b=oYdX9nzKoJif6AkXObIozxVfvj
 7cGF/f/pUnJJHDQ6T2624151wrdwaTi3mmORA1Sk4dkNQXTLpvcPq6k6KdWEaLJxRF4lDmEXm8qw9
 oYE1wB5V9C5rcNG0vg2/s/RZq7WpvPXksRbrz6BhFVFbp3fgW6Cu8Ei10wVmFRzzU2lZbNkryPPwp
 UyZEBLPwZzIDOtCGDnQaZ/yC0WN3H+ttyOeryQQMS7541LF9/8zj21iM7fknwF/oyMb92PdRg+U+/
 bjDqshSNF4XCVwta4ehBG8dKT/cx10oylnvhgVmCv3gk5lCpRUkUrEy9iufHfdIZqR7G/SymA4RHz
 LVTtFmtA==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefxu-0003sm-C6; Mon, 16 Nov 2020 14:58:46 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 26/78] block: add a new set_read_only method
Date: Mon, 16 Nov 2020 15:57:17 +0100
Message-Id: <20201116145809.410558-27-hch@lst.de>
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

Add a new method to allow for driver-specific processing when setting or
clearing the block device read-only state.  This allows to replace the
cumbersome and error-prone override of the whole ioctl implementation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/ioctl.c          | 5 +++++
 include/linux/blkdev.h | 1 +
 2 files changed, 6 insertions(+)

diff --git a/block/ioctl.c b/block/ioctl.c
index c6d8863f040945..a6fa16b9770593 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -389,6 +389,11 @@ static int blkdev_roset(struct block_device *bdev, fmode_t mode,
 		return ret;
 	if (get_user(n, (int __user *)arg))
 		return -EFAULT;
+	if (bdev->bd_disk->fops->set_read_only) {
+		ret = bdev->bd_disk->fops->set_read_only(bdev, n);
+		if (ret)
+			return ret;
+	}
 	set_device_ro(bdev, n);
 	return 0;
 }
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 639cae2c158b59..5c1ba8a8d2bc7e 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1850,6 +1850,7 @@ struct block_device_operations {
 	void (*unlock_native_capacity) (struct gendisk *);
 	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
+	int (*set_read_only)(struct block_device *bdev, bool ro);
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 	int (*report_zones)(struct gendisk *, sector_t sector,
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
