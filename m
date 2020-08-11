Return-Path: <SRS0=CGXy=BV=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1EF0C433E0
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:15 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9F33820782
	for <linux-nvme@archiver.kernel.org>; Tue, 11 Aug 2020 21:01:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="uOVR2xsx"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9F33820782
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-Id:Date:Subject:To:From:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GP2OUkVcEnQNdCvOGTxOzUWklmBIvg0kh3fjDJFJI78=; b=uOVR2xsxHTIe/fFi7VcpH6MD2y
	T0KjEPt5QdcSCvWjOLxZfS+dCBEJ7wNoFlNWKzgL8UXrqdrl0yv9cXbJ14IM3KEltgktsvSaSLBNq
	O8lge/qCJoDIbDNt5VFQh2eo92HaZpsU1rsqL29AcePqnwOfH0Bd2NOkRXzHEL4qgu5JsUZNk8tHN
	vhM6nXpRUXwWdB3BURkeklnWkods0X45rXPdl8ApICrg3+4IFOD3HD6cNnG4LKkTi8eMlzOxsWHWe
	MvOFaIjG5Rmwa1xmsMCAP5eHCqdbmAcCrQFUmnoVrk02QyT/0S0cZQ3MkLxiH88wK03VCUJ9m+AL4
	X2aM5uEA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1k5bOQ-0005Er-EQ; Tue, 11 Aug 2020 21:01:10 +0000
Received: from mail-pl1-f179.google.com ([209.85.214.179])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1k5bON-0005E6-Cb
 for linux-nvme@lists.infradead.org; Tue, 11 Aug 2020 21:01:08 +0000
Received: by mail-pl1-f179.google.com with SMTP id p1so116405pls.4
 for <linux-nvme@lists.infradead.org>; Tue, 11 Aug 2020 14:01:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=2M/NkPwr5H4y0EaA8vvnqwXlS7IQXN7YAERbtmkGJNY=;
 b=tVnReNMp2ZaW2NZfjoH67NuHaPw3gzlaYjtoMG97THhG2ZwzIEAT2GgBnFnrxFEZN/
 Qgr1clTOfImvTIBAybnrvloS4lgEcNCB8YAYneY/0S785AdbN9SGINAIg2W2TpafaO7Z
 2qGV95gMt+rnGjfVw6u3/8g9WyGaOTHM3rqGKp+r00Fp7sqKiXERr9nyhGQGFaz4HDEf
 3aDtcx3o/z+GG069UCdjVWqJjV7pGQWmCee1adXFqw4wrX2j4LZEi1C//pQXiB7XiZMy
 uX7eE5LkuLrViCY340O0VYgWSdnNLJMuBcM2HWmfAWiQnJ66b4hl8RJhR84VR6uwNn6D
 37RA==
X-Gm-Message-State: AOAM533s7XzDgm8OwE5/pgh3s0JpRWJpapDAOYt0qnNVb2lb31/zkpJa
 VHiucXnYVZSQjPr2HrQUU61s2ISSh1Q=
X-Google-Smtp-Source: ABdhPJxx/dr7cGE5Ub9Nwurqe4S+Z+H1ybsv0Bd9Fm1GGYZp2Ccrl3ctVztF1An6mET1ko9AkJPJyw==
X-Received: by 2002:a17:90a:c505:: with SMTP id
 k5mr2668093pjt.188.1597179665743; 
 Tue, 11 Aug 2020 14:01:05 -0700 (PDT)
Received: from localhost.localdomain ([2601:647:4802:9070:b58b:5460:6ed2:8ff9])
 by smtp.gmail.com with ESMTPSA id o17sm59370pgn.73.2020.08.11.14.01.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 14:01:04 -0700 (PDT)
From: Sagi Grimberg <sagi@grimberg.me>
To: linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 Omar Sandoval <osandov@osandov.com>
Subject: [PATCH v3 0/7] blktests: Add support to run nvme tests with tcp/rdma
 transports
Date: Tue, 11 Aug 2020 14:00:55 -0700
Message-Id: <20200811210102.194287-1-sagi@grimberg.me>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200811_170107_830963_7F458463 
X-CRM114-Status: GOOD (  13.63  )
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
Cc: Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>,
 Chaitanya Kulkarni <Chaitanya.Kulkarni@wdc.com>,
 Bart Van Assche <bvanassche@acm.org>
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
 34 files changed, 322 insertions(+), 179 deletions(-)

-- 
2.25.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
