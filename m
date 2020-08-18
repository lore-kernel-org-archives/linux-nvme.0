Return-Path: <SRS0=NqxM=B4=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95DCBC433DF
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:24:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69D652076E
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Aug 2020 16:24:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="0Y37Pm3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69D652076E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=uOGnsB62WqAlZbP2df1oCQO4J3gaZ77KUUl+q8SDkPU=; b=0Y37Pm3qrk6ys2Op/INcnGaAe
	kxIQUwcO8EAk6hv1hpxaaeGh1vFzBhc3hMAQ7ASrXwR4DQZuwodF/5Z0ncz3iE7PIZ5zyvv+bI1AU
	mvfQPfJ7NmXy1R/SOOF9xqH9XeX6oU1Ooh8zgKpu9AH9tbzXMFVQ1cURZClw4DkB+ziMys25iHo/Q
	mT/z4Fb0dvYkNjahM2CqdE6WUSZIAKYi+4DqJUMziJ4fjDy8qaYO5fqxh8ZD4aqzRcyrK5iRAMDnF
	Zz+WHSJMbXEPZXn3IHLOZolPVCpkt1dU/+9ZK0tkzouvCfL/SuYhD11M4J8UmatJpxNIAt+vcStNB
	9VlIzdwUA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k84PC-0004Xb-7b; Tue, 18 Aug 2020 16:24:10 +0000
Received: from verein.lst.de ([213.95.11.211])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k84P9-0004Wv-DY
 for linux-nvme@lists.infradead.org; Tue, 18 Aug 2020 16:24:08 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id D0D1368AFE; Tue, 18 Aug 2020 18:24:04 +0200 (CEST)
Date: Tue, 18 Aug 2020 18:24:04 +0200
From: Christoph Hellwig <hch@lst.de>
To: Coly Li <colyli@suse.de>
Subject: Re: [PATCH v7 1/6] net: introduce helper sendpage_ok() in
 include/linux/net.h
Message-ID: <20200818162404.GA27196@lst.de>
References: <20200818131227.37020-1-colyli@suse.de>
 <20200818131227.37020-2-colyli@suse.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20200818131227.37020-2-colyli@suse.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200818_122407_601560_1B650670 
X-CRM114-Status: GOOD (  13.81  )
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
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, linux-scsi@vger.kernel.org,
 netdev@vger.kernel.org, Philipp Reisner <philipp.reisner@linbit.com>,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
 Mikhail Skorzhinskii <mskorzhinskiy@solarflare.com>,
 linux-block@vger.kernel.org, Hannes Reinecke <hare@suse.de>,
 Jan Kara <jack@suse.com>, stable@vger.kernel.org, ceph-devel@vger.kernel.org,
 open-iscsi@googlegroups.com, Christoph Hellwig <hch@lst.de>,
 Sagi Grimberg <sagi@grimberg.me>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

I think we should go for something simple like this instead:

---
From 4867e158ee86ebd801b4c267e8f8a4a762a71343 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Tue, 18 Aug 2020 18:19:23 +0200
Subject: net: bypass ->sendpage for slab pages

Sending Slab or tail pages into ->sendpage will cause really strange
delayed oops.  Prevent it right in the networking code instead of
requiring drivers to work around the fact.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 net/socket.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/net/socket.c b/net/socket.c
index dbbe8ea7d395da..fbc82eb96d18ce 100644
--- a/net/socket.c
+++ b/net/socket.c
@@ -3638,7 +3638,12 @@ EXPORT_SYMBOL(kernel_getpeername);
 int kernel_sendpage(struct socket *sock, struct page *page, int offset,
 		    size_t size, int flags)
 {
-	if (sock->ops->sendpage)
+	/*
+	 * sendpage does manipulates the refcount of the passed in page, which
+	 * does not work for Slab pages, or for tails of non-__GFP_COMP
+	 * high order pages.
+	 */
+	if (sock->ops->sendpage && !PageSlab(page) && page_count(page) > 0)
 		return sock->ops->sendpage(sock, page, offset, size, flags);
 
 	return sock_no_sendpage(sock, page, offset, size, flags);
-- 
2.28.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
