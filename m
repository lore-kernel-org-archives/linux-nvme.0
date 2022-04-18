Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5FC4C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Apr 2022 04:54:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=rEun4CykQNh9XCzIn07hcf266lJSo8SoQFV5h3aZDN4=; b=aN37fVUYHWgQM0Wg3Lxl8kl+GU
	q5KoXeB8hyQ+Wq0ppBDkbPN08egP39i3TaGgXI4eFwxDd4xk1ezFTeoIVUZdaiU17UIzp6xlBcPjb
	sBDxBUkFYqWS6yw6JY8Tr52IpZ0aWL8FosB4lN+FrsuwhpkU5grWRq21tqOCFyI3WIpHYiH7/WFzT
	nFmmaNM386AkOvSjOOoWASLB0Dm40OqT5UCiMGlCNp6FqQ/w/xpx9O53l5T4K/Aj67v3B6nYyO5TD
	bDC/WRZC4JU2Z7szpEN7+Ok4/HnCFdIo9bL/t30KRV2/ikn8l3jrIjUYRzci2hJpoESsARO9DBQDY
	eP8EjK4A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1ngJOq-00FZHB-7n; Mon, 18 Apr 2022 04:54:08 +0000
Received: from [2a02:1205:504b:4280:f5dd:42a4:896c:d877] (helo=localhost)
 by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
 id 1ngJOK-00FYlu-W5; Mon, 18 Apr 2022 04:53:37 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Richard Weinberger <richard@nod.at>,
 Johannes Berg <johannes@sipsolutions.net>,
 Josef Bacik <josef@toxicpanda.com>,
 "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
 Jack Wang <jinpu.wang@ionos.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>,
 =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
 Mike Snitzer <snitzer@kernel.org>, Song Liu <song@kernel.org>,
 Stefan Haberland <sth@linux.ibm.com>,
 Jan Hoeppner <hoeppner@linux.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 linux-um@lists.infradead.org, linux-block@vger.kernel.org,
 nbd@other.debian.org, virtualization@lists.linux-foundation.org,
 xen-devel@lists.xenproject.org, linux-raid@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-s390@vger.kernel.org,
 dm-devel@redhat.com
Subject: [PATCH 07/11] dasd: don't set the discard_alignment queue limit
Date: Mon, 18 Apr 2022 06:53:10 +0200
Message-Id: <20220418045314.360785-8-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220418045314.360785-1-hch@lst.de>
References: <20220418045314.360785-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The discard_alignment queue limit is named a bit misleading means the
offset into the block device at which the discard granularity starts.
Setting it to PAGE_SIZE while the discard granularity is the block size
that is smaller or the same as PAGE_SIZE as done by dasd is mostly
harmless but also useless.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/s390/block/dasd_fba.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/s390/block/dasd_fba.c b/drivers/s390/block/dasd_fba.c
index 8bd5665db9198..60be7f7bf2d16 100644
--- a/drivers/s390/block/dasd_fba.c
+++ b/drivers/s390/block/dasd_fba.c
@@ -782,7 +782,6 @@ static void dasd_fba_setup_blk_queue(struct dasd_block *block)
 	blk_queue_segment_boundary(q, PAGE_SIZE - 1);
 
 	q->limits.discard_granularity = logical_block_size;
-	q->limits.discard_alignment = PAGE_SIZE;
 
 	/* Calculate max_discard_sectors and make it PAGE aligned */
 	max_bytes = USHRT_MAX * logical_block_size;
-- 
2.30.2


