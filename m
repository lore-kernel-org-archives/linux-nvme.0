Return-Path: <SRS0=Ae0q=BN=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4C8BC433E0
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 962F42075A
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Aug 2020 06:48:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="eRlbV8BF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 962F42075A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe
	:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:Reply-To:Cc:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=7jZoSvPKBYYAhYtBnWhQnGJxeQWY1qa0d+ow8vb9j08=; b=eRlbV8BFkkbKZJBzzxwb2lC9IH
	ZahMuJzWv0+D4+FV0FOCvgwPCPsIkDrvNNLtZ4u3f9iKCA+Nkk2iBUtvmDhZJi5FNKQBXGGaPLpNm
	aXe9QpfJ7n0f3xx9nm+phD3IIXhS8J2Z6ojWHgPb74RoXHjUeebHHiIB7W59MHg5ydyZrQ41mdohz
	0C/6QL6gHUYmxIO3ClKvpdjDzU71jgm+NvaOz/hFq+mMOSH/HJPyYsAYMoJFAf13//NxUrE8jme6g
	bwDKHYhQ4b9DDJk+otZh2SKpqjhvyjxY4M87uzplgVwGwMSjJ+QPR7QKCgldpQR7+AKJfY8vANFgs
	ciIJc9Ow==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k2UHB-0002k7-4G; Mon, 03 Aug 2020 06:48:49 +0000
Received: from mail-wr1-f51.google.com ([209.85.221.51])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k2UH8-0002j5-4H
 for linux-nvme@lists.infradead.org; Mon, 03 Aug 2020 06:48:46 +0000
Received: by mail-wr1-f51.google.com with SMTP id z18so29526672wrm.12
 for <linux-nvme@lists.infradead.org>; Sun, 02 Aug 2020 23:48:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Ah7+Fdla9BLpnlB5TAyVE+EsnlJ3z0oSf241X879VJg=;
 b=T3Gt7Aha3heX2yjVNW3TmOiMhZ8nR1usy3R4wY5YDYNEP2e+VGGODOFuWX2D5fNUgM
 ul/a2iksYoguh0ON0gPnAkcxfDJWa/aDmIb8bgAUNWvbkc8GewTh0RPk3oTQxERkxr0h
 LbhwJ8AqQlNFeICtKJP9/60zBhpJCYE/t9lQj8WdF6CU9WukhGBMODiMZgVOjelCC1TF
 XcPtekwnE+tBQUxRCYeA1gBPfdiYlUbn9t5EG9sbIfNKkV+rk+3kZOOmK0Jqtj7ZAu8X
 ja1+8Fm0IdBoKM3aUb+Ph6d5oB4WqnVdaHtxTNV2odnK3s8YzxiewrnPghahgT3eK0H3
 Nw8w==
X-Gm-Message-State: AOAM530ps7Tfrcg23zXUogBf7dDNcKggAxBvu699fNIsJcqQRa8+zcf1
 W7DWLPEOoMzilMbGW3egMnjdO69j
X-Google-Smtp-Source: ABdhPJz7q0GMxDdL+HvRPj165/7m7+t+eCym1gpeLsxSz0TlYtAAE8Z3tQOA+YTu8geOkWTip7N82w==
X-Received: by 2002:adf:9526:: with SMTP id 35mr14576749wrs.326.1596437323137; 
 Sun, 02 Aug 2020 23:48:43 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:6dac:e394:c378:553e])
 by smtp.gmail.com with ESMTPSA id z6sm23740647wrs.36.2020.08.02.23.48.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Aug 2020 23:48:42 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>, Keith Busch <kbusch@kernel.org>,
 Christoph Hellwig <hch@lst.de>, Johannes Thumshirn <jthumshirn@suse.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>
Subject: [PATCH rfc 0/6] blktests: Add support to run nvme tests with tcp/rdma
 transports
Date: Sun,  2 Aug 2020 23:48:29 -0700
Message-Id: <20200803064835.67927-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200803_024846_179853_37049E78 
X-CRM114-Status: GOOD (  10.91  )
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

We have a collection of nvme tests, but all run with nvme-loop. This
is the easiest to run on a standalone machine. However its very much possible
to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
tests with a new environment variable to set the transport type $nvme_trtype.

$ nvme_trtype=[loop|tcp|rdma] ./check test/nvme

This buys us some nice coverage on some more transport types. We also add
some transport type specific helpers to mark tests that are relevant only
for a single transport.

Sagi Grimberg (6):
  nvme: consolidate nvme requirements based on transport type
  nvme: consolidate some nvme-cli utility functions
  nvme: make tests transport type agnostic
  tests/nvme: restrict tests to specific transports
  nvme: support nvme-tcp when runinng tests
  nvme: support rdma transport type

 tests/nvme/002 |   8 ++--
 tests/nvme/003 |  10 ++--
 tests/nvme/004 |  12 +++--
 tests/nvme/005 |  15 +++---
 tests/nvme/006 |   7 +--
 tests/nvme/007 |   5 +-
 tests/nvme/008 |  13 +++---
 tests/nvme/009 |  11 +++--
 tests/nvme/010 |  13 +++---
 tests/nvme/011 |  13 +++---
 tests/nvme/012 |  14 +++---
 tests/nvme/013 |  13 +++---
 tests/nvme/014 |  13 +++---
 tests/nvme/015 |  12 +++--
 tests/nvme/016 |   7 +--
 tests/nvme/017 |   7 +--
 tests/nvme/018 |  13 +++---
 tests/nvme/019 |  13 +++---
 tests/nvme/020 |  11 +++--
 tests/nvme/021 |  13 +++---
 tests/nvme/022 |  13 +++---
 tests/nvme/023 |  13 +++---
 tests/nvme/024 |  13 +++---
 tests/nvme/025 |  13 +++---
 tests/nvme/026 |  13 +++---
 tests/nvme/027 |  13 +++---
 tests/nvme/028 |  15 +++---
 tests/nvme/029 |  13 +++---
 tests/nvme/030 |   8 ++--
 tests/nvme/031 |  12 ++---
 tests/nvme/032 |   4 ++
 tests/nvme/rc  | 122 +++++++++++++++++++++++++++++++++++++++++++++----
 32 files changed, 309 insertions(+), 166 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
