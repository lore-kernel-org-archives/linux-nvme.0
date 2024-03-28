Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3E24C54E67
	for <linux-nvme@archiver.kernel.org>; Thu, 28 Mar 2024 00:46:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=k7m5NtkU+aXMiVo4QUchjjRPw4lrxs9YHLYMWS/1tY8=; b=d8zZgl+xSUCTpHSGPuBKhSxILM
	gU2NkhJ06HsvKISvRQjyFjPuiCef0S0iekKWshLd502s7nNWF5AiI1k9YaqVhQyUaUqVSMKWyYdy4
	XObz833h1L52xBGVFXudv1ywZfIPMBfjBva2zTznlO1UGjlzCwvzYj2bUJ6zI3RCFVRtVbKIUaSs5
	16jaHcOVxZTZ6fK5c4JTG89Wfhp0sZBUv2HPFak7FAIWR4Pk7mHV5I9+C28qIznigYpett//JLyiG
	lCbXEglh74oHP/LYDTwZcpkJbVZJAnGhlQxCdDG3C3I3c3ow7Po8lgKLN59yVu5d/CP5LMwkIwDUM
	XpRbgy2g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdum-0000000Boy4-1jqE;
	Thu, 28 Mar 2024 00:46:44 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdtR-0000000BnzY-07aY
	for linux-nvme@bombadil.infradead.org;
	Thu, 28 Mar 2024 00:45:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=k7m5NtkU+aXMiVo4QUchjjRPw4lrxs9YHLYMWS/1tY8=; b=GR3f0wReS7KQuYBQkksAPeX8YL
	YD1yTTS4cYqbrZMyTsfDBfC3IT89eCJtd3m6wjzo1pvJfUvniQ1K9m90E9C9MWCjPJC0ea5g68AIv
	2HD5uH1PxbgA1hYfypnPciXy1YYL7/rh0DZJcntSXuxemw6M6BCoroBl1XwQlwNW/5Lyqh88uHHza
	UAniDO5oZUScsnjT80+/xovQIiegxm8yHbqNgR1Nb456pyHRFmfJZhPQ+2DobdmelqfrookFNT16N
	zvkSxaxDroyikBTHqJ6/G6XNnV+ICV3KO4CPmiVpfDt39VebViqkWwQ0oVVCyxr7HMT/x82MfESNO
	4nFJuVkA==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rpdt0-00000000fKc-0NSD
	for linux-nvme@lists.infradead.org;
	Thu, 28 Mar 2024 00:45:08 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id E43B661719;
	Thu, 28 Mar 2024 00:44:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BF37C43394;
	Thu, 28 Mar 2024 00:44:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1711586681;
	bh=ODVsC1HbJGQ0xy47J0sOpPmNReTkb8nd71OLgnXHrrE=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=UIkvnjQ+Pd78daqoPK8zTOCSuCDb9ZHi6b6VfFk7jQYwRd7aGYQy3QEGScqHjGiPX
	 YpYxpKhaYhCX0JDi2SucOoCiHGoS8gy3HMw3IeS6dxVzrkvscjE95p4GUhlreZQWCL
	 gerIM8++teBXw4aUsDDg7px/c/LJT+I3DfhmQPtmQjN9COOgtqKkM1qoBs+sescz0g
	 1lF9oe1N7wTtRY6RPOFzqDCiQ6CcKRgIAoCvXgoqu5tVNaJdLYbxQWuHn5iASwpuSI
	 Y1CQsXxmmdy+I3Hhk32FzByrodxlWslltPnhzmwElG0E8CTNSs7kaXe8f7NGgiBSVu
	 TOEhKMgjTjMLA==
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
Subject: [PATCH v3 16/30] ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Thu, 28 Mar 2024 09:43:55 +0900
Message-ID: <20240328004409.594888-17-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240328004409.594888-1-dlemoal@kernel.org>
References: <20240328004409.594888-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240328_004458_739082_46E93097 
X-CRM114-Status: GOOD (  12.18  )
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
feature. Removing this allows using a zoned ublk device with any
scheduler, including "none".

Signed-off-by: Damien Le Moal <dlemoal@kernel.org>
Reviewed-by: Hannes Reinecke <hare@suse.de>
---
 drivers/block/ublk_drv.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index bea3d5cf8a83..ab6af84e327c 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -249,8 +249,7 @@ static int ublk_dev_param_zoned_validate(const struct ublk_device *ub)
 static void ublk_dev_param_zoned_apply(struct ublk_device *ub)
 {
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, ub->ub_disk->queue);
-	blk_queue_required_elevator_features(ub->ub_disk->queue,
-					     ELEVATOR_F_ZBD_SEQ_WRITE);
+
 	ub->ub_disk->nr_zones = ublk_get_nr_zones(ub);
 }
 
-- 
2.44.0


