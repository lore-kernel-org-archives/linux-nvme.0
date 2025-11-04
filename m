Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1C789CCFA03
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 01:36:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=uF7O0EkSAQGeTb6eD06KeXcBRvyawLAAlJBLDYkGD/Q=; b=ezYaEsnFv4ZsxpPpZpw/fjPKSC
	DOY6gZYFNbv7HBBF1qUZBlH3Y3ZYvoikAhWTY+OqG02hGebuVidLa+KKtuy0fStlLtCRx5QZlU/uS
	egFVPA96GigL+pb99YVgfsrhOb0YVobi2UgSoxrdtlQwiE7YuBVD1XdH+6s+V/AkHeQXmHSFsf/CN
	hrETzK8aEWCIzroH8Nq+ClOnQaGdJ2aNotlSNIj+iPsWQRZQtZpkjauN6uVa1ebNvwg2OmYibfEtQ
	mHqopyQMh+ybcYDuOMEpSW+z1BrH5fsZMwIPe3f4/OgpylJJoXBnCSMP/eR/41NbzF8sPYUWDS1+F
	PzFi+Mrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5y3-0000000Auib-3heK;
	Tue, 04 Nov 2025 01:36:15 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vG5y1-0000000Auff-48P1
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 01:36:14 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 52DE4601E2;
	Tue,  4 Nov 2025 01:36:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9125AC113D0;
	Tue,  4 Nov 2025 01:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762220173;
	bh=3XYBGkzqttaT+ciE+Af6N6/imfqeeydh9/goSdG+2ZU=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TKoIYPIS2z8xXEJAeeMi4CafBnxmPoXX5KSzH5Lsl2vH6tgxnu24TkAvsEmPASeCN
	 vnM3M6YzG1cCjTkOVxVDj64c+r9YxUHOJO3AU/qADG8Qe3+dM04XMGeypSv7WGL96Z
	 6FIjvYr8BIsxKVj7xxqfdVH2/y+D0QAwQ1GpDoYCxZbhf2+IgXPxztF0scN2E+j5rk
	 QLalEvgpaMHTp/ci096TB9+J1rC6nZ+WprD4Cexpt4WFwO8rRSrMoZTXiG6lXKyqNu
	 A7Ra7holVxQgkzZ/xD8SF/zKjNAIOiCPgzvyhtuTib1dK/Z9pJG/5+Rua7xhgxDl9e
	 ETC8Rzkrbk3hg==
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
Subject: [PATCH v3 13/15] block: add zone write plug condition to debugfs zone_wplugs
Date: Tue,  4 Nov 2025 10:31:45 +0900
Message-ID: <20251104013147.913802-14-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104013147.913802-1-dlemoal@kernel.org>
References: <20251104013147.913802-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
To improve readability and ease of use, rather than the zone condition
raw value, the zone condition name is given using blk_zone_cond_str().

Suggested-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 2180d5256f9f..bf6495f0d49f 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2295,19 +2295,21 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
 	unsigned int zwp_wp_offset, zwp_flags;
 	unsigned int zwp_zone_no, zwp_ref;
 	unsigned int zwp_bio_list_size;
+	enum blk_zone_cond zwp_cond;
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
+		"Zone no: %u, flags: 0x%x, ref: %u, cond: %s, wp ofst: %u, pending BIO: %u\n",
+		zwp_zone_no, zwp_flags, zwp_ref, blk_zone_cond_str(zwp_cond),
 		zwp_wp_offset, zwp_bio_list_size);
 }
 
-- 
2.51.0


