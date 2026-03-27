Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B5B3E10ED67F
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Mar 2026 14:44:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=wtqZU6t0lX3Usl4dFvXwksRpAQkLOIbdiHipHUT8Cy4=; b=FmScJXG4hPwlNFXZiipNu5ur6G
	8oVsQF8zI9IMLkvn+HkQEnz8XR2IU3CfKgw6pE6Pc8lA/sKi5NNn6ZP4si+qMYv1aVdHwqDX1RFRq
	rH3qalq2EYalCpabX/il65Vj0XGlO/roz2dpbL6hXnebPEj6+jZRJ1bptTJxWScjFkSYy69lW4uC4
	+UPUZrSkVNe1///l6SygCks7HgoeKzvYxweSBeCh+CPdL4iOBe7nlnoS1BCIDH9Gwmd4E7It0KTd3
	l2PdbVuHjIG+T+sRt3jiLkrDf9RUzQhChkS7ECrA0wlJRspywCck0nl+n21s//6crdJ4o1PB8zM3q
	YIjDsgPA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w68QP-00000007d8i-0G0N;
	Fri, 27 Mar 2026 14:44:37 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w68QO-00000007d8c-1eio
	for linux-nvme@lists.infradead.org;
	Fri, 27 Mar 2026 14:44:36 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 5304760054;
	Fri, 27 Mar 2026 14:44:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CB732C19423;
	Fri, 27 Mar 2026 14:44:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774622675;
	bh=+vxcQvN5lkVPWgOZm8QWsJgUkMv6+tatS5HQKkOLukU=;
	h=Date:From:To:Cc:Subject:From;
	b=BsFc7rBGeklH6H7NIpkvLN5vS945AcnGRKBOOEQVwW+95HBihWEXMTccOtwMgrC17
	 fIXTy1WwMR02a718VD8hjco3ZOC3Cd0+bAb/L+9cDmy7ZPHFTTAcPDLERuhizC7rBJ
	 kZ10FfAOhavt3WtoCHnz2hJa7VWS/1wOybVbCTCGIer++rlwWZK7wOP2hI76+24Yk7
	 4H+7rwKOeQAey9ZEe+kdrrtHLZCi6EYQsK64rmASBiujS6/y72SOPZ/1zSrJR5lbWp
	 Y+h7DkePubz1z00Ma5/um68QyJS+QG3Jy4R69E2Z9eKdOSy49bsbEX3KwGMAHNcR8m
	 KBGCP+LnG7gSw==
Date: Fri, 27 Mar 2026 08:44:33 -0600
From: Keith Busch <kbusch@kernel.org>
To: axboe@kernel.dk
Cc: hch@lst.de, sagi@grimberg.me, linux-nvme@lists.infradead.org
Subject: [GIT PULL] nvme updates for Linux 7.1
Message-ID: <acaX0TREWsWBDyWp@kbusch-mbp>
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

The following changes since commit 67807fbaf12719fca46a622d759484652b79c7c3:

  block: fix bio_alloc_bioset slowpath GFP handling (2026-03-23 07:58:32 -0600)

are available in the Git repository at:

  git://git.infradead.org/nvme.git tags/nvme-7.1-2026-03-27

for you to fetch changes up to 886f35201591ded7958e16fe3750871d3ca0bcdf:

  nvme-loop: do not cancel I/O and admin tagset during ctrl reset/shutdown (2026-03-27 07:35:06 -0700)

----------------------------------------------------------------
nvme updates for Linux 7.1

 - Fabrics authentication updates (Eric, Alistar)
 - Enanced block queue limits support (Caleb)
 - Workqueue usage updates (Marco)
 - A new write zeroes device quirk (Robert)
 - Tagset cleanup fix for loop device (Nilay)

----------------------------------------------------------------
Alistair Francis (6):
      nvmet-tcp: Don't error if TLS is enabed on a reset
      nvmet-tcp: Don't free SQ on authentication success
      nvme: Expose the tls_configured sysfs for secure concat connections
      nvme: Allow reauth from sysfs
      nvme: Add the DHCHAP maximum HD IDs
      nvme-auth: Don't propose NVME_AUTH_DHGROUP_NULL with SC_C

Caleb Sander Mateos (8):
      nvme: add preferred I/O size fields to struct nvme_id_ns_nvm
      nvme: fold nvme_config_discard() into nvme_update_disk_info()
      nvme: update nvme_id_ns OPTPERF constants
      nvme: always issue I/O Command Set specific Identify Namespace
      nvme: add from0based() helper
      nvme: set discard_granularity from NPDG/NPDA
      nvmet: use NVME_NS_FEAT_OPTPERF_SHIFT
      nvmet: report NPDGL and NPDAL

Eric Biggers (21):
      nvme-auth: add NVME_AUTH_MAX_DIGEST_SIZE constant
      nvme-auth: common: constify static data
      nvme-auth: use proper argument types
      nvme-auth: common: add KUnit tests for TLS key derivation
      nvme-auth: rename nvme_auth_generate_key() to nvme_auth_parse_key()
      nvme-auth: common: explicitly verify psk_len == hash_len
      nvme-auth: common: add HMAC helper functions
      nvme-auth: common: use crypto library in nvme_auth_transform_key()
      nvme-auth: common: use crypto library in nvme_auth_augmented_challenge()
      nvme-auth: common: use crypto library in nvme_auth_generate_psk()
      nvme-auth: common: use crypto library in nvme_auth_generate_digest()
      nvme-auth: common: use crypto library in nvme_auth_derive_tls_psk()
      nvme-auth: host: use crypto library in nvme_auth_dhchap_setup_host_response()
      nvme-auth: host: use crypto library in nvme_auth_dhchap_setup_ctrl_response()
      nvme-auth: host: remove allocation of crypto_shash
      nvme-auth: target: remove obsolete crypto_has_shash() checks
      nvme-auth: target: use crypto library in nvmet_auth_host_hash()
      nvme-auth: target: use crypto library in nvmet_auth_ctrl_hash()
      nvme-auth: common: remove nvme_auth_digest_name()
      nvme-auth: common: remove selections of no-longer used crypto modules
      crypto: remove HKDF library

Marco Crivellari (3):
      nvmet: replace use of system_wq with system_percpu_wq
      nvmet-fc: add WQ_PERCPU to alloc_workqueue users
      nvme: add WQ_PERCPU to alloc_workqueue users

Nilay Shroff (1):
      nvme-loop: do not cancel I/O and admin tagset during ctrl reset/shutdown

Robert Beckett (2):
      nvme: respect NVME_QUIRK_DISABLE_WRITE_ZEROES when wzsl is set
      nvme-pci: add NVME_QUIRK_DISABLE_WRITE_ZEROES for Kingston OM3SGP4

 Documentation/ABI/testing/sysfs-nvme   |  13 +
 crypto/Kconfig                         |   6 -
 crypto/Makefile                        |   1 -
 crypto/hkdf.c                          | 573 --------------------------------
 drivers/nvme/common/.kunitconfig       |   6 +
 drivers/nvme/common/Kconfig            |  14 +-
 drivers/nvme/common/Makefile           |   2 +
 drivers/nvme/common/auth.c             | 587 +++++++++++++--------------------
 drivers/nvme/common/tests/auth_kunit.c | 175 ++++++++++
 drivers/nvme/host/auth.c               | 187 ++++-------
 drivers/nvme/host/core.c               |  88 +++--
 drivers/nvme/host/nvme.h               |   6 +
 drivers/nvme/host/pci.c                |   2 +
 drivers/nvme/host/sysfs.c              |  50 ++-
 drivers/nvme/target/admin-cmd.c        |   4 +-
 drivers/nvme/target/auth.c             | 202 ++++--------
 drivers/nvme/target/configfs.c         |   3 -
 drivers/nvme/target/core.c             |   7 +-
 drivers/nvme/target/fabrics-cmd-auth.c |  18 +-
 drivers/nvme/target/fc.c               |   6 +-
 drivers/nvme/target/io-cmd-bdev.c      |  19 +-
 drivers/nvme/target/loop.c             |   2 -
 drivers/nvme/target/nvmet.h            |   8 +-
 drivers/nvme/target/tcp.c              |   2 +-
 include/crypto/hkdf.h                  |  20 --
 include/linux/nvme-auth.h              |  41 ++-
 include/linux/nvme.h                   |  24 +-
 27 files changed, 766 insertions(+), 1300 deletions(-)
 create mode 100644 Documentation/ABI/testing/sysfs-nvme
 delete mode 100644 crypto/hkdf.c
 create mode 100644 drivers/nvme/common/.kunitconfig
 create mode 100644 drivers/nvme/common/tests/auth_kunit.c
 delete mode 100644 include/crypto/hkdf.h


