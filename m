Return-Path: <SRS0=rzv5=EW=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 352E4C61DD8
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:12:22 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C1E46216C4
	for <linux-nvme@archiver.kernel.org>; Mon, 16 Nov 2020 15:12:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Ljy/Q3lF";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="pWF6GiYZ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C1E46216C4
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=tBPgpxoYD5LHHWfqZDTwmps/q4TEBJXC+ARgViKV5Cc=; b=Ljy/Q3lF/eEgpZoq4PvTrGGSX
	iAgpn3bNhn3CFWIzbh5yhmyjlNEUtGsC+oSUW0apeahMlgO4iTsMr8Kc2//HrYRzeeM5ZMnpNXllF
	rGDraFR+2ETqD3+iqMy9CZDffvgErScf+XM2FthvG5lVBE2/eHVjn6IChIyjZCgRVPFb1V/yNu8+Y
	a3ezyH4afMSMJQaDuZlXRr9FoIMx+Y23N+f9nYTyID6dGpbfQQQeS6ZFAGLHPdnx7bAjlp7OZSGm3
	k3fZvsAxXk1g9ScmdeAKnqSiWoLWQsgMSdGcNaokuQR3NG+yHlIK5ENM87iKzmBNTecxDzyzD0rR8
	M3ZTqJ0dA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kegB1-0002u1-9l; Mon, 16 Nov 2020 15:12:19 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyn-00040t-L5
 for linux-nvme@merlin.infradead.org; Mon, 16 Nov 2020 14:59:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=2AKcef4DY6iJcprvQynjGgbCIgh8d3+qztu8J6nwbBU=; b=pWF6GiYZwuWwwwCepRCy7HJGry
 ebNMkKhyrUdm7IJyWpCzL1mHXVX2uHrDvMEZnLp7EDprwz/Ixpo6UyIkP9C/eBgJtKePlQ9iOFGEX
 anVcipPAM3jKhn7+W0pAqmOpSUkPyf5/WcShPIbr+Kvrkdy7ShEiMu40JORvE9Eu7vJW7k1YP9SBn
 x4dzOxFL2eT+4GeR6EmljUox59XCLVLuOr/c4rirnRVpl1nSS3OL1hT4yGJ4ATQQt0nK9jflQBVkF
 1F1WeS9cKSzs/UYR7bWm7TOPnDssO/WwxWuvt6FJ3Za4yj5tMQ3BhtLdQ4aklV0fV0Tw57B/U2ugq
 BAULThIQ==;
Received: from [2001:4bb8:180:6600:255b:7def:a93:4a09] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kefyl-0004C5-Vu; Mon, 16 Nov 2020 14:59:40 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 62/78] loop: do not call set_blocksize
Date: Mon, 16 Nov 2020 15:57:53 +0100
Message-Id: <20201116145809.410558-63-hch@lst.de>
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

set_blocksize is used by file systems to use their preferred buffer cache
block size.  Block drivers should not set it.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index 9a27d4f1c08aac..b42c728620c9e4 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1164,9 +1164,6 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	size = get_loop_size(lo, file);
 	loop_set_size(lo, size);
 
-	set_blocksize(bdev, S_ISBLK(inode->i_mode) ?
-		      block_size(inode->i_bdev) : PAGE_SIZE);
-
 	lo->lo_state = Lo_bound;
 	if (part_shift)
 		lo->lo_flags |= LO_FLAGS_PARTSCAN;
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
