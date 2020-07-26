Return-Path: <SRS0=KTc9=BF=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A378C433EA
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:18 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09841206D7
	for <linux-nvme@archiver.kernel.org>; Sun, 26 Jul 2020 00:23:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="F7N+tbKB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09841206D7
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4NfxS9TonNkLtC+R4rEa0n2mM2h+YRoitV/8RDpzG/U=; b=F7N+tbKBr0P9mYGAwaM2d1RM+E
	oh/XOwleY/76uz+Qs0BTFan9afuD6yMdlCs9rt2N9FVbpywbqttPWm0B4NLvM1fVZ7nfMw5pUgR0Z
	qlF5a6Pewu8NGgS7dNwTJEOQgnLiE8hIwle2uUh/HsGI6zMznAJlDm7fKUfFwr189dvNpIivN9xYT
	ee09iWTeXhMbbvrnm/vt2E7ka8wbtEOofQ/untuirr8zRPAa0046rrADV7jXTj2uuFm4z4iRvVIfp
	hoa8JLJNyRTaDFkG90VZ9JygUBqiLFGbrR/xiiNe2xgPGGDoqNkJ4lSroMhSVMo1oyRqQoDFRB6Re
	CIRD7N6Q==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jzURZ-0007wL-NU; Sun, 26 Jul 2020 00:23:09 +0000
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jzURW-0007v4-Ir
 for linux-nvme@lists.infradead.org; Sun, 26 Jul 2020 00:23:07 +0000
Received: by mail-pf1-f194.google.com with SMTP id s26so7182032pfm.4
 for <linux-nvme@lists.infradead.org>; Sat, 25 Jul 2020 17:23:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Zov0rmybKEV0FzMtRbguhfxoEydQHEwBnfQeWkxGBD4=;
 b=TCIQkfp2tWZ4mq0NMG4FeB7OmcDNeqgaeQMEWerjZ0q3Z7ofSA2XoyljQRiYy/nz57
 ssM+wCttzYKWTOCVA/McDEwns1anD/MF8C3h12Cfh7sEeWO6A1queCIpBpI73fRD8eJ1
 JX4OTBYgjTYpbruHBSZiwaCvsigv7f5EzemctGbE1X88Dbc44VVQd7Bdq+GvB1SJT0Oz
 FzYIiiXDc8GPLy6UlepRN6m446ONddKpwmcD7CZ/rNw2Mh2eY7BNmag+j6y6sYkA/UWO
 RLwvWpnFq7+uOUMQxZc0jOZKFG4S4GQwWfIzzR2AQEdLbTgnDtUfgfKDwa3oZvxA0Jru
 nyjw==
X-Gm-Message-State: AOAM531JofnOjwuYVCM/QGQnXK2+slovBI4BYQrJMWKq/G/wR2fbbNol
 Esg6iGGtCZlgEOh6uZuqIfsXpAiZ
X-Google-Smtp-Source: ABdhPJwcEDqhV+qtgHezjEOLgjMywYa8dBy4Jvq5qgrInC1mzqtKrpsIJjl6TpwgAP5K6EXMsIJeXg==
X-Received: by 2002:a63:4419:: with SMTP id r25mr13648955pga.198.1595722984965; 
 Sat, 25 Jul 2020 17:23:04 -0700 (PDT)
Received: from sagi-Latitude-7490.hsd1.ca.comcast.net
 ([2601:647:4802:9070:c428:8d39:30dd:38a5])
 by smtp.gmail.com with ESMTPSA id z62sm10185620pfb.47.2020.07.25.17.23.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 25 Jul 2020 17:23:04 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH v3 0/2] improve quiesce time for large amount of namespaces
Date: Sat, 25 Jul 2020 17:22:59 -0700
Message-Id: <20200726002301.145627-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200725_202306_663302_ABDB80B5 
X-CRM114-Status: UNSURE (   9.20  )
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
Cc: linux-block@vger.kernel.org, Chao Leng <lengchao@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This set attempts to improve the quiesce time when using a large set of
namespaces, which also improves I/O failover time in a multipath environment.

We improve for both non-blocking hctxs (e.g. pci, fc, rdma) and blocking
hctxs (e.g. tcp) by splitting queue auiesce to async call_(s)rcu and
async_wait to wait for it to complete.

Changes from v2:
- made blk_mq_quiesce_queue_async operate on both blocking and
  non-blocking hctxs.
- removed separation between blocking vs. non-blocking queues
- dropeed patch from Chao
- dropped nvme-rdma test patch

Changes from v1:
- trivial typo fixes

Sagi Grimberg (2):
  blk-mq: add async quiesce interface
  nvme: improve quiesce time for large amount of namespaces

 block/blk-mq.c           | 32 ++++++++++++++++++++++++++++++++
 drivers/nvme/host/core.c |  4 +++-
 include/linux/blk-mq.h   |  4 ++++
 3 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
