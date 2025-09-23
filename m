Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EC34BCAC5AC
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Sep 2025 22:45:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pLg5ga1CImpozqQ/92CVQKWeMfwKFwWU4kfoQvG06NI=; b=AP6xqgxno9oABtHNWWOAypRubf
	yeO0fqxf7uaNXhy/OFm4VtetoOo2/4rI7vm6NmB26CLt9gB7B9MJvbiK4txFTEm0R34Vmi6IwsNXa
	yduXCjXL50l/yhK+W8NAjypRkfqHRYcfcCd1k0Bt3N7tATYL39m8K2u6P6yCEx0u+YDJ7kubyLEPk
	JEejZqyjLqTWaQALRn6RsmePy1brETKRAC9MhVint5R+EZvNsR7+RkdfMbyWeK1ii5tTHkQYlbe7t
	cRQSeS1juyHbKuDIcZTnZty5icjBma9xhe6HHIyWy+RkzaBgzoqyIvCMx9TB5hGF7btmrpV4x/kK4
	NPk66wvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Bkx-0000000F6cF-0Yki;
	Tue, 23 Sep 2025 22:45:07 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1v1Bkv-0000000F6bu-0P0X
	for linux-nvme@lists.infradead.org;
	Tue, 23 Sep 2025 22:45:06 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 6E47C4455B;
	Tue, 23 Sep 2025 22:45:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1870CC4CEF5;
	Tue, 23 Sep 2025 22:45:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1758667504;
	bh=0aEiYD+q3ZRre/L62z1l3O0OWM12GoXO3/hd0CpHRsw=;
	h=Date:From:To:Cc:Subject:From;
	b=GTpSPhSRyXqjwyz9WMr4LQjyGLgzmIp97caIkCQ4WqZkA/K27cvpoQzznY7ceavLf
	 qstUaxY6UIWuNKVf6HXS16nd2ryqN8lZHfo7ULvQ0xComL5Oy6qEpAJM+1qTRBTmvq
	 GCp++TOKmfCt0zIpwWSD2YIxA8/TfoaOnj9y7mbxxB9FnMqhcnZrZ2ycqEcjSkMuI2
	 DSPqnKDnU6E+LwxhcxZw8/T4QvmxBGRvcQUcH7hJowU/2tztRTKepshXnYhey9jrFY
	 xa3E4Cf/2Z2psrPjiddFrx44ZCcUVv/R5NaqHhijWYPJ+kehK6IPbBxYlhTGVDMinm
	 5S3PDzjDBQdDw==
Date: Tue, 23 Sep 2025 16:45:02 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, linux-nvme@lists.infradead.org, chaitanyak@nvidia.com
Subject: [GIT PULL] nvme updates for linux 6.18
Message-ID: <aNMi7ggly46pZGzm@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250923_154505_173961_20AEBCE2 
X-CRM114-Status: UNSURE (   8.34  )
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

The following changes since commit 34585dc649fb255b40075dab56af063c1bfc9933:

  rnull: add soft-irq completion support (2025-09-02 05:23:56 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.18-2025-09-23

for you to fetch changes up to 2e482655019ab6fcfe8865b62432c6d03f0b5f80:

  nvme: Use non zero KATO for persistent discovery connections (2025-09-23 15:38:28 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.18

 - FC target fixes (Daniel)
 - Authentication fixes and updates (Martin, Chris)
 - Admin controller handling (Kamaljit)
 - Target lockdep assertions (Max)
 - Keep-alive updates for discovery (Alastair)
 - Suspend quirk (Georg)

----------------------------------------------------------------
Alistair Francis (1):
      nvme: Use non zero KATO for persistent discovery connections

Chris Leech (2):
      nvme-auth: add hkdf_expand_label()
      nvme-auth: use hkdf_expand_label()

Daniel Wagner (4):
      nvmet-fc: move lsop put work to nvmet_fc_ls_req_op
      nvmet-fc: avoid scheduling association deletion twice
      nvmet-fcloop: call done callback even when remote port is gone
      nvme-fc: use lock accessing port_state and rport state

Georg Gottleuber (1):
      nvme-pci: Add TUXEDO IBS Gen8 to Samsung sleep quirk

Kamaljit Singh (2):
      nvme-core: add method to check for an I/O controller
      nvme-core: do ioccsz/iorcsz validation only for I/O controllers

Martin George (3):
      nvme-auth: update bi_directional flag
      nvme-tcp: send only permitted commands for secure concat
      nvme-core: use nvme_is_io_ctrl() for I/O controller check

Max Gurtovoy (1):
      nvmet: add safety check for subsys lock

 drivers/nvme/common/auth.c   | 86 +++++++++++++++++++++++++++++++++-----------
 drivers/nvme/host/auth.c     |  5 +--
 drivers/nvme/host/core.c     | 19 +++++++---
 drivers/nvme/host/fc.c       | 10 ++++--
 drivers/nvme/host/pci.c      |  2 ++
 drivers/nvme/host/tcp.c      |  3 ++
 drivers/nvme/target/core.c   | 15 ++++----
 drivers/nvme/target/fc.c     | 35 +++++++++---------
 drivers/nvme/target/fcloop.c |  8 +++--
 9 files changed, 126 insertions(+), 57 deletions(-)


