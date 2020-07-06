Return-Path: <SRS0=+gr8=AS=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23875C433E1
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:21:58 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DE979206E6
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jul 2020 00:21:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s3IzMqxw";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CJYM2UNW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DE979206E6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=wdc.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Dz7LJNJbbApDcL2iKTtOIZw+bRIp05k/7In07uACZ+E=; b=s3IzMqxwT35xkfsOmhNAnmyBLZ
	wy5UKQ3QZdSpCo0ECfxLIfN2J8eKNH1mLulJrIZTDwLnR+owunNPNiFKVFiKJ6OYX600zpg/8eyso
	PvjUrc9GyYfP61zVRgUsb4Q1xJynZ82ccwk9WGRhwTDjQIb3M600lcutZXpBm5isPLWpxttk0qGHr
	wpFeJvMeVytczfQv9DBlPhVKf6Hd4BhNerGVikJBnNoPtTAGZme61YweAEbCapm6RXXTVxyNkSg1U
	Mv8lIPvN3U4UXzXWr4LRXgL0tAzC4BI6j3D1YwQcnwusfsgXnsFkd+ETn0tcA8pJbMGegzHjPfXyb
	YFL0P1yw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jsbMu-0001gN-4w; Tue, 07 Jul 2020 00:21:52 +0000
Received: from esa1.hgst.iphmx.com ([68.232.141.245])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jsbMr-0001fy-Kv
 for linux-nvme@lists.infradead.org; Tue, 07 Jul 2020 00:21:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
 d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
 t=1594081309; x=1625617309;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=T/JPuBTRz+X2z+vSgZojRHT6NicgdILmFzytMYwxyAc=;
 b=CJYM2UNW8lhSjmPY0IaWYQDCN8BIxdH6fGs/pcd4o0giseoE7Kvh3dOW
 h7FmNM9VcBrXNX7m6WF/k5s8d+VzFaAZHCrs6PVWcgUee+fzLHQVqRRqR
 5XyAANd3v04refZ6btgNjdGo4RfbZf0nNPrVowWrZKcCJ+6My4/6DyBsa
 03wfXq/kQuN+/kv2YNNI+Q8o8meWcFEjSzwR/50nrq3c7gBjSD3tPctFJ
 wc8GdzMq2RtpQ3a5N2SuQKGGhcgIijZXyP3S8i896MYKxrhYHbaFEfrZT
 Gba3r1liPdVHeKbjKbpaef2kJX+K2EFsDBC9TMd4g8/Ms+P96KGeYa/Qj g==;
IronPort-SDR: fvSK+rKiyamCPDgZrDfurNw5y+eLIh+Y0+thkJdyTx9EpXoYSFTa7/kMCnl/2mlg/n98zVp/SJ
 0Ah7xi9wm21cw84D06VxwWZtUOX17mCvV1T38eQdKcbcCNrhgvRkyL9xotTOhGwqGyfeGNbLGX
 oxiInFiofAMeakXm0U4gLLVXfNHyy/XoyMmNWPsu6MrEZ6zIXV+oliHcyyKLyCnciYS90o8RbE
 ewCTiOO2hD03MJeHD5GDBXInvUSbpLUgI0WOVXBjNQabns91wdNg0DoZMaKY6BN18U7pv4JtSb
 VJw=
X-IronPort-AV: E=Sophos;i="5.75,321,1589212800"; d="scan'208";a="251010517"
Received: from uls-op-cesaip01.wdc.com (HELO uls-op-cesaep01.wdc.com)
 ([199.255.45.14])
 by ob1.hgst.iphmx.com with ESMTP; 07 Jul 2020 08:21:47 +0800
IronPort-SDR: zNqZVHURLQaZoJZalYd3QBKVmEUt+sRB0ZBTD6Y+GxotDm1xwar4Gps0I+tYMe0fP1wJpzpw+X
 LuFAoKSsD/5OiQCaz4bFtrd1OzkexApOo=
Received: from uls-op-cesaip02.wdc.com ([10.248.3.37])
 by uls-op-cesaep01.wdc.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 06 Jul 2020 17:10:27 -0700
IronPort-SDR: buxChONGN4i/0Gn2k3211zOTcsbddj1U/+SCBXRIIPxiSirB4w8MWQS0nEHgs/zYQSh1ll70Fg
 IcKkO7GDVfAw==
WDCIronportException: Internal
Received: from ioprio.labspan.wdc.com (HELO ioprio.sc.wdc.com) ([10.6.139.89])
 by uls-op-cesaip02.wdc.com with ESMTP; 06 Jul 2020 17:21:47 -0700
From: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To: hch@lst.de, james.smart@broadcom.com, kbusch@kernel.org, sagi@grimberg.me
Subject: [RFC PATCH 0/5] nvme: reduce repetitive calls in fast path
Date: Mon,  6 Jul 2020 16:15:19 -0700
Message-Id: <20200706231524.16831-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.22.0
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200706_202149_943190_EE59FBCC 
X-CRM114-Status: UNSURE (   8.42  )
X-CRM114-Notice: Please train this message.
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
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Christoph/James/Keith/Sagi,

While reviewing other patch-series I found that there are repetitive
calls to blk_rq_nr_phys_segments() in the fast path for NVMe Transports 
(pci, rdma, fc, loop). We should try and avoid as many repetitive checks
in the fast-path as possible.

This patch-series reduces multiple calls and minimizes the repetitive
checks in blk_rq_nr_phys_segments() for NVMe transports.

P.S. Tagging it as an RFC since I've not tested rdma/tcp/fc part, if we
agree to get this in I'll put more effort in testing.

Regards,
Chaitanya

Chaitanya Kulkarni (5):
  nvme-pci: reduce blk_rq_nr_phys_segments calls
  nvme-rdma: reduce blk_rq_nr_phys_segments calls
  nvme-tcp: reduce blk_rq_nr_phys_segments calls
  nvme-fc: reduce blk_rq_nr_phys_segments calls
  nvme-loop: reduce blk_rq_nr_phys_segments calls

 drivers/nvme/host/fc.c     | 20 ++++++++++----------
 drivers/nvme/host/pci.c    | 18 ++++++++++--------
 drivers/nvme/host/rdma.c   |  8 ++++----
 drivers/nvme/host/tcp.c    | 10 +++++-----
 drivers/nvme/target/loop.c |  6 +++---
 5 files changed, 32 insertions(+), 30 deletions(-)

-- 
2.22.0


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
