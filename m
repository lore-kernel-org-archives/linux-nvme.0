Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36C83C433E1
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:09 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08F35206F6
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="l05qTEa5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08F35206F6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/7MEQwDu+nlP+et07WD7xCjfc5yYpO3+tec6ObYuuSo=; b=l05qTEa5rRG4kbF68Mf6oGGOGN
	N85ykmtv/0Wdhk1q15MqdbxLUVjS4tqCXe//uj5gRYcmS69HIXdiFmKvb6zovmYELdBy/QZC6kM/A
	WaGJtQFwTRN8Aerjoe/lTL29BvKXNZyryebrOygZLhUHVKODIn5iZXS03NzJL9TJjQKNtwJPIGfU/
	MLOJyz1N5h/2lkP4Vg8bxAN5vptDEvxn1oPvctMDH0PHEVpQzEuW0KPvhLsxIpWSk+FQy+y8K5PgU
	lgUZBZHA7FfEeUTCHD3FmKgWh/r93nGh/UbI0eSsj/390e+W7B2sVvJBqjZiwOTszxOSCjD5BPruC
	+M4LNvJA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UR5-0004rn-77; Mon, 03 Aug 2020 06:59:03 +0000
Received: from mail-wr1-f65.google.com ([209.85.221.65])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UR2-0004qx-5h
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:59:00 +0000
Received: by mail-wr1-f65.google.com with SMTP id r2so28031724wrs.8
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:58:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=VbkFBnJjf8SXl074m2Kazik+By6OfqCKHXhWWOlC9i0=;
 b=uAkZcaB7zqsuclLEefmPb+noun5lrkef2rqw7JJYIPJOMWf7C28C2f8Yw/kNu+tlC7
 COiMjiC8hvabs95BmlppJL+kQxJ1N6mkF77u8pScwHLWOVHKtpmkC4Tk+5xyMIwk+o8H
 2eAXSCt65JwGZU/ZA67FMUluCG6gnaxguDCrqcTtYj7cqKsfvm99KM/WvF56MOdNVpz7
 oWqfeMfditMmfazmAflRkrAp8mj99E3+yfPTirBW9tTB2vTb4IrLqQgDMniEtxyh+Sgq
 a1YT7D/SGfg3ybuPBraveAYeN5JDF0ljcVWTl2PPVwWC5pkb3o6/R++w+di/67Kqp8Hv
 ibGQ==
X-Gm-Message-State: AOAM533o2q9hPp8+B8TnPl4vpNfyjtGVUsOCw/uoNk5bl+JYChyy4X9m
 JT/+IAfETLRxGhx9IXoLZFQ8dPF2
X-Google-Smtp-Source: ABdhPJx0PTa2Row6Rz/PcDSQ+dAUHZq9hkowNeehIjbi52tcmL0+UZ7Eu1AVa1J1J9G2cjBWSzJ9dQ==
X-Received: by 2002:a5d:5004:: with SMTP id e4mr13935481wrt.359.1596437938924; 
 Sun, 02 Aug 2020 23:58:58 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id c15sm21574511wme.23.2020.08.02.23.58.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:58:58 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH 0/6] fix possible controller reset hangs in nvme-tcp/nvme-rdma
Date: Sun,  2 Aug 2020 23:58:46 -0700
Message-Id: <20200803065852.69987-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_025900_267495_EB03AB18 
X-CRM114-Status: GOOD (  13.87  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

When a controller reset runs during I/O we may hang if the controller
suddenly becomes unresponsive during the reset and/or the reconnection
stages. This is due to how the timeout handler did not fail inflight
commands properly and also not being able to abort the controller reset
sequence when the controller becomes unresponsive (hence can't ever
recover even if the controller ever becomes responsive again).

This set fixes nvme-tcp and nvme-rdma for exactly the same scenarios.

Patch 1 prevents commands being queued fora  live queued, making
commands mistakenly getting requeued forever while we are either
resetting or connecting to a controller.

Patches 2,4,6 address the case when a controller stops responding when
we are in the middle of a connection establishment stage (tcp and rdma).

Patches 3,5 rework the timeout handler to fail commands (and allow them
to either requeue or fail) in case the controller is not responsive when
we are in the middle of reset (teardown) or establishment (connect
sequence).

James, please have a look to patch 1, this relates to the discussions
we had recently. We still keep the admin commands with a guard, but
that would be addressed in a follow-up set.

Sagi Grimberg (6):
  nvme-fabrics: allow to queue requests for live queues
  nvme: have nvme_wait_freeze_timeout return if it timed out
  nvme-tcp: fix timeout handler
  nvme-tcp: fix reset hang if controller died in the middle of a reset
  nvme-rdma: fix timeout handler
  nvme-rdma: fix reset hang if controller died in the middle of a reset

 drivers/nvme/host/core.c    |  3 +-
 drivers/nvme/host/fabrics.c | 13 +++---
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    | 78 ++++++++++++++++++++++++++---------
 drivers/nvme/host/tcp.c     | 81 +++++++++++++++++++++++++++----------
 5 files changed, 130 insertions(+), 47 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
