Return-Path: <SRS0=JqC7=GH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBFC9C433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:02 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 620172087E
	for <linux-nvme@archiver.kernel.org>; Mon,  4 Jan 2021 05:10:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 620172087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=ubSVP1qQiJZtXQl1lbc5FZ8CQmkfGSQphXx2o25xagM=; b=wLHEnnnCb0P9/ECLNmxelCWJo
	zDvQG0nisIPkaLk6hO6l+sKzfhK1nmCmvJlup2HUuI248FiUcQqkof8GBkoPCSDL36SbtLyu+scdt
	nuzmeUfCKffB8WQ4EcpOtUy1t3wGLRScC+BYhDhpC6uTqFBJgWVENWvH8kYi4vtHOApsp76sBofVA
	u023/TMVYRjfe8Zj/F3C2HfOcAtN2Mdi2scECOu+9Zu8ngSoOUHsBtJpxinX+hRMU6JzAmoFM95W8
	GvkErH3E6y3jkgUMgHjZnGc3tOAnGoQUf8+XuoNFumn1tRci2EOMuk2GCaov7N9OmJOcgs8/6EfiS
	Dif3TFZUw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kwI7w-0002rQ-2D; Mon, 04 Jan 2021 05:09:56 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kwI7t-0002qA-5C
 for linux-nvme@lists.infradead.org; Mon, 04 Jan 2021 05:09:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1609736993; x=1641272993;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=88Lp0y2hIyhYG8It0MWl/SOspuKedN/u1kjgeCCanzg=;
 b=KQAB1DRSAdDArEST0nWGyWdcCa/zRYE5G/vJzLlJA8f2qn1I3Of4ePLY
 WBSp1DehnJ51FyoV7ozdALcJCwfHBoaqWmypTQKlUSkAm+Xfyx/iTC0Wh
 8q+FNq/YNrqjPRcL7atRD29aQo935UWXd2Epac7Evf18k8rzz4XISCTAH
 QK0Go+iJ6tEnebCSm+L+T/0YTZI+NFpMhotoePMs7ngZBVm489SBn67LW
 UkB1dKVeBAfvEyqUCIqbbK+Rqwr1HVWOc4jfkkHYE/YQzMSPw3H1utswx
 WMBwtXq4UK2sycgAIIBOYTg9TsMcZJgspitKe8kXrwJEiffraKC7w1qeP A==;
IronPort-SDR: O7eYvn3rV2cPsot8cKGsGvI9pgrY1+8VqubFBZ/pc5MZKgvrCwB2DwYfWHrTWl8yQID400VcOP
 nEv3+B0lRBHyUCci4cVQXh6T/c/GJuNsh+nVOa5dKDr7VAYHWF12uYlrANlxRcC/O1pEhYZAHG
 Ga6CrJmc80c/CnVevv0iusmTikoSheWoSEaW/uVJePHqSpe40mbssqjRhTrkXQv/U50F8WxrZl
 LTmCxZUks+XQg2Th+NjKLA+1OHNWRRfHaeQ1TDt7uRIVacMKGozF8W/RiKsi+G3IJIkBuVUTGc
 kFs=
X-IronPort-AV: E=Sophos;i="5.78,473,1599494400"; d="scan'208";a="266697163"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 04 Jan 2021 13:09:52 +0800
IronPort-SDR: YBodKa2mY/Rlqe4Iyc5g7ZqPbzmhGLIfJoNd86Px9q/b3RX5zoSG+gsyBfp5FhaCO7gNQ7w0Ey
 jrlnvVv1wd4gXLbB963TqVzVX9gOmV00uNl7VOZNHrxos0I6eA749FPA6aSe49kLAbEqvyj1Vr
 zV2G4d3eTgvC/s4ZuSCM3A628VUIPqlOj/oIam1XZw8YQbu//GsRaQhDRFMZZQPk/7icnqBi07
 8jVGOXwzYd1fzSLX20SuuYxZ25C5wUbnnH/rXN945Oq9BBQ/9CNPuFets7+3L6YmvN0/duFmef
 Lt2tYvZ+y5PWbqlKefaKg2/S
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 03 Jan 2021 20:54:47 -0800
IronPort-SDR: fzEsAR7GYUtito1PhagHHkKiB8f4IrvsSRix+tpndqJVfwn0LzWXRYiPfDFk162RLK974u/XNZ
 bMEjnDox/ZuUALq/HCVdBpTub18py+KFCPJNqn81fcgTqmXBLWCiNhnsq+x/FNE/ulfySrIJX8
 i00IrLuXbbI1Exm6jwWwXiwSTvY0W+MbwK6v5aKEsv932E2c2MhqG/aLiEDfoEuikgoyjjzU82
 ZI5yuXDKNwTn4BelWKvjh+GXwEokRCp6fPTVBuQoSu4j7uGYyjvLxgLXmG6LsVWEHlm1O6d6KJ
 txk=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip02.wdc.com with ESMTP; 03 Jan 2021 21:09:53 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-nvme@lists.infradead.org
Subject: [PATCH V8 1/9] block: export bio_add_hw_pages()
Date: Sun,  3 Jan 2021 21:09:30 -0800
Message-Id: <20210104050938.25745-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
References: <20210104050938.25745-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210104_000953_383402_6115B055 
X-CRM114-Status: GOOD (  13.91  )
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
Cc: hch@lst.de, Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To implement the NVMe Zone Append command on the NVMeOF target side for
generic Zoned Block Devices with NVMe Zoned Namespaces interface, we
need to build the bios with hardware limitations, i.e. we use
bio_add_hw_page() with queue_max_zone_append_sectors() instead of
bio_add_page().

Without this API being exported NVMeOF target will require to use
bio_add_hw_page() caller bio_iov_iter_get_pages(). That results in
extra work which is inefficient.

Export the API so that NVMeOF ZBD over ZNS backend can use it to build
Zone Append bios.

Signed-off-by: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
---
 block/bio.c            | 1 +
 block/blk.h            | 4 ----
 include/linux/blkdev.h | 4 ++++
 3 files changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 1f2cc1fbe283..5cbd56b54f98 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -826,6 +826,7 @@ int bio_add_hw_page(struct request_queue *q, struct bio *bio,
 	bio->bi_iter.bi_size += len;
 	return len;
 }
+EXPORT_SYMBOL(bio_add_hw_page);
 
 /**
  * bio_add_pc_page	- attempt to add page to passthrough bio
diff --git a/block/blk.h b/block/blk.h
index 7550364c326c..200030b2d74f 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -351,8 +351,4 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 		sector_t start, sector_t length);
 int disk_expand_part_tbl(struct gendisk *disk, int target);
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 070de09425ad..028ccc9bdf8d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2005,6 +2005,10 @@ struct block_device *I_BDEV(struct inode *inode);
 struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
 
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page);
+
 #ifdef CONFIG_BLOCK
 void invalidate_bdev(struct block_device *bdev);
 int truncate_bdev_range(struct block_device *bdev, fmode_t mode, loff_t lstart,
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
