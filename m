Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D3902E77188
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Jan 2025 22:23:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=IjzJrSG1rEQjc8O2DvGhKoocUDrasN2bRe+V1O4UD3s=; b=FhmldsipxiXOrxkqzJUfwTY9rO
	oSiLuH7obDbaA+QPh/cI+pC1cUqfKphP8M9sjNfVQrbjVMQx91aioakETuE4dZl2HRz5PfQ8a1N3y
	7S70EfO8r3fruLdCg45JoaMko4IZ7NVZ9C8gS/FjVJYanHWFJ8jJvWILiVsqBZHan64uijynuZRvX
	PBmxWhBh9plwzPWr50fUXdoDUSo3wAjo3H8vDs+mvJjXgqEWOYpI5UNWIY37kKyjMqALcwkGeqB1S
	jw9ytDVoqfEpZKa/yH45toVJqqf5b4HLSwlEGSlZigumIEfx2NSxI8vzQgWnoEaqovLMiaA7hKQ2x
	nvIahXKQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tX6MD-00000003WpE-0CPi;
	Sun, 12 Jan 2025 22:22:57 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tX6M9-00000003WoE-33iQ
	for linux-nvme@lists.infradead.org;
	Sun, 12 Jan 2025 22:22:54 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id E5440A40A1D;
	Sun, 12 Jan 2025 22:21:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6C97C4CEE3;
	Sun, 12 Jan 2025 22:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736720571;
	bh=x5Bi9G+9rPDtSI6v2ph1FKKIR5N07E9vpy3cmbxYEPI=;
	h=Date:From:To:Cc:Subject:From;
	b=T3uWyzLSW/tXTY8K1N4L5PJKrOBwxI/mB+kT3Opd3VPPL8/OOtp/J75LsAvaU8o/I
	 OoQqqZ0sGV8BK62bLI9/DjqMaOSIaqQ1YtKVB817ZAeZ1VYgMrmiCRCCn8utgD1wS6
	 FbCOA7uKJotLNqB8oFoXiJDZYRKrvvHHk9ZnWD3PiJpwyGFrFEJAbJFf1+gZCjte4Z
	 XlHJKQaWDbSa50F/vnBmwOQoFGFA044Y8fpLKxgVawdAcWgqfS0LeeEWgEMmMOvm+G
	 W7wT7mrGM+CXWssYS1RLEknq5UlFKrRYWzojRRiFHrLIu5yYHS+6ZRVH8YUGavHZdG
	 zBnKD04jVVmkw==
Date: Sun, 12 Jan 2025 15:22:48 -0700
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for 6.14 (resend)
Message-ID: <Z4RAuMknJQo-nheX@kbusch-mbp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250112_142253_892881_22DB9A52 
X-CRM114-Status: GOOD (  12.01  )
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

Please drop the previous pull and use this one instead. This fixes the
reported linux-next failures (missing sign-off and semi-colon build
warning) and drops the secure concatenation series due to build
failures with that series.

The following changes since commit 844b8cdc681612ff24df62cdefddeab5772fadf1:

  nbd: don't allow reconnect after disconnect (2025-01-06 07:38:20 -0700)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-6.14-2025-01-12

for you to fetch changes up to 4a324970fabad503260973cd588609f3a26baab9:

  nvme-pci: use correct size to free the hmb buffer (2025-01-12 14:11:29 -0800)

----------------------------------------------------------------
nvme updates for Linux 6.14

 - Target support for PCI-Endpoint transport (Damien)
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

Keisuke Nishimura (2):
      nvme: Add error check for xa_store in nvme_get_effects_log
      nvme: Add error path for xa_store in nvme_init_effects

Sagi Grimberg (1):
      nvme-tcp: Fix I/O queue cpu spreading for multiple controllers

Yongsoo Joo (1):
      nvme: change return type of nvme_poll_cq() to bool

 Documentation/PCI/endpoint/index.rst             |    1 +
 Documentation/PCI/endpoint/pci-nvme-function.rst |   13 ++
 Documentation/nvme/index.rst                     |   12 ++
 Documentation/nvme/nvme-pci-endpoint-target.rst  |  368 ++++++++++++++++++++++++++++++++++++++++++++
 Documentation/subsystem-apis.rst                 |    1 +
 drivers/nvme/host/core.c                         |   34 +++-
 drivers/nvme/host/nvme.h                         |   39 -----
 drivers/nvme/host/pci.c                          |   14 +-
 drivers/nvme/host/tcp.c                          |   70 +++++++--
 drivers/nvme/target/Kconfig                      |   11 ++
 drivers/nvme/target/Makefile                     |    2 +
 drivers/nvme/target/admin-cmd.c                  |  388 ++++++++++++++++++++++++++++++++++++++++++++--
 drivers/nvme/target/configfs.c                   |   49 ++++++
 drivers/nvme/target/core.c                       |  266 +++++++++++++++++++++++---------
 drivers/nvme/target/discovery.c                  |   17 ++
 drivers/nvme/target/fabrics-cmd-auth.c           |   14 +-
 drivers/nvme/target/fabrics-cmd.c                |  101 ++++++++----
 drivers/nvme/target/io-cmd-bdev.c                |    3 +
 drivers/nvme/target/nvmet.h                      |  110 ++++++++++++-
 drivers/nvme/target/pci-epf.c                    | 2591 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/nvme.h                             |   42 +++++
 21 files changed, 3960 insertions(+), 186 deletions(-)
 create mode 100644 Documentation/PCI/endpoint/pci-nvme-function.rst
 create mode 100644 Documentation/nvme/index.rst
 create mode 100644 Documentation/nvme/nvme-pci-endpoint-target.rst
 create mode 100644 drivers/nvme/target/pci-epf.c

