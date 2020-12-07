Return-Path: <SRS0=D68J=FL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 648F9C4167B
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:21:43 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8D84E2343E
	for <linux-nvme@archiver.kernel.org>; Mon,  7 Dec 2020 13:21:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8D84E2343E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=njuZyd5g5wY+WIW7UNKD8jmuAgUye0pVPM9Q/l3HJWo=; b=FAghX3cwI2TDfDXhNNludGoqf
	L3fmTMZXYLqLj317IZVuQStVjPE/CVS/Q95cfwM19rBiismA1J5C76Vx3lygZwvb2y/cdkwtdfr/X
	Y9+zV9O6Q/JvhRmG/GGsNe24657KX9cMveFvEp4YOZBa2FJMnqFHiziaoTtFmMe7xoUQ2uADdIFXx
	lMSG5tL5I24iYTkj5COW1G0BCmypIpyMhUztIAavcFpg5IW1BecuGS/QAcnf4xIMUQpVfGHloWmLH
	lOGPFOAJS8/Gom0MT55jtfEosd10oAxv4Mb6+hznd3UB3ZDmMcYFFjbiS/wDvEQyg0ZlBaiW4xQPj
	JH/tPhXVQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kmGSQ-0005uQ-Od; Mon, 07 Dec 2020 13:21:38 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmGSM-0005tV-6t
 for linux-nvme@merlin.infradead.org; Mon, 07 Dec 2020 13:21:34 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
 Content-Type:Content-ID:Content-Description;
 bh=P+/gCBxIheHJGDi3+bpOjeRK+157ValOVnRejSvOwWE=; b=Z2RKlT+SK7W1QGWnjaBeY3Yjn4
 +pY6zzOcs8NlwZgg4DL7ZAdyTrRQW6S97qaTP+/QiEpKrROMtXkJblXVRIIr4ZHHa2f7Lcy2c1/Ha
 8D74zoQHAEablq5XavxTmG9Yw5PWrhuCFpSmM4a+Q21+Lxu9YEjvN09RO4lCNnypqxeJAGP4dD6d2
 LEt/5W1WpriloeFpS8Lttq2bD2ZEr/SXj2JmbSRb/irg5sb7IPZBydxjUUVoX2DcC1LRozMFelXMp
 QtnEeoTBM+SADeaKSt/DLqL1M4XWRrh2Y4YfBzC9Zlw2lJ/LvJuf3ML5nYr/zjl6+UbqaaYeg3crL
 Y5+7TP8w==;
Received: from [2001:4bb8:188:f36:4fd9:254f:b3b5:5284] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kmGSK-0006Oz-Te; Mon, 07 Dec 2020 13:21:33 +0000
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] block: remove the NULL bdev check in bdev_read_only
Date: Mon,  7 Dec 2020 14:19:14 +0100
Message-Id: <20201207131918.2252553-3-hch@lst.de>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <20201207131918.2252553-1-hch@lst.de>
References: <20201207131918.2252553-1-hch@lst.de>
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
 Dongsheng Yang <dongsheng.yang@easystack.cn>, linux-block@vger.kernel.org,
 dm-devel@redhat.com, linux-nvme@lists.infradead.org,
 "Martin K . Petersen" <martin.petersen@oracle.com>,
 Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Only a single caller can end up in bdev_read_only, so move the check there.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 3 ---
 fs/super.c    | 3 ++-
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index 09ff6cef028729..c87013879b8650 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1445,11 +1445,8 @@ EXPORT_SYMBOL(set_disk_ro);
 
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
