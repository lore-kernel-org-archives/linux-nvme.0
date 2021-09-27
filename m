Return-Path: <SRS0=w6YM=OR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF5BAC433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:28 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9557060EB6
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Sep 2021 22:02:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9557060EB6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:
	Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=bqAXjkrGAGBBYg/PwxqlTapMhTM3cISkeEUiovQtC6Y=; b=m28vKIeXOTmqby
	vKaLmOe4Quw5PT8qIsDXnxqbHISrzry1nsf1+oG9URvta0NKAuF0aleiZ4gqnsCrgsAzdqFBuTxUF
	t/hf3vNPIcDW1O9loX+toimolozYsAhW5+OnGnaRHXpqgX0JL+/6P/wEg4kcRpXl+gfwYqxGRtl/O
	GdFNOCwjov5pFDe9/RGUjQZu7Sh64gI1ZS9B8gPrYaOJkhgqGOMg2ofgxT+jyJxKmuaDy/WvIPy4p
	B8eVuQYvQ5PtC5SOnZiIkxmMrfV/425ZiO5d84gIjEAZHGF4AUZ1JVnFv5QOsuEt/1gtNXgdcqSOp
	yGn1O3rKtz3EzGjs6aKw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mUyhe-004Un6-7y; Mon, 27 Sep 2021 22:02:26 +0000
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.94.2 #2
 (Red Hat Linux)) id 1mUyfw-004Suu-Fq; Mon, 27 Sep 2021 22:00:40 +0000
From: Luis Chamberlain <mcgrof@kernel.org>
To: axboe@kernel.dk, colyli@suse.de, kent.overstreet@gmail.com,
 kbusch@kernel.org, sagi@grimberg.me, vishal.l.verma@intel.com,
 dan.j.williams@intel.com, dave.jiang@intel.com, ira.weiny@intel.com,
 konrad.wilk@oracle.com, roger.pau@citrix.com, boris.ostrovsky@oracle.com,
 jgross@suse.com, sstabellini@kernel.org, minchan@kernel.org,
 ngupta@vflare.org, senozhatsky@chromium.org
Cc: xen-devel@lists.xenproject.org, nvdimm@lists.linux.dev,
 linux-nvme@lists.infradead.org, linux-bcache@vger.kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
 Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH v2 04/10] nvdimm/btt: do not call del_gendisk() if not needed
Date: Mon, 27 Sep 2021 15:00:33 -0700
Message-Id: <20210927220039.1064193-5-mcgrof@kernel.org>
X-Mailer: git-send-email 2.31.1
In-Reply-To: <20210927220039.1064193-1-mcgrof@kernel.org>
References: <20210927220039.1064193-1-mcgrof@kernel.org>
MIME-Version: 1.0
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We know we don't need del_gendisk() if we haven't added
the disk, so just skip it. This should fix a bug on older
kernels, as del_gendisk() became able to deal with
disks not added only recently, after the patch titled
"block: add flag for add_disk() completion notation".

Signed-off-by: Luis Chamberlain <mcgrof@kernel.org>
---
 drivers/nvdimm/btt.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 52de60b7adee..29cc7325e890 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1538,7 +1538,6 @@ static int btt_blk_init(struct btt *btt)
 		int rc = nd_integrity_init(btt->btt_disk, btt_meta_size(btt));
 
 		if (rc) {
-			del_gendisk(btt->btt_disk);
 			blk_cleanup_disk(btt->btt_disk);
 			return rc;
 		}
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
