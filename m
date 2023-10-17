Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9F9F4CDB474
	for <linux-nvme@archiver.kernel.org>; Tue, 17 Oct 2023 21:09:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=QcAV0sVN+EOXN8pT7cy/8bK3xnXMTx5EIcV2REN+Vq8=; b=mlRzLoVKizkJ+RHWKNwOmSb8dj
	ClJkH+j5RGHDecDb5edkR/e2eiSMcKXFKE12XCO9lBti6ClsSth2ttYN2FGCxVm+XN0Gf9YjdsZYN
	YsKr6GPMe8pD0/c5rhk7G9g7AcjhN+9P2Xf7d2jlsqWst9aOSLOqQr3b14sx8JlXPRgG6fsiAqHl+
	+trx6Y/nLy/JDujTCLRSiLTxpgJmLFOmyU4fQ4mk5eDPzUCN/FujcMxvOZu54LNNvsWAj4Z7q2T9L
	XP5c5vE0/ZMLrebkO73Eir13Q+2v//KI0Iqmr6+C2fAGuxpC5n8MEUnFl6IeFRYgyZ9YvgmCirNoD
	fmpPNeSw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qsrJQ-00DGlh-1k;
	Tue, 17 Oct 2023 21:09:12 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qsrJN-00DGlB-1v
	for linux-nvme@lists.infradead.org;
	Tue, 17 Oct 2023 21:09:11 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id AF1C3CE220C;
	Tue, 17 Oct 2023 21:09:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97098C433C7;
	Tue, 17 Oct 2023 21:09:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1697576945;
	bh=cqp4SL3P2n8rhnRRxKwrS2fTt1A+Y7o1Hz6EwLMaf7E=;
	h=Date:From:To:Cc:Subject:From;
	b=cGgyDAioLge9IuIBzuGRRlLJkmdxJ7/K6OrexKhWjs714dzeJY5bYgb5//ukJaePF
	 BWIsSbZ/5aKv79/WASPHJYRAeEqR0uelJYdm1V59klLEzZFUYDu2ntYnuhk7ThpSms
	 TXi+X+HohEM8g5irarlzGvNjSXYz/TdF10lTmf8mznH/k7frruKQIJ/v9ouA3qECeh
	 EiLPJaKwxcOU1izXHXTVbIVqsd6DEhyF2hIjeobaQyEaAR7VSRelP175X8QvaHLllQ
	 oMPNygTF7AelsVrN53oe2p5HfIZLrsDudlowG/dfE9M/YVqaJ+OlDSO5uBCLvAC/9Y
	 SulXCeUhNynDA==
Date: Tue, 17 Oct 2023 15:09:03 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: [GIT PULL] nvme updates for Linux 6.7
Message-ID: <ZS7376V7Q6-6cgxD@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20231017_140909_985371_5A169C16 
X-CRM114-Status: GOOD (  10.00  )
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

The following changes since commit 5e9b7cfc209b84d135993b8cb75ea383f24b2bba:

  aoe: replace strncpy with strscpy (2023-10-03 18:23:48 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.7-2023-10-17

for you to fetch changes up to 32445526d836f827ea7e74ef933610b531d239df:

  nvme-auth: allow mixing of secret and hash lengths (2023-10-17 13:57:55 -0700)

----------------------------------------------------------------
nvme updates for Linux 6.7

 - nvme-auth updates (Mark)
 - nvme-tcp tls (Hannes)
 - nvme-fc annotaions (Kees)

----------------------------------------------------------------
Hannes Reinecke (20):
      nvme-keyring: register '.nvme' keyring
      nvme-keyring: define a 'psk' keytype
      nvme: add TCP TSAS definitions
      nvme-tcp: add definitions for TLS cipher suites
      nvme-keyring: implement nvme_tls_psk_default()
      security/keys: export key_lookup()
      nvme-tcp: allocate socket file
      nvme-tcp: enable TLS handshake upcall
      nvme-tcp: control message handling for recvmsg()
      nvme-tcp: improve icreq/icresp logging
      nvme-fabrics: parse options 'keyring' and 'tls_key'
      nvmet: make TCP sectype settable via configfs
      nvmet-tcp: make nvmet_tcp_alloc_queue() a void function
      nvmet-tcp: allocate socket file
      nvmet: Set 'TREQ' to 'required' when TLS is enabled
      nvmet-tcp: enable TLS handshake upcall
      nvmet-tcp: control messages for recvmsg()
      nvmet-tcp: peek icreq before starting TLS
      nvme: rework NVME_AUTH Kconfig selection
      nvmet-tcp: use 'spin_lock_bh' for state_lock()

Kees Cook (1):
      nvmet-fc: Annotate struct nvmet_fc_tgt_queue with __counted_by

Mark O'Donovan (3):
      nvme-auth: alloc nvme_dhchap_key as single buffer
      nvme-auth: use transformed key size to create resp
      nvme-auth: allow mixing of secret and hash lengths

 drivers/nvme/common/Kconfig    |  13 +++++++++++++
 drivers/nvme/common/Makefile   |   3 ++-
 drivers/nvme/common/auth.c     |  68 +++++++++++++++++++++++++++++++++++++----------------------------
 drivers/nvme/common/keyring.c  | 182 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/Kconfig      |  24 ++++++++++++++++-------
 drivers/nvme/host/Makefile     |   2 +-
 drivers/nvme/host/auth.c       |  30 ++++++++++++++---------------
 drivers/nvme/host/core.c       |  14 ++++++++++----
 drivers/nvme/host/fabrics.c    |  67 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 drivers/nvme/host/fabrics.h    |   9 +++++++++
 drivers/nvme/host/nvme.h       |   5 +++--
 drivers/nvme/host/sysfs.c      |  27 +++++++++++++++++++++++---
 drivers/nvme/host/tcp.c        | 184 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-----------
 drivers/nvme/target/Kconfig    |  22 +++++++++++++++------
 drivers/nvme/target/auth.c     |  31 ++++++++++++++++--------------
 drivers/nvme/target/configfs.c | 128 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++---
 drivers/nvme/target/fc.c       |   3 ++-
 drivers/nvme/target/nvmet.h    |  11 +++++++++++
 drivers/nvme/target/tcp.c      | 338 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++-------------------------------
 include/linux/key.h            |   1 +
 include/linux/nvme-auth.h      |   7 +++++--
 include/linux/nvme-keyring.h   |  36 +++++++++++++++++++++++++++++++++++
 include/linux/nvme-tcp.h       |   6 ++++++
 include/linux/nvme.h           |  10 ++++++++++
 security/keys/key.c            |   1 +
 25 files changed, 1090 insertions(+), 132 deletions(-)
 create mode 100644 drivers/nvme/common/keyring.c
 create mode 100644 include/linux/nvme-keyring.h

