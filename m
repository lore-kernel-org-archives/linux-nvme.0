Return-Path: <SRS0=7aSL=EM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA9AEC55ABD
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:06:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 64E3720882
	for <linux-nvme@archiver.kernel.org>; Fri,  6 Nov 2020 19:06:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="FoEXcwfI";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="KdFsWVDD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 64E3720882
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=N1vCIePtdcrfRx4S1XY2iOvLGYUc8BWq54s0M8if++A=; b=FoEXcwfIA+RmmwicW1NLnrMCm
	IZeS7XrvNTO3ns0lOrd0P80K/4IcBI9yV2WJsTO13shoi3/t4L1TI7OuqYXKGc04iw98rB4HJVGGb
	32hz9jiOIXAqOuvHSS3kje3fXA2Hqt44MNl3NN7ZtNp+b7rVn2MMVALC1BIfhOyByUlilxHPI//e1
	vGpBPLUGN8zW/wiEI98ArJsllEK839m4TWPY41GEtKP5aHp7A8jWi/jsX7p2bAqdF3E0X2SDk54Ry
	bLUK9woPt5mxvBhQ3Ed3nUkLqM1VHEIHOpOCOe01+IcNCNlA1Ay8jO3t3saUVfhIXZykhRaW5CEsN
	u0qwcxm1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kb73o-0002Fb-Ly; Fri, 06 Nov 2020 19:06:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb72I-0001Lv-5E
 for linux-nvme@merlin.infradead.org; Fri, 06 Nov 2020 19:04:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=X/fdtbnM6VzLEnbiAcIZtVB4MyztRye1iMhB9bpmGjw=; b=KdFsWVDDKhCb1S0+D0SokRPV+y
 +J4M6xcEJslqQfLhh8x6+66DaWFnczf1aBndVMP3EIIA+96ALRDycvFUpIzf2js2xvrsL5iP6O1+A
 ZKLK8qzUck32sEA469YdsEhBj5KXKjBMfIrXwNzMerCpymh6yL7J+3OCKmpXeH15Tn7bxLuzBCRLz
 hl7TxbtqOEdufrClF29OKAO2fi/5ZmeFIHiUXsY/1CVk/DF7ZGpB+29s9GAZmn5HLwCP/ya6jSA1Q
 muKeYFGA3/E5oI4KqySpaJNW0DC9LvJqAjqN3XUqHjqzBVWPtrxSloZh0rikWjmPlEjklxeW4xqF+
 LXF3M7pQ==;
Received: from [2001:4bb8:184:9a8d:9e34:f7f4:e59e:ad6f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kb72G-00016V-3y; Fri, 06 Nov 2020 19:04:32 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 22/24] md: remove a spurious call to revalidate_disk_size in
 update_size
Date: Fri,  6 Nov 2020 20:03:34 +0100
Message-Id: <20201106190337.1973127-23-hch@lst.de>
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

None of the ->resize methods updates the disk size, so calling
revalidate_disk_size here won't do anything.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/md/md-cluster.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/md-cluster.c b/drivers/md/md-cluster.c
index 87442dc59f6ca3..35e2690c1803dd 100644
--- a/drivers/md/md-cluster.c
+++ b/drivers/md/md-cluster.c
@@ -1299,8 +1299,6 @@ static void update_size(struct mddev *mddev, sector_t old_dev_sectors)
 	} else {
 		/* revert to previous sectors */
 		ret = mddev->pers->resize(mddev, old_dev_sectors);
-		if (!ret)
-			revalidate_disk_size(mddev->gendisk, true);
 		ret = __sendmsg(cinfo, &cmsg);
 		if (ret)
 			pr_err("%s:%d: failed to send METADATA_UPDATED msg\n",
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
