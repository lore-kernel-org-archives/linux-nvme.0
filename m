Return-Path: <SRS0=oNOl=GM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2219DC433E6
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 10:47:59 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B379B23A23
	for <linux-nvme@archiver.kernel.org>; Sat,  9 Jan 2021 10:47:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B379B23A23
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ILij5bXBw31+6LyylUY6VR6HWmFHmkZf2rNM+1YNnqo=; b=sZjFVTmvloozn6KgmVmSn3CBl
	AXXGicbZJdKBcgC/r1Xw2Wz+wSh8YkG2txa7q7eNtG9Bmia1/xOuge4Bu7k+Etxi7gU6MB7I9Ktbx
	w3clfPTfC4CExc4/s6T3+PsyV/4YEGcNBI13RGlxRipCfq/KWzcVhy4ijUdReooc1RrBggkRW/oLo
	y4lKr6eMDkJZ4SloBnqChET8o21o9V8aIDDZPScrr2t8JckH9hXVc08iwjPhQgulUFmCuov5xCrtn
	kyf17kDqMDWdmXrwd+B45K2YY0HeCQGPE2XRnw66uqbVfh5zlDsoVOYOOix+0GpPUpTo2qKLjhW9o
	tRe7c69+A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kyBma-0004OP-G1; Sat, 09 Jan 2021 10:47:44 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kyBmY-0004NS-Kp
 for linux-nvme@merlin.infradead.org; Sat, 09 Jan 2021 10:47:42 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=wxTexlKWoneBV6anguGO7lPwaZLGPxnUSoduv84HejQ=; b=jU1mJj9yQJ3yuBh2nxDhfbiwPk
 PWLPKvlKs2ww9DnqLspxRCC7AMxns9SMfy+KADVB3Kb6FDHVWlgrXmSz7S0B/iZjIeUtG1JF2uV46
 r6OdelNAwOSO+Y4Omkc3WEcO+sTI7RegH/UDzzD/YCl6AD4GWhtCDkG8P51ex0fm6wN8aFZpwJ4A7
 o4cHKWHao7BpRjm4tgSPvB3cpqukaj20y/hM8n4xvqHNZUR3x5vw0W3Uw2lHbIRj1U+VZMsfq501h
 T3w+1Qu4oxARPjiEvJmJGE1D40YEjVxRfDOsSq2d5jGte3qFmDIwNxLi4GRoLSvnFb7XJgYcwa48x
 u8ibnoxg==;
Received: from [2001:4bb8:19b:e528:4197:a20:99de:e7b0] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1kyBlg-000TGF-Cc; Sat, 09 Jan 2021 10:47:20 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] rbd: remove the ->set_read_only method
Date: Sat,  9 Jan 2021 11:42:53 +0100
Message-Id: <20210109104254.1077093-6-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20210109104254.1077093-1-hch@lst.de>
References: <20210109104254.1077093-1-hch@lst.de>
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org,
 Hannes Reinecke <hare@suse.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Now that the hardware read-only state can't be changed by the BLKROSET
ioctl, the code in this method is not required anymore.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Acked-by: Ilya Dryomov <idryomov@gmail.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 drivers/block/rbd.c | 19 -------------------
 1 file changed, 19 deletions(-)

diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
index 59cfe71d0b3a39..bbb88eb009e0ba 100644
--- a/drivers/block/rbd.c
+++ b/drivers/block/rbd.c
@@ -692,29 +692,10 @@ static void rbd_release(struct gendisk *disk, fmode_t mode)
 	put_device(&rbd_dev->dev);
 }
 
-static int rbd_set_read_only(struct block_device *bdev, bool ro)
-{
-	struct rbd_device *rbd_dev = bdev->bd_disk->private_data;
-
-	/*
-	 * Both images mapped read-only and snapshots can't be marked
-	 * read-write.
-	 */
-	if (!ro) {
-		if (rbd_is_ro(rbd_dev))
-			return -EROFS;
-
-		rbd_assert(!rbd_is_snap(rbd_dev));
-	}
-
-	return 0;
-}
-
 static const struct block_device_operations rbd_bd_ops = {
 	.owner			= THIS_MODULE,
 	.open			= rbd_open,
 	.release		= rbd_release,
-	.set_read_only		= rbd_set_read_only,
 };
 
 /*
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
