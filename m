Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D31DCCF9FE
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Nov 2025 13:35:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=BgC0pT+d6VmAdxedJ5hJ9Sg5HGI5O8Q0Eed1hWhyApM=; b=KGW/QfZunbOtDlhW9/IlkCo3e+
	3LNsB0z2ZuflMAQmB4laExG4fyu/LoKIX5/8960ttXgvZxJzP0xvdjA0sbIInTXlqSconuf7KCMTc
	1430MJWe6hEw0YzutVMJ/TVkFbeGk1uKMPe/SJmWy5ewPEm1dcUHTyAhvjvqcm4zqprP2wfaLlnGm
	1jtL+dVwyNolwNErxgCb00fCEqfZzlU8EZjzCmJZy9m6uKAwPsQCb5a3rJvJ1DIRmVbdOm+VKYGFg
	x9t3lVcawzgp56NqlXvxGOefcYVTW+WTYB2ujenjiIkozTO6wC1d9dYTV6jwmsNcLSE3xkhPQQ2hE
	muhc7Vnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuil-00000009uUV-1il6;
	Mon, 03 Nov 2025 13:35:43 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vFuig-00000009uN8-1MxC
	for linux-nvme@lists.infradead.org;
	Mon, 03 Nov 2025 13:35:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 0A40F409E8;
	Mon,  3 Nov 2025 13:35:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C922C4CEE7;
	Mon,  3 Nov 2025 13:35:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762176937;
	bh=gomlfGWCLgGQ3HJBaETQ13a6X7IFnbJLRFatQgVnJME=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=E5/mqZIda7ydc30NreeKe1jAfSz2ayaa7xmLHHOYF61YE9IMADRACTVkU37pq97cB
	 ISJEKN/dpDrmj3sCa3/bVmz2g0bxFl/TNlkWLg4DQvFwtFz7L2ENYP52TINaH0/1Qg
	 4e8CUDXAbtfgewtXHINKUVZQAZeKMPKggiRmyc9YGg8nV+EGnAUU0u7ZYk7ACCpZDE
	 W5hYwcxIbn8x5cff4jMBDQO1+Mh4htJ4JwkaelAjhwGDMb/EmNEzbLONlPFDCwxdjj
	 oGlWU8EleqXf1UalGI8aeEog1gIXXvcKg24FC3yldye+OAGV+jR7xmIe1hjbvmII9G
	 zRVm9SsQJ165A==
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
Subject: [PATCH v2 12/15] block: improve zone_wplugs debugfs attribute output
Date: Mon,  3 Nov 2025 22:31:20 +0900
Message-ID: <20251103133123.645038-13-dlemoal@kernel.org>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251103133123.645038-1-dlemoal@kernel.org>
References: <20251103133123.645038-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251103_053538_388719_97E54B0E 
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

Make the output of the zone_wplugs debugfs attribute file more easily
readable by adding the name of the zone write plugs fields in the
output.

No functional changes.

Suggested-by: Bart Van Assche <bvanassche@acm.org>
Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
---
 block/blk-zoned.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index a2f4aa88747a..8773af89980d 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -2303,8 +2303,10 @@ static void queue_zone_wplug_show(struct blk_zone_wplug *zwplug,
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


