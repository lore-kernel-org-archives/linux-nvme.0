Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D96FCD128D
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 13:49:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZobphGoezPtx6qyKtbVXNh+BXkaD8C8l2/QuEZF0pNU=; b=kr+KQFQcmG94XdvI8kJXVqRppH
	vDBIKqZPqO+MNnfmFjzROl6zH91Mij5gdWHdO0g0eYTxRz+SLR3zzUJJ8Rj4ewTNZlIvaYO4J4WXl
	aXtbqpAnuFMI2DgZcAbSDChvB12WJykv6US7eF7tG/+5E5Hij4Wc4ptFp/aso6vV6AmAhpYgCswyt
	wKjv7gdivH+RthsteCvePNXEnhQ2aDd9TazI0+fLKXKupfWYSBIzsHFIPk8y1uR58TU1DeAD9m+Dv
	kPhUN6exFJl8Y7oYtQlLokE3nLxPq3GvIGWdNimyHtqMZ6EjbU4rTpY3KQ6PABpTNjPhENMQVQHG0
	ZhhK0TYA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rreVe-0000000BQjV-2Qpl;
	Tue, 02 Apr 2024 13:49:06 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQb-0000000B6c1-0FiR
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:53 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 2CB6C60FFB;
	Tue,  2 Apr 2024 12:39:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3D4FC433C7;
	Tue,  2 Apr 2024 12:39:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061588;
	bh=zJg2W4YZSVDbkVyvzcyKxS2XcZn+CTU4gufBXBk7TGE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=htWgIJ+JnqgK4cHlu11qGHY7T0xl7GDqsm8tBL+bB5Q+UlgIRGISjVqSFOY9Hnz79
	 1ga9wnbMKCWsuHOW9decuefz8yqniDP3nKEMmsp1mHDK476+nmERvhMgzl5jj4Htfp
	 +59i5Onqb0i4oMNBDN8Yrwt6KEom/csqBCy4CpcRfsDFRdXH+QkmckpJ2poTsuAzla
	 gQ992AJfloMoJooDyDC1LjM+ouGpUxmRtKBdwC30yrBuiggX4BuPmg3Aagli0cn5Zt
	 gh169kTBBCI3qruSiwdeZbT79u7dY3gA0U4Z+AN9KeN4OBoGxC0VMwbr0PML1Lve/u
	 W247doYrfy4fg==
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
Subject: [PATCH v4 27/28] block: Do not force select mq-deadline with CONFIG_BLK_DEV_ZONED
Date: Tue,  2 Apr 2024 21:39:06 +0900
Message-ID: <20240402123907.512027-28-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_053949_975417_0EBB29C6 
X-CRM114-Status: GOOD (  10.80  )
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


