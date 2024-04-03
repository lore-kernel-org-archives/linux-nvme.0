Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A648CD1288
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 08:44:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZobphGoezPtx6qyKtbVXNh+BXkaD8C8l2/QuEZF0pNU=; b=KQnm9+MigNgP37ROdBHIql9IOt
	tZVv3rGvOJnkS8d9CuDGI9mbn6jdPZkpKiqHD5Bjw5KYSSbTRNrpakVsC23FtIU+GlHlJ2ZP0HCyK
	Sqfm8No8w7oRii4WwQjehTfDr+X5anUk5tGHm8AErPLJxDSVvOY3NPfKiYCHcFfO2uTKW+09MGVpf
	f46LAxYxnIbZkgZtzLitUTlR1mSQiYsCatl0LKWM79t/j4aK4v5m4C82XU//xQtGL+qrxRZvu/y+E
	emiH6ssEVPtrMTnZLwtH19NijNgNEl4mCOjwJPKhCGC2G1Ugmo/mFnH/S7Rj4M0K6EqoGStvlMm3P
	kvWKbUHQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwEc-0000000Ezpz-4BWq;
	Wed, 03 Apr 2024 08:44:43 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDc-0000000EzCV-24ys
	for linux-nvme@bombadil.infradead.org;
	Wed, 03 Apr 2024 08:43:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=ZobphGoezPtx6qyKtbVXNh+BXkaD8C8l2/QuEZF0pNU=; b=V4TRbbDVzjSzQgk/S0YUQiTEnn
	2omBUxfXkjYcrFKhO1kwk955qaDWMkUX9S59qAOp9981YUJiHoG4tTknTbpoG1/tP6V+5X36TgX04
	r9i7/D62vBfIKHRMQDwWNeV6nZqPhzYrBRF5rM+28Mnhzra2CAOUp4jptvreO7Ic7Dq3n0IP0ZX0y
	Lq7GtRcKKBSFD0DnjXFH2rAfEKKenxY2dtwr/mskqLTRE2TF4lWozE8Snt4SF454hZ3Z3kddj9GAQ
	jAvSA7idV20SiS1hCZJ+RZOZovatEgmyLCqKK3QTgFFkktVFTIXH71IlwCkm+yUXK3KNiNYb3dNvg
	zHj/q8mA==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDY-000000046TH-3gVh
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id B8F09CE2116;
	Wed,  3 Apr 2024 08:43:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0ED2C433C7;
	Wed,  3 Apr 2024 08:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133813;
	bh=zJg2W4YZSVDbkVyvzcyKxS2XcZn+CTU4gufBXBk7TGE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=f2NzCmrnluP4faK+qiofhB3B8jqJo0iuekt8ofhgENDnxZETJNAu4yvhtorNbJM5e
	 4eS0PN8QKwmHgUTgPoU6e3SZWCFp37gd3vWOn/2W3K4MGgJdh9/pxuLm4GNESf6AqS
	 mp4y4AOnfvJMp5H9dMzHaTZzg4kjyuKcMTcA7EyVXGPp4CI3/SkVVHTNe9IdZJy70e
	 qbypqL1vkaOgYaJ0Svg7odi5+NzlRriDg0lPvH3NmkzzR4WMh+Mrn1E+YgkQlc60UK
	 9SjOsl3LlhMTUL7gczAQUFnU89lIrF1tYnhc8t1zJOPq1gvjL19YFFWyP8v2TeeWmI
	 IeGM2KHvro73w==
From: Damien Le Moal <dlemoal@kernel.org>
To: linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	linux-scsi@vger.kernel.org,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@redhat.com>,
	linux-nvme@lists.infradead.org,
	Keith Busch <kbusch@kernel.org>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 27/28] block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
Date: Wed,  3 Apr 2024 17:42:46 +0900
Message-ID: <20240403084247.856481-28-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_094337_329280_A5E86455 
X-CRM114-Status: GOOD (  10.52  )
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

Now that zone block device write ordering control does not depend
anymore on mq-deadline and zone write locking, there is no need to force
select the mq-deadline scheduler when CONFIG_BLK_DEV_ZONED is enabled.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig | 1 -
 1 file changed, 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 9f647149fbee..d47398ae9824 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -100,7 +100,6 @@ config BLK_DEV_WRITE_MOUNTED
 
 config BLK_DEV_ZONED
 	bool "Zoned block device support"
-	select MQ_IOSCHED_DEADLINE
 	help
 	Block layer zoned block device support. This option enables
 	support for ZAC/ZBC/ZNS host-managed and host-aware zoned block
-- 
2.44.0


