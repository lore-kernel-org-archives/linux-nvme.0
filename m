Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 82178C6FD1F
	for <linux-nvme@archiver.kernel.org>; Tue,  2 Apr 2024 12:40:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YwIwTJWLzlj3JINTC9TTgWbKwrhAt/4WKpGszV+J6xA=; b=aiPgvqfMXClwmo3q3hrr8uxw61
	lCwuLFRZSszIawoaOuJBoz0vQBrrnV3H+pJp3kPvqft1v0dlqEBAiXnXNX7G0JVd9lXJ52ERusu1P
	/9yEz09KPaOQYMsBy8LcqoP5n0cOZVsVQc25DhpAW8Itu8AfHN0D6UPIhBzctF8B9cubj44Bj0ojI
	ZhhLCK4rfza0gHYtwAFrM1cLkA5poRn/5AdGLVNfNWMmhefZW53I2MlR7M91sbZjSJMLZZEAFR/Ml
	5MMesBMaDV0DdduTDGpyEWRq/3eASFpJRC4xrtDEvw0jhrN7o2GBFvDO5bKdPz5DKZ2CNpxS/rPxn
	ZK17ryKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdR6-0000000B6yX-1LLN;
	Tue, 02 Apr 2024 12:40:20 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQX-0000000B6Zb-2ThF
	for linux-nvme@bombadil.infradead.org;
	Tue, 02 Apr 2024 12:39:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=YwIwTJWLzlj3JINTC9TTgWbKwrhAt/4WKpGszV+J6xA=; b=kjmItZbFyJcL05axqyA8DEw12M
	UtvxA7kOe1FWa+oefIvfSqlFlevbHNCsCQy/ykIhB47q1zQaoEXMAZ+BaBHDUbYbLX2F/yK6gBrHG
	T8ourqxuL8AdBpYYPM2AJT6To+nakPqLJouBc/Ha+MtPamzw8b9lqRY3tQAtaHVmb6QRmbqTSkPZG
	y5/vaCQmEJ6CC3YmPO0pN/wMMAjFTaP1ISkHeA8m2OiW/u7sRESBbwndg0CPFhnZOgkxpW9gVp5lr
	9yWPxsxV/spaQ3exDuQvjQbQF2WQs7x8ndMesrNUNhkYU6j0FJ42QbAvjaYTVykc+D2fmb3/ysasV
	Q2s8xWNw==;
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrdQM-00000003cIL-2BAl
	for linux-nvme@lists.infradead.org;
	Tue, 02 Apr 2024 12:39:43 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 7ECC9CE1B58;
	Tue,  2 Apr 2024 12:39:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1602BC433C7;
	Tue,  2 Apr 2024 12:39:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712061570;
	bh=nMry4ZEBzaq6P0CgjEd5nmJRTc+Xolb7U7Xwyyw7OHM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=TGEi07KEhkHfl5Zi5d9hvYQePKAMqW3JSkL51rylAaNHauwGsOU0mpmwTxJmut6dX
	 dicdlf2nPcLvvgQKmNnKZkVNmGEOlBwIAja7R+uaJwZRRMNPXJFwC+pvdcZmQ45PZZ
	 t3WWzHk3WSJWoJ3wTa8S+8FcQBNEa/qVkvZ3DUlG5vxiBdXiCYovVjguux62RXmfZ8
	 Xw60qiiDE/AKxbDWh96oakGMzMAmqpA9hyxp5n31dFwqvXn3x1KSFyEz70DxKRNGvx
	 qLF6GbmuYB8mNWGG6tyydF5ekJWdOH/xQcysqRC1VpGOaVF8BHnJK8NqAhsmS3l5pp
	 Or2NU6UHosW/Q==
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
Subject: [PATCH v4 14/28] ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Tue,  2 Apr 2024 21:38:53 +0900
Message-ID: <20240402123907.512027-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240402123907.512027-1-dlemoal@kernel.org>
References: <20240402123907.512027-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240402_133939_641096_8B10491D 
X-CRM114-Status: GOOD (  12.51  )
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
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Bart Van Assche <bvanassche@acm.org>
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


