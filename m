Return-Path: <SRS0=y1aL=4R=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C007C3F2D2
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Feb 2020 02:52:53 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E1FBE24697
	for <linux-nvme@archiver.kernel.org>; Sat, 29 Feb 2020 02:52:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qwd7rvwT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E1FBE24697
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=joshtriplett.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=SSu8xfavcRBuSB6vHJh+hyR7a1WvKW1s7ngTbRIYv7U=; b=qwd7rvwTP1VW4m
	Yekke4Q2FOtugtR0JMaU1s9Dincm1GkV5MB+P6HuVwoMLTuxWj/NXplNsFmHp9lOjRfIqXYJWjBbt
	LF/kMxqLagpPNzgRn8XEYlTLiyFF8w+u02In+Byxk+LJD1DNVBJHNRF7jswHzhuQ+fZITGjXqfDj2
	tsqGYum2CfWwtPfMLks54ycKT8uMNDB+nD1uYo8ntYzdTzzGm2E6GcUewGwmo7leQq/XJhM/PArXN
	ehfVsGfE+o/Q9N5xSoipf5nnvLiqLcM7Z8+gUM1jVisKKi+9nG9axAtY9EuBPvrQ4Hl2mA362CRTV
	lrRkWXfoqO6mo0oPTLQQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1j7sFD-0004tn-HP; Sat, 29 Feb 2020 02:52:47 +0000
Received: from relay12.mail.gandi.net ([217.70.178.232])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1j7sFA-0004tJ-SR
 for linux-nvme@lists.infradead.org; Sat, 29 Feb 2020 02:52:46 +0000
Received: from localhost (c-71-238-64-75.hsd1.or.comcast.net [71.238.64.75])
 (Authenticated sender: josh@joshtriplett.org)
 by relay12.mail.gandi.net (Postfix) with ESMTPSA id 3EC1F200007;
 Sat, 29 Feb 2020 02:52:30 +0000 (UTC)
Date: Fri, 28 Feb 2020 18:52:28 -0800
From: Josh Triplett <josh@joshtriplett.org>
To: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH] nvme: Check for readiness more quickly, to speed up boot time
Message-ID: <20200229025228.GA203607@localhost>
MIME-Version: 1.0
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200228_185245_054607_BDEDD0AC 
X-CRM114-Status: GOOD (  11.72  )
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
Cc: linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

After initialization, nvme_wait_ready checks for readiness every 100ms,
even though the drive may be ready far sooner than that. This delays
system boot by hundreds of milliseconds. Reduce the delay, checking for
readiness every millisecond instead.

Boot-time tests on an AWS c5.12xlarge:

Before:
[    0.546936] initcall nvme_init+0x0/0x5b returned 0 after 37 usecs
...
[    0.764178] nvme nvme0: 2/0/0 default/read/poll queues
[    0.768424]  nvme0n1: p1
[    0.774132] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)
[    0.774146] VFS: Mounted root (ext4 filesystem) on device 259:1.
...
[    0.788141] Run /sbin/init as init process

After:
[    0.537088] initcall nvme_init+0x0/0x5b returned 0 after 37 usecs
...
[    0.543457] nvme nvme0: 2/0/0 default/read/poll queues
[    0.548473]  nvme0n1: p1
[    0.554339] EXT4-fs (nvme0n1p1): mounted filesystem with ordered data mode. Opts: (null)
[    0.554344] VFS: Mounted root (ext4 filesystem) on device 259:1.
...
[    0.567931] Run /sbin/init as init process

Signed-off-by: Josh Triplett <josh@joshtriplett.org>
---
 drivers/nvme/host/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index a4d8c90ee7cc..04174a40b9b0 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -2074,7 +2074,7 @@ static int nvme_wait_ready(struct nvme_ctrl *ctrl, u64 cap, bool enabled)
 		if ((csts & NVME_CSTS_RDY) == bit)
 			break;
 
-		msleep(100);
+		usleep_range(1000, 2000);
 		if (fatal_signal_pending(current))
 			return -EINTR;
 		if (time_after(jiffies, timeout)) {
-- 
2.25.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
