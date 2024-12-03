Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0119E69EA6
	for <linux-nvme@archiver.kernel.org>; Tue,  3 Dec 2024 11:15:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=HZHS5wVVo9NtJcTQz6gJR06aWdHiTHHRXdFoImJ5scI=; b=Sowee5Q2aL5HRKRskKGMYFjZO1
	8iRHGsjDw/s890KMzrwWFPx3riqfHCvm0fjFTzOAiSukDADMrskKGkE9oqlkvqQElCmNAORLniQqj
	VIlxSBmkFsyJc1ggehxgTveQcxnYjwtBupBKyi3mG0OIe6ViP9wIM6CY+udg4CivAS6fLPH/OGlu2
	0fsYhboWtnq3xVOM5PMUwwoKIYuO2BBQcZh3EW4CU8P+W/hdOzHq7psc0jXZQMlT/CERDywXPIK94
	rdE3lvyWj9VgqdepA16jDPTauleiiAobPvmWc9vUD6HsT9ryPnlJ84p8OlBgAU/+8/nP9rst4mlWP
	r8RrOxDw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQrp-00000009E3X-2Ngn;
	Tue, 03 Dec 2024 11:14:57 +0000
Received: from nyc.source.kernel.org ([147.75.193.91])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tIQgB-00000009BMy-1ly2
	for linux-nvme@lists.infradead.org;
	Tue, 03 Dec 2024 11:02:56 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by nyc.source.kernel.org (Postfix) with ESMTP id 5F302A40442;
	Tue,  3 Dec 2024 11:01:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE7BBC4CED6;
	Tue,  3 Dec 2024 11:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733223774;
	bh=bUkWd5SYNuOAFzVrlSwVpW+KtHfl5WHZ1BIIPbbmwH4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ot/CJiVkL6/3LNw3D4W7gBETWxZ3xQJ00uf+8aI5qLNXDo+PqVqTZJs2PAD+cQTGK
	 BUKp7HmqBNMHTbOAk5yYkF1Z6PVFi/+JY8hQoPTg0IXvxflpaSQle64dXFm0g803Cj
	 yuL7hh/xEXvKf3RTisf1U8mOcfHqdq811uMlKRyZKE+A7Ac6AFCP2fJ85XPrw5Rmb6
	 j0+PcXq7XV9v4bX5D72OupJU38dscgj0RXpVe/YMq+rCOXSWrX/NEx3o3PMXXFhvEz
	 f3KtLnXLRfDzMrcDWAa8MP0cMJ6l2AVUXTI9mfrQRxFrXwVC6GXgVPGYqQMda/s/CP
	 LbKENQpgMmPTg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv13 00/10] nvme: implement secure concatenation
Date: Tue,  3 Dec 2024 12:02:27 +0100
Message-Id: <20241203110238.128630-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241203_030255_591317_9E1D79F7 
X-CRM114-Status: GOOD (  20.66  )
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
https://github.com/osandov/blktests/pull/147
in case anyone want to run their own tests.

As usual, comments and reviews are welcome.

Patchset can be found at
git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
branch secure-concat.v13

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
 drivers/nvme/host/auth.c               | 113 ++++-
 drivers/nvme/host/fabrics.c            |  34 +-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   2 +
 drivers/nvme/host/sysfs.c              |   4 +-
 drivers/nvme/host/tcp.c                |  68 ++-
 drivers/nvme/target/auth.c             |  72 +++-
 drivers/nvme/target/debugfs.c          |  27 ++
 drivers/nvme/target/fabrics-cmd-auth.c |  49 ++-
 drivers/nvme/target/fabrics-cmd.c      |  33 +-
 drivers/nvme/target/nvmet.h            |  38 +-
 drivers/nvme/target/tcp.c              |  24 +-
 fs/crypto/Kconfig                      |   1 +
 fs/crypto/hkdf.c                       |  85 +---
 include/crypto/hkdf.h                  |  20 +
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |  12 +-
 include/linux/nvme.h                   |   7 +
 24 files changed, 1482 insertions(+), 111 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


