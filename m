Return-Path: <SRS0=CEZP=BQ=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 793D1C433E0
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:30 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 936762177B
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Aug 2020 19:15:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="J228TWeV"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 936762177B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=eVPBs1jB3HomXHv5tWl7yi+8u2l1b9yBmfGMdF9TQSo=; b=J228TWeVqlvsAl3rDmneDX+VU2
	muA57UUCM4v0T6WWYRyC++pzyzg1Q/UUypIXeG2Rqih7ZVuPkMu4iGSBH6lml4lvb316YRLlqm/fN
	/dkS6UxSb9grX1YMbV+UCLhlGx6yfkbELuySIDmxSPOZNmIBy56i89aRk5a1N75nUdR6BwKDoBAlf
	JReKhPcp31Bzp4j7J5+pMfADlje35zspRSv7CXf3OSBZZuh4acLiFGXB7aY+cl74sZKWCDrsIsQS1
	zbnSaVA4+k6X0kKJZUo0fKg+ou0urobRN9lL4ZXW0cwx/hF1BoZfAM4vcGjOvTxpRPTj2OioNVuAN
	ZpAU2vgA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k3lMM-0000xL-V9; Thu, 06 Aug 2020 19:15:27 +0000
Received: from mail-pj1-f43.google.com ([209.85.216.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k3lMJ-0000vR-LL
 for linux-nvme@lists.infradead.org; Thu, 06 Aug 2020 19:15:24 +0000
Received: by mail-pj1-f43.google.com with SMTP id mw10so3470732pjb.2
 for <linux-nvme@lists.infradead.org>; Thu, 06 Aug 2020 12:15:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=JypsJ0h7s72m23H6GigPawWwJJNonSHqnIBYNNnmBSo=;
 b=Mkm/7K32/3NjwgVt6j9OQrdXg4hM9W8AEcqnUugRgBdLAazYXgvexFoErfgXg4FufG
 Dg+BQzFjCQe57bup79DZATpzOJhlTqk88amLMzgqVYJ4BhwLU1Kni1LvmsG7a3ZLZhOJ
 m+1euVJ/HVylfH2oISuFz/jruLa1zFVl7YIV1ZnbDcVMIvCTvPRUFgMVsnG0F26TSZS3
 j16habz6lrpozmpKBgG4dZ8ydwUgohRklI+J1+MMC9kPAUcf05VJVAOwGgtPkeIc/1zG
 +6PTakRmbSDchBAygSDxtB93CAgOElOqxMLORpZTSFQYHY5yCm8QqfWDJ7NtYa6hI2Gp
 C2Bg==
X-Gm-Message-State: AOAM533OyxtBIC0hZa0nta2ZQPGkYmUCLw6Gsjuzv8qZuh9Z8or1/Fap
 9WI1H4B0Hdg1t+mF2lZ4cUr+Niik
X-Google-Smtp-Source: ABdhPJxYYSrd/dTe+3M2cP56OgT9CkGaJH2lfqWcW1dGHPbAlKUeQmoHJHIntb3i5CEr+AV1DcS7Qg==
X-Received: by 2002:a17:902:d303:: with SMTP id
 b3mr9404776plc.101.1596741321078; 
 Thu, 06 Aug 2020 12:15:21 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:d88d:857c:b14c:519a])
 by smtp.gmail.com with ESMTPSA id q16sm9784014pfg.153.2020.08.06.12.15.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 06 Aug 2020 12:15:20 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v2 0/7] blktests: Add support to run nvme tests with tcp/rdma
 transports
Date: Thu,  6 Aug 2020 12:15:11 -0700
Message-Id: <20200806191518.593880-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200806_151523_750937_63DACF94 
X-CRM114-Status: GOOD (  11.92  )
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
Cc: Keith Busch <kbusch@kernel.org>,
 Johannes Thumshirn <Johannes.Thumshirn@wdc.com>,
 Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We have a collection of nvme tests, but all run with nvme-loop. This
is the easiest to run on a standalone machine. However its very much possible
to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
tests with a new environment variable to set the transport type $nvme_trtype.

$ nvme_trtype=[loop|tcp|rdma] ./check test/nvme

This buys us some nice coverage on some more transport types. We also add
some transport type specific helpers to mark tests that are relevant only
for a single transport.

Changes from v1:
- added patch to remove use of module_unload
- move trtype agnostic logig helpers in patch #3

Sagi Grimberg (7):
  nvme: consolidate nvme requirements based on transport type
  nvme: consolidate some nvme-cli utility functions
  nvme: make tests transport type agnostic
  tests/nvme: restrict tests to specific transports
  nvme: support nvme-tcp when runinng tests
  common/multipath-over-rdma: don't retry module unload
  nvme: support rdma transport type

 common/multipath-over-rdma |   4 +-
 tests/nvme/002             |   8 ++-
 tests/nvme/003             |  10 +--
 tests/nvme/004             |  12 ++--
 tests/nvme/005             |  15 ++---
 tests/nvme/006             |   7 ++-
 tests/nvme/007             |   5 +-
 tests/nvme/008             |  13 ++--
 tests/nvme/009             |  11 ++--
 tests/nvme/010             |  13 ++--
 tests/nvme/011             |  13 ++--
 tests/nvme/012             |  14 +++--
 tests/nvme/013             |  13 ++--
 tests/nvme/014             |  13 ++--
 tests/nvme/015             |  12 ++--
 tests/nvme/016             |   7 ++-
 tests/nvme/017             |   7 ++-
 tests/nvme/018             |  13 ++--
 tests/nvme/019             |  13 ++--
 tests/nvme/020             |  11 ++--
 tests/nvme/021             |  13 ++--
 tests/nvme/022             |  13 ++--
 tests/nvme/023             |  13 ++--
 tests/nvme/024             |  13 ++--
 tests/nvme/025             |  13 ++--
 tests/nvme/026             |  13 ++--
 tests/nvme/027             |  13 ++--
 tests/nvme/028             |  15 ++---
 tests/nvme/029             |  13 ++--
 tests/nvme/030             |   8 +--
 tests/nvme/031             |  12 ++--
 tests/nvme/032             |   4 ++
 tests/nvme/rc              | 122 ++++++++++++++++++++++++++++++++++---
 33 files changed, 311 insertions(+), 168 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
