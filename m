Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 24F36FED3F2
	for <linux-nvme@archiver.kernel.org>; Fri, 24 Apr 2026 17:49:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=G0zXiVNOOt1kMo1dOVDlPFoXnHSjsSjiYp+Y7hqw4QM=; b=OHA3absbII4bHFbKSsu+7qUwCe
	n59lkOah0mQO39g8vYdIBtAbO9ML4M5xFUkyThLSmcsRXlbTDm7HOQn0jPSP/DFsDUPftUc1wK77K
	n/eLxDlbS07occMeICmSxgSvOtEwaO8hkMEWnVxZhaSgJp5dcsQm7UQ7NXrc3NhRzLvyPuiDRjXWz
	QESWzvkGw06hg8gxpwEHz0ZUOlyoOGNE0peliMxlQQHTzpI2oGVMWAjk3gmR2rF5UzWKXZ69SONQz
	BIN9Pi6h9AcHJTnw6T7Vcr7DXcZaOaDTlTMU4YbiUm+d0n1AQU3L5lJnRcOgthuqKRynKa0bilKgi
	mDm9fHcQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGKel-0000000DbaR-3eyz;
	Fri, 24 Apr 2026 17:49:35 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1wGKek-0000000DbaH-1JxO
	for linux-nvme@lists.infradead.org;
	Fri, 24 Apr 2026 17:49:34 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id EA79D600AE;
	Fri, 24 Apr 2026 17:49:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 80656C19425;
	Fri, 24 Apr 2026 17:49:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777052971;
	bh=i1JeNOTOX20gAmGrgwxJBJTPAM0aQle4I5k4TIqw00A=;
	h=Date:From:To:Cc:Subject:From;
	b=N7BX0CjNryxijLC2vt5xoxNBI2f1GVSLnyMnCqY+D+1LUcNbVVKYnXrzpRYreXvoV
	 +nNP7y9pEqhexyjO5Ihpe6vRhrmOnCYSz+gCt9NUB3eNiTESNTMK0qHATagY1Xco5D
	 s0cONTh8JEvA4uN9geMtLSd2CjNWXRSqpb3a7P+3TVqoCx0TINL9Lne8QqcoHcSnea
	 wodQqDViNU1himS2kL3AKnev64oMriFYYinJsJ3YpGl6cI7hwqaaWuKPrM3W7jk5pV
	 9ew6t4yh3I4jD0qEJ6l+g/3oWXEV4YY2ZmA4YxsQjXYIQlyLXrNW+sLmkWVTzEkLl8
	 1ze+rL7OXLJ6w==
Date: Fri, 24 Apr 2026 11:49:29 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 7.1
Message-ID: <aeutKVHQDxuEfEVn@kbusch-mbp>
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

I realize I missed the pull for this week, but sending this now just to
get into your queue in case other distractions get my way again.

The following changes since commit e9b004ff83067cdf96774b45aea4b239ace99a2f:

  blk-wbt: remove WARN_ON_ONCE from wbt_init_enable_default() (2026-04-06 12:54:03 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.1-2026-04-24

for you to fetch changes up to bd7b7ce96db4487bb77692a85ee4489fd2c395df:

  nvme-auth: Hash DH shared secret to create session key (2026-04-22 13:02:16 -0700)

----------------------------------------------------------------
nvme fixes for Linux 7.1

 - Target data transfer size confiruation (Aurelien)
 - Enable P2P for RDMA (Shivaji Kant)
 - TCP target updates (Maurizio, Alistair, Chaitanya, Shivam Kumar)
 - TCP host updates (Alistair, Chaitanya)
 - Authentication updates (Alistair, Daniel, Chris Leech)
 - Multipath fixes (John Garry)
 - New quirks (Alan Cui, Tao Jiang)
 - Apple driver fix (Fedor Pchelkin)
 - PCI admin doorbell update fix (Keith)

----------------------------------------------------------------
Alan Cui (1):
      nvme: add quirk NVME_QUIRK_IGNORE_DEV_SUBNQN for 144d:a808 (Samsung PM981/983/970 EVO Plus )

Alistair Francis (3):
      Revert "nvmet-tcp: Don't free SQ on authentication success"
      nvmet-tcp: Don't clear tls_key when freeing sq
      nvme-auth: Include SC_C in RVAL controller hash

Aurelien Aptel (1):
      nvmet: introduce new mdts configuration entry

Chaitanya Kulkarni (3):
      nvmet-tcp: fix race between ICReq handling and queue teardown
      nvmet: avoid recursive nvmet-wq flush in nvmet_ctrl_free
      nvme-tcp: teardown circular locking fixes

Chris Leech (1):
      nvme-auth: Hash DH shared secret to create session key

Daniel Wagner (1):
      nvme: expose TLS mode

Fedor Pchelkin (1):
      nvme-apple: drop invalid put of admin queue reference count

Flavio Suligoi (1):
      nvme-core: fix parameter name in comment

Geliang Tang (1):
      nvme: add missing MODULE_ALIAS for fabrics transports

John Garry (2):
      nvme-multipath: drop head pointer check in nvme_mpath_clear_current_path()
      nvme-multipath: put module reference when delayed removal work is canceled

Keith Busch (2):
      nvme: skip trace completion for host path errors
      nvme-pci: fix missed admin queue sq doorbell write

Maurizio Lombardi (2):
      nvmet-tcp: propagate nvmet_tcp_build_pdu_iovec() errors to its callers
      nvmet-tcp: remove redundant calls to nvmet_tcp_fatal_error()

Shivaji Kant (1):
      nvme: enable PCI P2PDMA support for RDMA transport

Shivam Kumar (1):
      nvmet-tcp: check INIT_FAILED before nvmet_req_uninit in digest error path

Tao Jiang (1):
      nvme-pci: add quirk for Memblaze Pblaze5 (0x1c5f:0x0555)

 drivers/nvme/common/auth.c             |  94 ++++++++++++++++++++------
 drivers/nvme/host/apple.c              |   6 +-
 drivers/nvme/host/auth.c               |  16 +++--
 drivers/nvme/host/core.c               |  16 +++--
 drivers/nvme/host/fc.c                 |   1 +
 drivers/nvme/host/multipath.c          |   4 --
 drivers/nvme/host/pci.c                |   5 ++
 drivers/nvme/host/rdma.c               |   9 +++
 drivers/nvme/host/sysfs.c              |  19 ++++++
 drivers/nvme/host/tcp.c                |  29 ++++++--
 drivers/nvme/target/admin-cmd.c        |   8 +--
 drivers/nvme/target/auth.c             |  21 +++---
 drivers/nvme/target/configfs.c         |  27 ++++++++
 drivers/nvme/target/core.c             |  10 ++-
 drivers/nvme/target/fabrics-cmd-auth.c |   9 +--
 drivers/nvme/target/nvmet.h            |  13 ++++
 drivers/nvme/target/tcp.c              | 117 ++++++++++++++++++---------------
 drivers/nvme/target/zns.c              |   6 +-
 include/linux/nvme-auth.h              |   6 +-
 19 files changed, 285 insertions(+), 131 deletions(-)


