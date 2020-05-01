Return-Path: <SRS0=VrRv=6P=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B616C35280
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 21:25:59 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2BB120857
	for <linux-nvme@archiver.kernel.org>; Fri,  1 May 2020 21:25:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="VmN03oLh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C2BB120857
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To
	:From:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=zPkCj6TBMws+/pCzAtBXA3OpZPuVDf7dW66hkgrDYuo=; b=VmN03oLhuG0AHx
	Kwu6VsVTJ11aE0+JfFupUNnApbsbBIz0QSoooiCl3zA5WFeDPk7iP5ZlDfFkcm5xwCWvP9ePIICf8
	1KM2AGbXhAY42FW9fltGaKMYsr+n5OV8Gk733fFb5UdSTqjPa4ZSr9wUYCkUVgCQNk8Tgg2dIVGUc
	JWf3btu2WRyGltjqtWZmZF3PVBxlqO7QvD/Idi7FTByQsX4A1zCQvfFELVqaw/Zse7gDSXFR0QE1f
	SVPRs3TP068GLTaxeJfDb4ootloEcRkVbNxcrBftTH8tsu0uP42s84Fwu3PXMKD+Pcu6h2MpwcwZt
	3f8M+BwNMD5NoS1+xUqg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jUdAL-0002rV-Nv; Fri, 01 May 2020 21:25:49 +0000
Received: from [2601:647:4802:9070:4c3:8135:9a7c:5f17]
 (helo=bombadil.infradead.org)
 by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jUdAJ-0002oR-P1; Fri, 01 May 2020 21:25:47 +0000
From: Sagi Grimberg <sagi@grimberg.me>
To: Christoph Hellwig <hch@lst.de>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org
Subject: [PATCH 0/2 ] nvme-tcp I/O path optimizations
Date: Fri,  1 May 2020 14:25:43 -0700
Message-Id: <20200501212545.21856-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.20.1
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
Cc: Anil Vasudevan <anil.vasudevan@intel.com>,
 Mark Wunderlich <mark.wunderlich@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hey All,

Here are two data-path optimizations that result in a measurable reduction
in latency and context switches.

First optimization is a heuristic relevant for polling oriented workloads
avoiding scheduling io_work when the application is polling. The second
optimization is an opportunistic attempt to send the request in queue_rq if
it is the first in line (statistic sampling reveals that this is often the
case for read-intensive workloads), otherwise we assume io_work will handle
it and we don't want to contend with it. The benefit is that we don't absorb
the extra context switch if we don't have to. Do note that given that network
send operations, despite setting MSG_DONTWAIT, may sleep, so we need to set
blocking dispatch (BLK_MQ_F_BLOCKING).

There are more data path optimizations being evaluated, both for the host and
the target. The ideas came from Mark and Anil from Intel who also benchmarked
and instrumented the system (thanks!). Testing was done using a NIC device from
Intel, but should not be specific to any device.

Representative fio micro-benchmark testing:
- ram device (nvmet-tcp)
- single CPU core (pinned)
- 100% 4k reads
- engine io_uring
- hipri flag set (polling)

Baseline:
========
QDepth/Batch    | IOPs [k]  | Avg. Lat [us]  | 99.99% Lat [us]  | ctx-switches
------------------------------------------------------------------------------
1/1             | 35.1      | 27.42          | 47.87		| ~119914
32/8            | 234       | 122.98         | 239		| ~143450

With patches applied:
====================
QDepth/Batch    | IOPs [k]  | Avg. Lat [us]  | 99.99% Lat [us]  | ctx-switches
------------------------------------------------------------------------------
1/1             | 39.6      | 24.25          | 36.6             | ~357
32/8            | 247       | 113.95         | 249              | ~37298

Sagi Grimberg (2):
  nvme-tcp: avoid scheduling io_work if we are already polling
  nvme-tcp: try to send request in queue_rq context

 drivers/nvme/host/tcp.c | 49 +++++++++++++++++++++++++++++++----------
 1 file changed, 37 insertions(+), 12 deletions(-)

-- 

2.20.1


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
