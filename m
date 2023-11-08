Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02FC3C4332F
	for <linux-nvme@archiver.kernel.org>; Wed,  8 Nov 2023 16:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=AqkC5oxMQzwCqHYhLAoKAZIEP3LZ0MpzDT9sse2lnE0=; b=ZZhMHHF03Kl36m8DSLuf066T4h
	xYWdJed7cOwNf097aBHXLz6io7CEyl0TmKEy9+koa+73eE9+1FaY/bY0zLrAwMmI8DGWbaSRsPJzt
	qUyizM0e9XhN9q/8alxYylpjwAUkAxihcChg6zsWWeRTdRgTZR8gHkSfFWabamalisoXntZzcV2T9
	h4ISI3/NmwhUhBNuOx8pMYUaWeB3FrA1siP7MbkUIfNpFs9Du+zwsYWSn9iqu9r+uQavyGIW/ZS6R
	U1HrPJBOEJeerOd+kTc8IYhdnnjmusrJCBWO2HboKuL3HFac6u5weIjZLNHXvIlKUOqNLKbfUVa6X
	e6vziDIQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1r0lDR-004H4G-2K;
	Wed, 08 Nov 2023 16:15:41 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1r0lDP-004H3x-0z
	for linux-nvme@lists.infradead.org;
	Wed, 08 Nov 2023 16:15:40 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 6D1566155E;
	Wed,  8 Nov 2023 16:15:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD9B1C433C7;
	Wed,  8 Nov 2023 16:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1699460138;
	bh=c4O+OOVwoTENc5zPJctFY2uQG4i85h6fJRCiy9MHC2U=;
	h=Date:From:To:Cc:Subject:From;
	b=DPuxTmvM3EUFqY6hANv5IQY3DVFOq2LbhJvQjrEWAVnmuz98apC5P0Yp2gjQ9+PG9
	 1GV2gSaC9Nf9wLKHggXEeHZbeKSUC9aOP5aKKpyp+UDcKN2EkwySsGNxSytIZx0ME8
	 vFnCvMniyHAHJp2Sr21TdTXZXzlvz2gS6xwgHd0n8ck7EVmEFXBBr+Yee3THLxR2Ol
	 Bg40Bl7srB/2tZxMUKRtn+QuNy6ZA8hWKGTwh56zFF/Iy8mTfMxKuAKmWFqDdizX94
	 i5lx0jdPiQ0UGHkcdP4x7OxknPNx1Z16Jp3yJ5bsSn17cVM7kUZ4o2SjUM5qgJ5JTD
	 nhXAIBWR+h9Ow==
Date: Wed, 8 Nov 2023 09:15:35 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de
Subject: [GIT PULL] nvme fixes for 6.7
Message-ID: <ZUu0J09yJmK72bKa@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231108_081539_406072_86D0479B 
X-CRM114-Status: UNSURE (   8.33  )
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

The following changes since commit d2f51b3516dade79269ff45eae2a7668ae711b25:

  Merge tag 'rtc-6.7' of git://git.kernel.org/pub/scm/linux/kernel/git/abelloni/linux (2023-11-05 18:49:40 -0800)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.7-2023-11-8

for you to fetch changes up to 706add13676da7ad213b65e92b94af5efc8c4131:

  nvme: keyring: fix conditional compilation (2023-11-08 08:07:08 -0800)

----------------------------------------------------------------
nvme fixes for 6.7

 - nvme keyring config compile fixes (Hannes and Arnd)
 - fabrics keep alive fixes (Hannes)
 - tcp authentication fixes (Mark)
 - io_uring_cmd error handling fix (Anuj)
 - stale firmware attribute fix (Daniel)
 - tcp memory leak (Christophe)
 - cytpo library usage simplification (Eric)

----------------------------------------------------------------
Anuj Gupta (1):
      nvme: fix error-handling for io_uring nvme-passthrough

Arnd Bergmann (1):
      nvme: common: make keyring and auth separate modules

Christophe JAILLET (1):
      nvme-tcp: Fix a memory leak

Daniel Wagner (1):
      nvme: update firmware version after commit

Eric Biggers (1):
      nvme-auth: use crypto_shash_tfm_digest()

Hannes Reinecke (4):
      nvme-tcp: avoid open-coding nvme_tcp_teardown_admin_queue()
      nvme-loop: always quiesce and cancel commands before destroying admin q
      nvme: start keep-alive after admin queue setup
      nvme: keyring: fix conditional compilation

Mark O'Donovan (3):
      nvme-auth: auth success1 msg always includes resp
      nvme-auth: add flag for bi-directional auth
      nvme-auth: always set valid seq_num in dhchap reply

 drivers/nvme/Makefile                  |  2 +-
 drivers/nvme/common/Kconfig            |  7 ++-----
 drivers/nvme/common/Makefile           |  7 ++++---
 drivers/nvme/common/auth.c             | 23 ++---------------------
 drivers/nvme/common/keyring.c          | 11 +++++++----
 drivers/nvme/host/Kconfig              |  2 --
 drivers/nvme/host/auth.c               | 13 ++++++-------
 drivers/nvme/host/core.c               | 30 ++++++++++++++++++------------
 drivers/nvme/host/fc.c                 |  6 ++++++
 drivers/nvme/host/ioctl.c              |  7 +++++--
 drivers/nvme/host/tcp.c                |  9 +++------
 drivers/nvme/target/Kconfig            |  2 --
 drivers/nvme/target/fabrics-cmd-auth.c |  2 +-
 drivers/nvme/target/loop.c             |  4 ++++
 include/linux/nvme-keyring.h           | 10 +---------
 include/linux/nvme.h                   |  2 +-
 16 files changed, 61 insertions(+), 76 deletions(-)


