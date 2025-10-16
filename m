Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0573CCD199
	for <linux-nvme@archiver.kernel.org>; Thu, 16 Oct 2025 18:52:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=GY08UiQMfZpNgHM/7FB9O/+a8WCC8DwGdmmYzMXrXro=; b=rOsIjtgV/ui7m1T43uIFRj7slm
	Y20b9iAnY61puP8ST7//B5C6VWiHA9Wekhep6QgWaKfBffmlyspbDdVinHOf71CqErV7jJSdLN8yS
	as+a6uJLhojlmjar4mQDk+cOplinKA1unu6TMTq9O1OqUSyfMmcAQyaLgK3BBYGq5dPlwXV4h82/V
	MJSHs8vh3sBYRrQYrZyDXL2et+kKACy6aIqDmFS48rEdhI1G5O4FBFatlyelr8VxF08SpYp97vxdS
	ONsiT0Grjv+VKyR6g3V2Ik9HWYgeJwPQka5rOVSpc0EX1rAq+QhySk9uhi/Pu1lpK2Wg1gAXv0i6Z
	YZO7S4jg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9T5X-00000005jXb-16hh;
	Thu, 16 Oct 2025 18:52:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v9T5S-00000005jXQ-2SLl
	for linux-nvme@lists.infradead.org;
	Thu, 16 Oct 2025 18:52:30 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id F0E9A6045D;
	Thu, 16 Oct 2025 18:52:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56B9FC4CEF1;
	Thu, 16 Oct 2025 18:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1760640749;
	bh=DdmGhSOcB92s7kWk3uuAq/yMEqt+XYCyr8+4QI7LBwY=;
	h=Date:From:To:Cc:Subject:From;
	b=hnjdg+Z5dQRa3CPSAef2HMKZo3ATMIPkCjcm85IFDELonuQNIdYM7wUZgO1GQR8Pt
	 IG0sFP108mp8g9VmjSa2d8iZ5HtTOauJk0pV+6NowwLzOndqem6B/DI655rbO7eCIw
	 wp28BYZtgpsOGbdSezyMYMOZfGZB3q15c1c+gIAdirM2UxjUIENTlN6T7kN0251+i0
	 CDpKEiLEaiKhGyH4t+Zm/3NgdMwJdzUGAF8O44qQM+C4/KcoJvbN5uFlkAGPVyQFmh
	 KI27nTA1OkTM7ZNjSUCwxCAIKN7u54m5alBSDwZVmo0tp6Q2w6WF5/HeHYRdl6FP5u
	 XINTkvOhVs0CQ==
Date: Thu, 16 Oct 2025 12:52:27 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.18
Message-ID: <aPE-64L5715o7FlW@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

The following changes since commit 455281c0ef4e2cabdfe2e8b83fa6010d5210811c:

  loop: remove redundant __GFP_NOWARN flag (2025-10-08 06:27:53 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.18-2025-10-16

for you to fetch changes up to 5a869d017793399fd1d2609ff27e900534173eb3:

  nvme/tcp: handle tls partially sent records in write_space() (2025-10-16 11:32:04 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.18

 - iostats accounting fixed on multipath retries (Amit)
 - secure concatenation response fixup (Martin)
 - tls partial record fixup (Wilfred)

----------------------------------------------------------------
Amit Chaudhary (1):
      nvme-multipath: Skip nr_active increments in RETRY disposition

Martin George (1):
      nvme-auth: update sc_c in host response

Wilfred Mallawa (1):
      nvme/tcp: handle tls partially sent records in write_space()

 drivers/nvme/host/auth.c      | 6 +++++-
 drivers/nvme/host/multipath.c | 6 ++++--
 drivers/nvme/host/tcp.c       | 3 +++
 3 files changed, 12 insertions(+), 3 deletions(-)

