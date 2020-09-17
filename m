Return-Path: <SRS0=U7CH=C2=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 389B1C2BBD1
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 17:39:14 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A095A20872
	for <linux-nvme@archiver.kernel.org>; Thu, 17 Sep 2020 17:39:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="L2TpF2gK";
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="sNvZ85ZJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A095A20872
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=infradead.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From:Date:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wSxzhI3x/oDD3QqfG9eBhFEPXnK/GUHSmhNTYaBnaso=; b=L2TpF2gKmlyjOku1LPfw8Fa76U
	6Q1DsPLCldtGGUOUGUhcbcOJmbQFT9QlMSgUOukoEKoJH3SMfEirfUOX2B5l9aGZ2HBwGOQEKBve5
	VVVPgO89Vw21Ph/eg2ajCAd0oqPMdeqJOEH9ssex/n9ilijy6O99vao7jqywzTa1afwmdCNg2qBXc
	TUIfk/YVBCBifmXjZYNGiPFDYy5SdHRI9lsCiy2p2Yi8kDNCKaOgwksOrQ/aCOn1wyxGhe92odUHE
	N7XdaNhGScb80S5nwFj3PecloWBeIAs3Duv7H8ME4b+fi5K5Rgsbsd2Jorp+apgU1i+CSbPba3N+w
	/8UVI4vQ==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kIxsC-0007d0-E7; Thu, 17 Sep 2020 17:39:08 +0000
Received: from casper.infradead.org ([2001:8b0:10b:1236::1])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIxsB-0007cn-Kg
 for linux-nvme@merlin.infradead.org; Thu, 17 Sep 2020 17:39:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=casper.20170209; h=Content-Type:MIME-Version:Message-ID:
 Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=cVjYCdQq6oWYwx7BQKEnoBv/QOUczwpDqncGM7xXaZo=; b=sNvZ85ZJgoDRaVw19sn7RIawZi
 mmwlFqyBej05oqFFfOQUralWYX3+8PuNo6+2nKM5j7mGOU/0zw88zoVDfzcuGC3QuHV4YquTT19kU
 uMzEtoCjD7eTvXX57aG5PSQ3ANQcLmYshkOoS2MtdwDqPQNq9VxvPqI23riUZTvmBw+K8AOvbcAUm
 FPXzsXjKRYDfye0ym08rmDzb2ZIiJAAvRNChQmj0GZRYSTOzOGlPcs6eC4WGe4NXFw/L9SZk6XB5i
 rnelzRxTOuRj+eHpnzCi4OvzTHbnW5bSUDl7fVTcLRFfpEjE1VB2dr+YiMmOIADfXPNFoXrGkhJ0z
 Qakz6frQ==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92]
 helo=localhost)
 by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kIxsA-0003Bm-C5; Thu, 17 Sep 2020 17:39:06 +0000
Date: Thu, 17 Sep 2020 19:36:54 +0200
From: Christoph Hellwig <hch@infradead.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.9
Message-ID: <20200917173654.GA3311729@infradead.org>
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

The following changes since commit 709192d531e5b0a91f20aa14abfe2fc27ddd47af:

  s390/dasd: Fix zero write for FBA devices (2020-09-14 19:40:21 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-5.9-2020-09-17

for you to fetch changes up to 3a6b076168e20a50289d71f601f1dd02be0f8e88:

  nvmet: get transport reference for passthru ctrl (2020-09-17 10:36:25 +0200)

----------------------------------------------------------------
nvme fixes for 5.9

 - another quirk for the controller from hell (David Milburn)
 - fix a Kconfig dependency (Necip Fazil Yildiran)
 - char devices / passthrough refcount fixes (Chaitanya Kulkarni)

----------------------------------------------------------------
Chaitanya Kulkarni (1):
      nvme-core: get/put ctrl and transport module in nvme_dev_open/release()

Christoph Hellwig (1):
      nvmet: get transport reference for passthru ctrl

David Milburn (1):
      nvme-pci: disable the write zeros command for Intel 600P/P3100

Necip Fazil Yildiran (1):
      nvme-tcp: fix kconfig dependency warning when !CRYPTO

 drivers/nvme/host/Kconfig      |  1 +
 drivers/nvme/host/core.c       | 15 +++++++++++++++
 drivers/nvme/host/pci.c        |  3 ++-
 drivers/nvme/target/passthru.c |  2 ++
 4 files changed, 20 insertions(+), 1 deletion(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
