Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94574C3DA64
	for <linux-nvme@archiver.kernel.org>; Thu, 18 Jul 2024 15:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=m7pee/+7MFkYueJ6XcoI3ZKMG03ckCCFoek3Fq8rEBo=; b=woZKvnUSl6haXnO16xqlDSIIgg
	xEXWbK1ER0+qSP1m0oIYmwUuLtcy/9YdhTxzBGi7m1aokCBgTbi7hUUbgSBzwbGKmdmCjM18/v2OA
	DA/7UynBjASdLt7ob5I0bs+u1TRJG4TCiBDl5BJGV0Qh4i78ixSEcQt9AVxQv/uPijCMfV9g0k6MT
	53yi9EENZtbl5cOFXCnMojdFbNeC2Zo/AOIiOjhSnTEdpQBBYQ28uUoU2gXXPJlWTClRvb0apmu/8
	bEvEBU7s0qBG7jai3ng+wl/lEaQCfZ3MSk88s9JqMMFY0oEwB9F/UeYuWa9gxDt3OgVoVqju+/EBK
	BZOG/8hw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSiz-0000000HNzP-11xB;
	Thu, 18 Jul 2024 15:07:17 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sUSiw-0000000HNyc-2pRC
	for linux-nvme@lists.infradead.org;
	Thu, 18 Jul 2024 15:07:16 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 071996199A;
	Thu, 18 Jul 2024 15:07:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AA2C116B1;
	Thu, 18 Jul 2024 15:07:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721315233;
	bh=4bres+ZtekW2O/8cbZT26tKAtNNLI5aM3JlgFxTzNjU=;
	h=From:To:Cc:Subject:Date:From;
	b=a86M6xgcQxWNGueiTDVyryDnZZyL3JUa85W5PDG8da5cSi2cTk+Tv60E66ZZKf0ub
	 ZNVEhbSMC21rt+XRhFJDjvNKj6BlRl9mo+EzlOIWK+wtKNy63znUNbSjufAnfBCnp2
	 FIPOcmd4UZlaJeoumBXcZ3MZgjXKMBVfk+F436ZtFnOumuPC6XubGIgV1C+xpTqdg0
	 1T7N9WgRu4FCByBoYJFhcaM/Oh03zeGYLv27S4BC8KnEmAabclv/TbjqdMTMnHwOAA
	 RvugU+bwjj5YXunv2dBZCOY2oUYHxa1CehtlqspJ2wj0A9PSRs9xyQF0bZrqKz2KS9
	 4cabCQSXnCChg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv6 0/8] nvme: implement secure concatenation
Date: Thu, 18 Jul 2024 17:06:50 +0200
Message-Id: <20240718150658.99580-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240718_080714_835304_0B89D7E5 
X-CRM114-Status: GOOD (  17.29  )
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
The original (v5) patchset had been split in two, and this is the
second part based on top of the patchset 'nvme: fixes for secure
concatenation' sent earlier to the mailinglist.

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
branch secure-concat.v6

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

Hannes Reinecke (8):
  crypto,fs: Separate out hkdf_extract() and hkdf_expand()
  nvme: add nvme_auth_generate_psk()
  nvme: add nvme_auth_generate_digest()
  nvme: add nvme_auth_derive_tls_psk()
  nvme-keyring: add nvme_tls_psk_refresh()
  nvme-tcp: request secure channel concatenation
  nvme-fabrics: reset admin connection for secure concatenation
  nvmet-tcp: support secure channel concatenation

 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 112 +++++++++
 drivers/nvme/common/auth.c             | 303 +++++++++++++++++++++++++
 drivers/nvme/common/keyring.c          |  50 ++++
 drivers/nvme/host/auth.c               | 100 +++++++-
 drivers/nvme/host/fabrics.c            |  34 ++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/tcp.c                |  65 +++++-
 drivers/nvme/target/auth.c             |  72 +++++-
 drivers/nvme/target/fabrics-cmd-auth.c |  49 +++-
 drivers/nvme/target/fabrics-cmd.c      |  26 ++-
 drivers/nvme/target/nvmet.h            |  38 +++-
 drivers/nvme/target/tcp.c              |  23 +-
 fs/crypto/hkdf.c                       |  68 +-----
 include/crypto/hkdf.h                  |  18 ++
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |   7 +
 include/linux/nvme.h                   |   7 +
 18 files changed, 889 insertions(+), 94 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


