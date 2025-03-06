Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46AC4C19F32
	for <linux-nvme@archiver.kernel.org>; Thu,  6 Mar 2025 01:39:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=OqjZkkbuxZnJo8Oro6RPW0Rpsbk7s1VDkYfmOpPLiC4=; b=si7XQbgZaWA2NWLt3T9KH8fJwX
	2rWdlD+ymfOHQ0WyhlAsiPg0FpzhRgqg69Zk534l7mPv3jW77rA5pmy8L1zw3J00gcHYOeaRVmW8X
	nm8ouZcG/ioNzvhBMtpIqPoMknsV7pTb70gXaioZRoFEj5r9NBPkH+fyxbH7Xh37B5GmitvL/rdQh
	FBsHF4DNKQDMwf8sahv7j93FgGEjiMv4fNGzerd/bwH5sF40otAUkcNMQ2yKvFP0EPnE0BrkUVib8
	DdHDjgrF9aOBBEY5qTL6QFh6Gz7AfjhfFWEy3OMbO9d01fKAIItAK7WjrX5RYyGqdZKci0CojSQkR
	Rvb0YMzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tq0D3-00000009nl5-1wYw;
	Thu, 06 Mar 2025 01:39:37 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tq0D1-00000009nkk-0qU1
	for linux-nvme@lists.infradead.org;
	Thu, 06 Mar 2025 01:39:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B9A365C6D84;
	Thu,  6 Mar 2025 01:37:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D92A2C4CED1;
	Thu,  6 Mar 2025 01:39:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1741225174;
	bh=k3GzQsqIrYv6ECa/ZaEVT+71xe9jpe3vMRCOHMos8O4=;
	h=Date:From:To:Cc:Subject:From;
	b=TB5MgbrYd7U5rU3KhdUUxgjXB2SWWmdGVhCMB12HBWps8J23yu8UIZ/4GQJhyOsJo
	 YNUIxSXsq3rYokL4gBmU6EEMsfzbGL24SThFwZRBJVyrOvC7wDgsfKKH8+up5JEZ0W
	 vx+eLrEF4lP9A/v+f7hEvwrpONjdx8sWbQiG1b7b1in9LjKeeeTW4fvx5LZSTlHicF
	 20V7ZVoEPxHFlCIB/TtyQ74eGDmUNuyZCqPpjEIturmKMaoq8gmDFLg+MXfobmqros
	 F0n0S2fUNSAhBCIys9IckeGhNxvQynKmd8ULLJKXDZcAE/f3fzFvZEKMg7UIKmwxMv
	 JWMQTuVNxBhGA==
Date: Wed, 5 Mar 2025 18:39:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme fixes for Linux 6.14
Message-ID: <Z8j800qyBDDkQcDh@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250305_173935_283443_25B16751 
X-CRM114-Status: UNSURE (   7.87  )
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

The following changes since commit 70550442f28eba83b3e659618bba2b64eb91575f:

  Merge tag 'nvme-6.14-2025-02-20' of git://git.infradead.org/nvme into block-6.14 (2025-02-20 17:43:59 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.14-2025-03-05

for you to fetch changes up to 528361c49962708a60f51a1afafeb00987cebedf:

  nvme-tcp: fix signedness bug in nvme_tcp_init_connection() (2025-03-05 10:37:01 -0800)

----------------------------------------------------------------
nvme fixes for Linux 6.14

 - TCP use after free fix on polling (Sagi)
 - Controller memory buffer cleanup fixes (Icenowy)
 - Free leaking requests on bad user passthrough commands (Keith)
 - TCP error message fix (Maurizio)
 - TCP corruption fix on partial PDU (Maurizio)
 - TCP memory ordering fix for weakly ordered archs (Meir)
 - Type coercion fix on message error for TCP (Dan)

----------------------------------------------------------------
Dan Carpenter (1):
      nvme-tcp: fix signedness bug in nvme_tcp_init_connection()

Icenowy Zheng (2):
      nvme-pci: clean up CMBMSC when registering CMB fails
      nvme-pci: skip CMB blocks incompatible with PCI P2P DMA

Keith Busch (1):
      nvme-ioctl: fix leaked requests on mapping error

Maurizio Lombardi (3):
      nvmet: remove old function prototype
      nvme-tcp: Fix a C2HTermReq error message
      nvme-tcp: fix potential memory corruption in nvme_tcp_recv_pdu()

Meir Elisha (1):
      nvmet-tcp: Fix a possible sporadic response drops in weakly ordered arch

Sagi Grimberg (1):
      nvme-tcp: fix possible UAF in nvme_tcp_poll

 drivers/nvme/host/ioctl.c   | 12 ++++++++----
 drivers/nvme/host/pci.c     | 21 +++++++++++++--------
 drivers/nvme/host/tcp.c     | 45 ++++++++++++++++++++++++++++++++++++---------
 drivers/nvme/target/nvmet.h |  1 -
 drivers/nvme/target/tcp.c   | 15 +++++++++++----
 5 files changed, 68 insertions(+), 26 deletions(-)

