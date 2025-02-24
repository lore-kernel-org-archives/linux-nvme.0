Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F10EC021A4
	for <linux-nvme@archiver.kernel.org>; Mon, 24 Feb 2025 13:14:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=g4yJj2nuwY0Mi2cgPPVwdPvvnlT93CB+/DghEfnHVGY=; b=DcFVx6KjhZ/H2lv6kWZwmW0Vwh
	0TLTOg09VdPDiXfRD3kj3C/txfYCFdGHtQNeIHlW3zauYVKE3+GXaduIE8WwsHczL2no8kT/EV08Y
	8zQrMZtr4AZl+LocMQYUiRrvxljxJL1xJAicF54cA4aFvWULIQyjYdWGrC4hIgifCkSXqe+WoaDvO
	g31tUEXyPpjEOvnjDay8VV8zE/1hhOr1IUCmAmGP8d2QL8Q0nNLbU018X2TVBkYiK3nPZjbj3N7a5
	UVY6cNJ2r/FwHxCCm4B/N1tX1bIw9SUTI2UgB3sQolIq4YPkeOPvZXkaugmqvnmdVlqw1Y/r8MW98
	aOnQpkJA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tmYHt-0000000Do0Z-3txg;
	Mon, 24 Feb 2025 13:14:21 +0000
Received: from tor.source.kernel.org ([172.105.4.254])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tmXjH-0000000DiXJ-1Rdz
	for linux-nvme@lists.infradead.org;
	Mon, 24 Feb 2025 12:38:35 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 97384611AF;
	Mon, 24 Feb 2025 12:38:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2B4C4CEE6;
	Mon, 24 Feb 2025 12:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1740400714;
	bh=yOdt02ETeQV0b3ZGduyzG5POJQgVsrvroHJ6s/SD7iU=;
	h=From:To:Cc:Subject:Date:From;
	b=KgdFepnPuOofBkntwV7gsTYrPpYIHE9aI8Jg/suqYN2HUQrr9fddzDR8dMnVFmuah
	 xKD90JV9iUqOorS9BLLrXd4HMwRNv7uBfPs++IT5fRW5n3Xqe4HwnA/e43Djb8eL9U
	 XntfHnnQ8fB6maFpjWQj07kSY7jP0EhrJJKkwolglRcovJy2sjt7pw/c1R6v09yOkJ
	 huHi1oRfCOT6Yii5YjI7TfIzrCzbjqOfMxl2nFYwg7HousyaPHBJX7ecyxAj/fkfKo
	 7RmtMIcxv2HC5zOcEgDYUvfvCBABn8eFR196stF3m/N69ikkeR46kBD3+OQj+oabj7
	 wY/pjwQOqLqDg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv15 00/10] nvme: implement secure concatenation
Date: Mon, 24 Feb 2025 13:38:08 +0100
Message-Id: <20250224123818.42218-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

From: Hannes Reinecke <hare@suse.de>

Hi all,

here's my attempt to implement secure concatenation for NVMe-of TCP
as outlined in TP8018 / NVMe Base Spec v2.1.
The original (v5) patchset had been split in two, the first part of
which has already been merged with nvme-6.11, and this is the second part
which actually implements secure concatenation.

Secure concatenation means that a TLS PSK is generated from the key
material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
is then used for a subsequent TLS connection.
With NVMe v2.1 the connection has to be reset after DH-HMAC-CHAP
negotiation, and the new connection can then be started with TLS
encryption using the generated TLS PSK.

To implement that Sagi came up with the idea to directly reset the
admin queue once the DH-CHAP negotiation has completed; that way
it will be transparent to the upper layers and we don't have to
worry about exposing queues which should not be used.

A blktest submission is in
https://github.com/osandov/blktests/pull/158
in case anyone want to run their own tests.

As usual, comments and reviews are welcome.

Patchset can be found at
git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
branch secure-concat.v15

Changes to v14:
- Include reviews from hch
- Split off prep patch adding 'sq' argument to alloc_ctrl_args

Changes to v13:
- Fixup yet another kbuild robot failure
- Rework to apply on nvme-6.14

Changes to v12:
- Fixup kbuild robot failures
- Add missing return value

Changes to v11:
- Include reviews from Sagi

Changes to v10:
- Include reviews from Eric Biggers
- Drop test vectors for SHA1
- Add test vectors for SHA384 and SHA512
- Include reviews from Mark O'Donovan

Changes to v9:
- Include reviews from Eric Biggers
- Fixup secure concatenation after reset
- Rebased to nvme-6.12

Changes to v8:
- Include reviews from Eric Biggers
- Make hkdf a proper module
- Add testcases for hkdf

Changes to v7:
- Add patch to display nvme target TLS status in debugfs
- Include reviews from Sagi

Changes to v6:
- Rebase to nvme-6.11

Changes to v5:
- Include reviews from Sagi
- Split patchset in two parts

Changes to v4:
- Rework reset admin queue functionality based on an idea
  from Sagi (thanks!)
      - kbuild robot fixes
            - Fixup dhchap negotiation with non-empty C2 value

Changes to v3:
- Include reviews from Sagi
- Do not start I/O queues after DH-HMAC-CHAP negotiation
- Use bool to indicate TLS has been enabled on a queue
- Add 'tls_keyring' sysfs attribute
- Add 'tls_configured_key' sysfs attribute

Changes to v2:
- Fixup reset after dhchap negotiation
- Disable namespace scanning on I/O queues after
  dhchap negotiation
      - Reworked TLS key handling (again)

Changes to the original submission:
- Sanitize TLS key handling
- Fixup modconfig compilation

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

 crypto/Kconfig                         |   6 +
 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 573 +++++++++++++++++++++++++
 drivers/nvme/common/Kconfig            |   1 +
 drivers/nvme/common/auth.c             | 337 +++++++++++++++
 drivers/nvme/common/keyring.c          |  65 ++-
 drivers/nvme/host/Kconfig              |   2 +-
 drivers/nvme/host/auth.c               | 115 ++++-
 drivers/nvme/host/fabrics.c            |  34 +-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   2 +
 drivers/nvme/host/sysfs.c              |   4 +-
 drivers/nvme/host/tcp.c                |  64 ++-
 drivers/nvme/target/auth.c             |  72 +++-
 drivers/nvme/target/core.c             |   7 +-
 drivers/nvme/target/debugfs.c          |  27 ++
 drivers/nvme/target/fabrics-cmd-auth.c |  60 ++-
 drivers/nvme/target/fabrics-cmd.c      |  25 +-
 drivers/nvme/target/nvmet.h            |  38 +-
 drivers/nvme/target/tcp.c              |  32 +-
 fs/crypto/Kconfig                      |   1 +
 fs/crypto/hkdf.c                       |  85 +---
 include/crypto/hkdf.h                  |  20 +
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |  12 +-
 include/linux/nvme.h                   |   7 +
 26 files changed, 1490 insertions(+), 110 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


