Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 934BEC54E5D
	for <linux-nvme@archiver.kernel.org>; Mon, 18 Mar 2024 15:03:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=/7iI5+QO13+W49SF8phKBtuhl13d6rzLAevEPJsX9s4=; b=InTJh1UJGLI3EQeLbVYYPLjtIf
	6U6LXTAcknSvvq6i42EL9hLePV9fS/JyBtzGwx54BBirDRGpXrUUbDuk9lpyKuIvs0BaS63UkBOcG
	fXgN7CAymS4/nAnIJRLOO8TzMGS4Z5UxVsZuaRgZZ2af0OZJbDb7lo2xFkOOgYQqrLtWJhpPw43xA
	c0rZU+dCKHe/nGqur30wQez2tyTmbI2PHCQjlektavvOCHrO9lRZ/iXsrWxULQHPyYA0kdTzwsq7E
	W/1uPoR/41M1w+W0qpzX+EACnyxthvyjIQlBNqb4Bac58dJNM/WN6SA5qpgCDVLiqxPGBdUy5ZmuU
	ZGTwzrsQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWa-00000008uGX-1RuJ;
	Mon, 18 Mar 2024 15:03:40 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rmEWV-00000008uDT-3jwy
	for linux-nvme@lists.infradead.org;
	Mon, 18 Mar 2024 15:03:37 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 829F0CE09EF;
	Mon, 18 Mar 2024 15:03:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75C65C43390;
	Mon, 18 Mar 2024 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1710774209;
	bh=S7BtdsLEdV+avuKOBYehOZhCdHwuIZEHGqB1V208+ps=;
	h=From:To:Cc:Subject:Date:From;
	b=mwIWj4bmNdZdp/gQ2Mq7PCq5UEccYx7fl4HSIy75k4G/nW0voB7+iW+WGPgmjv8SB
	 +NMURNB9lFKy+wf3hYG8Zpz8lcwdgA5QowN4os7a9lljeCjJyVigd6HdzSAZDAFVnQ
	 jYqTGzqLX9SphZsp1gYUPctqOvnzuh2ga9B4BEoIH8IkGxyZmrBw6pB53WttvdNQ9R
	 2i8b7hvRuxE+S0i4ZzQNcIoensv4V6uchRAc5wQihgTCHTco4hx5hjl0fqu5ir+n14
	 Pe0fv7A7PfxrEg/mytrmMQiOBB5UAsCmQIQViqfNhLomVw3Da8vJgD05WBqK06ON09
	 B0t4mMj6vtUvg==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv3 00/17] nvme: implement secure concatenation
Date: Mon, 18 Mar 2024 16:02:59 +0100
Message-Id: <20240318150316.138501-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240318_080336_403948_BF211516 
X-CRM114-Status: GOOD (  16.33  )
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
The drawback with this approach is that we'll create all I/O queues
before resetting for TLS, even though these queues should never be used.
But fixing that requires a larger rewrite of the TCP driver to unify the
setup and reconnect paths. So keep it that way for now.

As usual, comments and reviews are welcome.

Changes to v2:
- Fixup reset after dhchap negotiation
- Disable namespace scanning on I/O queues after
  dhchap negotiation
- Reworked TLS key handling (again)

Changes to the original submission:
- Sanitize TLS key handling
- Fixup modconfig compilation

Hannes Reinecke (17):
  nvme-keyring: restrict match length for version '1' identifiers
  nvme-tcp: check for invalidated or revoked key
  crypto,fs: Separate out hkdf_extract() and hkdf_expand()
  nvme: add nvme_auth_generate_psk()
  nvme: add nvme_auth_generate_digest()
  nvme: add nvme_auth_derive_tls_psk()
  nvme-keyring: add nvme_tls_psk_refresh()
  nvme-tcp: sanitize TLS key handling
  nvme-tcp: do not quiesce admin queue in nvme_tcp_teardown_io_queues()
  nvme: add a newline to the 'tls_key' sysfs attribute
  nvme-tcp: request secure channel concatenation
  nvme-fabrics: reset connection for secure concatenation
  nvme-tcp: reset after recovery for secure concatenation
  nvmet-auth: allow to clear DH-HMAC-CHAP keys
  nvme-target: do not check authentication status for admin commands
    twice
  nvme-target: do not check authentication status for I/O commands twice
  nvmet-tcp: support secure channel concatenation

 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 112 +++++++++++
 drivers/nvme/common/auth.c             | 252 +++++++++++++++++++++++++
 drivers/nvme/common/keyring.c          |  84 ++++++++-
 drivers/nvme/host/auth.c               | 108 ++++++++++-
 drivers/nvme/host/core.c               |   9 +-
 drivers/nvme/host/fabrics.c            |  38 +++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/sysfs.c              |  11 +-
 drivers/nvme/host/tcp.c                | 132 +++++++++++--
 drivers/nvme/target/admin-cmd.c        |   3 +-
 drivers/nvme/target/auth.c             |  82 +++++++-
 drivers/nvme/target/core.c             |   3 -
 drivers/nvme/target/fabrics-cmd-auth.c |  46 ++++-
 drivers/nvme/target/fabrics-cmd.c      |  29 ++-
 drivers/nvme/target/nvmet.h            |  30 ++-
 drivers/nvme/target/tcp.c              |  34 +++-
 fs/crypto/hkdf.c                       |  68 +------
 include/crypto/hkdf.h                  |  18 ++
 include/linux/nvme-auth.h              |   5 +
 include/linux/nvme-keyring.h           |   7 +
 include/linux/nvme.h                   |   7 +
 22 files changed, 958 insertions(+), 124 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


