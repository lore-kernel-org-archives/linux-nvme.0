Return-Path: <SRS0=f2/u=AV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 509A5C433EB
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 13:26:33 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DA7B207BB
	for <linux-nvme@archiver.kernel.org>; Fri, 10 Jul 2020 13:26:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="X9yTjRGf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DA7B207BB
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=DRH9PhkpUWN+RK5XW4pgYpI3COF4PQbndTL0/pKcCw4=; b=X9yTjRGfRKa3N5bGNd+MhSlzS7
	2ltmZZ+mQVFga4PaPgRd2hq35kkW/ldY/I5NbKHVtlQkaTMQH2Ha25f0p0CrkNETujSDj4TUciKAK
	OiYxsLW4OQZnEnlKCqq55izfbc+OnLfcjVOovXX/HV0t3KPvt/TcryBo5U3vz9pwuWcY/KJGH7TG9
	fHd5Zlp5H1dQWtzrCpnGkI8bXU2olZunO2sBMdXog6wAh3I48N5hD/4u5BnuIAysIGPyLbxDB8n7l
	JXWhd9fYNEo5+i0p8fQrqT+xBuZzGpq4bCJpQteqZCh/TIwTig7WbWcKt3w/kJ2x9Ruhq4W3n6GUn
	WsnlWijQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jtt2p-0004wr-8u; Fri, 10 Jul 2020 13:26:27 +0000
Received: from mx2.suse.de ([195.135.220.15])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jtt2m-0004ul-LP
 for linux-nvme@lists.infradead.org; Fri, 10 Jul 2020 13:26:25 +0000
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 08C05ACBF;
 Fri, 10 Jul 2020 13:26:20 +0000 (UTC)
From: Coly Li <colyli@suse.de>
To: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
 linux-bcache@vger.kernel.org
Subject: [PATCH 1/2] nvme-tpc: don't use sendpage for pages not taking
 reference counter
Date: Fri, 10 Jul 2020 21:26:09 +0800
Message-Id: <20200710132610.11756-1-colyli@suse.de>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200710_092624_825159_F1D4491F 
X-CRM114-Status: GOOD (  17.05  )
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
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>, stable@vger.kernel.org,
 Coly Li <colyli@suse.de>, Hannes Reinecke <hare@suse.de>,
 Jan Kara <jack@suse.com>, Philipp Reisner <philipp.reisner@linbit.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Currently nvme_tcp_try_send_data() doesn't use kernel_sendpage() to
send slab pages. But for pages allocated by __get_free_pages() without
__GFP_COMP, which also have refcount as 0, they are still sent by
kernel_sendpage() to remote end, this is problematic.

When bcache uses a remote NVMe SSD via nvme-over-tcp as its cache
device, writing meta data e.g. cache_set->disk_buckets to remote SSD may
trigger a kernel panic due to the above problem. Bcause the meta data
pages for cache_set->disk_buckets are allocated by __get_free_pages()
without __GFP_COMP.

This problem should be fixed both in upper layer driver (bcache) and
nvme-over-tcp code. This patch fixes the nvme-over-tcp code by checking
whether the page refcount is 0, if yes then don't use kernel_sendpage()
and call sock_no_sendpage() to send the page into network stack.

The code comments in this patch is copied and modified from drbd where
the similar problem already gets solved by Philipp Reisner. This is the
best code comment including my own version. 

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
 drivers/nvme/host/tcp.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 79ef2b8e2b3c..faa71db7522a 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -887,8 +887,17 @@ static int nvme_tcp_try_send_data(struct nvme_tcp_request *req)
 		else
 			flags |= MSG_MORE | MSG_SENDPAGE_NOTLAST;
 
-		/* can't zcopy slab pages */
-		if (unlikely(PageSlab(page))) {
+		/*
+		 * e.g. XFS meta- & log-data is in slab pages, or bcache meta
+		 * data pages, or other high order pages allocated by
+		 * __get_free_pages() without __GFP_COMP, which have a page_count
+		 * of 0 and/or have PageSlab() set. We cannot use send_page for
+		 * those, as that does get_page(); put_page(); and would cause
+		 * either a VM_BUG directly, or __page_cache_release a page that
+		 * would actually still be referenced by someone, leading to some
+		 * obscure delayed Oops somewhere else.
+		 */
+		if (unlikely(PageSlab(page) || page_count(page) < 1)) {
 			ret = sock_no_sendpage(queue->sock, page, offset, len,
 					flags);
 		} else {
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
