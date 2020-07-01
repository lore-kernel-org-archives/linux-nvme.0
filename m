Return-Path: <SRS0=8PNV=AM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15317C433E1
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 09:01:16 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB2B520775
	for <linux-nvme@archiver.kernel.org>; Wed,  1 Jul 2020 09:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="GcafxIjt";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Z/F5JgSB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB2B520775
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=5ArxX6fpZRbq/rpS20LFmkbwYLzJHUezT1BVW6+ilK0=; b=GcafxIjtDh9N03zCdGEyscICq
	O6k3QltYu6TAsiZ7JJ0+VJWp8pc3uka8IwTxJ5EP3EVRXybC2mrJhDnNVYlhqoZBkJkgW83LumpDo
	PCihoXFPc7fopfi0ud6cETugdbI9ge9I+Amlw6AAmSsGkZHzSxdrcvaFAxoXjn4Nnu0da0enPYsgX
	DB5c1BP/MsIt8kBQnf3oDvr+QM5bKRjNp+L2/Wsl4T3Zna594WC+Mx2CXGzciJV1J0av2NOGaqJru
	YG4HgprrKJvgqkHcr798icTn2iFJEaCCm7cFFgbuibV1991rwRSOi3p8ERYikBao71ln4/Q6/x2WQ
	6ycwQMUDg==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jqYcB-0005cG-Ux; Wed, 01 Jul 2020 09:01:12 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqYbC-000514-5U
 for linux-nvme@merlin.infradead.org; Wed, 01 Jul 2020 09:00:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=tMUnz3Lcybn8dQofQ1ryTzIcUAQ8+R8Yiszv/2NG4rI=; b=Z/F5JgSBdsAyHAjWTFzaMp6g/q
 oUzASIPvrJSJhS8H/JfA1QH8G6IT7wmV5wLn36QX/aHDo/hsxYVlgCl6qoTtD6nZ6IvOBUe/JnXQt
 goBpJk9KmMg/PLs2u8o5kRTqrjTKbPsqjWXOy6JnNqrkKOfwRlEIIUz20TquRejre+i/DVwTPiltW
 jHYesHi+fT0Dd0T/0ANjA7isBclM9yDdn8EbcZjL2aV1xUSGZFyB4MPPtssG0ekb0Vesqf9t2hN5D
 7E5atGWNGy/7VUYWuHLULEFzZmWMZQO1JDyBMSdbTihaE6Swz+QOzO9Y+CnVIeWgK7UHJ4QLdU4Me
 +zEre2Dw==;
Received: from [2001:4bb8:184:76e3:ea38:596b:3e9e:422a] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jqYbA-0008Ea-Rh; Wed, 01 Jul 2020 09:00:09 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/20] block: tidy up a warning in bio_check_ro
Date: Wed,  1 Jul 2020 10:59:40 +0200
Message-Id: <20200701085947.3354405-14-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200701085947.3354405-1-hch@lst.de>
References: <20200701085947.3354405-1-hch@lst.de>
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
Cc: linux-bcache@vger.kernel.org, linux-xtensa@linux-xtensa.org,
 linux-nvdimm@lists.01.org, linux-s390@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-raid@vger.kernel.org, linux-m68k@lists.linux-m68k.org,
 linuxppc-dev@lists.ozlabs.org, drbd-dev@lists.linbit.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The "generic_make_request: " prefix has no value, and will soon become
stale.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-core.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 76cfd5709f66cd..95dca74534ff73 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -869,8 +869,7 @@ static inline bool bio_check_ro(struct bio *bio, struct hd_struct *part)
 			return false;
 
 		WARN_ONCE(1,
-		       "generic_make_request: Trying to write "
-			"to read-only block-device %s (partno %d)\n",
+		       "Trying to write to read-only block-device %s (partno %d)\n",
 			bio_devname(bio, b), part->partno);
 		/* Older lvm-tools actually trigger this */
 		return false;
-- 
2.26.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
