Return-Path: <SRS0=jca5=JN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 764F4C433B4
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:06:43 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EADC16117A
	for <linux-nvme@archiver.kernel.org>; Fri, 16 Apr 2021 03:06:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EADC16117A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=4lLm7NUy7pfIjZyvQPVghz2wVBAVsJHWYkaakZEEILA=; b=jLSchEa2Shq2Cv8QOTMjUzzqy
	BBLmjzgTJqAidZTvUc2XZlu1gRfEDHEvLJBU4jPU2W7gMK6QZ1FyhJqxoe1ypeog8W105HB8CjYIP
	r0OKuCiUrdCBeuhtL55I//8jql83HBH4JisN12VEWCL283+fZL8GQRhv6mN6bxf1WjGB8hfgHjXMe
	v0pWM16u02SpBGV0Prso1R0O/r0Mk8K2YofBEgfdMDCgkvrGL6weNmFwUUeIc8upHReVBxPbMo2Vd
	eV6SfUFQrxNL2eJBHNRtYjaGKUJSHpYUPvfRrW454YQF14yPv0W7eXZfNKig+uGmCm0OWXOjFwjxV
	mz+jcgvlA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXEoV-000aJb-5M; Fri, 16 Apr 2021 03:06:35 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEni-000aDL-Ep
 for linux-nvme@desiato.infradead.org; Fri, 16 Apr 2021 03:05:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=DnoGz2qU7KYIkDP3ceekd6uRxQ9f0NgXdmQ3Ljr+ZDI=; b=JFlSS9RMlXbXZKLbZ47xhCBVzA
 kvuUvzD/DK4aY+mYFqnCLgw50t8ryzwe6yPhiIo8KP/yUKrJlAvTM+lCIHJDJfMmnR/PqE+sOGIqU
 TNvi9w123fIuFsKckaUM9NYp7G2YlO8Dm9i+3diUTESocyQp85D9ge8jsRpNeV53eNyL5/glVqfB9
 olqJ5vqEpOWGU50hMssHH8P+l5RdEzsu9z3FUfdclzUCBA8hVq63FY/gMYjXm9bTd1FImg9XyAuol
 MVOHkKd7GiohKmNLIc9wA38XGiNFNlCDk6VskJxgsY83gTFkssvYDPtb427BbyfSfdPiq0Cbq8WVa
 E5VqW/kw==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXEnf-0092zb-Tr
 for linux-nvme@lists.infradead.org; Fri, 16 Apr 2021 03:05:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618542343; x=1650078343;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=uVfh8D4+sBBq64E108Yvid21+UPvhkglPh0NjleQvb4=;
 b=iW+0pZcv5a0ErLfX/FCAa7mXIAAg3TMv4qg0Grx4g89Vjw6KI+OEOIFs
 CId1ncjMSrV+tN4K2TgaKF3YrSELfIq09VXwair+ajKyym1yHsZBFeEVh
 f3kVyKD9Ua1bLnGhmwsmpr42ng4mVsTcMiuAjiDJIS3TIjdheVGOn46qq
 RjyA2f4ya7AApYi6bwo+tL1CeeWcKWeLuu6IzXE3+8IMCpStADK7CU1jQ
 FnDpKJWxB75cCRblfXi91NFfZBV4boNnMF++a6APPxumcwllh8tLgHW7i
 M7+n93wejy227/G69PI+eLOinDUCoeGBC55UuGelefT0PCY0wQKeEKB3k A==;
IronPort-SDR: UeY/oCL6Y4eanz2As2/gpWjtNgzXvaZq1AFXm7HB/mmkzCujYWPuqVNZIukdpwFioiqPHIaU1P
 QOYzHGuqAVSqNJ5xueSGfTjUDCFVIc1fdJ/fUIUsgcTEEh5JhUgxLa1EZZdcznKPwzbZoLddzo
 rsYAWz8teMwPuqHz0/zxSNagTdSmo2iUNG/ywXsCaiL2hJLTu27xFQ4oeffcYae7JUwov+2Dfi
 aHNsIwo++jk7KjyShzGIE9bxDo1m1swiMZsIAjMMZ6SHlvBo2nGhhLLE1UMwG4QcUlODzxmwHa
 2mg=
X-IronPort-AV: E=Sophos;i="5.82,226,1613404800"; d="scan'208";a="275938876"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 16 Apr 2021 11:05:42 +0800
IronPort-SDR: Tlb4x3aCzuMxzREUkDJDO2cKYV8oGjFEBMeT8O9bfUg7xTaWlqfn+ZMXd9liozu1Y+XIQIZzbm
 dFUlw7R4ZZmcv7F612WYxz+0bJMuUUY+JUJb89eUmJQBwKKI90lVMl8hh9w7nX3XPrW0VlpxSw
 QpzaXdgsfjoZ/9a5WSD7fVN5phCecHlpFoP4bjagOv0h98zKxxe8wzfZyWexKJMOKRJOuZvDtI
 plg0J3cZAyPnL+PmazWCjosb5ZcUJ6TTBLqL2hPyuvREYogofQCM36yhGD7xeSpULK9Yuy5/Ir
 AihYrTfiW1xX7yF0b3z9u31K
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 15 Apr 2021 19:46:35 -0700
IronPort-SDR: u5Gc1810z5GreDYJpvaZDBd+bkB81RNJhYok8IDgPhe6JYgYj4b/4/fYIpyX1cNfJVEHlvUAnA
 MvOAeuVc8FBQZXEYMRwsr7AEl4o9EH4ZWc0IZfF4PcbzBOhhh0kx5kXMSJLHk9aqaOUbscvFQO
 cnR+SMMtVcof5L8EjlIR/eC/8XN0d4vx2Lzk9Lhsnt21cd/URva91ybcVwFbQqbeHdz6R/7aav
 OkHZyDzHZ5SnIdccJAHt+KUB7t7KMxH5k97pMJAwdRTYfFo0Amj59jJpiDg1hrSqHsfS+f5qTA
 0pc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip02.wdc.com with ESMTP; 15 Apr 2021 20:05:40 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org,
 David Sterba <dsterba@suse.com>, Josef Bacik <josef@toxicpanda.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>,
 Naohiro Aota <naohiro.aota@wdc.com>
Subject: [PATCH 4/4] zonefs: fix synchronous write to sequential zone files
Date: Fri, 16 Apr 2021 12:05:28 +0900
Message-Id: <20210416030528.757513-5-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210416030528.757513-1-damien.lemoal@wdc.com>
References: <20210416030528.757513-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210415_200543_988465_98B21C6E 
X-CRM114-Status: GOOD (  14.35  )
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

Synchronous writes to sequential zone files cannot use zone append
operations if the underlying zoned device queue limit
max_zone_append_sectors is 0, indicating that the device does not
support this operation. In this case, fall back to using regular write
operations.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/zonefs/super.c  | 16 ++++++++++++----
 fs/zonefs/zonefs.h |  2 ++
 2 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/zonefs/super.c b/fs/zonefs/super.c
index 049e36c69ed7..b97566b9dff7 100644
--- a/fs/zonefs/super.c
+++ b/fs/zonefs/super.c
@@ -689,14 +689,15 @@ static ssize_t zonefs_file_dio_append(struct kiocb *iocb, struct iov_iter *from)
 {
 	struct inode *inode = file_inode(iocb->ki_filp);
 	struct zonefs_inode_info *zi = ZONEFS_I(inode);
-	struct block_device *bdev = inode->i_sb->s_bdev;
-	unsigned int max;
+	struct super_block *sb = inode->i_sb;
+	struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+	struct block_device *bdev = sb->s_bdev;
+	sector_t max = sbi->s_max_zone_append_sectors;
 	struct bio *bio;
 	ssize_t size;
 	int nr_pages;
 	ssize_t ret;
 
-	max = queue_max_zone_append_sectors(bdev_get_queue(bdev));
 	max = ALIGN_DOWN(max << SECTOR_SHIFT, inode->i_sb->s_blocksize);
 	iov_iter_truncate(from, max);
 
@@ -853,6 +854,8 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 
 	/* Enforce sequential writes (append only) in sequential zones */
 	if (zi->i_ztype == ZONEFS_ZTYPE_SEQ) {
+		struct zonefs_sb_info *sbi = ZONEFS_SB(sb);
+
 		mutex_lock(&zi->i_truncate_mutex);
 		if (iocb->ki_pos != zi->i_wpoffset) {
 			mutex_unlock(&zi->i_truncate_mutex);
@@ -860,7 +863,7 @@ static ssize_t zonefs_file_dio_write(struct kiocb *iocb, struct iov_iter *from)
 			goto inode_unlock;
 		}
 		mutex_unlock(&zi->i_truncate_mutex);
-		append = sync;
+		append = sync && sbi->s_max_zone_append_sectors;
 	}
 
 	if (append)
@@ -1683,6 +1686,11 @@ static int zonefs_fill_super(struct super_block *sb, void *data, int silent)
 		sbi->s_mount_opts &= ~ZONEFS_MNTOPT_EXPLICIT_OPEN;
 	}
 
+	sbi->s_max_zone_append_sectors =
+		queue_max_zone_append_sectors(bdev_get_queue(sb->s_bdev));
+	if (!sbi->s_max_zone_append_sectors)
+		zonefs_info(sb, "Zone append is not supported: falling back to using regular writes\n");
+
 	ret = zonefs_read_super(sb);
 	if (ret)
 		return ret;
diff --git a/fs/zonefs/zonefs.h b/fs/zonefs/zonefs.h
index 51141907097c..2b8c3b1a32ea 100644
--- a/fs/zonefs/zonefs.h
+++ b/fs/zonefs/zonefs.h
@@ -185,6 +185,8 @@ struct zonefs_sb_info {
 
 	unsigned int		s_max_open_zones;
 	atomic_t		s_open_zones;
+
+	sector_t		s_max_zone_append_sectors;
 };
 
 static inline struct zonefs_sb_info *ZONEFS_SB(struct super_block *sb)
-- 
2.30.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
