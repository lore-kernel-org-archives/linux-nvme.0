Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4162FC433EF
	for <linux-nvme@archiver.kernel.org>; Wed,  9 Mar 2022 06:03:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=yWR1kUumBdS0c+8pN7b3R0vEfRPDETm6rA/UxErbXbg=; b=cUuWxnky0PjFMjlx7kKOUqTbI2
	8UTqtkXiv6j5pLZqnASwnflHJUdndAQsexfhJ7CnG+2AyY2hcdb9FJcgM/gTVhzG9fE7WUqsQ5QoZ
	k4vvIJbCblkN9exehSiIAJV/KQye2Jfg9nUnZAGK2mxku38Ovxjd6uwYLJ0ssy6O2/pKqlcJbVoWI
	wtoCgaf8KNtn4tpEiss1po2pDeRaks9Dv7hMxJ2hc0Pz8IkHVWcH/A89PTC54+z1jqBpqQFGZjZJ1
	FiGo3zKIMtKrmQlq80I1dDgTu6YU06W800PZDMoilFfl58OXfdqGO6+GIEQSg1Q8Y/IGb6OwnnOnR
	/pBekFtw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nRpPS-007PvP-RP; Wed, 09 Mar 2022 06:02:54 +0000
Received: from out1.migadu.com ([2001:41d0:2:863f::])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nRpPG-007Pr8-QZ
 for linux-nvme@lists.infradead.org; Wed, 09 Mar 2022 06:02:44 +0000
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and
 include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
 t=1646805757;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding;
 bh=yWR1kUumBdS0c+8pN7b3R0vEfRPDETm6rA/UxErbXbg=;
 b=uDURJcht+rnVBNz+StFivReGyp+ScB0q6FuJZ1MFvKS5z3Jhkabre16RRLqxfO+e256OBL
 uyNP2ebveRVb2S56pmOnUW7uqaz1bZO6AYOWuJM5xGdG1X5aHeQ1kNnK1tPwlGKDgyY44C
 qYDk/5G3e/cWMMZz0kTengjYfaat4EA=
From: Guoqing Jiang <guoqing.jiang@linux.dev>
To: kbusch@kernel.org,
	axboe@fb.com,
	hch@lst.de,
	sagi@grimberg.me
Cc: linux-nvme@lists.infradead.org
Subject: [PATCH] nvme-multipath: call bio_io_error in nvme_ns_head_submit_bio
Date: Wed,  9 Mar 2022 14:02:28 +0800
Message-Id: <20220309060228.18846-1-guoqing.jiang@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Migadu-Auth-User: linux.dev
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220308_220243_269068_056A995F 
X-CRM114-Status: UNSURE (   7.60  )
X-CRM114-Notice: Please train this message.
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

Use bio_io_error() here since bio_io_error does the same thing.

Signed-off-by: Guoqing Jiang <guoqing.jiang@linux.dev>
---
 drivers/nvme/host/multipath.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/nvme/host/multipath.c b/drivers/nvme/host/multipath.c
index f8bf6606eb2f..31c756fffcec 100644
--- a/drivers/nvme/host/multipath.c
+++ b/drivers/nvme/host/multipath.c
@@ -386,8 +386,7 @@ static void nvme_ns_head_submit_bio(struct bio *bio)
 	} else {
 		dev_warn_ratelimited(dev, "no available path - failing I/O\n");
 
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
+		bio_io_error(bio);
 	}
 
 	srcu_read_unlock(&head->srcu, srcu_idx);
-- 
2.31.1


