Return-Path: <SRS0=ej39=3Y=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,URIBL_DBL_ABUSE_MALW,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C78FBC35247
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 17:37:46 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9CE372166E
	for <linux-nvme@archiver.kernel.org>; Tue,  4 Feb 2020 17:37:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="oNJ92KOX";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="cHFyV0GS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9CE372166E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=pYdfaTfO7MwGzpAjXMFOe4fgm4a0XPHSuVr/riJ7Ywo=; b=oNJ92KOXJMkcQ6
	sj86vcOHCd+AUfajVWmAGzGnypLxBN5bvmUjsPeid8Dkw1cKM4Q95oLMHWIpQ6tG/P+wFNcwlLY5u
	PEEuB8ZMLlpn4MCcNywj7apaEkla1uWdgXeI/VaUgVrSCcVsua9t4YQLriUpYwOTVwd2KA5ybw8UQ
	KhChaGkv6i1CtQjDpX9cSVVAQLtu+YiUKLO1UXRofDHB4dph2aFb2tLHv7aamv4Gi4kLqqWQejgQ6
	oAgy8X9kp1V89qMChvJXwXa5vpb0lXxSEP9TYU9SvkQfKb64Gx/p2hnCXb43czOXt+02pmoRsU6UA
	/pcr79IsWoaeC/GvpgDg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iz28v-0007vn-0L; Tue, 04 Feb 2020 17:37:45 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iz28s-0007vC-Ic
 for linux-nvme@lists.infradead.org; Tue, 04 Feb 2020 17:37:43 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id 1523320674;
 Tue,  4 Feb 2020 17:37:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1580837860;
 bh=W1ed+xro59K0xqlLci3RARCwSbU55shpw5UGVzCJZg8=;
 h=Date:From:To:Cc:Subject:From;
 b=cHFyV0GSpQSK6KmxhosFgJ55ZpT+veCaoMO+NZxzACKvCDTi9Viu5jbvxy8mC7jiL
 vYYwm/mwwxRZv+sPo6KPOXTUmhJHYJoFzWAGzTmttNg/43waF/y9SoSuFTvUIaorZx
 PsKXnyD81lFnU3MWnYL6taUjG4ZpZRHH1O8BgYPs=
Date: Wed, 5 Feb 2020 02:37:34 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme-5.6
Message-ID: <20200204173734.GE6823@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200204_093742_634333_68E2CC34 
X-CRM114-Status: GOOD (  10.95  )
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
Cc: chaitanya.kulkarni@wdc.com, hch@lst.de, linux-nvme@lists.infradead.org,
 sagi@grimberg.me
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

Just a small collection of various fixes for 5.6 for this merge window's
nvme pull request. We'll have more exciting features to consider for
the next release.

The following changes since commit c92bddee77353a773f0df76115c1a01877ce1eae:

  block, bfq: clarify the goal of bfq_split_bfqq() (2020-02-03 06:58:15 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.6

for you to fetch changes up to 0f5be6a4ff7b3f8bf3db15f904e3e76797a43d9a:

  nvmet: update AEN list and array at one place (2020-02-05 01:56:10 +0900)

----------------------------------------------------------------
Amol Grover (1):
      nvmet: Pass lockdep expression to RCU lists

Christoph Hellwig (1):
      nvme-pci: remove nvmeq->tags

Daniel Wagner (1):
      nvmet: update AEN list and array at one place

Israel Rukshin (2):
      nvmet: Fix error print message at nvmet_install_queue function
      nvmet: Fix controller use after free

Sagi Grimberg (1):
      nvmet: fix dsm failure when payload does not match sgl descriptor

 drivers/nvme/host/pci.c           | 23 ++++-------
 drivers/nvme/target/core.c        | 80 +++++++++++++++++++++++++--------------
 drivers/nvme/target/fabrics-cmd.c | 15 +++++---
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/io-cmd-file.c |  2 +-
 drivers/nvme/target/nvmet.h       |  1 +
 6 files changed, 72 insertions(+), 51 deletions(-)


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
