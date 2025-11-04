Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59524CCF9F8
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=XF/SQ7fXT+vofnZCulFDvNeXu6ICH73O6NDXQt5SMUA=; b=2NgEUtR5d37RmKj4gs+APrhSGD
	J2Os3pWhJNhA4KLVbYbDyKEGoULnMqcq1+WSWpABbPXuW6aSEppWsjBXWYzRVqQJifk+Kuf8pahdP
	91S+Gr3Jd9bQrRiIAjk3OJsv4uHykIzf3EIz/urh8MeQh69CbltWsAt5YsF/t0bjmW2LfGiBKOjqm
	cusYmEmAKcJQpnfM93GICIge2FFNK7R7uHo/PUXiGQiEAzeZmuQ6dY3VlYrulxwk6pUEhchxZ8rhI
	kHEvCMBbrsX1+X8Xsp1uvaHglV7ABsPwc3FqXss5s4nt2I6PqLH1aFoINRFyQRj1B/MNwQXL6Kkqe
	8NPR5dnQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5y3-0000000AuhS-0uiS;
	Tue, 04 Nov 2025 01:36:15 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5xy-0000000Auao-2psb
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:36:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4D09B4396A;
	Tue,  4 Nov 2025 01:36:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6965C16AAE;
	Tue,  4 Nov 2025 01:36:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220170;
	bh=ELabnKiZFe6DwArSXoHXUHbKT9aZEi5tHHUKFPxhJ7Y=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=R1yre24h9zJReqcamtttSoEXcNiu9FDpe4sxkyd/c2b1sBtcSKsRFNGeAU9Jy0FxH
	 jjEOyaNxWyjyoyuAKNKKL8Ttw1h00u/nDVr6lA2hGbXDC2CrhBBPhjnrh7OzWJ+nD8
	 yleeMKkesq7mwKyUnIPoWq47TPrLMtxl39UpGOEYvwDg4/3SBGp7DSinOpuJKOwITV
	 y0NN4D0L2NBgMdrmooGj5M41z0tQYhBFQlAVwfnci0l2Hxti3UiAOD/x2zMzBceO/N
	 4GDlBreiUfPUWvGdfDJUK5LcOPZlLHNH72SczB5THaJZxzHGim02+co5frnWToiSOO
	 vcA3wcym8u+Uw==
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
Subject: [PATCH v3 12/15] block: improve zone_wplugs debugfs attribute output
Date: Tue,  4 Nov 2025 10:31:44 +0900
Message-ID: <20251104013147.913802-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_173610_758478_8F034FEB 
X-CRM114-Status: GOOD (  11.49  )
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

Make the output of the zone_wplugs debugfs attribute file more easily
readable by adding the name of the zone write plugs fields in the
output.

No functional changes.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index ea61ad7905c0..2180d5256f9f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2305,8 +2305,10 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 	zwp_bio_list_size = bio_list_size(&zwplug->bio_list);
 	spin_unlock_irqrestore(&zwplug->lock, flags);
 
-	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
-		   zwp_wp_offset, zwp_bio_list_size);
+	seq_printf(m,
+		"Zone no: %u, flags: 0x%x, ref: %u, wp ofst: %u, pending BIO: %u\n",
+		zwp_zone_no, zwp_flags, zwp_ref,
+		zwp_wp_offset, zwp_bio_list_size);
 }
 
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
-- 
2.51.0


