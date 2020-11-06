Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A4A2C2D0A3
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:06:20 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8680206F4
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:06:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nIKKn1Uf";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="iiGVfdCI"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C8680206F4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=JitiH1enTLz5VRfmZzSIfmh1ICAqMwlQSAUid0yS0RE=; b=nIKKn1UfzGNyMkfCnUeR3FA7s
	ZZxkV7G+Qdws49sThvi4T1nOOKVc0/91SZt/ZiA9cEUtkBd4UnNoRBGBEJSrpyO8cpOfeyB6kTuOo
	YquWuOy2vBMZUXBGi8P9dIbkqWHcK+9zl261ORycrKB6It5GBx4Bf0C0bOCYGvUFJPZ4vn19xRWnX
	sdSEU2J4ADmujo/kSmlHCK+cPcv/wIsvuNSy3tMPAZ7NeFohQdMXHEvxJCD97omrtAvmCBAe/Q9C5
	gUtYirVWoNiB4D69CcaMesDhN5uUempsT3CUA9woq0wkbm1bKg7Iw5CyrWRuit+oBhte7iJM/3nmk
	C26USOQhQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb73w-0002Jw-AT; Fri, 06 Nov 2020 19:06:16 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb72K-0001NB-Bb
 for linux-nvme@merlin.infradead.org; Fri, 06 Nov 2020 19:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=MupYDI4l/YovZ7RWUiZbIkKTEoIVA+KjloyNnUiTimo=; b=iiGVfdCIPPX+IkfTbBzmxkNClz
 t982+XiX0rLzTMHY8HFo1Fp5Mtn7rK+diWNO+RHxxMdKcJUTti2/wcEDk1JuKfU/o4+K8dKleodTE
 HTiaGtNCpYoo9vb3GGX4aLbLQQjLGGtNWkpDZpYqEwfuTn9hbBczupYDxFhREBpBASbSx6M7Lze9e
 iKaTzCv7Ayt/qABbDvowSzznAcYB/VzFYgYnipTJO4suLkefkpjbVL2Cs7whyJwZIOchXyT0sQa+l
 gQuWBa19/ZwoPZGFHeWQytUlRCgvx6EJq35hta2jU2txOK4i/ZI7bcgxRU7PROSuEa2OkMTwR08Xi
 9io2po4w==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb72H-00017b-Qy; Fri, 06 Nov 2020 19:04:34 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 23/24] virtio-blk: remove a spurious call to
 revalidate_disk_size
Date: Fri,  6 Nov 2020 20:03:35 +0100
Message-Id: <20201106190337.1973127-24-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201106190337.1973127-1-hch@lst.de>
References: <20201106190337.1973127-1-hch@lst.de>
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

revalidate_disk_size just updates the block device size from the disk
size.  Thus calling it from revalidate_disk_size doesn't actually do
anything.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/virtio_blk.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 3e812b4c32e669..145606dc52db1e 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -598,7 +598,6 @@ static void virtblk_update_cache_mode(struct virtio_device *vdev)
 	struct virtio_blk *vblk = vdev->priv;
 
 	blk_queue_write_cache(vblk->disk->queue, writeback, false);
-	revalidate_disk_size(vblk->disk, true);
 }
 
 static const char *const virtblk_cache_types[] = {
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
