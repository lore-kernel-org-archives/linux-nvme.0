Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE267C02195
	for <linux-nvme@archiver.kernel.org>; Mon,  3 Feb 2025 15:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:To:From:Date:Reply-To:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=NcEt/PM/xUNrQMNDyrteBLjEIUEGTiNqdp8DworkMKM=; b=ZwrIazuSrISFCVvvZG0XIhPunW
	L2DdH1JQLbKgJbcsE+IJz08t+JbR9PG4IKEERHrVLbU/rucdyBVByk0bNKXFK70x1ogLGNvWiSvcX
	JxcwzLodU5MTm8JzIdOH9r20HfFN+lliGtduQfZqwcWnz7TC0qW+BTrnxp/WrPHPFlFj2GIfLQvCH
	yEV68LZyOhP9NTU+w9qVvrmx0Ob5fPcx4ms64+CHDuYTtQNcXjI0Vsn6krY+HG9jWBMwMuju6vJKL
	JgoF4Ny2Teab6MLklWW3kok4pDhF+acuIt0W8LjXcwG9LlwRc3gEXZ86RAhL4Qb4OCTsXSDmSb+HE
	f9KxV7mA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1texz2-0000000FnhR-4Blw;
	Mon, 03 Feb 2025 15:03:33 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1texz0-0000000Fnh0-2JqJ
	for linux-nvme@lists.infradead.org;
	Mon, 03 Feb 2025 15:03:31 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id F3BE2A40D54;
	Mon,  3 Feb 2025 15:01:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 99C07C4CED2;
	Mon,  3 Feb 2025 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1738595008;
	bh=J3QHTtcaWzJUgJ5PUEX2qSOhNrYOmK222n9QT2cQLOo=;
	h=Date:From:To:Subject:From;
	b=sOZ6aRpVC29Yh8SWBnF3dU4r237y+nUeWdv3CM5wzBIK43ibY0ia2ChqwLQpfA7rX
	 oYFT4WmdiGKUaV4lWhfgnX7iLPiHR152fH1z/En1BKyCor/SrkLZRadyT+cB4nUnlq
	 22J7N/pfkYbd8MpTcUSt+kfpk5UJozhmCKWxanAYGLvKbjY6pLHiM552cixwiRaY0X
	 pvf0fekis1fiXkcEwj89AJk3lwFEoRcSEp2piujYvyepyMlIDrgW0yCoI5jDvtIs1D
	 wgXZNf6MQZkkn6lIf8FosKWFnapqnQwvMb2qqXjJmT0njD0WATapLx34MS8A+0nP05
	 YDBvERQzN5w0A==
Date: Mon, 3 Feb 2025 08:03:26 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.14
Message-ID: <Z6DavvYWWh5eWDjr@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250203_070330_653735_55552B27 
X-CRM114-Status: UNSURE (   9.40  )
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

[now with linux-nvme list copied]

The following changes since commit e7b94c5c6f3b6435206f0e4ef7c5aa4eceae42f9:

  Merge tag 'md-6.14-20250113' of https://git.kernel.org/pub/scm/linux/kernel/git/mdraid/linux into for-6.14/block (2025-01-13 10:30:33 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.14-2025-01-31

for you to fetch changes up to c8ed6cb5d37bc09c7e25e49a670e9fd1a3bd1dfa:

  nvme-fc: use ctrl state getter (2025-01-31 10:14:36 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.14

 - Connection fixes for fibre channel transport (Daniel)
 - Endian fixes (Keith, Christoph)
 - Cleanup fix for host memory buffer (Francis)
 - Platform specific power quirks (Georg)
 - Target memory leak (Sagi)
 - Use appropriate controller state accessor (Daniel)

----------------------------------------------------------------
Christoph Hellwig (2):
      nvmet: the result field in nvmet_alloc_ctrl_args is little endian
      nvmet: add a missing endianess conversion in nvmet_execute_admin_connect

Daniel Wagner (4):
      nvme-fc: go straight to connecting state when initializing
      nvme: handle connectivity loss in nvme_set_queue_count
      nvme-fc: do not ignore connectivity loss during connecting
      nvme-fc: use ctrl state getter

Francis Pravin (1):
      nvme-pci: remove redundant dma frees in hmb

Georg Gottleuber (2):
      nvme-pci: Add TUXEDO InfinityFlex to Samsung sleep quirk
      nvme-pci: Add TUXEDO IBP Gen9 to Samsung sleep quirk

Keith Busch (2):
      nvmet: fix rw control endian access
      nvme: make nvme_tls_attrs_group static

Sagi Grimberg (1):
      nvmet: fix a memory leak in controller identify

 drivers/nvme/host/core.c          |  8 +++++++-
 drivers/nvme/host/fc.c            | 35 +++++++++++++++++++++++++----------
 drivers/nvme/host/pci.c           | 12 +++---------
 drivers/nvme/host/sysfs.c         |  2 +-
 drivers/nvme/target/admin-cmd.c   |  1 +
 drivers/nvme/target/fabrics-cmd.c |  2 +-
 drivers/nvme/target/io-cmd-bdev.c |  2 +-
 drivers/nvme/target/nvmet.h       |  2 +-
 8 files changed, 40 insertions(+), 24 deletions(-)


