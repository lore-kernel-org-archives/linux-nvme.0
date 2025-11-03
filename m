Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 460BACCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:35:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=sv0h3UjHvRUaJG+QUJTsQM7HU9rgH60HJvIAKCJaSVU=; b=MQy9K4/p2wdMVHZOO4u22NnoUf
	2JU0WUdqt9O2cstPYZ31cqHVFAev0d4eG3Ddn6PCixirLlx4p89jicUdABkI47V9yHJraQm9u2iAh
	T7rlFQQwahiV4OMiQvsBfbYXLaz6uGB3w/84BWp7AbpPineHOWR8rLReXrb5g32jEKEIwdWzzCRNU
	7vzRHK/4eYXYmFT5RwTvDccI9RMIoSGFCNDld4nOkt0iv8Q1VxrgsSD99lhEo2N5aEmN/lN5k7jjN
	irVibzbH8gqevk8jhd8Y1EOBSmDeW4MePUGnI6KXSZrioxao4Cn5rNKM3iO/e2dEnH4dEHeEQ6ekk
	1YrQ74kA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuin-00000009uYQ-40wR;
	Mon, 03 Nov 2025 13:35:45 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuii-00000009uQx-2w5h
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:35:44 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 3EF00438AC;
	Mon,  3 Nov 2025 13:35:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3FC73C4CEFD;
	Mon,  3 Nov 2025 13:35:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176940;
	bh=K3sXqMKFMt+RLh4JOZhVvYF2rGA92o4uAKlp+MpsqJM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=r+NfXeWQOghrQ1iyE3XfG3ugVEXqhHFQO7sKkjUDNjP3hIJgMwe6Qg4CuNr0jWMMJ
	 gaioMOmTknbWmPxBW8pTEFFVCH4K9Jkhl325QXPV5uG+6EHMP880qtNJdZ1dqOWTCn
	 sniWtCsO2ayarWUvrml4BXYcFL2JqsuTTOrrQHNOkzTIsbg69anqLSvPxX0BT6sG1r
	 wF9aWZBwoIc1qCrfgBI9vjwsKktlXRD34OMMQWLrESBXEy8E2c/2vUZ/GjeAydtyDP
	 1jdpDb6DgYv4TURdDIzuW7tsHlN62AaTu/LgHlYvfsr/uCgZUIIofyNkeerTRiNJmj
	 gJ2CCYRXiSYVQ==
From: Damien Le Moal <dlemoal@kernel.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Keith Busch <keith.busch@wdc.com>,
	Christoph Hellwig <hch@lst.de>,
	dm-devel@lists.linux.dev,
	Mike Snitzer <snitzer@kernel.org>,
	Mikulas Patocka <mpatocka@redhat.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org,
	linux-xfs@vger.kernel.org,
	Carlos Maiolino <cem@kernel.org>,
	linux-btrfs@vger.kernel.org,
	David Sterba <dsterba@suse.com>
Subject: [PATCH v2 13/15] block: add zone write plug condition to debugfs zone_wplugs
Date: Mon,  3 Nov 2025 22:31:21 +0900
Message-ID: <20251103133123.645038-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_053540_776159_DD121124 
X-CRM114-Status: GOOD (  10.73  )
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

Modify queue_zone_wplug_show() to include the condition of a zone write
plug to the zone_wplugs debugfs attribute of a zoned block device.

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 8773af89980d..07553bde7b33 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2293,19 +2293,21 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 	unsigned int zwp_wp_offset, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
+	unsigned int zwp_cond;
 	unsigned long flags;
 
 	spin_lock_irqsave(&zwplug->lock, flags);
 	zwp_zone_no = zwplug->zone_no;
 	zwp_flags = zwplug->flags;
 	zwp_ref = refcount_read(&zwplug->ref);
+	zwp_cond = zwplug->cond;
 	zwp_wp_offset = zwplug->wp_offset;
 	zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
 	seq_printf(m,
-		"Zone no: %u, flags: 0x%x, ref: %u, wp ofst: %u, pending BIO: %u\n",
-		zwp_zone_no, zwp_flags, zwp_ref,
+		"Zone no: %u, flags: 0x%x, ref: %u, cond: 0x%x, wp ofst: %u, pending BIO: %u\n",
+		zwp_zone_no, zwp_flags, zwp_ref, zwp_cond,
 		zwp_wp_offset, zwp_bio_list_size);
 }
 
-- 
2.51.0


