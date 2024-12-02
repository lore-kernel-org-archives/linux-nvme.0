Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 018E6D78326
	for <linux-nvme@archiver.kernel.org>; Mon,  2 Dec 2024 14:31:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=jtMigI/QVzRW67pGLXVye1VqBIgY2JHTEPIZJfyZISE=; b=xhnbM/8VDdvWIyczQJsCTf0yTa
	bilDfy4Z7LKOSk89zP5xJWH6GT1IWsNTOwzqPr7VJWfbZ0/YjGInLIlfeBM9S2IFpNlrvh5Saspo1
	zITnWt3NYPeMmuFpP6317xGAhkWJjBaTxUZFta+ykfKnr/CyOSHqxBKUaymhmopHe1bppt7XnqaLb
	MvyO/HbIDXO9GZsTDLNV9LzpRW482sPFn5UtG1tKbuad50AhMIeoEDjOLJ/IIgEUQ0iXSKTGNpsc2
	oIMdcfYh78Whp3IyAb/oz4YUAa3DNwkv8i6OBE9yfrjdioG1Ks6Qv+Ac6Xuhek0ypf1UVtAfayYL1
	sBoDwhWA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7Si-00000006R4R-0xXJ;
	Mon, 02 Dec 2024 14:31:44 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tI7RD-00000006Qdx-40rm
	for linux-nvme@lists.infradead.org;
	Mon, 02 Dec 2024 14:30:13 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 10B1C5C5FF9;
	Mon,  2 Dec 2024 14:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 215F9C4CED1;
	Mon,  2 Dec 2024 14:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733149810;
	bh=dPQQiFg6E3MYIWuowOkKPwCdJodOw4dHVqO+lw/k2I8=;
	h=From:To:Cc:Subject:Date:From;
	b=SD8HrFz7/BsGeyolj5W9gxmlwPtnVFXsVFro601aPZzzyhHk0/9uGXQvOVJQqHt3/
	 LQd5npX14atl4Y7q4jnBqk6UIWiCQYzIYl3BDZOPx/jBQfAOVdi49q5lRlWEMt/IVh
	 4gvcvs5bkZkUDajtl3pDMHQ7G9t1ZVIh4Dlry0CnzCGq/+Q6ody1AcmqWNFFMieEJs
	 H/iYQwLyiRX5YojsFTsFYSCzGfmsL/h4STt3R+MLyr0Fc7c1Dtt6lImcPRKWaiJlOO
	 OVFhd/e1qqtBtHz9tN5Xvs9zdB3XkrYOH+L7Xdvh3yIMnDKp/CnwwDRLVFUvj+eM6j
	 DL36StxzHgBMQ==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv12 00/10] nvme: implement secure concatenation
Date: Mon,  2 Dec 2024 15:29:49 +0100
Message-Id: <20241202142959.81321-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241202_063012_080031_C8519E9A 
X-CRM114-Status: GOOD (  20.32  )
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
branch secure-concat.v12

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
 drivers/nvme/common/auth.c             | 346 +++++++++++++++
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
 include/linux/nvme-keyring.h           |  11 +
 include/linux/nvme.h                   |   7 +
 24 files changed, 1480 insertions(+), 110 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


