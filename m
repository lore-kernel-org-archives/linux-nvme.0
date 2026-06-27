Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC139C44500
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jun 2026 05:42:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:
	Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hKeiCzbPRbTnzm/AI4vnqpxf3f5IT13bPWCisZ89M54=; b=vwr+/IQxP2Ns1nHwjuPwaiA8vA
	Qx1mDiwTw314b+Dw3rKV81kbOYYKGRZJx+Q2qNo0LDnU6ZU00cDC9TMU3Qfyn7ufbr0cpceYPOGI4
	v/Ayej4grf7mOebDp3HN06WIQMDMqrB6r4+fNT7qkPkEd7lrOXd+lJ+lAMpVRebwO6B0Nws7RfsWt
	xbv1equI53MPBV8HRn3ljkeS9jiMFBRJ+oBMk4KWoBbx9wlPD1t26R/rL8179YQFNE3n20+pgB8Gc
	f0kiGwOZWa9uWAxXpnpBR18udRLCYPIQ7MqYdoILh4ves5hKSYqwv55Nlkl7nG6l4hpjl2dVldyNn
	Qc5XoWpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoc-0000000CA7i-0KlB;
	Sat, 27 Jun 2026 05:42:54 +0000
Received: from mail-lf1-x161.google.com ([2a00:1450:4864:20::161])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1wdLoZ-0000000CA5L-3F2S
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jun 2026 05:42:52 +0000
Received: by mail-lf1-x161.google.com with SMTP id 2adb3069b0e04-5aea9ee2611so33853e87.2
        for <linux-nvme@lists.infradead.org>; Fri, 26 Jun 2026 22:42:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=purestorage.com; s=google2022; t=1782538969; x=1783143769; darn=lists.infradead.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=hKeiCzbPRbTnzm/AI4vnqpxf3f5IT13bPWCisZ89M54=;
        b=GOuvRVNSrR698ZcdrNn5A3ZlZo+Smbf+DcNSV25GwgMDFU5tPgEyj1rLkvNSreGU4K
         EZGZBO1qBEPZwBQCpsyVdOIkT0mJlcD9aMDspBeY8peGxiIi1kr1L8JIQLVOjmbj5ND3
         t7ntHBZdbAtGKBmO8ZdQU3vWtXXWs9Fxi/MKu7e0aVdbdoRsUyb2RAhySALDlMX/jLBp
         E8FbfhOle32CN/GTBMqJeiNnJTsUFloKkpSMT5Tf/HWuHdQLBaiAokqjOLMefZiJ7fDO
         uN13CziIiej9zXXVPKuB9F+majQs/CQSDxMN/QIkIwPMaV7OeIkYJMrJSTTAnenyHaYY
         K+EQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782538969; x=1783143769;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=hKeiCzbPRbTnzm/AI4vnqpxf3f5IT13bPWCisZ89M54=;
        b=DNvPb5ncHF1EAfJKdsw/EffmR1tDn7rTzwpg1cks7RyRE/y/7Myi0uOMmlYRuCkpyg
         XyUOFCBHwkyZghtvfQZB8gMsDoej5eC7WKtC/ugVnnOsTGSValvEvpjkzhDTSf90xXIV
         8/Ti4QFGEL0KlZxWNlXiezuYWg150B0zVj8xTCUeiLdFfHvi1OAD921Y6e/huU/WrLXs
         ySGDPb2BwJW+tesaoCCcR7hjfiXsOXeTGup5w+WmHhPCEgpLK2zI1RcbuMZ9LoxpJzEM
         y6wP/Zz6tslvDlvDrPlQZG3AtqKa2MyWLyz+6V3x74v9gy36o0OpNaJOa5DJeBCXogMZ
         5ysw==
X-Forwarded-Encrypted: i=1; AHgh+Romd48ZHeY2ZNRQbeV6gLU6CihIMQgjaIcPdgDGYHpdJMhfv0maTiQoD2KGDeb7YpfKIIFiU0GSxcJs@lists.infradead.org
X-Gm-Message-State: AOJu0YzmArKmppgz1Qh4hExEWYU5p8BibjpxldC/w63CjbcvNvScUdOr
	BX4lOnNunU1cAKxh+yoASW35XcNOB4+M2y/q6TCwSgq4YVQENaEmgdS+ILLPTEndYuahq3cP9wA
	mVXyW0kOAQ/lNhB0J7rtpdYbaSsFClSZ0f4p7
X-Gm-Gg: AfdE7cleItUlejFkt5VoLOTsK6G0lupw1sSGYCBStuNbkVgyTgzYaDh9vGnTzM+y7VH
	WLwGYf8xIWNWecbHKxRPKCCUHsolJlwe5Lnf9lANIDfbog2TiI+fuYttmb7/aLfTYSzEocfxz3S
	3d77ug0KCN6Y9bCTiGaoWcF7ZPQwxgn74cClXsHMmpdEF6TwbEf822FbubmNFYG59kKHt+F/W7K
	vyBqR/HbOAy5XdrQ49thumPosy6XX0ulRcrw9Qtqb3lnktgnmEmkviOpn6q8RKRn6uylAXGhULR
	PBBy/U/MHdv5ftkHIZE4v+I2oqiCBnmo/vBtdKA7REVt8/8z/4K4J/YugRke6XtU0Jivm9822WO
	izqiHF/PMRoqnfQAhOdGq7vu+yam0FluLEaGKVwzOLlg=
X-Received: by 2002:a05:651c:2224:b0:396:8491:3135 with SMTP id 38308e7fff4ca-39acb54fe16mr10822271fa.1.1782538969173;
        Fri, 26 Jun 2026 22:42:49 -0700 (PDT)
Received: from c7-smtp-2026.dev.purestorage.com ([208.88.159.128])
        by smtp-relay.gmail.com with ESMTPS id 38308e7fff4ca-3999b1cf17bsm15732331fa.13.2026.06.26.22.42.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jun 2026 22:42:49 -0700 (PDT)
X-Relaying-Domain: purestorage.com
Received: from dev-csander.dev.purestorage.com (bond0.slc5-n17m28-k8s.dev.purestorage.com [IPv6:2620:125:9025:20::a31:41f])
	by c7-smtp-2026.dev.purestorage.com (Postfix) with ESMTP id 73DC4402B3;
	Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
Received: by dev-csander.dev.purestorage.com (Postfix, from userid 1557716354)
	id 7161FE40712; Fri, 26 Jun 2026 23:42:46 -0600 (MDT)
From: Caleb Sander Mateos <csander@purestorage.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
Cc: Anuj Gupta <anuj20.g@samsung.com>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	linux-scsi@vger.kernel.org,
	target-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Caleb Sander Mateos <csander@purestorage.com>
Subject: [PATCH v4 2/5] blk-integrity: take u64 in bio_integrity_intervals()
Date: Fri, 26 Jun 2026 23:42:17 -0600
Message-ID: <20260627054220.2174166-3-csander@purestorage.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260627054220.2174166-1-csander@purestorage.com>
References: <20260627054220.2174166-1-csander@purestorage.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.9.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260626_224251_834409_0F7B0DE1 
X-CRM114-Status: GOOD (  12.97  )
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

To allow bio_integrity_intervals() to convert an absolute sector to an
absolute integrity interval, use u64 for its argument and return types.
Also use SECTOR_SHIFT instead of the magic constant 9.

Signed-off-by: Caleb Sander Mateos <csander@purestorage.com>
Reviewed-by: Anuj Gupta <anuj20.g@samsung.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/blk-integrity.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/linux/blk-integrity.h b/include/linux/blk-integrity.h
index b1b530613c34..825d777c078b 100644
--- a/include/linux/blk-integrity.h
+++ b/include/linux/blk-integrity.h
@@ -64,23 +64,23 @@ queue_max_integrity_segments(const struct request_queue *q)
 {
 	return q->limits.max_integrity_segments;
 }
 
 /**
- * bio_integrity_intervals - Return number of integrity intervals for a bio
+ * bio_integrity_intervals - Convert sectors to integrity intervals
  * @bi:		blk_integrity profile for device
- * @sectors:	Size of the bio in 512-byte sectors
+ * @sectors:	Number of 512-byte sectors
  *
  * Description: The block layer calculates everything in 512 byte
  * sectors but integrity metadata is done in terms of the data integrity
  * interval size of the storage device.  Convert the block layer sectors
  * to the appropriate number of integrity intervals.
  */
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
-	return sectors >> (bi->interval_exp - 9);
+	return sectors >> (bi->interval_exp - SECTOR_SHIFT);
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
 					       unsigned int sectors)
 {
@@ -151,12 +151,12 @@ static inline unsigned short
 queue_max_integrity_segments(const struct request_queue *q)
 {
 	return 0;
 }
 
-static inline unsigned int bio_integrity_intervals(struct blk_integrity *bi,
-						   unsigned int sectors)
+static inline u64 bio_integrity_intervals(const struct blk_integrity *bi,
+					  u64 sectors)
 {
 	return 0;
 }
 
 static inline unsigned int bio_integrity_bytes(struct blk_integrity *bi,
-- 
2.54.0


