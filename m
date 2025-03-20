Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A0EC28B30
	for <linux-nvme@archiver.kernel.org>; Thu, 20 Mar 2025 20:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=8ls+P2lKhBpMaTcD3tm+s1IkLkWTPnVTQ96KJmIfLIk=; b=M95pY+gAinGwOCLdZ309VqDeK2
	+b7j+2t9aH0Y8x6RuLzelW21h6fg/vaZQPwWzW1oaI63N350rSBB3PtIi8XIEQA9+4H1i9t62gVXk
	vM3gyiQZWnaJf/nn/dd6Y9xM3Nz03/KJrz/1ptYxfkg5Elgp1K7wxrUaS7IXA+ogavO2npUiMRj3/
	QHo3BS68Yy1H6d6kiM2xFQ6NDkM9GJQz7UkNc05iTTQKyKZ5awKHKH9VwMsD62FodLnJlejnee45c
	AcLgXFJQbiIoY96kAhHKGyeiNWQe8HXIj5TT0dz4xGPlV8cs0/I1eJbwe+6lCQ4z9LsytzgqrYReS
	FmUwmI5w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvMhE-0000000DBKD-2rrz;
	Thu, 20 Mar 2025 20:40:56 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvMhC-0000000DBK5-2mke
	for linux-nvme@lists.infradead.org;
	Thu, 20 Mar 2025 20:40:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 3DE1261141;
	Thu, 20 Mar 2025 20:40:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D950C4CEDD;
	Thu, 20 Mar 2025 20:40:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742503253;
	bh=gokjHWRdSOboYgUDu+yoX9kKPzGDrzfYNKbNT2NNu+k=;
	h=Date:From:To:Cc:Subject:From;
	b=QY74GIgY+pa9nAAvxX9KyVPM/1gqKvSh8qJjNXbVKuP9jaWQzhQYoXvfRCL8bFLS4
	 QuNs/dOpSHkfnlUhh4RLLhmBsMweR3rh9BdiobSdsvj8Kk9p/kNa7K/LyGgCJHGhEA
	 ytbWcCeZLTrIgMQFVoDJMxbRQj6s65jFRdXTeQ2qdU0aVjNfb+1OwgbgP4hv56dkNo
	 irRRtuG3tq59+xSI3CL5b+YKAZTzeOvPQrB5He3vfWvvex3XWkGejOggiissg2knBf
	 8EBSNFGny2tjHJXHX3FtB9jqosu7aLXIM07X91uX5aYPg/Gdl0FYl0frWV99qdU3BR
	 Q08U5uObvmoPw==
Date: Thu, 20 Mar 2025 14:40:51 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme updates for Linux 6.15
Message-ID: <Z9x9U4DQA_a2erBK@kbusch-mbp.dhcp.thefacebook.com>
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

The following changes since commit 9fcc4add3c0d6e43788d55bf7a957c1d4de8584a:

  ublk: add DMA alignment limit (2025-02-27 07:58:13 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-03-20

for you to fetch changes up to 8c38a7ac3ef5b09d438479f018280e65c4d52d09:

  nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi) (2025-03-20 13:10:56 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.15

 - Secure concatenation for TCP transport (Hannes)
 - Multipath sysfs visibility (Nilay)
 - Various cleanups (Qasim, Baruch, Wang, Chen, Mike, Damien, Li)
 - Correct use of 64-bit BARs for pci-epf (Niklas)
 - Socket fix for selinux when used in containers (Peijie)

----------------------------------------------------------------
Baruch Siach (1):
      nvme-pci: remove stale comment

Chen Ni (1):
      nvmet: pci-epf: Remove redundant 'flush_workqueue()' calls

Damien Le Moal (1):
      nvme: zns: Simplify nvme_zone_parse_entry()

Hannes Reinecke (10):
      crypto,fs: Separate out hkdf_extract() and hkdf_expand()
      nvme: add nvme_auth_generate_psk()
      nvme: add nvme_auth_generate_digest()
      nvme: add nvme_auth_derive_tls_psk()
      nvme-keyring: add nvme_tls_psk_refresh()
      nvme-tcp: request secure channel concatenation
      nvme-fabrics: reset admin connection for secure concatenation
      nvmet: Add 'sq' argument to alloc_ctrl_args
      nvmet-tcp: support secure channel concatenation
      nvmet: add tls_concat and tls_key debugfs entries

Li Haoran (1):
      nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi)

Mike Christie (1):
      nvmet: Remove duplicate uuid_copy

Niklas Cassel (1):
      nvmet: pci-epf: Always configure BAR0 as 64-bit

Nilay Shroff (3):
      nvme-multipath: Add visibility for round-robin io-policy
      nvme-multipath: Add visibility for numa io-policy
      nvme-multipath: Add visibility for queue-depth io-policy

Peijie Shao (1):
      nvme-tcp: fix selinux denied when calling sock_sendmsg

Qasim Ijaz (1):
      nvme-fc: Utilise min3() to simplify queue count calculation

WangYuli (1):
      nvmet-fc: Remove unused functions

 crypto/Kconfig                         |   6 +
 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 573 +++++++++++++++++++++++++++++++++
 drivers/nvme/common/Kconfig            |   1 +
 drivers/nvme/common/auth.c             | 337 +++++++++++++++++++
 drivers/nvme/common/keyring.c          |  65 +++-
 drivers/nvme/host/Kconfig              |   2 +-
 drivers/nvme/host/auth.c               | 115 ++++++-
 drivers/nvme/host/core.c               |   3 +
 drivers/nvme/host/fabrics.c            |  34 +-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/fc.c                 |   4 +-
 drivers/nvme/host/multipath.c          | 138 ++++++++
 drivers/nvme/host/nvme.h               |  22 +-
 drivers/nvme/host/pci.c                |   3 -
 drivers/nvme/host/sysfs.c              |  24 +-
 drivers/nvme/host/tcp.c                |  67 +++-
 drivers/nvme/host/zns.c                |  10 +-
 drivers/nvme/target/auth.c             |  72 ++++-
 drivers/nvme/target/core.c             |   9 +-
 drivers/nvme/target/debugfs.c          |  27 ++
 drivers/nvme/target/fabrics-cmd-auth.c |  60 +++-
 drivers/nvme/target/fabrics-cmd.c      |  25 +-
 drivers/nvme/target/fc.c               |  14 -
 drivers/nvme/target/nvmet.h            |  40 ++-
 drivers/nvme/target/pci-epf.c          |  12 +-
 drivers/nvme/target/tcp.c              |  32 +-
 fs/crypto/Kconfig                      |   1 +
 fs/crypto/hkdf.c                       |  85 +----
 include/crypto/hkdf.h                  |  20 ++
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |  12 +-
 include/linux/nvme.h                   |   7 +
 33 files changed, 1685 insertions(+), 146 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h


