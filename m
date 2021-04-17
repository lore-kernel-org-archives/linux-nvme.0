Return-Path: <SRS0=qGt+=JO=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8FB0BC433ED
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:34:39 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08CFA60FEF
	for <linux-nvme@archiver.kernel.org>; Sat, 17 Apr 2021 02:34:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08CFA60FEF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:Cc:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=RmZRPuqhNYGuVHLvgg0lQkREpr/x944EDPzuMUidp74=; b=n8ySJJCJ56m8akn9U2KxtEPAQ
	JbXx/uvgGfzrJAiBmJsOPbVUH1lrbiNjeDB2ROH01QQrb8RQPiopwJq8BgeOHiKb+3qOkNt5CjbvT
	d7HdepBHIb2shBSvs0btXYeAvzsQnOELMQArGwbC2f1FX7mD0J9B0W/eQvXED+VBtP4d5sEEaT2Je
	m6Y1HTDsceW0XKqMzB0lOA10loEGVDlHu5GQK2Gz8Vz2rKDi6+zAEsquczriN9gsz+8vI5xGrRYHr
	I5XZpy/forgzAA/CHJarTRQnQBycXfyxK2LiyOwh3v0G3+11bcr85GdH2klX7OT4lEKDtJ45lGlVn
	LqDBZ/ZwA==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lXamg-0045mv-A5; Sat, 17 Apr 2021 02:34:10 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXam8-0045kG-Ij
 for linux-nvme@desiato.infradead.org; Sat, 17 Apr 2021 02:33:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
 :Reply-To:Content-Type:Content-ID:Content-Description;
 bh=cD6nWw/Rg8u2f75Aza/Rbv7C96RtZRnFJ39EQIextIE=; b=Q+Zi+q138S5wviySdOCRHMZVwx
 dLkCklLfpqOxnrobprirXSmYl+Z8X1LywdIrfPTe9rDtY17D3emkyjjNEUMXQGT7bLN12AYbAlz0Z
 TYn1R9put71QmWK3JDx7Z+tkmFC5olKVuCDgzIruk1G2nURyk/ZNGjRpAm5qEMN55YlpX8379Ib8F
 naTP/uBbicr0wVoz7EIvISENAf47hAf4V2WdNSGUeWigUNDGHxgN9U/JlzhLzzi78e3oBeSqna7yU
 AruJUn9U0akEDIHQpOLSaXX6nc+WDf7I+N4b/Kp1jykdIEdtrgwZFGKsQ5cLhd629q5xLHW8htR7E
 MnGxxYhA==;
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lXam5-009pji-UX
 for linux-nvme@lists.infradead.org; Sat, 17 Apr 2021 02:33:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1618626813; x=1650162813;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=1bt8pdRaO5fUcGqSEgkOZzZgAvMQ4pvkgiTI/HOypSk=;
 b=Kq8Lg2av9HzOxHDlzVUCjcbB8Zsc7oGCud+Rpmtymhr2o4fy6iTyhn5K
 7nYA2480tQFYm6Iq4U/OdgN+xKoYu8nQ+q2O0XT1LGgx69c3Io+T6psDD
 JStC4UqVEKyqDOEFOyudwb9JgFyuKbQxssCTbzw3eQCPJodoV/zd0n6BV
 YO4nKDdiAg9lt4JumLZKcU4fnIT5P/JsfIu1YqPUp2I4iugEMO28zdoIR
 pisiiQDKLezzMqhl3WdfaMhvOmpXmX3opAvVOmK8C9PYtrsdXSVE50Rtt
 w5Sqh/AzJ+WuLgVLQtLWSgAghRFETF+CDX6sEWTHhVQJhhhfLoK2SzjHs g==;
IronPort-SDR: Jra5Qi6xOdwgHBB+9EC/5CBWsdWItNRFQgAcI+itBxsVowTQr6bMbIC0w5b8ozW7/NCgT5t+Fw
 TUsd9XnLmjLIt5j9PWf+v3VzyTcevczV792NX8Tb4KJ9U+fczCm1aY3nOuYu/TBO3103dwluiS
 0HLpXxZ5RwjB8WTcNNiD4JP511Jy5J1tyz8VCeOaMCA6E7gTTJbYEqZhIH3JzSCKDl5PjtYf/F
 SekaY6u67cJoyIDFz55n9hfmMUQsnU1Cttu71upeMTupy9NcEJ4A5ff4PnZzqPPk7eLQdSjkso
 dmI=
X-IronPort-AV: E=Sophos;i="5.82,228,1613404800"; d="scan'208";a="276118899"
Received: from uls-op-cesaip02.wdc.com (HELO uls-op-cesaep02.wdc.com)
 ([199.255.45.15])
 by ob1.hgst.iphmx.com with ESMTP; 17 Apr 2021 10:33:32 +0800
IronPort-SDR: h3NRv/o8ZVbmFJZEnueXextDvwAwdqSB9iWd07jBh72BbDyTWcSRg3W6v+NnaQoibkJKkZ2cI2
 zcDnYpUJcUNrC1LoTqbSDcz71xsAaF6TwnbH8hkWBr9YNRK2q4CJhFP3E9U/ukKUrn5wsfukuT
 NM7babpFy4l0DWB/pN+BnrgqaGeqBU4DOm1yzghNX+2xujj1lDFzsBDMxcd/5T2kxSGuloIgX9
 saFgYJhq8Qut0moPM5BWO9j1Ss1Tc7sgre7h2IyyrNy8UokjbQwI2K9GB9txzpYT5Q9KYYeJNb
 NKG+a2TD4A9mfzuFFygIIHLp
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
 by uls-op-cesaep02.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Apr 2021 19:12:45 -0700
IronPort-SDR: ffwDuNJdgpDyZs+F+I7hb5tSfdWh7H3NQY/F8KVBqjx1K+WoPrmksYPHiqq3maw5NfYpqZctE9
 gWv+C7z7BiidjMOBh+0BeZRwHA5xPSD1s6Kg3GUZiliiyyBB0i0Uv2nQz0774FLe8UiAoCUSqt
 e+5ZqS22Z3zk1jmc+G8LVLkZJk8bruBBF+amRb69DmiJ5Lq6G3GvG7tTV6S+KC5sTAewBEgA84
 hAnkDYwYNQCOL+1UEM6V12/EMZYtLQG3IrKQoLYYc5WTTO5MKtF+ZIu3Pf8XRj1vqGFTTgE1HH
 LWc=
WDCIronportException: Internal
Received: from washi.fujisawa.hgst.com ([10.149.53.254])
 by uls-op-cesaip01.wdc.com with ESMTP; 16 Apr 2021 19:33:31 -0700
From: Damien Le Moal <damien.lemoal@wdc.com>
To: dm-devel@redhat.com, Mike Snitzer <snitzer@redhat.com>,
 linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 linux-scsi@vger.kernel.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 linux-fsdevel@vger.kernel.org
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>,
 Shinichiro Kawasaki <shinichiro.kawasaki@wdc.com>
Subject: [PATCH v2 3/3] zonefs: fix synchronous write to sequential zone files
Date: Sat, 17 Apr 2021 11:33:23 +0900
Message-Id: <20210417023323.852530-4-damien.lemoal@wdc.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210417023323.852530-1-damien.lemoal@wdc.com>
References: <20210417023323.852530-1-damien.lemoal@wdc.com>
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210416_193334_021126_339894CB 
X-CRM114-Status: GOOD (  14.36  )
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

Fixes: 02ef12a663c7 ("zonefs: use REQ_OP_ZONE_APPEND for sync DIO")
Cc: stable@vger.kernel.org
Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
