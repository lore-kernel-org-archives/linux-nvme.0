Return-Path: <SRS0=lokR=FM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A00C433FE
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:35:12 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6388223AFA
	for <linux-nvme@archiver.kernel.org>; Tue,  8 Dec 2020 16:35:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6388223AFA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+mjKUD12fcoBPOCfgOpfxjuzESAwtW6KSHz5dPvNDz4=; b=vNBhRAOgDi+pNkK5nasTkbmsi
	0c0H2rdw7Ib6saRugv4MUMmZPSQneAJJ4CjwdDIlDDxZeWi65e9BuSgGhMX5iX1qAg0hTdaHWqrDT
	eFlf4li+XI+fvHKlqip4LTtFeANzFHE8TvgdnTsIofIcCmPChWRds5YoF/8lI81fOlpixrySzP7EX
	2mRdPeR2k4I8ggDwZOy3uvTGq2K84QpsZddTwq8xW3b9PeSpesfasTp5k4rcNJ59wE1Rf00XLUcWF
	5dmkdZ0pR5o9UVDCqbhnfsNY+SOdHTaA1VJLMDmB6jcAI5CZS6U5Z8xJXNO4Zr0JjWVkiJbt1rpTh
	OIMgexV3A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmfxF-0001If-5T; Tue, 08 Dec 2020 16:35:09 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmfxB-0001Hk-Co
 for linux-nvme@merlin.infradead.org; Tue, 08 Dec 2020 16:35:05 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=FcrfDLXDMA6oQ175CyeC3VNyPVZW/odXwBqmYwf7d6s=; b=NbDUxu3AofBgFFaEc6xSfIhXOw
 c7uvYPpuX5u9/zeVdKnrjZFeNQaTZKOBIJ7Yp9OXPLhRHUm/XzX46cZdPGlAc4Nfb6S2XsbS/e4x6
 tINnMYr9bWpAHYEY7HZ3nZC5wTVtr2zNzLsF+sB0ZBQgdsZBvgrdZ05ZPRzOm7m6CEiLFpkkfvV++
 XMuSfHOgIbo0JYdoThDm+vhmMvPg73O1tZkI0nRNRchwezl803XDFGmt4WUEICTMr93kqLKXSAms8
 z5gpTzgFAJyIR2cSDudEYXqtXbbSoDJ69nkjyMrq8padi8W8wewDHZiKQ35URTLaEAan/7FGABTap
 Ljz+GWiQ==;
Received: from 089144200046.atnat0009.highway.a1.net ([89.144.200.46]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmfx9-0001Dj-SE; Tue, 08 Dec 2020 16:35:04 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] block: remove the NULL bdev check in bdev_read_only
Date: Tue,  8 Dec 2020 17:28:25 +0100
Message-Id: <20201208162829.2424563-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201208162829.2424563-1-hch@lst.de>
References: <20201208162829.2424563-1-hch@lst.de>
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
Cc: Sagi Grimberg <sagi@grimberg.me>, Mike Snitzer <snitzer@redhat.com>,
 Oleksii Kurochko <olkuroch@cisco.com>,
 Dongsheng Yang <dongsheng.yang@easystack.cn>, Ming Lei <ming.lei@redhat.com>,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Only a single caller can end up in bdev_read_only, so move the check
there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/genhd.c | 3 ---
 fs/super.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index b84b8671e6270a..8f2b89d1161813 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1652,11 +1652,8 @@ EXPORT_SYMBOL(set_disk_ro);
 
 int bdev_read_only(struct block_device *bdev)
 {
-	if (!bdev)
-		return 0;
 	return bdev->bd_read_only;
 }
-
 EXPORT_SYMBOL(bdev_read_only);
 
 /*
diff --git a/fs/super.c b/fs/super.c
index 2c6cdea2ab2d9e..5a1f384ffc74f6 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -865,7 +865,8 @@ int reconfigure_super(struct fs_context *fc)
 
 	if (fc->sb_flags_mask & SB_RDONLY) {
 #ifdef CONFIG_BLOCK
-		if (!(fc->sb_flags & SB_RDONLY) && bdev_read_only(sb->s_bdev))
+		if (!(fc->sb_flags & SB_RDONLY) && sb->s_bdev &&
+		    bdev_read_only(sb->s_bdev))
 			return -EACCES;
 #endif
 
-- 
2.29.2


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
