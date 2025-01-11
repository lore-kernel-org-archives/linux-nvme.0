Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E07C9E7719C
	for <linux-nvme@archiver.kernel.org>; Sat, 11 Jan 2025 04:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dp3MbfU3+F9l6tVFvZ3XXSI1sFivSRzrTWTKbLKXLa0=; b=h7TN6RBZb+Gm9B4QkMrKqRNLbs
	9CFHfFfpjTFzG5ntJcTU7uql3u36j/mYIy65kZokaOhHOe/wGj/ulqt2UQrgGB/LoA4myqOKvxDTX
	UxMSEL9O9pJ6b1AiFGfOEeF4yFEa90NStGfW+7FxTJHeJIKb0k9ELvyvhfB3it2fYMFf8SWXk24Bm
	/udP/9EYGFFSNFPQt4jvjwTC+QlpYdH2qW9C5FBTcWdbHdScPFpQ7Pq3ANxJA2mGoIIFG6sjJHhdT
	YmoRH+vjB9fDJw7wD0wk3zl4dUqKlgdbwWXE0YIsEVRBEf9PZO2so/e7FVw/mYYLXBvGUIywqp9AC
	m/efwhtA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tWSlT-000000007MJ-1MLh;
	Sat, 11 Jan 2025 04:06:23 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tWSlR-000000007Lp-0g0E
	for linux-nvme@lists.infradead.org;
	Sat, 11 Jan 2025 04:06:22 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id BEA875C0149;
	Sat, 11 Jan 2025 04:05:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0CB2FC4CED2;
	Sat, 11 Jan 2025 04:06:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736568379;
	bh=b+5xNkTAexozpVJRD4feBSUO2qsINxrA3vlZzNc8+Ds=;
	h=Date:From:To:Cc:Subject:From;
	b=am/mICknAT9rwW5/+atcaPmY/9g1P77ts8/DcqOewpWPA4+kAyX7iaMv9Npi+N1Q+
	 JuofP5aivoaGa1FRkkKRyRbBQb+F+AXt1FO7sk0Mi+qTerOzA/2lrMz6e1RE/n2OeK
	 CCaOgui2wxVPAq0GtWVqwx5Id4G4rxR5UumfFxkpAiza5pBhxwFF7v1aicf0QGfDqS
	 tkrk9F+CpWJdlGtlfI0Qf41ICv5jtATQgrogllM/f3nF4hLXeRLhUsyNgE7pKgtObn
	 f2bA0rgVb9Rk5Srw2iGolpFuNVge6PXRZdibblhQ0VNu35ZOFAy0teBJowYtqSgaeD
	 xJMZPy0sPnvwg==
Date: Fri, 10 Jan 2025 21:06:17 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me,
	kch@nvidia.com
Subject: [GIT PULL] nvme updates for Linux 6.14
Message-ID: <Z4HuOSnrCRIwy5PG@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250110_200621_299202_9198BE82 
X-CRM114-Status: GOOD (  12.63  )
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

The following changes since commit 844b8cdc681612ff24df62cdefddeab5772fadf1:

  nbd: don't allow reconnect after disconnect (2025-01-06 07:38:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.14-2024-01-10

for you to fetch changes up to 6d84dae9af94be43bb71d24353aef102fd0744da:

  nvme-pci: use correct size to free the hmb buffer (2025-01-10 19:30:51 -0800)

----------------------------------------------------------------
nvme updates for Linux 6.14

 - Target endpoint for PCI-Endpoint transport (Damien)
 - Fabrics secure concatenation (Hannes)
 - TCP IO queue spreading fixes (Sagi, Chaitanya)
 - Target handling for "limited retry" flags (Guixen)
 - Poll type fix (Yongsoo)
 - Xarray storage error handling (Keisuke)
 - Host memory buffer free size fix on error (Francis)

----------------------------------------------------------------
Baruch Siach (1):
      nvme-pci: fix comment typo

Damien Le Moal (18):
      nvme: Move opcode string helper functions declarations
      nvmet: Add vendor_id and subsys_vendor_id subsystem attributes
      nvmet: Export nvmet_update_cc() and nvmet_cc_xxx() helpers
      nvmet: Introduce nvmet_get_cmd_effects_admin()
      nvmet: Add drvdata field to struct nvmet_ctrl
      nvme: Add PCI transport type
      nvmet: Improve nvmet_alloc_ctrl() interface and implementation
      nvmet: Introduce nvmet_req_transfer_len()
      nvmet: Introduce nvmet_sq_create() and nvmet_cq_create()
      nvmet: Add support for I/O queue management admin commands
      nvmet: Do not require SGL for PCI target controller commands
      nvmet: Introduce get/set_feature controller operations
      nvmet: Implement host identifier set feature support
      nvmet: Implement interrupt coalescing feature support
      nvmet: Implement interrupt config feature support
      nvmet: Implement arbitration feature support
      nvmet: New NVMe PCI endpoint function target driver
      Documentation: Document the NVMe PCI endpoint target driver

Francis Pravin (1):
      nvme-pci: use correct size to free the hmb buffer

Guixin Liu (1):
      nvmet: handle rw's limited retry flag

Hannes Reinecke (10):
      crypto,fs: Separate out hkdf_extract() and hkdf_expand()
      nvme: add nvme_auth_generate_psk()
      nvme: add nvme_auth_generate_digest()
      nvme: add nvme_auth_derive_tls_psk()
      nvme-keyring: add nvme_tls_psk_refresh()
      nvme: always include <linux/key.h>
      nvme-tcp: request secure channel concatenation
      nvme-fabrics: reset admin connection for secure concatenation
      nvmet-tcp: support secure channel concatenation
      nvmet: add tls_concat and tls_key debugfs entries

Keisuke Nishimura (2):
      nvme: Add error check for xa_store in nvme_get_effects_log
      nvme: Add error path for xa_store in nvme_init_effects

Sagi Grimberg (1):
      nvme-tcp: Fix I/O queue cpu spreading for multiple controllers

Yongsoo Joo (1):
      nvme: change return type of nvme_poll_cq() to bool

 Documentation/PCI/endpoint/index.rst             |    1 +
 Documentation/PCI/endpoint/pci-nvme-function.rst |   13 +
 Documentation/nvme/index.rst                     |   12 +
 Documentation/nvme/nvme-pci-endpoint-target.rst  |  368 +++
 Documentation/subsystem-apis.rst                 |    1 +
 crypto/Kconfig                                   |    6 +
 crypto/Makefile                                  |    1 +
 crypto/hkdf.c                                    |  573 +++++
 drivers/nvme/common/Kconfig                      |    1 +
 drivers/nvme/common/auth.c                       |  348 +++
 drivers/nvme/common/keyring.c                    |   65 +-
 drivers/nvme/host/auth.c                         |  113 +-
 drivers/nvme/host/core.c                         |   34 +-
 drivers/nvme/host/fabrics.c                      |   34 +-
 drivers/nvme/host/fabrics.h                      |    3 +
 drivers/nvme/host/nvme.h                         |   41 +-
 drivers/nvme/host/pci.c                          |   14 +-
 drivers/nvme/host/sysfs.c                        |    4 +-
 drivers/nvme/host/tcp.c                          |  138 +-
 drivers/nvme/target/Kconfig                      |   11 +
 drivers/nvme/target/Makefile                     |    2 +
 drivers/nvme/target/admin-cmd.c                  |  388 +++-
 drivers/nvme/target/auth.c                       |   72 +-
 drivers/nvme/target/configfs.c                   |   49 +
 drivers/nvme/target/core.c                       |  269 ++-
 drivers/nvme/target/debugfs.c                    |   27 +
 drivers/nvme/target/discovery.c                  |   17 +
 drivers/nvme/target/fabrics-cmd-auth.c           |   63 +-
 drivers/nvme/target/fabrics-cmd.c                |  124 +-
 drivers/nvme/target/io-cmd-bdev.c                |    3 +
 drivers/nvme/target/nvmet.h                      |  148 +-
 drivers/nvme/target/pci-epf.c                    | 2591 ++++++++++++++++++++++
 drivers/nvme/target/tcp.c                        |   24 +-
 fs/crypto/Kconfig                                |    1 +
 fs/crypto/hkdf.c                                 |   85 +-
 include/crypto/hkdf.h                            |   20 +
 include/linux/nvme-auth.h                        |    7 +
 include/linux/nvme-keyring.h                     |   12 +-
 include/linux/nvme.h                             |   49 +
 39 files changed, 5441 insertions(+), 291 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/nvme/index.rst
 create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
 create mode 100644 crypto/hkdf.c
 create mode 100644 drivers/nvme/target/pci-epf.c
 create mode 100644 include/crypto/hkdf.h


