Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0C2BFC0218D
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Jan 2025 16:59:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=WffU+9NE+I4lvEY9yofn5PAuSdMCQ87ZxBVBYqhYRJ4=; b=J0BmJ6Wbqb4ZPZxksThWK+TRMp
	z2zYnUJgv6L9+Uxe/wrK8uEDXDswF/t1bGqPFqAjUezo1zqH/iWqbcV+6hAO7Rug6VIoH3C8IpYY6
	NgArvKV7YqdRIxhjHwJZdZMM4p7gTaoCM6T2eU0mJf9SLmfw67eeKnV6l4+2qiqe9DyWMiiFnOT1O
	f6kCMAHptNMrao09D6a6nMy2bgJ1WiwOVb/K4tg5tRCoxp6KIPnXcJH91uQSofMoVSBOf38GfScEp
	6NSRj86PiFEcd26mZJS2r8kaZASAVtf6Mtwpf6FynaDyPBHhwcl84PjkGlYXpFTbsBVXbsyVS+GLA
	YCFglNvA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4D-0000000Amvm-48DV;
	Wed, 22 Jan 2025 16:59:01 +0000
Received: from nyc.source.kernel.org ([2604:1380:45d1:ec00::3])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tae4A-0000000Amti-4Adg
	for linux-nvme@lists.infradead.org;
	Wed, 22 Jan 2025 16:59:00 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 4DA43A428E6;
	Wed, 22 Jan 2025 16:57:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D296C4CED2;
	Wed, 22 Jan 2025 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737565137;
	bh=10h8PXD1O5Yq0R6xspNd9GyxfCDDydInJLx7UHkG7p0=;
	h=From:To:Cc:Subject:Date:From;
	b=hElKAqTL7aD4t/gWtk+5MyKnBugO+V63sO3iwray2eDqhlV6TMXHba1cBIzXJ1jk6
	 E2Zp/HUggM3bdd38My7pvRKUXXM9eLOCd5FVsu6rMGgSVmYaeDxZ/y351W0FfkMKIB
	 DVhVZ12aaM6MMOiK7oHJH3BgEgCeZKNo6Zc/IBOZlT4I7vWchDYRavXyWL+Qpz30yZ
	 pBwJF2mWa0mee48tuamWQl0soPRV3zx1z0j6n1R30AXBMTwhhthV8B/rPwAKeTs/f9
	 mo4+f2QBx2/ejKwGLd2xvF9v/aK2FfHAG/pufr9zW9ekWSdAeIH8wvepdHMYfQxNCz
	 XMjklr6IOJucA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv14 00/10] nvme: implement secure concatenation
Date: Wed, 22 Jan 2025 17:58:19 +0100
Message-Id: <20250122165829.11603-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250122_085859_159006_FA32211F 
X-CRM114-Status: GOOD (  20.79  )
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
https://github.com/osandov/blktests/pull/158
in case anyone want to run their own tests.

As usual, comments and reviews are welcome.

Patchset can be found at
git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
branch secure-concat.v14

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

*** BLURB HERE ***

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

 crypto/Kconfig                         |   6 +
 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 573 +++++++++++++++++++++++++
 drivers/nvme/common/Kconfig            |   1 +
 drivers/nvme/common/auth.c             | 348 +++++++++++++++
 drivers/nvme/common/keyring.c          |  65 ++-
 drivers/nvme/host/Kconfig              |   2 +-
 drivers/nvme/host/auth.c               | 113 ++++-
 drivers/nvme/host/fabrics.c            |  34 +-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   2 +
 drivers/nvme/host/sysfs.c              |   4 +-
 drivers/nvme/host/tcp.c                |  68 ++-
 drivers/nvme/target/auth.c             |  72 +++-
 drivers/nvme/target/core.c             |   7 +-
 drivers/nvme/target/debugfs.c          |  27 ++
 drivers/nvme/target/fabrics-cmd-auth.c |  49 ++-
 drivers/nvme/target/fabrics-cmd.c      |  25 +-
 drivers/nvme/target/nvmet.h            |  38 +-
 drivers/nvme/target/tcp.c              |  24 +-
 fs/crypto/Kconfig                      |   1 +
 fs/crypto/hkdf.c                       |  85 +---
 include/crypto/hkdf.h                  |  20 +
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |  12 +-
 include/linux/nvme.h                   |   7 +
 26 files changed, 1484 insertions(+), 110 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


