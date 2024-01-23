Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E752C47258
	for <linux-nvme@archiver.kernel.org>; Tue, 23 Jan 2024 14:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=W8jA2ZP0iescDBjutpIr/YU5E/vpCak/CWWmNC7R9Yg=; b=sUB1tSKk9EeSaUkTBpAJv7w+Fq
	l4SiCnZQm1v5mlxoCti3bNNVZYk9VZdu2AuEfv8qA/ZzG5yOXk4kx9BBHYl3mJPyPuun7OfzCUL9g
	O8c2OdhklyKb6fu/uyBAQzWlbGjGYwTeUCyPlM8yZSUOUDkyBa0hdKzHv++fmpyI1zOUosJFbKdeU
	aFsXiw8oWef0Liwm1aaVZ4Z92gjPX0ZjHtQSLS8clcm4c5M6ryLi1pSCNE9N/ZVYzDCbHNngugLaD
	vitQesiJQ9BpM5LGbsMr0Y53TskXgqmn5qwFtFhHOTS4XsxPiy2VKLsjNn+62Xsi1zEN5FKYZZiPu
	nJdZR+CA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHcd-00GltZ-0X;
	Tue, 23 Jan 2024 14:19:27 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1rSHca-00GlsV-1q
	for linux-nvme@lists.infradead.org;
	Tue, 23 Jan 2024 14:19:25 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 3E6E861DB0;
	Tue, 23 Jan 2024 14:19:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B1E50C433C7;
	Tue, 23 Jan 2024 14:19:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706019562;
	bh=XaOpB2G8wT19u3VTWxapE/u9+tzv92l7LnqEkxvZBQc=;
	h=From:To:Cc:Subject:Date:From;
	b=Rv8GbIHz4WL5oGzV11B9Be9kE/+wJqjz98bUkEiW4moTpylyZTC+dhb8m6H3GaC9R
	 9erbWFKitEqrhKrgAPNpH0Xr8D102LBcx97EikjyZ6Pmaa5pG7ttHGSwnUWTgatyJT
	 zp9GTED+dx6NCL11aqxMuSR7OEm7eMmGyr+M7ZZfciOnE16IPteNlmb+9NyqC3+Ilv
	 snghgf6pTV6161+HxG5kM3hMaDpeADQmY4YnHDou9b1d83UeFZSTM9bo5QrtnwQ4hK
	 XGrmYUo3td1a18V+N+Kx4LQgA/TYWEFWvK2vYRxJXzUnCYggGZ1E6aabRArhE8EmFa
	 VPfeSHgGcTkAg==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [RFC PATCH 00/11] nvme: implement secure concatenation
Date: Tue, 23 Jan 2024 15:18:58 +0100
Message-Id: <20240123141909.79061-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240123_061924_657040_B2FC2103 
X-CRM114-Status: GOOD (  14.94  )
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
Secure concatenation means that a TLS PSK is generated from the key
material negotiated by the DH-HMAC-CHAP protocol, and the TLS PSK
is then used for a subsequent TLS connection.
The difference between the original definition of secure concatenation
and the method outlined in TP8018 is that with TP8018 the connection
is reset after DH-HMAC-CHAP negotiation, and a new connection is setup
with the generated TLS PSK.

To implement that I have decided on resetting the connection from the
nvme-tcp driver after the initial connection has been set up.
Another way would have been to offload the connection reset to userspace,
and let nvme-cli reset the connection. But that would be a modification
to the userspace interface, and hence I didn't go that way.

As usual, comments and reviews are welcome.

Hannes Reinecke (11):
  crypto,fs: Separate out hkdf_extract() and hkdf_expand()
  nvme: add nvme_auth_generate_psk()
  nvme: add nvme_auth_generate_digest()
  nvme: add nvme_auth_derive_tls_psk()
  nvme-keyring: add nvme_tls_psk_refresh()
  nvme-keyring: restrict match length for version '1' identifiers
  nvme-tcp: check for invalidated or revoked key
  nvme-fabrics: authentication errors are not retryable
  nvme: add nvme_noretry_error()
  nvme-tcp: request secure channel concatenation
  nvmet-tcp: support secure channel concatenation

 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 111 +++++++++++
 drivers/nvme/common/auth.c             | 252 +++++++++++++++++++++++++
 drivers/nvme/common/keyring.c          |  71 +++++++
 drivers/nvme/host/auth.c               | 108 ++++++++++-
 drivers/nvme/host/core.c               |   2 +-
 drivers/nvme/host/fabrics.c            |  46 ++++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/fc.c                 |   4 +-
 drivers/nvme/host/nvme.h               |  10 +
 drivers/nvme/host/tcp.c                |  46 +++--
 drivers/nvme/target/auth.c             |  62 +++++-
 drivers/nvme/target/fabrics-cmd-auth.c |  43 ++++-
 drivers/nvme/target/fabrics-cmd.c      |  27 ++-
 drivers/nvme/target/nvmet.h            |  16 +-
 drivers/nvme/target/tcp.c              |  26 +++
 fs/crypto/hkdf.c                       |  68 +------
 include/crypto/hkdf.h                  |  18 ++
 include/linux/nvme-auth.h              |   5 +
 include/linux/nvme-keyring.h           |   7 +
 include/linux/nvme.h                   |   7 +
 21 files changed, 824 insertions(+), 109 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


