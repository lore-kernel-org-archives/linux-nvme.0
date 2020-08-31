Return-Path: <SRS0=W+Vz=CJ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D5EC433E7
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 15:30:05 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AF4C214D8
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Aug 2020 15:30:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="APilCP9r";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="za9rohno"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AF4C214D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Message-Id:Date:
	Subject:To:From:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=G+zQsizSndOm4B/AX2CoINQnkQv8htFvhqkVptM1qnc=; b=APilCP9rDDCCG28mhfm+sKpdc
	1PgcR6/87b6RepmFhRChjcx1fhdE0iLSub5XldwZ1uT7LeHnXVdL9kKm8Rw8okIIdaKL4GNvnQqsF
	y1WK3JGhPQvrVDzsqRwBimhh0pQFSUddSOycLIrPtFtyu7MVmlmKuZlxGCWzNW5cwvMA226z44AFZ
	QllLdZWUX0o5wsABTMfnv5N8FHdH0Zke56Fx4ho+AgLal912uTlSViKhVfioT6m6s7qB2CW+tleJJ
	KXwMo1Bdwxdd/QgOG+lzAl3Sa2LVa4qlahOvfEPtpuUlOT/tmJKsrBuxF9rfUkHp1HFrP53BuzI4F
	eXoWuHPbQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kClkr-0000b6-Ey; Mon, 31 Aug 2020 15:29:57 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kClkn-0000ZN-Ke
 for linux-nvme@lists.infradead.org; Mon, 31 Aug 2020 15:29:54 +0000
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net
 [73.47.72.35])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 3BD7C20767;
 Mon, 31 Aug 2020 15:29:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1598887793;
 bh=Va+uG3982E/A+B5LOqE36PWBGeYhfsCtVJhExIKAmXE=;
 h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
 b=za9rohnoRqlV6zkmXx7+X0B8qbEjhsDVHGtNoTAhB5nm8TUle5PcOdlgm8AOJ4qKy
 DRrp+lLS81VyOB1G9ZA0LPXsiX0oG/HTO6Kq0hKCWORq4b1XvYSEU2pjMqRW6QGqS7
 P3svqIMya753FiOhvlq5ruwqnHhygZ614cBRK1SQ=
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH AUTOSEL 5.8 11/42] nvme: skip noiob for zoned devices
Date: Mon, 31 Aug 2020 11:29:03 -0400
Message-Id: <20200831152934.1023912-11-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200831152934.1023912-1-sashal@kernel.org>
References: <20200831152934.1023912-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200831_112953_846001_A686A1B8 
X-CRM114-Status: GOOD (  15.32  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
 Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

From: Keith Busch <kbusch@kernel.org>

[ Upstream commit c41ad98bebb8f4f0335b3c50dbb7583a6149dce4 ]

Zoned block devices reuse the chunk_sectors queue limit to define zone
boundaries. If a such a device happens to also report an optimal
boundary, do not use that to define the chunk_sectors as that may
intermittently interfere with io splitting and zone size queries.

Signed-off-by: Keith Busch <kbusch@kernel.org>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f38548e6d55ec..6ea0bab621df3 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1975,7 +1975,7 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 		}
 	}
 
-	if (iob)
+	if (iob && !blk_queue_is_zoned(ns->queue))
 		blk_queue_chunk_sectors(ns->queue, rounddown_pow_of_two(iob));
 	nvme_update_disk_info(disk, ns, id);
 #ifdef CONFIG_NVME_MULTIPATH
-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
