Return-Path: <SRS0=5rXh=BY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C683FC433E3
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:35 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 966BD20791
	for <linux-nvme@archiver.kernel.org>; Fri, 14 Aug 2020 06:18:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="3jhD4ctv"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 966BD20791
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=FBDTEIhGEBpiBX8i5mxGdFadJddgNjPoULnk8Fmvszs=; b=3jhD4ctvfrCp51ZyvoVrhHHrTV
	stXuAk0VVtECujkNn02LOek9cJCXd3sTZhshLo51D4aa93FqMIPEJzq8tJ/de+kNnedD2C5I9oxMR
	b1O25iKZJw3TWJwt1P1G6MD+HD8jYPPTLAXofjnP8GDmX54HKaONjerUA/kibhXG5uRynFnwvx4VC
	agAfRd68E2V1oOQmi4FUnhar9pw8nDDydzpyZkDM715GXlw6680oUUbj4ROX4+YPb+b+SdlnaZB5Y
	3IMZ0P8WQwpHKxcYOp8iZADeDP30BWoY/pBGCN0P224u7e1MaoBmtxZTBT8CY+kr+plIL2ciKvmte
	NvP56AxQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k6T2s-0002Fp-LT; Fri, 14 Aug 2020 06:18:30 +0000
Received: from mail-wm1-f48.google.com ([209.85.128.48])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k6T2p-0002FF-4Z
 for linux-nvme@lists.infradead.org; Fri, 14 Aug 2020 06:18:28 +0000
Received: by mail-wm1-f48.google.com with SMTP id k20so6960508wmi.5
 for <linux-nvme@lists.infradead.org>; Thu, 13 Aug 2020 23:18:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=+rPYJl+zwBo7bcedu39vEi+OGKsxylV+CZ1OMf5GpV4=;
 b=cgnZNTqvIVAHxRH/J4r///kZxyWIbhD+ZwRoI1VDni1JzE2ZSZYC2cwaLMv2YvamBz
 oMvSj6l/WHayd5iJtr7lVrX7adHzaKRA+AHRh5DGiMeIYKgibf0eOXCl+UMzHkzVcvO5
 WyiVHFeNIolmx6TAk063MWbuA2xOSPoN0mo96gAnRniagxfk+ghTZp+VhDKE0I4E5dUw
 UV7YZNlCN1lyukltwfn8TsPqYRuGcUuJ6dMGF9X6Kt1kB+wJOlZzVdgPUrwnhw41bqHJ
 4CWd7mIqVz2tn7AqKc8kysd0YA9VhXD209VTsRRDkR9O+nTvqF8GcXf7yI6l+OtWxaWl
 wF+A==
X-Gm-Message-State: AOAM533DgZ5U3IGyuIBifBLz88LE4Z1jVwHFcx4yBVonQLTL5ghkbImX
 QWjrczeQ1BlrlvNnuFBQmQdAytlaWOoTMg==
X-Google-Smtp-Source: ABdhPJyjydJfKcPmycuYrS140FSMY1IjFNikbpoug3vRzD7Md5IVQ5410WrFCxmmsp5jbZKargZlHA==
X-Received: by 2002:a1c:9616:: with SMTP id y22mr1077901wmd.100.1597385905332; 
 Thu, 13 Aug 2020 23:18:25 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:51f:3472:bc7:2f4f])
 by smtp.gmail.com with ESMTPSA id
 l21sm12278131wmj.25.2020.08.13.23.18.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 13 Aug 2020 23:18:24 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v4 0/7] blktests: Add support to run nvme tests with tcp/rdma
 transports
Date: Thu, 13 Aug 2020 23:18:08 -0700
Message-Id: <20200814061815.536540-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200814_021827_237081_FB18F179 
X-CRM114-Status: GOOD (  13.26  )
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
Cc: Keith Busch <kbusch@kernel.org>, Bart Van Assche <bvanassche@acm.org>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

We have a collection of nvme tests, but all run with nvme-loop. This
is the easiest to run on a standalone machine. However its very much possible
to run nvme-tcp and nvme-rdma using a loopback network. Add capability to run
tests with a new environment variable to set the transport type $nvme_trtype.

$ nvme_trtype=[loop|tcp|rdma] ./check nvme

This buys us some nice coverage on some more transport types. We also add
some transport type specific helpers to mark tests that are relevant only
for a single transport.

Changes from v3:
- remove unload_module from tests/srp/rc
- fixed test run cmd
Changes from v2:
- changed patch 6 to move unload_module to common/rc
- changed helper to be named _require_nvme_trtype_is_fabrics
Changes from v1:
- added patch to remove use of module_unload
- move trtype agnostic logig helpers in patch #3

Sagi Grimberg (7):
  nvme: consolidate nvme requirements based on transport type
  nvme: consolidate some nvme-cli utility functions
  nvme: make tests transport type agnostic
  tests/nvme: restrict tests to specific transports
  nvme: support nvme-tcp when runinng tests
  common: move module_unload to common
  nvme: support rdma transport type

 common/rc          |  13 +++++
 tests/nvme/002     |   8 +--
 tests/nvme/003     |  10 ++--
 tests/nvme/004     |  12 +++--
 tests/nvme/005     |  15 +++---
 tests/nvme/006     |   7 +--
 tests/nvme/007     |   5 +-
 tests/nvme/008     |  13 ++---
 tests/nvme/009     |  11 ++--
 tests/nvme/010     |  13 ++---
 tests/nvme/011     |  13 ++---
 tests/nvme/012     |  14 +++---
 tests/nvme/013     |  13 ++---
 tests/nvme/014     |  13 ++---
 tests/nvme/015     |  12 +++--
 tests/nvme/016     |   7 +--
 tests/nvme/017     |   7 +--
 tests/nvme/018     |  13 ++---
 tests/nvme/019     |  13 ++---
 tests/nvme/020     |  11 ++--
 tests/nvme/021     |  13 ++---
 tests/nvme/022     |  13 ++---
 tests/nvme/023     |  13 ++---
 tests/nvme/024     |  13 ++---
 tests/nvme/025     |  13 ++---
 tests/nvme/026     |  13 ++---
 tests/nvme/027     |  13 ++---
 tests/nvme/028     |  15 +++---
 tests/nvme/029     |  13 ++---
 tests/nvme/030     |   8 +--
 tests/nvme/031     |  12 ++---
 tests/nvme/032     |   4 ++
 tests/nvme/rc      | 122 ++++++++++++++++++++++++++++++++++++++++++---
 tests/nvmeof-mp/rc |  13 -----
 tests/srp/rc       |  13 -----
 35 files changed, 322 insertions(+), 192 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
