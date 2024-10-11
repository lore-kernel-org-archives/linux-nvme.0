Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71326D0EE17
	for <linux-nvme@archiver.kernel.org>; Fri, 11 Oct 2024 16:01:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4eXS0FWXNWyWz4ZyI3dccuHTOg3I+4XkUSggtbFc+FA=; b=Gdvtwozhyuj3soZjmfg4TgmNn4
	Ecokw5bTvRFH6aKIrRbs0cVTOSURl8DZu9hD+32XOpECmsbZlI7rUwbrLL2EhSefydNTcxQzDJ0CO
	tVR22kGBotwsSnI7xXBJCSpiit33HCPDY2/k4KYgOIjhnh4BgSv25K9ltD1o9o/oMrK2A3C7Ckj8J
	+8XkejM7zHitxlDuoiGP5l4/4xiFE+o6RUY38wMxVCOjTgwDXm6cZ/yrI/NFfADY3UpyQdHKaqz38
	PFgsEtqbxaDJe5vstjBYgLICuWlzcS3CFs0Kw/cY7geiNLXwkCcuPTHj4WBb6FiAJAKvBkGq3Jufb
	U7uXvdJg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1szI51-0000000Gtpw-2nMs;
	Fri, 11 Oct 2024 16:01:27 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1szHyc-0000000Gsv4-0PYe
	for linux-nvme@lists.infradead.org;
	Fri, 11 Oct 2024 15:54:51 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 1BE5EA44B3F;
	Fri, 11 Oct 2024 15:54:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5747FC4CEC3;
	Fri, 11 Oct 2024 15:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1728662088;
	bh=HdoLHibnRwy9BsJeQ6us0hgYQTaSOegJuudcvCRnHok=;
	h=From:To:Cc:Subject:Date:From;
	b=ez5wHEyFThqX+GO63GCIMrnk1wZRtLnOra/It0THRSLvTzIk8wuQDis1YDGVUQ11k
	 pxBygjizfAtxPuZrw31GnwXXaP8zMW8TUEjnVAHbZMNY91wHGJo/49RPdDBxm+i4M+
	 EOeIdvRwxSKCQOWrCjDzqA0TgYuLpShNFRT2V86DK7NdQT9FYDCDnSnywNTpGQxPWS
	 75QfV+qzHCTlMqXgVgBcgeDugQ+SIyGqPraP6suCgG3Vg3qBgC2roKkjG521TAGCK/
	 z9m2lJ6cBIQalMxgX6RKLDncFOIwcBwa9Y7DuD8Uit/Rn1mjoiIF2J+vylrJ/NKRdt
	 cn6aljK49KMPQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv10 0/9] nvme: implement secure concatenation
Date: Fri, 11 Oct 2024 17:54:21 +0200
Message-Id: <20241011155430.43450-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241011_085450_292651_61215799 
X-CRM114-Status: GOOD (  19.56  )
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
as outlined in TP8018.
The original (v5) patchset had been split in two, the first part of
which has already been merged with nvme-6.11, and this is the second part
which actually implements secure concatenation.

Secure concatenation means that a TLS PSK is generated from the key
material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
is then used for a subsequent TLS connection.
The difference between the original definition of secure concatenation
and the method outlined in TP8018 is that with TP8018 the connection
is reset after DH-HMAC-CHAP negotiation, and a new connection is setup
with the generated TLS PSK.

To implement that Sagi came up with the idea to directly reset the
admin queue once the DH-CHAP negotiation has completed; that way
it will be transparent to the upper layers and we don't have to
worry about exposing queues which should not be used.

A blktest submission is in
https://github.com/osandov/blktests/pull/147
in case anyone want to run their own tests.

As usual, comments and reviews are welcome.

Patchset can be found at
git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
branch secure-concat.v10

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

Hannes Reinecke (9):
  crypto,fs: Separate out hkdf_extract() and hkdf_expand()
  nvme: add nvme_auth_generate_psk()
  nvme: add nvme_auth_generate_digest()
  nvme: add nvme_auth_derive_tls_psk()
  nvme-keyring: add nvme_tls_psk_refresh()
  nvme-tcp: request secure channel concatenation
  nvme-fabrics: reset admin connection for secure concatenation
  nvmet-tcp: support secure channel concatenation
  nvmet: add tls_concat and tls_key debugfs entries

 crypto/Kconfig                         |   6 +
 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 402 +++++++++++++++++++++++++
 drivers/nvme/common/Kconfig            |   1 +
 drivers/nvme/common/auth.c             | 344 +++++++++++++++++++++
 drivers/nvme/common/keyring.c          |  64 ++++
 drivers/nvme/host/auth.c               | 108 ++++++-
 drivers/nvme/host/fabrics.c            |  34 ++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   2 +
 drivers/nvme/host/sysfs.c              |   4 +-
 drivers/nvme/host/tcp.c                |  56 +++-
 drivers/nvme/target/auth.c             |  72 ++++-
 drivers/nvme/target/debugfs.c          |  27 ++
 drivers/nvme/target/fabrics-cmd-auth.c |  49 ++-
 drivers/nvme/target/fabrics-cmd.c      |  33 +-
 drivers/nvme/target/nvmet.h            |  38 ++-
 drivers/nvme/target/tcp.c              |  23 +-
 fs/crypto/Kconfig                      |   1 +
 fs/crypto/hkdf.c                       |  85 +-----
 include/crypto/hkdf.h                  |  18 ++
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |   9 +
 include/linux/nvme.h                   |   7 +
 24 files changed, 1287 insertions(+), 107 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


