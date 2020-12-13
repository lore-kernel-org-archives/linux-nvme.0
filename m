Return-Path: <SRS0=ZzGD=FR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F38C433FE
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:27 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2992422D71
	for <linux-nvme@archiver.kernel.org>; Sun, 13 Dec 2020 05:51:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2992422D71
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=Jl+bTgRo1xoCYkvsweTcij+H4DvPPLfQkAi9X8JbEoI=; b=WiNQ+Zy2mceNVrH5I6w2sLKlg
	JR9B7MnFwWxzXMe1lfEbshR7zinvUAHE99L3hz81wrp678SVCjcxBK1JULDjG3V6Tsgm0/yWIj+qA
	wy9cwlqa5DiNp3Ny9e7vn1wMIJFPUzlzG9tX0xMyZweU7SHn76o8xXc94RJpjjp1M8R429IVl2zo8
	Z7KikV/GAvyDCbSK6FzV4YlBfxwqDIiFDcylCM7Mrcd6+ax2LUVQBCkL6KbAqXkYe1lzA10+dGxSc
	G+SUh5t+WpAajfiVlRl6LrlpCmZW79zsodpgvyXSxFr0ecnbB6QcdA1QFEX8kDZFjhcLV9W+wP7xY
	4BBBiIP7g==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1koKHy-0005nQ-Gf; Sun, 13 Dec 2020 05:51:22 +0000
Received: from esa2.hgst.iphmx.com ([68.232.143.124])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1koKH7-0005hX-S0
 for linux-nvme@lists.infradead.org; Sun, 13 Dec 2020 05:50:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1607839400; x=1639375400;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=UfKvG3DF5+e1xbSx0w/6Rpv8SlZKd4h4pbL+RDgW3Js=;
 b=nMWJHoj8Bth+9FQz5Clojg1DpvUhawEFy/0WM9j/p7jFxtt8rvbYMAsI
 9V0WvLjBUGUa6WmdqDDoZwwJZap1txSgzRoFmCDVkzMR/eYbEBkrL04CN
 BQc2x5slvHUMZ7ry4uBEZCrmW6BsgqDK9vweI1vzk+8o/LcYUDRMO2UMn
 YSfg0raM1pMjXXZjDdb9plauJpnIBFhIMA3BZerjrPAEhmFOysznGSEw3
 POQA8jQw7CLi5jKwAx08nlpv3PcMBTwJoOql7lCTv+CSajSQvQJlTCS7v
 hpaSnI1XpK0qhQ0yN1ZoqfqcvNgVFRNMWctSk/tfCQIxtxW1nOX+LzIU6 g==;
IronPort-SDR: oaqPcyU1/gqb73oMceQ1gJ8Ze6FqcWJBnOvykBen50PkMET4rKswir/etefyN14Aq47IOuKjHZ
 iyv652EVlLcvAES6lR47JGHwKKjnWwO2KEaFgIJ0Ha96bWbVpMnQzrwrkpzjaUrN6qVFAyoeUb
 ubqxR3mC4WG4DTipECrGb1Ax6j0DMCaHquUS6YdtHEvjkFLJxZah2QArimM9ceMgX7v0p1+AQV
 2OGhBkte6KLjpwMB4JN9CcFVus5EhtBMB7Kw3doPBfZSWGKNHW9qTiNa0fJre97J8ZlRMifCIV
 REY=
X-IronPort-AV: E=Sophos;i="5.78,415,1599494400"; d="scan'208";a="258770346"
Received: from h199-255-45-14.hgst.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 13 Dec 2020 14:03:18 +0800
IronPort-SDR: 7TQKwUgl9G8PI0rvw+aS4dE72mIA1nwMYBpN48QKdtFruud2IKJYjhM2LSpxAAjPGdKFBoR0Vg
 fPTbqXAKUFXyfKVkzwfhFfwSKZfAkzKXJoW6nQ0U7iav0DZo4Szt7bq4TrMSR2f6VNFfA6E+pk
 SfntU0+wu7KtycpEIE4C5op0a+CbN83cfIBAnC1RGJ8UH/hZ791gBYMUWx2OIVIJhiu31He+qr
 X2V1CxbiKGxcnFu/WK5xGfAAbwVXBwpeMUPdSdyqbM9u52ZlxCAE47HZxstV8+ctQUPJutiUvZ
 edRHdcYcog+O3GkAbMVu099R
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 12 Dec 2020 21:35:50 -0800
IronPort-SDR: ohj9NsNmuMQLzfYUIUh2nT/CRG9S+5u6OxzAE7/lgGoo5dGPUv5E5WxW8Y2+UbMKSt4nByGjX3
 VXpgVSNqq08wYox7b+su32+oCh8F1ngqXdsjnm4+YjDwzn7pNBfEucn2i97vqkOQAxMdAHx4rg
 jxPrA8zT8sz1ZT4nGUcEUC24R+wAB1wNNXWuTVddzOX1aQR9iqAkETwcTVNfe23cCzsReUw2Bw
 2QfhY2AbubFs0HssdNbtLiEx8lYyovYByqA2O17gBd3QiTSo1ANDzmFOwtYF+xJa7SQE59BAwb
 36g=
WDCIronportException: Internal
Received: from vm.labspan.wdc.com (HELO vm.sc.wdc.com) ([10.6.137.102])
 by uls-op-cesaip01.wdc.com with ESMTP; 12 Dec 2020 21:50:28 -0800
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Subject: [PATCH V6 1/6] block: export bio_add_hw_pages()
Date: Sat, 12 Dec 2020 21:50:12 -0800
Message-Id: <20201213055017.7141-2-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.1
In-Reply-To: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
References: <20201213055017.7141-1-chaitanya.kulkarni@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20201213_005030_221405_B1E8DF3D 
X-CRM114-Status: GOOD (  14.13  )
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
Cc: damien.lemoal@wdc.com, sagi@grimberg.me,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>, hch@lst.de
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
index fa01bef35bb1..eafd97c6c7fd 100644
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
index e05507a8d1e3..1fdb8d5d8590 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -428,8 +428,4 @@ static inline void part_nr_sects_write(struct hd_struct *part, sector_t size)
 #endif
 }
 
-int bio_add_hw_page(struct request_queue *q, struct bio *bio,
-		struct page *page, unsigned int len, unsigned int offset,
-		unsigned int max_sectors, bool *same_page);
-
 #endif /* BLK_INTERNAL_H */
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 05b346a68c2e..2bdaa7cacfa3 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2023,4 +2023,8 @@ int fsync_bdev(struct block_device *bdev);
 struct super_block *freeze_bdev(struct block_device *bdev);
 int thaw_bdev(struct block_device *bdev, struct super_block *sb);
 
+int bio_add_hw_page(struct request_queue *q, struct bio *bio,
+		struct page *page, unsigned int len, unsigned int offset,
+		unsigned int max_sectors, bool *same_page);
+
 #endif /* _LINUX_BLKDEV_H */
-- 
2.22.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
