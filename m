Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14829C28B30
	for <linux-nvme@archiver.kernel.org>; Fri, 21 Mar 2025 00:04:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MqDfdTZX49Ro6CYT+WrSsJozfYAYlbcLySx6v0PRYtM=; b=DAtleqhaw8SXHWfvODDKx6iAfO
	6wlbOyLBPS4uDhXYSM+JM05maCG9/fiK2M9WGk5R7OBa3K+CAbpZj+O+ZV09mQjOtSQqmclwsYbDA
	vpX2T6XDe+teHVtI6/ATv1UKIRTtf2QYxwo8CVmAWaSbkdT6u45p/eb5GC1Bk9KK9USiRkgekd4oO
	BzbORyOOCWEzii4MtFqAuJTODM0XvkPam7zzuh/j6FRIkYcfs2AF4MSS0m9hih+Y8HXJBpTK1H/lG
	qQh+kysu6MHWisLgXp1luZUJmj7LUuJrujYejHcVaolGOW4C4lF1FfwUOpEVLoDb1FxDEQuCQ0vtP
	2IzQ86yg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tvPsa-0000000DVi0-23cI;
	Fri, 21 Mar 2025 00:04:52 +0000
Received: from sea.source.kernel.org ([172.234.252.31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tvPsY-0000000DVhZ-0NxI
	for linux-nvme@lists.infradead.org;
	Fri, 21 Mar 2025 00:04:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2D9C243D07;
	Fri, 21 Mar 2025 00:04:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28330C4CEDD;
	Fri, 21 Mar 2025 00:04:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1742515489;
	bh=60H99sDjQAFsZSWPV4GSluf0TZU4gw2JVSNRo7jafnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=HY6eQvkwT6WS/ATM7vjwbjPSv4l8rxU4cnEMVefiXinuTiJTQleTUGvXh6TknOoDe
	 1vL63jX0GTanMg57b/DhafpXFDUO5BzQelWVpKzkFAWQvpSN6JZXBoR39Vpyk6LAHx
	 OoHRZvbwFKNudtJ0u8gzG8HkII1Dq1urLQ7cU7vA4MdTo4NGuStcQPTDbyompShOwt
	 CEPJBWldUb8AxNm8amDAJL8HD0XZ+rD1CJfpe6wI3bNK8eRi4gw0pfWdccgPYVAoPf
	 wluSzp/hkQq+fD19cUWlx9Uq3RCqebQoHQtzuphn/GR+MWr+jYwm9DIlCXk/2rlteR
	 sRPkUd5ugMemg==
Date: Thu, 20 Mar 2025 18:04:46 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [GIT PULL] nvme updates for Linux 6.15
Message-ID: <Z9ytHt3tpEMsTcbN@kbusch-mbp>
References: <Z9x9U4DQA_a2erBK@kbusch-mbp.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Z9x9U4DQA_a2erBK@kbusch-mbp.dhcp.thefacebook.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250320_170450_175065_394049D9 
X-CRM114-Status: GOOD (  12.43  )
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

Sending a rebased pull: our trees were out of sync in the previous pull
request.

The following changes since commit fc22b34e95ce0a294c797c397a9db671e6ff4448:

  docs: sysfs-block: Clarify integrity sysfs attributes (2025-03-20 05:44:09 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.15-2025-03-20

for you to fetch changes up to 64ea88e3afa8c5b6c3f9c477da304b7a56149612:

  nvmet: replace max(a, min(b, c)) by clamp(val, lo, hi) (2025-03-20 16:53:56 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.15

 - Secure concatenation for TCP transport (Hannes)
 - Multipath sysfs visibility (Nilay)
 - Various cleanups (Qasim, Baruch, Wang, Chen, Mike, Damien, Li)
 - Correct use of 64-bit BARs for pci-epf target (Niklas)
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


