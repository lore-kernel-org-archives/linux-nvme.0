Return-Path: <SRS0=kOig=GY=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15DA6C433DB
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:33:01 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 226B523976
	for <linux-nvme@archiver.kernel.org>; Thu, 21 Jan 2021 08:33:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 226B523976
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=y8MB+CLdlO0ZVfiAoEwLY9kkxd0Jruj5Wx0qclAwwBc=; b=xLwxbJiZJvCdl519wbr9GBJDJ6
	mCZo+Y4iwtKmsLvfmd/tUV03lXMUsgGd92Vryl/357h6P/1PSM95T/Nr0eQE6nK31AdxZRh/+PFfw
	OdV26Udbb0483SzTN/KEoqdovoQf2x80mMnXrPEsV3Y00N3491K6TQ2XPd7G814L6nxdTD5mXNQkm
	54nFmi5Ac3vB9dDeNxnc65n9Dht4OAld28foEGzoUPlvIMTr35uznOPtmiZxNI3X6BCvuWzvgmJT6
	rMoacLNC6TCSdVsC6eqtg8SuNpGsK6418qY0+TZA4JGm8ms+IocT4T97iKhIEnMAcEJDvrtwcax8V
	qfoMEGAw==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1l2VOc-0004Ni-2l; Thu, 21 Jan 2021 08:32:50 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1l2VOZ-0004Mz-LC
 for linux-nvme@merlin.infradead.org; Thu, 21 Jan 2021 08:32:47 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=tCQyPoxlkt0mcG4IJQ3TV9idT57nElqTrtxIPpTvinM=; b=tp4x2GI4WPuksHoYU/5ymQSsmM
 tG839XzOj4nrxflSbc8s8Ytzj89Sgbj3bGt3UP47vhOaVuknMsnO0EBA1kfAkz7uj8eWWqcIWtt2r
 AOwt2gy+iezMoGJvOufJ/m4+kzTeEVULui/lOLSMJyhIfUh8RaRV9IrsRD7JF4DxreLSGEW4vvuUx
 jyANyk0pH2pyhv6ajHV8NAljSmYI0p/m5BI/9qQ2b22Jghq2p7AQLWzaf20J0Yt3NnCvfFvfilQnL
 EaUHrQ7a9k2cEDQc5VGsAIGeC7lazK8zqF/qSO8+QxLg+iyRs38qplBO3NjOHgm3os3TWvXrdWGcc
 AdE4AS+A==;
Received: from [2001:4bb8:188:1954:d5b3:2657:287:e45f] (helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
 id 1l2VOV-00Go83-83; Thu, 21 Jan 2021 08:32:44 +0000
Date: Thu, 21 Jan 2021 09:32:42 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.11
Message-ID: <YAk8Kt/DRZ7T6WBl@infradead.org>
MIME-Version: 1.0
Content-Disposition: inline
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by
 casper.infradead.org. See http://www.infradead.org/rpr.html
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
Cc: Keith Busch <kbusch@kernel.org>, linux-block@vger.kernel.org,
 Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit b4f664252f51e119e9403ef84b6e9ff36d119510:

  Merge tag 'nvme-5.11-2021-01-14' of git://git.infradead.org/nvme into block-5.11 (2021-01-14 15:17:33 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.11-2020-01-21

for you to fetch changes up to fa0732168fa1369dd089e5b06d6158a68229f7b7:

  nvme-pci: fix error unwind in nvme_map_data (2021-01-20 18:56:33 +0100)

----------------------------------------------------------------
nvme fixes for 5.11:

 - fix a status code in nvmet (Chaitanya Kulkarni)
 - avoid double completions in nvme-rdma/nvme-tcp (Chao Leng)
 - fix the CMB support to cope with NVMe 1.4 controllers (Klaus Jensen)
 - fix PRINFO handling in the passthrough ioctl (Revanth Rajashekar)
 - fix a double DMA unmap in nvme-pci

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvmet: set right status on error in id-ns handler

Chao Leng (2):
      nvme-rdma: avoid request double completion for concurrent nvme_rdma_timeout
      nvme-tcp: avoid request double completion for concurrent nvme_tcp_timeout

Christoph Hellwig (2):
      nvme-pci: refactor nvme_unmap_data
      nvme-pci: fix error unwind in nvme_map_data

Klaus Jensen (1):
      nvme-pci: allow use of cmb on v1.4 controllers

Revanth Rajashekar (1):
      nvme: check the PRINFO bit before deciding the host buffer length

 drivers/nvme/host/core.c        |  17 +++++-
 drivers/nvme/host/pci.c         | 119 +++++++++++++++++++++++++++-------------
 drivers/nvme/host/rdma.c        |  15 +++--
 drivers/nvme/host/tcp.c         |  14 +++--
 drivers/nvme/target/admin-cmd.c |   8 ++-
 include/linux/nvme.h            |   6 ++
 6 files changed, 129 insertions(+), 50 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
