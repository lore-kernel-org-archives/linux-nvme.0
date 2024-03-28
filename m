Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9DCADC47DD9
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 01:48:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RdM8RRX5pxWl2plQ361SCHWCKyS/+NJsSQGtC36vj1I=; b=vt0MErvdX/gnv8B2WYvYKgfmSC
	+Qh5gjfjVhgZxhgccrcaL5iRkRUw9AQ8Vo1zDh7Sr1aTaFlKWYnltQ8IunsvQdjBQNw0rg/sSnwfM
	WHPwdE8U5AnaxUDtFoDJlSdL88H625nCgLxrC8hUEaumGEb/fwYMM9ZHDTTL7d+VBlEKHAVeo+QnJ
	aDGIS/RdASpT6wV8kSMEy4BBNRGJrB6CMYOAX+c7FQI4usZl7veQyGPbXsqdNlnmiya+YQQhwGave
	9UHCOdpm77+FBZi9seDUcrkU6/6iTqkvGGRBxwO8YVLMmWzd1gZGDfGy6VEG+To4811UjIo7nczfH
	r7NTIoPQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpeso-0000000BzZ3-3zHn;
	Thu, 28 Mar 2024 01:48:46 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtR-0000000BnzX-0Fo2
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Mar 2024 00:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=RdM8RRX5pxWl2plQ361SCHWCKyS/+NJsSQGtC36vj1I=; b=k/sEmG9xu4cVW31bMY+W8dHmLy
	K4JWkdeqZTXdCuxsNolPa6xfGKtgI2hJQikSTdithjJXbXQo8xf8sMzQ5fQMUzyFMNZoH+Sg+Cxdp
	Lu000yAZ89f8JhQoOdV3BS/8jd0xBra/JXv6YzR0laDcPsLZ0sBwVMhMDKVxtvjhMAx1BVDbqnqNZ
	vVlFGyFy/0EYU5W0C3xKBaSM8WaR/UvpVzLuJ28rRvynupicDIlyZdbm1f41VK+ylNkNJV1FXdN4X
	qyU5U4PtWM9lwVpwqNpJFmtzWlvbPt7Pwcy0ERPUHIdL31uzczJs7bfGpy75c0gntXlk9RPtev9KF
	c78DPktg==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdt0-00000000fKx-0NO8
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:45:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id C323BCE28FE;
	Thu, 28 Mar 2024 00:44:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF73C433F1;
	Thu, 28 Mar 2024 00:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586683;
	bh=qoEibzLZjgtTKtSOz/7gZtcAbueqRKkO2g10bjgbvI4=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=qwFl8Kq3/2IBpoe22HUbHBJaqbLS/L5vqLLZnaoQaLQfXZ7DHqWbV85dPXn52DAx8
	 ruowiPjLPpeJ0pXpzm46d7GuGxbJuRLjPzZJ+RYsKCIc5esfVYCLdtuFd6FHvAe0pc
	 Sc5FOW5V7E+yz16GrrXVrlnU57VNhnCQDBN05Tbj5jVvvDul1g7FylVOayZ4YSS6pA
	 DKMDewpWm1ojABxzQjafOZYrrnlmAMf+wHKZI/vVWxcEWn7B9btZYWk1A33KjQ/wgR
	 /sWANfXdR0E9feUfKNfhuG0Dfg3hnj0ZbBqIWXzUFrBSODE0Cszx6EhUGdBSHIonbT
	 SLTWG0dUAqS/A==
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
Subject: [PATCH v3 17/30] null_blk: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Thu, 28 Mar 2024 09:43:56 +0900
Message-ID: <20240328004409.594888-18-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_004457_060765_AC2850FF 
X-CRM114-Status: GOOD (  11.03  )
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

With zone write plugging enabled at the block layer level, any zone
device can only ever see at most a single write operation per zone.
There is thus no need to request a block scheduler with strick per-zone
sequential write ordering control through the ELEVATOR_F_ZBD_SEQ_WRITE
feature. Removing this allows using a zoned null_blk device with any
scheduler, including "none".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/null_blk/zoned.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 1689e2584104..8e217f8fadcd 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -165,7 +165,6 @@ int null_register_zoned_dev(struct nullb *nullb)
 	struct request_queue *q = nullb->q;
 
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
-	blk_queue_required_elevator_features(q, ELEVATOR_F_ZBD_SEQ_WRITE);
 	nullb->disk->nr_zones = bdev_nr_zones(nullb->disk->part0);
 	return blk_revalidate_disk_zones(nullb->disk, NULL);
 }
-- 
2.44.0


