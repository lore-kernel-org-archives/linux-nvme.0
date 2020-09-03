Return-Path: <SRS0=8iPx=CM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F32D3C07548
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:51 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BBB68206CA
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Sep 2020 21:26:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="brlhPVq4"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BBB68206CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=a74Lh4yP/l5UI+5iNSLFXhra/eNrC/pQJz5GmBg8c3E=; b=brlhPVq42Kqry8V0SB1UcPLTPf
	L9uEDqdcIWIVEKnnY1kOzX0pdlfTZNCXf1+ee4I5Sqhf+JhEgOBivcXgGHARvhzsf2TH6c6VBG8WS
	IEHtC/AxC8x3L4pDu6VVMK94S9SpJt9hXczI7vhcj+DVdH1vMwdcgYn2EwPMpcV8MdE6VpjTS8AQ7
	3eCOLV2rKE4Ae1qIslFAV07KDPuAN2ghclrmhozXg+pTBHrz7eJE7dnsUMGmGu/OCSnqmPgt4bExg
	AX/ECcUtugcY7URhI1AQb8qAxnZrYkE08H2jWTIHCwjMntjyMzTzJJp5TY3NGQ7w/3z2Ujc+equ3W
	vSnel92A==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kDwkn-0007dm-7P; Thu, 03 Sep 2020 21:26:45 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kDwkl-0007cp-8C
 for linux-nvme@lists.infradead.org; Thu, 03 Sep 2020 21:26:44 +0000
Received: by mail-wm1-f43.google.com with SMTP id q9so4235161wmj.2
 for <linux-nvme@lists.infradead.org>; Thu, 03 Sep 2020 14:26:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=baJOGYhSG0Qs/1LoHCKGaiBtFBXUf1unXiz8REvi8tQ=;
 b=qjj21rflp0jIm1CltZMqdC4zVZR4+X6UJ+vb9OGlXCtJ+ijz3uIlY/fq50jwmYFvLe
 vR0GCdk4I06yoZ9GH0yCq6kH4lWSPhVnLsuBBZQlZP0GHDBmo2Q6ecHvYQH+1nTjPldB
 DZyEpQ6gnrpfyGopiy0PMfgovVVR+9DNu4z2dzVz1DhOl4To04esdv9iyX77R6KlQukX
 WXAYXqw36pEms61WIH67p8EC1euqBOPzQHI4Uj9N5ob/b5D4UMND5TwkG8c4mQfC+4Aq
 7lpC5MjOt3D9U+bjiv79r++Ae0angWVvgx3BABQlLGDI2zvI2pOHQ/PDPohvi0679VmQ
 FxPw==
X-Gm-Message-State: AOAM532njLYHh6QHeTR16LLuo0meExJT4mmpLzH9NH3z50DXrFt11e6a
 AOYZnIdUrmnqLYFo3FPALoY=
X-Google-Smtp-Source: ABdhPJzcXOcddqd94BlJ+9mzeaaEIIZ+1FKo/W4W04mXVUbNnpSIRWO4nbE2Xbmrj62POZ5Lc3jFgA==
X-Received: by 2002:a1c:f605:: with SMTP id w5mr4389177wmc.6.1599168401991;
 Thu, 03 Sep 2020 14:26:41 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:79a5:e112:bd7c:4b29])
 by smtp.gmail.com with ESMTPSA id v204sm6659896wmg.20.2020.09.03.14.26.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Sep 2020 14:26:41 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-block@vger.kernel.org,
	Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v6 0/7] blktests: Add support to run nvme tests with tcp/rdma
 transports
Date: Thu,  3 Sep 2020 14:26:27 -0700
Message-Id: <20200903212634.503227-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200903_172643_308439_CEA075C0 
X-CRM114-Status: GOOD (  13.13  )
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
