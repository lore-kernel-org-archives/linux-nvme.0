Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7282BC52D7B
	for <linux-nvme@archiver.kernel.org>; Tue, 13 Aug 2024 11:15:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=3jJf9OecCHsQ3pl8WrOXuH0KjgezULW4OMIY45i2U6g=; b=p4vYYhWmM0ABEA9quvrfMa2F6R
	K/nVgVlYklrwoyH9+Ts77ouFV2pLpznEpflYnPbwWu27ILtMVW3gx2POqj4Ld37n0NM7m5h2Kb+tW
	GzXSHnSzyk2zRmCS7i7RjbbF19jyGtPn34QfvqHnXqRUVzW6ugkL+QgmPgh3g66r/FmPekvWKviNn
	Z9Jk5ymDBsvKJtEp3VoSs7k0gB4OUyzo0R5OPH94urPMlFW2rUKiLREjZ1tdfEoYIz1I4zfeiDDC0
	SluQ9WXxSQn0S0KldtIfHrkjUeWYhs8oKmkg3+3BRco3eePrxtbSXhz5aq/TiTsEMoVRekBjyJH5f
	c3P95GmQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdpV0-00000003TKP-0drO;
	Tue, 13 Aug 2024 11:15:34 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sdpUy-00000003TJq-0BkL
	for linux-nvme@lists.infradead.org;
	Tue, 13 Aug 2024 11:15:33 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id B04FF61635;
	Tue, 13 Aug 2024 11:15:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBB14C4AF0B;
	Tue, 13 Aug 2024 11:15:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723547730;
	bh=geyMkjNF+UiTEnQfr4PR13wFQ71eMS/kdrUZ6LndVD8=;
	h=From:To:Cc:Subject:Date:From;
	b=IjFs+06fMAKoDA+AK4idqJOb0lPKTZ6Ty9DVjuUEQPFZ97Q4koMV3SFaPVe7ahXoG
	 u5mfNc/HOi4l4iEloEo93xo2XirzjlrnR2haSUjaa0cpI5eriBGZyZZdb8FjORYWlr
	 wg6uSSNr9RgX+Hfgcfk2hMAMzMIvg9+LxEcs+YCdUU9XfhTnF5V4KDQimx5ptsWtHu
	 ud7XdEDJwN6emdkI8XSu4cQt0SH2RAEye/ic3vNNF4cXWQ2GTInettAkj3GaTQbIdk
	 RJbw6eGsSGw7LqXV+vOpsq9NUhrH8AT1ib8Zx5mvgLHorWK6Lo81xLGEW6/ULGd1qh
	 JU40R3rA8NZLg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv9 0/9] nvme: implement secure concatenation
Date: Tue, 13 Aug 2024 13:15:03 +0200
Message-Id: <20240813111512.135634-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240813_041532_244213_160C57C7 
X-CRM114-Status: GOOD (  20.05  )
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

As usual, comments and reviews are welcome.

Patchset can be found at
git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
branch secure-concat.v9

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

 crypto/Kconfig                         |   4 +
 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 404 +++++++++++++++++++++++++
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
 fs/crypto/hkdf.c                       |  87 +-----
 include/crypto/hkdf.h                  |  34 +++
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |   9 +
 include/linux/nvme.h                   |   7 +
 24 files changed, 1303 insertions(+), 109 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


