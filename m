Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A55CCD1297
	for <linux-nvme@archiver.kernel.org>; Mon,  8 Apr 2024 02:46:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=TXPsk+mtFQTuilmbshDCp1aoRSQCkoOWqvuvpHvpPrw=; b=BaO1zLh1E8VYtbmM97/pkJauLW
	8MQf2qGr6VDm18RRDRJNBVcFwXQH8Y2da8lcOG1b4iKnk7woLSEoE27upl6tC8epFQsqXP4ehnquw
	+5e+mhlZfU5q7B57Pxlwg0ETMJkJgXAsoQKG0j3KKkdB0chtZLUmfBNdIkeO9MmK0MWtmxJqLPNbW
	M36f+QTOVfr/l2X67VmnJgGXCLRgfSfP/djXv3DxcwGWmshYJqAJdJrUCQ+8jvJylxNdWl1KMcbTU
	7Qb8hTT+SHzft4OyTMB0zubsKnX02jvY5DS2m6vnihNAhNMJPWbMAUPxpDqy+tKZWu6NiwBTug4oO
	CAubMTvg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rtf1N-0000000E5jl-0hYS;
	Mon, 08 Apr 2024 02:46:09 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rte1e-0000000Dvqr-0hwn
	for linux-nvme@lists.infradead.org;
	Mon, 08 Apr 2024 01:42:41 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 335F5CE0B9B;
	Mon,  8 Apr 2024 01:42:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A33AAC433F1;
	Mon,  8 Apr 2024 01:42:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712540539;
	bh=Y2mdZkEnZ/DAhvusMpda3u94JlWFQ2zkygXuTzVrhEI=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=WUm2DQ0o1Wq3swKcnWyfxEQWdmqs9zon++fe9s1Z1SZygmTMMFGyg11hrjKrneYNo
	 qRt6eybt3Gvij/MbEKKOFlAExCjD9BsSxlZQicA3bqjoWf6bz0WtnVhiI7dnd1hluK
	 vlsATyvMxM1zc/TdnNn4TV9hfwdamlrBaeJElwuPsqaYB30uN9XSVCytMUiqmaC0sr
	 lpmYuIwVtYLt50ez2FC68aJN3DK6+mKitKsaC+BUmjOqz6w9XhDhgtkvx+E33TqkzG
	 nBccq+NGKPPNLEYLLybLxdsMWA/ZJ3QOj1KQHUH4YsWfUZiB3WHEC/63J79VpqsFYY
	 v5JfILRKmFp4A==
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
Subject: [PATCH v7 27/28] block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
Date: Mon,  8 Apr 2024 10:41:27 +0900
Message-ID: <20240408014128.205141-28-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240408014128.205141-1-dlemoal@kernel.org>
References: <20240408014128.205141-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240407_184222_838661_DB1ACA51 
X-CRM114-Status: GOOD (  10.47  )
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
Tested-by: Hans Holmberg <hans.holmberg@wdc.com>
Tested-by: Dennis Maisenbacher <dennis.maisenbacher@wdc.com>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
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


