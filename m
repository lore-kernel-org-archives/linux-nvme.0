Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56CB9C433E1
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 13:13:24 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 25FA220706
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 13:13:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="nLYwXQbh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 25FA220706
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ZpCa3L2fdlL1OHvb4s3jAWkzfEsc5HA7qA4dyr4OsQ8=; b=nLYwXQbhsoUULTNd/NyP8HL5F
	rPLVk2Lxg6fozOnr3T/7LcElNqDnbGTNLxYj5LUJSE8mpf2sioeGUDE9/7EUWP+pzPclz4p1CQ3ut
	PZeX1qVbzAPfX3ZKk/ktrFYeiT25iPXfCnvd3P8NLY1U9+/1+cyZZREX/wusXvv2Mn9CGLdeuII5P
	02Bb8mDUmvQ605i9iZo1cFmV8jLba9aLeySm7sbZY45O3EqgsLfNV5ZxzwSiblMaSD/nkPkgV+Arb
	xM47t+xejzaJZLcYyqPrN5Fgg7YJg6+mDBoEfFHyq1BTP/6BFtVXs1XVbnUJLkrbd/VsRnFI6Ob7J
	I1m0pSOgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k81QX-0005it-9F; Tue, 18 Aug 2020 13:13:21 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k81QV-0005iC-Bi
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 13:13:20 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 2008BB167;
 Tue, 18 Aug 2020 13:13:44 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 netdev@vger.kernel.org, open-iscsi@googlegroups.com,
 linux-scsi@vger.kernel.org, ceph-devel@vger.kernel.org
Subject: [PATCH v7 2/6] nvme-tcp: check page by sendpage_ok() before calling
 kernel_sendpage()
Date: Tue, 18 Aug 2020 21:12:23 +0800
Message-Id: <20200818131227.37020-3-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200818131227.37020-1-colyli@suse.de>
References: <20200818131227.37020-1-colyli@suse.de>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_091319_520124_F54C9E32 
X-CRM114-Status: GOOD (  15.00  )
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
Cc: Jens Axboe <axboe@kernel.dk>, Vlastimil Babka <vbabka@suse.com>,
 Sagi Grimberg <sagi@grimberg.me>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, Coly Li <colyli@suse.de>,
 Hannes Reinecke <hare@suse.de>, Jan Kara <jack@suse.com>,
 Philipp Reisner <philipp.reisner@linbit.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently nvme_tcp_try_send_data() doesn't use kernel_sendpage() to
send slab pages. But for pages allocated by __get_free_pages() without
__GFP_COMP, which also have refcount as 0, they are still sent by
kernel_sendpage() to remote end, this is problematic.

The new introduced helper sendpage_ok() checks both PageSlab tag and
page_count counter, and returns true if the checking page is OK to be
sent by kernel_sendpage().

This patch fixes the page checking issue of nvme_tcp_try_send_data()
with sendpage_ok(). If sendpage_ok() returns true, send this page by
kernel_sendpage(), otherwise use sock_no_sendpage to handle this page.

Signed-off-by: Coly Li <colyli@suse.de>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Jan Kara <jack@suse.com>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>
Cc: Philipp Reisner <philipp.reisner@linbit.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Vlastimil Babka <vbabka@suse.com>
Cc: stable@vger.kernel.org
---
 drivers/nvme/host/tcp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 62fbaecdc960..902fe742762b 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -912,12 +912,11 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 
-		/* can't zcopy slab pages */
-		if (unlikely(PageSlab(page))) {
-			ret = sock_no_sendpage(queue->sock, page, offset, len,
+		if (sendpage_ok(page)) {
+			ret = kernel_sendpage(queue->sock, page, offset, len,
 					flags);
 		} else {
-			ret = kernel_sendpage(queue->sock, page, offset, len,
+			ret = sock_no_sendpage(queue->sock, page, offset, len,
 					flags);
 		}
 		if (ret <= 0)
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
