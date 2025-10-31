Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4588CCF9EE
	for <linux-nvme@archiver.kernel.org>; Fri, 31 Oct 2025 06:17:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=zLPlVYeL/0mPeJQhcIxHnYkrm7Z0kYo5eoVEWJx5DGU=; b=MXp3B0VkKBeHe7R+s+L7glH102
	Vlda3zl6O3SQt7uMjvn6ykt0Fv8/vdfWXBXxKZXKTO+ixsL28/ZUJJTBb0mS+m/ta+/XGO4pWUDpp
	mYEp2bXTLzagPQrl5kDhLcPtncUY+AHgu6THVEN1TKMd5b2glzGTqESG5Pqi3s1aSTeFs7qTgnqvK
	FU6WLbWc0uDhcje4qeqqRmxk4l7I+iJDzUf3OAHFRVO+u3PsUndRyJCPBAtTz6U0cIDcRX7zDjZUx
	3T4oMPxVTLNPea6ALDll9UVVrpydOaz120lmZuPFSFvW5prrxpbLkp1HzRu/wtJT9qqsU88IOF/Hf
	DaawXjYw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiS5-00000005Rxk-0u4g;
	Fri, 31 Oct 2025 06:17:33 +0000
Received: from sea.source.kernel.org ([2600:3c0a:e001:78e:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vEiRm-00000005RmE-3mtS
	for linux-nvme@lists.infradead.org;
	Fri, 31 Oct 2025 06:17:20 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 9C50044BF1;
	Fri, 31 Oct 2025 06:17:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FD5FC16AAE;
	Fri, 31 Oct 2025 06:17:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761891434;
	bh=AFRfC/+L9+8EqBO+j5hc4RIPbK+fIEpNfl2CvB6ilbs=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=MPTUKdy1RphP61c8KqphsqN3kuqRtta5Kfq2QnYZX5NLKLH5HoNUq/tBOpgJDJH0y
	 V1Re4wFweO5nA+uVbgWUZD9hTSw8xDQbchUjEkfLwYTmulZGpxdvbP316EPHxvuYk4
	 g21xK+qrOYi5GDpBr/HwSImAaLOQ9b9bGl3Z5cCpPaDvvwrif38/fo1FZIo4sJaaeI
	 KhQQHVa2Rd3ZiRmFosGf8RxSmRz+As1KFJtdo5GX4la7K6zDqW2JKr4oHjAWDTB3/z
	 WWKrGBll4sVmH43GTBo4xF/dERKkE7uT/X2uMDLz1Uhl43QS9B41bsIkC2sCT0Xpnl
	 asu0cumzmCIbQ==
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
Subject: [PATCH 11/13] block: add zone write plug condition to debugfs zone_wplugs
Date: Fri, 31 Oct 2025 15:13:05 +0900
Message-ID: <20251031061307.185513-12-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251031061307.185513-1-dlemoal@kernel.org>
References: <20251031061307.185513-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251030_231719_319781_2B0EC7B3 
X-CRM114-Status: GOOD (  10.09  )
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
---
 block/blk-zoned.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index c8335654b1cd..1ccd78beb538 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2296,18 +2296,21 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
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
 
-	seq_printf(m, "%u 0x%x %u %u %u\n", zwp_zone_no, zwp_flags, zwp_ref,
-		   zwp_wp_offset, zwp_bio_list_size);
+	seq_printf(m, "%u 0x%x %u 0x%x %u %u\n",
+		   zwp_zone_no, zwp_flags, zwp_ref,
+		   zwp_cond, zwp_wp_offset, zwp_bio_list_size);
 }
 
 int queue_zone_wplugs_show(void *data, struct seq_file *m)
-- 
2.51.0


