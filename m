Return-Path: <SRS0=WpAz=AF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6475BC433E0
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:53:25 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 320D9207DD
	for <linux-nvme@archiver.kernel.org>; Wed, 24 Jun 2020 08:53:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="PYHwvoh2"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 320D9207DD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OVWdp3UJJuzLoJzqUs8sb+W0QUnP+4TkHNkUz8KaVhc=; b=PYHwvoh2KNp+uwDZorw6pmBxIu
	3Ll11lkpCehDIBzkdxMqBixVLfQpQ3wUklduE/UtZADPP7TZwWOC/D2D2k65KlrKtxjf+LkY8M22B
	yUg/zThgbv6O8+LAUEm4ufZGqu3qk5BBjRO+nwZ2fB7IsjcE7kaZIJxCcazSQuqNuem8+n2J0mXAF
	R4P2WX51iyRsAvgOwhf/12mWGw9C9O/e65ZzBT6QgS6dRXPv0btpNkECa07OcM4NZkm3+tjzP+XkT
	H78MTTBtPRGUrKmAg4fF8f96MIsv2+GjmrUWuTTotpcOvRdsz1v7S3vrNWnsxRwcDuVLM8xTscmTy
	OzMOXC1Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jo19m-00062B-So; Wed, 24 Jun 2020 08:53:22 +0000
Received: from mail-pf1-f193.google.com ([209.85.210.193])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jo19k-00060h-D2
 for linux-nvme@lists.infradead.org; Wed, 24 Jun 2020 08:53:21 +0000
Received: by mail-pf1-f193.google.com with SMTP id b16so852587pfi.13
 for <linux-nvme@lists.infradead.org>; Wed, 24 Jun 2020 01:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JuJvCvAx7a81hyWZlYzhPsfOtiMHOraF58aX8udPzOA=;
 b=s+h9t3LyhMMTHTqqg/jErD0I8StbeAkPotlKYwNVuQC9uu7QeazqVHWv4KGDrR92wa
 EihM4beJz17/wuaOiouFmFNZvJAiMN/RogEFb0VNUgNEjGgxiEHuqc7JOpAOBmAknw2c
 w/KTHongIUBZKi2qxUFz4DIWdbIs0/uhayfQGSsiMm5dl09+m1dPzvwJVar9497EulFS
 imcIebe/tzRoHGRcgbhSX8fT626FNOoZEgGrPuYchSIRkr09FnDUi+d8LBIAGxTlGgs4
 PoUNFlBRv5aqQ+eyBoBh3jtNR9fwkhSh+vKPngP+HHYWmZ1JmQQmWTnyQncdWknbgps0
 LPEA==
X-Gm-Message-State: AOAM533lTsy6TrkxMFyFV2MZrlYcgTMV+q8T7QbSPAxl/jiU+6mrrpEU
 RnoKUws/yd7O+UC+t3RCIaDE6bS7
X-Google-Smtp-Source: ABdhPJxPqcoKNBtGZ44e7zJubOmVPm6rSeIl/4j02BTljwuBj8qnJS+cSHSUOnPq/rzvLRu4opcE7Q==
X-Received: by 2002:a63:dc13:: with SMTP id s19mr20400692pgg.53.1592988797529; 
 Wed, 24 Jun 2020 01:53:17 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:9915:87a9:9728:63e])
 by smtp.gmail.com with ESMTPSA id m14sm4600814pjv.12.2020.06.24.01.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 24 Jun 2020 01:53:16 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>
Subject: [PATCH v3 for-5.8-rc 0/5] address deadlocks in high stress ns
 scanning and ana updates
Date: Wed, 24 Jun 2020 01:53:07 -0700
Message-Id: <20200624085312.35967-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
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
Cc: Anton Eidelman <anton@lightbitslabs.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Changes from v2:
- removed RFC patch #6 from the series
- patch #1: updated change log
- patch #2: renaming and nit restructuring in patch #2
- patch #3: Clarified change log and move srcu and requeue_work scheduling
  outside of the head->lock 
- patch #4: renamed flag to NVME_NSHEAD_DISK_LIVE

Changes from v1:
- Fixed compilation error in patch #4
- Added patch #5 to resolve a use-after-free condition

Hey All,

The following patches addresses some deadlocks observed while performing some
stress testing of a connect/disconnect storm in addition to rapid ana path
switches concurrently (paths may transition between live<->inaccessible)
on a large number of namespaces (100+).

The test mainly triggers three main flows:
1. ongoing ns scanning, in the presence of concurrent ANA path state changes
   and controller removals (disconnect).
2. ongoing ns scanning (or ana processing) in the presence of concurrent
   controller removal (disconnect).
3. ongoing ANA processing in the presence of concurrent controller removal
   (disconnect).

What was observed is that basically when we disconnect while scan_work and/or ana_work
are running, we can easily deadlock. The main reason is that scan_work and ana_work
may both register the gendisk, triggering I/O (partition scans). Given that a
controller removal (disconnect) may also be running at the same time, I/O may
block. The issue with blocking the head->disk I/O under the locks taken by
both ana_work and scan_work, it means that no other path may update path states
and by doing so, unblock the blocking I/O.

With this patchset applied (plus the missing RFC patch that we dropped)
the test is able to pass successfully without any deadlocks.

Anton Eidelman (2):
  nvme-multipath: fix deadlock between ana_work and scan_work
  nvme-multipath: fix deadlock due to head->lock

Sagi Grimberg (3):
  nvme: fix possible deadlock when I/O is blocked
  nvme: don't protect ns mutation with ns->head->lock
  nvme-multipath: fix bogus request queue reference put

 drivers/nvme/host/core.c      |  1 -
 drivers/nvme/host/multipath.c | 46 ++++++++++++++++++++++-------------
 drivers/nvme/host/nvme.h      |  2 ++
 3 files changed, 31 insertions(+), 18 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
