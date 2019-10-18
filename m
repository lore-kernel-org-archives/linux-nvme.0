Return-Path: <SRS0=X7Om=YL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86DF9CA9EA9
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 14:37:22 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4938F222BD
	for <linux-nvme@archiver.kernel.org>; Fri, 18 Oct 2019 14:37:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="Q4uDEZS0";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="K+sr6Red"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4938F222BD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:
	Content-Transfer-Encoding:Content-Type:Cc:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:Message-ID:Subject:To:From
	:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:
	List-Owner; bh=NNX7pB1O71AE96HXjN1B7W3Y1dREz3pra8wzyJquRHM=; b=Q4uDEZS0TXvF2j
	TJel26kVBw0zCmCIWuDchKxZLmC9sV7DUw6de2+ZUeGg/u1QbcoWuFV4Ltnzdy+HQqK80MpwJH1kN
	7/8R/LhTGjff7QYAZL7ev6YZKmX7985IkSdSB+xPur3AmHUR0h4yRSC+2RV0ihAnM1mECEZku7ML0
	5TgG4Lce3wUdT0HCZUeJMY+gtOTe8iPX81pAzE5Knid93RmnG22GlYtQfv0ehMMGTXH2UoRGPgEc4
	zkWOgj5gQbWydV6vwPdWGWQG5QHWcAQtE18fRW7P1FbF0GQNt2RzdlDTmGPPkzhcQsH+kNor+2Ktb
	ToKC6ydgjyMKm0wqiW3A==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iLTNT-0006e5-DK; Fri, 18 Oct 2019 14:37:15 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iLTNM-0006Uz-Ep
 for linux-nvme@lists.infradead.org; Fri, 18 Oct 2019 14:37:10 +0000
Received: from redsun51.ssa.fujisawa.hgst.com (unknown [199.255.47.7])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id A6CB8222BD;
 Fri, 18 Oct 2019 14:37:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1571409427;
 bh=YWp9MsoSqPw6Pf08bSv4okKF7mf1EzX+PcyDy/jDrn8=;
 h=Date:From:To:Cc:Subject:From;
 b=K+sr6Red/GL0srCCppesqzMjciaCDhYAmy6xIKxBmniDKnm0xU+ELlrB1zJfKn69f
 a/RZmMwPg6V8HNHzxoP61JvqIQKouCE7Z6aW/1gLxAgrFqIGIkR539cP7eXzHqU/C1
 iAPsRvQq73UZmHKMZQ5x61aQkK21Qy7OiW0J11oI=
Date: Fri, 18 Oct 2019 23:37:00 +0900
From: Keith Busch <kbusch@kernel.org>
To: Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] nvme fixes for 5.4
Message-ID: <20191018143700.GB7124@redsun51.ssa.fujisawa.hgst.com>
MIME-Version: 1.0
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191018_073708_596953_4748CA84 
X-CRM114-Status: GOOD (  10.78  )
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
Cc: sagi@grimberg.me, linux-nvme@lists.infradead.org, hch@lst.de
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Jens,

This is a collection of bug fixes committed since the previous pull
request that address deadlocks, double resets, memory leaks, and other
regression.

The following changes since commit a9eb49c964884654dd6394cb6abe7ceb021c9c96:

  block: sed-opal: fix sparse warning: convert __be64 data (2019-10-03 14:21:32 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git nvme-5.4

for you to fetch changes up to a4f40484e7f1dff56bb9f286cc59ffa36e0259eb:

  nvme-pci: Set the prp2 correctly when using more than 4k page (2019-10-18 23:09:41 +0900)

----------------------------------------------------------------
Ard Biesheuvel (1):
      nvme: retain split access workaround for capability reads

Keith Busch (5):
      nvme-pci: Free tagset if no IO queues
      nvme: Remove ADMIN_ONLY state
      nvme: Restart request timers in resetting state
      nvme: Prevent resets during paused controller state
      nvme: Wait for reset state when required

Kevin Hao (1):
      nvme-pci: Set the prp2 correctly when using more than 4k page

Max Gurtovoy (2):
      nvmet-loop: fix possible leakage during error flow
      nvme-tcp: fix possible leakage during error flow

Sagi Grimberg (1):
      nvme: fix possible deadlock when nvme_update_formats fails

Sebastian Andrzej Siewior (1):
      nvme-tcp: Initialize sk->sk_ll_usec only with NET_RX_BUSY_POLL

 drivers/nvme/host/core.c    | 94 ++++++++++++++++++++++++++++++++-------------
 drivers/nvme/host/fabrics.h |  3 +-
 drivers/nvme/host/nvme.h    |  5 ++-
 drivers/nvme/host/pci.c     | 83 +++++++++++++++++++++++----------------
 drivers/nvme/host/rdma.c    |  8 ++++
 drivers/nvme/host/tcp.c     | 11 ++++++
 drivers/nvme/target/loop.c  |  4 +-
 7 files changed, 144 insertions(+), 64 deletions(-)

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
