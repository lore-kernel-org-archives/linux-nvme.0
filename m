Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A4F74CCFA04
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Nov 2025 21:27:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=0bx/dDWXfLlmrWnjsbZzomaTS0vYxYteTVVv22hV5Sw=; b=vzeDnYNEQF7Zv2xr402qKScjW2
	kRewvVr87biAgNVdBouBmxMUJ3ROAJISFsVvDu4uUkxaDKsAnYDQBOJRR9NZlCYFYSatm2TwB7kGx
	gTdT2BN/UG59nx87aphpwnoL7PwZgWu8pSNMcq+hi78Y+ocda6IQ87xxPKaz6KQZSU69o3utJRtom
	3hhyrbGRqf1RLwk8yGPsQS0tc3gyFskJeKT70t6bnxqYBghEEpOv2hqQJPNANOk+xccPHOoR//MEx
	8blK6nTEq8t54BftyGrOvMOTsplHDfKKgcc6c/rU3BDWirRyOswmtLSDk9/yxFVSHwacbruaterg4
	6Gc5DcqQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOYT-0000000CbcY-1mtg;
	Tue, 04 Nov 2025 21:27:05 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vGOYQ-0000000CbYN-3zhH
	for linux-nvme@lists.infradead.org;
	Tue, 04 Nov 2025 21:27:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 57C1B601EC;
	Tue,  4 Nov 2025 21:27:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 51272C4CEF8;
	Tue,  4 Nov 2025 21:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762291622;
	bh=/CCHDJbVJ3PWgu3hj3rkfqxctPOjN5sAFJlgZQdPyDs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=KNYWDjD5H4LcgGeWXJ1yzM5k5fDQ7bBBihkDlSr4g+erlPrmiGFMrbn9nkVkIijRW
	 5T9Sro7r9CJaUiedryV/MpHwyzNFWO2JHFXHhPekGJDiVtG9t+bbAuRDPnACWvaC16
	 DfsFR7LN5xUj0anCuJEC2hRCQwDn//uUnokwEIAcsKlBDnKGsEO8QsTan/kr8fl5xi
	 HWxXJtEIIg9/fVKd2Ix0iL7z0ev86pMIWte/maX1eKrRRPW487xzvCF20tjzeyZz8k
	 7xw6dr4ae7fkVG5gcsnEr4Z/AD1hicIT5oWCHAPPuYzONVH40sUL6h/pwn072xgSUs
	 e0YoUamNLGoiQ==
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
Subject: [PATCH v4 12/15] block: improve zone_wplugs debugfs attribute output
Date: Wed,  5 Nov 2025 06:22:46 +0900
Message-ID: <20251104212249.1075412-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251104212249.1075412-1-dlemoal@kernel.org>
References: <20251104212249.1075412-1-dlemoal@kernel.org>
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

Make the output of the zone_wplugs debugfs attribute file more easily
readable by adding the name of the zone write plugs fields in the
output.

No functional changes.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Reviewed-by: Chaitanya Kulkarni <kch@nvidia.com>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 7a7b0704f095..3104fda5809b 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2313,8 +2313,10 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
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


