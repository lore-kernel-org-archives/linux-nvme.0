Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2A8EC433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:45 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 224E12173E
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:11:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="1t2c+9Ba"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 224E12173E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=lKOsFkLuPZVmXUKJeRDDDiG8B1CbLMMlSlkC6Agv6TA=; b=1t2c+9BaM3ZUyO2HGzDmDZeizQ
	98vCbeWprq9CWsWfG3d3bWDwrMwq1a6hgshiO3RU3zJkWpWd2+mKF6d4HpV2Le7LrFIyfRxJhvQzp
	1+KqSe9PnCptu2eCFSmO2lzfqn3Fyuq63kiWUKQC02Q1xr1NpCWRjo0azyqeZJRHxjsN19RDtgKdJ
	eX8ZHm1skdo04cq9TrKP6niA4yobtHLn2PZBDUKubtfCTauO/jWzJQuSXJ8ygHnscER+m/sBXwL0K
	bnMzgG2jBEYgeqvAZrhfqx4S9bPrHJJjHoi+d9YUfe7I9MgOBKAZn0SRugEfoB/RiO89Sz3DlbKPn
	SSn2LUQA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lIh-0008BH-Cz; Thu, 06 Aug 2020 19:11:39 +0000
Received: from mail-pf1-f196.google.com ([209.85.210.196])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lId-00088Y-Ug
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:11:36 +0000
Received: by mail-pf1-f196.google.com with SMTP id s26so25622303pfm.4
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:11:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pcUIrzLA78+SPsYny5CcV0djp58mUwgOjXrhsF6Pv3A=;
 b=r8dbcAhORCcs/kqD4doFxxEYLmk7fc0ez6CQ0NBwM4kBYmUtpFCDEpMncAwy/pm2OK
 OV4bL228v3mIH+0WzfhbZkd5j7pLDNksgpXbJLSLLeinOC1PnpDh4SU3Iq3u8JdLzeMT
 9SZlSc10/AJnPDpW0UUw1EDPVD9ezNu/oI0Pss0mY9Fase32F3UD4FD7spuJqInMtOT7
 ni1/qiKn4gkGwPZgtMKvnHO89Q69VfmWd5r+rnFpxwDxT2eiHvuJiozqXRqOuKTxCDcU
 6HuOaoJJ3w7jdt6/pG39nH3rn6HBZM8Ei+pJ0mbPvGk1aXaB9uyDrzWPjluafHjbg+Ow
 XEAQ==
X-Gm-Message-State: AOAM5312AL6JLsVfoDA4bG+SAAu9iLISlFbAUCokdaUdP0O7nu13gi51
 tHQ0opV1EWF+NkdjrUz2s23tAuQy
X-Google-Smtp-Source: ABdhPJz/0XrBo71MMAw51CNyz4eOaECqHAdik2Pk7kEhcOHr12qDky5EazU4Wrx7ePjICUkot4blQg==
X-Received: by 2002:a63:1962:: with SMTP id 34mr8566695pgz.411.1596741090281; 
 Thu, 06 Aug 2020 12:11:30 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id gn13sm7801348pjb.17.2020.08.06.12.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:11:29 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, James Smart <james.smart@broadcom.com>
Subject: [PATCH v2 0/8] fix possible controller reset hangs in
 nvme-tcp/nvme-rdma
Date: Thu,  6 Aug 2020 12:11:19 -0700
Message-Id: <20200806191127.592062-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151136_015001_98706EE7 
X-CRM114-Status: GOOD (  12.90  )
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

Patch 1 prevents commands being rejected by a live queue, making
commands mistakenly getting requeued forever while we are either
resetting or connecting to a controller.

Patch 2 lets consumers know if the freeze completed or a timeout
elapsed, will be used in patches 5,8.

Patches 3,4,6,7 fix the timeout handler in nvme-tcp and nvme-rdma
respectively to correctly and safely fail requests that are a
part of a serial (blocking) initialization or teardown sequences.

Patches 5,8 address the case when a controller stops responding when
we are in the middle of a connection establishment stage (tcp and rdma).

James, please have a look as well to see what needs to be addressed
for fc.

Changes from v1:
- added patches 3,6 to protect against possible (but rare) double
  completions for timed out requests.

Sagi Grimberg (8):
  nvme-fabrics: allow to queue requests for live queues
  nvme: have nvme_wait_freeze_timeout return if it timed out
  nvme-tcp: serialize controller teardown double completion
  nvme-tcp: fix timeout handler
  nvme-tcp: fix reset hang if controller died in the middle of a reset
  nvme-rdma: serialize controller teardown sequences
  nvme-rdma: fix timeout handler
  nvme-rdma: fix reset hang if controller died in the middle of a reset

 drivers/nvme/host/core.c    |  3 +-
 drivers/nvme/host/fabrics.c | 13 ++++--
 drivers/nvme/host/nvme.h    |  2 +-
 drivers/nvme/host/rdma.c    | 85 +++++++++++++++++++++++++--------
 drivers/nvme/host/tcp.c     | 93 ++++++++++++++++++++++++++++---------
 5 files changed, 147 insertions(+), 49 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
