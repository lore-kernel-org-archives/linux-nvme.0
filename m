Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B22FCC433E2
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 23:53:56 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 668CC2078E
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 23:53:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="ttK5FZ0p"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 668CC2078E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=rChbv+vqpWUGWeIz3uZBHa7bWJ3nx4zZ9cFORBdPeaM=; b=ttK5FZ0pn8N64bQ9Wy56nKZPJw
	C7QoN8fv5tBmYx+ACZzumTGCA8DlyHroCUH+ukKezELiK/GfjOv9eAyTJcv35upcnf8tm53agJNcW
	D1dfEY4wIDxATzF0cY5bWujiv/EaTyrGwRl3WMeSiDDLaYkR7g+z7qa1rcqEj/TjCj5ghhgNEGG1f
	mQ8IRI0f6n4PwKzrpgydUmwHRFKZDAfvbrymejh3ngOsdz/KumGPy932ywcRcADPEoq5fKZBdHJhc
	sXgovoG67Y8jLkqxFlsAH+hZQ6x3IDHJMPDSJ1rzlZT0ueMQvj726HQMzGmgCAvl0PEQD1uYk9Ndq
	bnsDUdMw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDz38-0001mW-5M; Thu, 03 Sep 2020 23:53:50 +0000
Received: from mail-wm1-f41.google.com ([209.85.128.41])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDz36-0001m2-Bj
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 23:53:49 +0000
Received: by mail-wm1-f41.google.com with SMTP id e11so6361513wme.0
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 16:53:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=41aue9Z2+0Jna6WTjt/oRp/zuBiUQmkW7wUAEMo5DEw=;
 b=qWc6ACuvIZYxqggQSnsaB6/5TytpXkuty3jKhiip/FkvkWhP2aCFJ3mWMXlzkNevyf
 pBmrpe3ELtXZiJm/P8r1aOZcp5X7yTGgggrbETQgjs3i6Kde90JwY7wzXMBQuGwh8jIL
 6GAWgN9trglyZ+VIol92b/XesDm3XByzh9maEpuDS5rZig7gFSNR0s31JnxFYZoIZtdN
 kvvCt/C3svBEeZIDoFX4vcoFTbIqa7rvr+750Q9qTxaRttpLbN7W/mFG3ge2y3hBBRzL
 PPKxHhHyMHB0ae3dT+TuaGusjBYDhKCHMoaZzb6hhZ9PbNhgs/BGZoLDVsVxkxAib39r
 qh/A==
X-Gm-Message-State: AOAM530qoKL+1QXqGhC44gJG/7dXG2jzTt4fw17zBAI9XvMqn0JxApNY
 Vbl1QMFdNNbYr36T/PHjgus=
X-Google-Smtp-Source: ABdhPJwXPP0YdJVg2SFl+KD6ZC7ExS7iGEtNZ2nMlZFg2LDJknlYF94J3TbS6pGgRj0zRnzyPYwITg==
X-Received: by 2002:a7b:c35a:: with SMTP id l26mr4880114wmj.42.1599177225548; 
 Thu, 03 Sep 2020 16:53:45 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id u17sm7024992wmm.4.2020.09.03.16.53.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 16:53:44 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v7 0/7] blktests: Add support to run nvme tests with tcp/rdma
 transports
Date: Thu,  3 Sep 2020 16:53:30 -0700
Message-Id: <20200903235337.527880-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_195348_418261_9E2664EF 
X-CRM114-Status: GOOD (  14.24  )
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
Cc: Keith Busch <kbusch@kernel.org>, Logan Gunthorpe <logang@deltatee.com>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 linux-nvme@lists.infradead.org, Christoph Hellwig <hch@lst.de>
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

Changes from v6:
- fix _nvme_discover wrong use of subsysnqn that is never passed
- move shellcheck fixes to the correct patches (not fix in subsequent patches)
Changes from v5:
- fix shellcheck errors
Changes from v4:
- removed extra paranthesis
- load either rdma_rxe or siw for rdma transport tests
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
 tests/nvme/012     |  14 ++---
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
 tests/nvme/rc      | 127 ++++++++++++++++++++++++++++++++++++++++++---
 tests/nvmeof-mp/rc |  13 -----
 tests/srp/rc       |  13 -----
 35 files changed, 327 insertions(+), 192 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
