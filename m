Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9C143CD1297
	for <linux-nvme@archiver.kernel.org>; Wed,  3 Apr 2024 09:49:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:To:From:Reply-To:
	Cc:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YwIwTJWLzlj3JINTC9TTgWbKwrhAt/4WKpGszV+J6xA=; b=3u+d/8eDEsZkks65McngiZAfYU
	eluQgvHanks4TC+ZfLykbt2qhjPCvB0mU67qjFKhpfOQgcQK0YV3VxOZRmnsZ3xZd6X478OUkoieV
	X0mwivJwSv5mlqC7qwV57hFVmOTGQ5nXyzNiXrUsNzeop4ILq12nHoOH/T/Z5ikF+a+tjLgCHYYda
	/NEORYYmnc9XlVz+k4OSmyKVrhLyH2ijI0iTvEt6eMBlpWENA6zmROd4FO6zQm3JoCBSG6hF7dJnI
	8231+Czw6j/F89/0XJ3h4z3JkXjMnwFm2q3NwIHkso55ZDxcp9Ww3FeBpopcMctzc0ccMx+KV5EK9
	nzVeoAeQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrxF0-0000000FIPs-2WKH;
	Wed, 03 Apr 2024 09:49:10 +0000
Received: from desiato.infradead.org ([2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDF-0000000Eyta-0y50
	for linux-nvme@bombadil.infradead.org;
	Wed, 03 Apr 2024 08:43:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=Content-Transfer-Encoding:MIME-Version
	:References:In-Reply-To:Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:
	Content-Type:Content-ID:Content-Description;
	bh=YwIwTJWLzlj3JINTC9TTgWbKwrhAt/4WKpGszV+J6xA=; b=m817L9WYaHu2VlUr3CcT4gRoHH
	p4UCQCPZV+EJQcVKKt8Bz9InEsQYj1ns4Th36T0D+apjOynzgub2DZMCqaZGRRL6UdwNJz++64Ql+
	V1Ys1Llj0pijNgSNGpPyL/t8T3jxjE3WVdRINKBmwLydKRCDBC0GUBLHbYkAcoroupG/2Xkn21G+X
	FreEaE425JvA/Oh+1Ggvzeo443IRWOkFR5LXH64nSi1etC1i9d828fAOAt1Kgt3pk99Aq95jcyc4h
	0YX62YwKMsCeV32HXE8Efwu5w9cmLyhKVEM5StXgaPpMlmBMxVq6CXmFAnfFIQxVOik5qX/rZ7XoH
	+O6h+zZg==;
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by desiato.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rrwDB-000000046OE-3Q8b
	for linux-nvme@lists.infradead.org;
	Wed, 03 Apr 2024 08:43:15 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 67CD36135A;
	Wed,  3 Apr 2024 08:43:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0058EC43399;
	Wed,  3 Apr 2024 08:43:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1712133792;
	bh=nMry4ZEBzaq6P0CgjEd5nmJRTc+Xolb7U7Xwyyw7OHM=;
	h=From:To:Subject:Date:In-Reply-To:References:From;
	b=Zcf1z/Ukvtla+eOroIGLzhmvlnYBn0Y8ngI3ICt8I+myvs1MfIltt7Fi1VenfBfXT
	 FTRDIiMd5TuNGkALSXO6hdeQ2MU+ZPIZC0fu+Fos5y9Qx4HurmP+hI3yeVRiyOqhjc
	 OhORF0aHE89c5eLkFpSaXmdqsQuGOM9Rj9SkkpBVvklRLX8YLFsGxGgIGsyp2voIFB
	 isLR1gqnV8wbbIunN2FDUhAAQLV/00PZH/F32SGYYCM0Mxk7DOC4l9sMLRe2rwcsxl
	 /o+D5TqO/FgJ0E5rZ/M+o419Lz3iXEyIFvNZygPy8ZUcqwpR1GVaofeEg+mxAnBVz7
	 R+v2xU5TZLjKQ==
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
Subject: [PATCH v5 14/28] ublk_drv: Do not request ELEVATOR_F_ZBD_SEQ_WRITE elevator feature
Date: Wed,  3 Apr 2024 17:42:33 +0900
Message-ID: <20240403084247.856481-15-dlemoal@kernel.org>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240403084247.856481-1-dlemoal@kernel.org>
References: <20240403084247.856481-1-dlemoal@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240403_094314_083452_29957389 
X-CRM114-Status: GOOD (  12.25  )
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


