Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72C50FA3757
	for <linux-nvme@archiver.kernel.org>; Fri, 13 Sep 2024 14:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=cH1XimKF4rFdsinPitsBlVNW42FEIVbS09TmuzLKsAc=; b=iR3LTqtPEXN7ouJkBd1dGhmnoO
	GTJVfXFLjgM0XNtHuzkluEuuGRJa0cOpKZhKLE5kriP3PY5+Vsy6HQWvknr6hqJGl3/DpYxBwaV1p
	OoEECZwC+7JzTYpLSOkkRkUehlmPRanyH3VGVOkkgQyWLzPqRkwZu4ybr7zlCBxTaEVrnKrD7+dvN
	7wqJdESwYpZ9C9qhl7+MBhtahAnFuFjKotZf1QRqzwg4NgoxuAPA9tjuPF7ECKeT/v/k/gMaFWEZP
	IbMM/131tjHDiYcxXnLvUYOkD0hjmPnL98N+7JdVLvUMCejusnkNzV+jrm6+hcWNzy0hF6HnNgoux
	xj+L3Lnw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7NE-0000000GCKK-2hWY;
	Fri, 13 Sep 2024 14:34:12 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sp7NB-0000000GCJU-0pgs
	for linux-nvme@lists.infradead.org;
	Fri, 13 Sep 2024 14:34:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 855455C1095;
	Fri, 13 Sep 2024 14:34:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 79155C4CEC0;
	Fri, 13 Sep 2024 14:34:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726238047;
	bh=CQIIimA3i5fVOtxW9gCAYGX0UgrOmJvG0ZmHXQ6mS08=;
	h=Date:From:To:Cc:Subject:From;
	b=AXJttev6Wyqo6y6MVHI019Wg4g3lwSR7q0v2M5FUgoe+GGH5V3zQSNs4o2Rmi6kcv
	 jZthFOI8RgidTMd1PsArFtsjYMgD7kBZ65Byw6trek97e7e+eaEGoBiAZ30Ibt5KaP
	 5qwBEfrFulVQIMOY7UIRAJqnaIVZay6tBASJXNF90MgrXhGiik5uhM5kaz9JJAMhY0
	 049a+isucG+fSEp/yjDaKKD7mYNHXVzUsnSzg7dME3s/jhTJIlMRmaqD1OAmm7KiVN
	 i5ve4lVx4n7QMXUVBu1R4tjwr81x/wIl8SSSZm3V8vzQdqcU9IhIuKxeHfti6e2W5U
	 RIYEp2kEp3KsA==
Date: Fri, 13 Sep 2024 08:34:04 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme fixes for linux 6.12
Message-ID: <ZuRNXAVHqQJngQKe@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240913_073409_299310_5EB6A77C 
X-CRM114-Status: UNSURE (   6.97  )
X-CRM114-Notice: Please train this message.
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

Sending a follow up sooner than usual: the important fix here is for a
potential build error for certain configs.

The following changes since commit 68f31e88917f5608eb8da0bef37249648ffd48d4:

  Merge tag 'md-6.12-20240906' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.12/block (2024-09-06 14:43:16 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.12-2024-09-13

for you to fetch changes up to 83bdfcbdbe5d901c5fa432decf12e1725a840a56:

  nvme-pci: qdepth 1 quirk (2024-09-13 07:29:30 -0700)

----------------------------------------------------------------
nvme fixes for Linux 6.12

 - A syntax cleanup (Shen)
 - Fix a Kconfig linking error (Arnd)
 - New queue-depth quirk (Keith)

----------------------------------------------------------------
Arnd Bergmann (1):
      nvme-tcp: fix link failure for TCP auth

Keith Busch (1):
      nvme-pci: qdepth 1 quirk

Shen Lichuan (1):
      nvme: Convert comma to semicolon

 drivers/nvme/host/Kconfig |  2 +-
 drivers/nvme/host/core.c  |  2 +-
 drivers/nvme/host/nvme.h  |  5 +++++
 drivers/nvme/host/pci.c   | 18 +++++++++---------
 4 files changed, 16 insertions(+), 11 deletions(-)

