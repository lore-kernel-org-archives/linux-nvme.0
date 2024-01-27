Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8884C46CD2
	for <linux-nvme@archiver.kernel.org>; Sat, 27 Jan 2024 09:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=ozkLuDP0x7Ho4m2J0fGRz/vPCv/jzTg8VP2XJGowne0=; b=le/Ne1gdvkA7pcSQCmujE685fm
	JJsINd46sFMdbjcuPVTIZHzIlbAIgJyUXkE8KnlRKHD6cPuACc1QpBwLUWxW133ct6dZ+FMYOEMP/
	ysl/J9uf6gKdVyNrV2G0Fx4w2YMJ3s1fpaSz3GEAGi6mK0q/nr/ZilhuPIzASrQQkcTthEpEAbPZN
	kEn8arFn9kGsgYx7c87WI3ydpkQGFVrctWBcyqgy8kOotjnrPqE7CbzPt3P26jOqtYd3KIXCGYJ/8
	oGrRSY1K1iByb2BD85fHPyn3yVvu/ZtE2Hh+dBBV6t3bMyTeBpOueKq2r7BkMuyFyxloeRnrYUdOO
	8X7iVm+g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf1t-00000007FSA-2wuP;
	Sat, 27 Jan 2024 09:31:13 +0000
Received: from dfw.source.kernel.org ([139.178.84.217])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1rTf1m-00000007FPo-3QtE
	for linux-nvme@lists.infradead.org;
	Sat, 27 Jan 2024 09:31:10 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 79F3C60B07;
	Sat, 27 Jan 2024 09:31:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1D53C433F1;
	Sat, 27 Jan 2024 09:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706347863;
	bh=7emcLW2PxAhP00sqc1y/VmWD4KDudjZhR2Egf7SvmlM=;
	h=From:To:Cc:Subject:Date:From;
	b=dd53FG+e1gvrVcm3eEOLGm/aG0vSnIPR40wboMbf6O798oClWOQ0vk/wVMUAZHfKg
	 ZOh1uZGv1FG8XLUINpYBf+jGyDiRGhXNJ8O5rzN2h8GWjVEJ1T4cE5ZSSF00OTySO3
	 jp5eRj8soNpVD5UI6FZIoW7BLGEp3A2UEVEdkhFXQ0sC+vs6gOTsYx3k7vMcasuw8E
	 Q5g2jC5lWHSH3T37lxHQZNDnmaSzFLm4gqlCMmdj+lLgwKMSy/PAVPU69yP0IcVJKp
	 /QV+4XWCp5bZBhM2DaS+5KZstkV3+qZUd6b1OcheAzCACalGCmSLAA80kwaANSAWju
	 UcKcKC33x/w+A==
From: hare@kernel.org
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv2 00/13] nvme: implement secure concatenation
Date: Sat, 27 Jan 2024 10:30:45 +0100
Message-Id: <20240127093058.15699-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240127_013106_975690_D115AEBE 
X-CRM114-Status: GOOD (  14.36  )
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
The drawback with this approach is that we'll create all I/O queues
before resetting for TLS, even though these queues should never be used.
But fixing that requires a larger rewrite of the TCP driver to unify the
setup and reconnect paths. So keep it that way for now.

As usual, comments and reviews are welcome.

Changes to the original submission:
- Sanitize TLS key handling
- Fixup modconfig compilation

Hannes Reinecke (13):
  crypto,fs: Separate out hkdf_extract() and hkdf_expand()
  nvme: add nvme_auth_generate_psk()
  nvme: add nvme_auth_generate_digest()
  nvme: add nvme_auth_derive_tls_psk()
  nvme-keyring: add nvme_tls_psk_refresh()
  nvme-keyring: restrict match length for version '1' identifiers
  nvme-tcp: check for invalidated or revoked key
  nvme-fabrics: authentication errors are not retryable
  nvme-tcp: sanitize TLS key handling
  nvme-tcp: request secure channel concatenation
  nvme-tcp: combine reset and recovery
  nvme-tcp: reset after recovery for secure concatenation
  nvmet-tcp: support secure channel concatenation

 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 111 +++++++++++
 drivers/nvme/common/auth.c             | 252 +++++++++++++++++++++++++
 drivers/nvme/common/keyring.c          |  71 +++++++
 drivers/nvme/host/auth.c               | 108 ++++++++++-
 drivers/nvme/host/core.c               |   1 -
 drivers/nvme/host/fabrics.c            |  46 ++++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   1 -
 drivers/nvme/host/sysfs.c              |   9 +-
 drivers/nvme/host/tcp.c                | 106 ++++++++---
 drivers/nvme/target/auth.c             |  73 ++++++-
 drivers/nvme/target/fabrics-cmd-auth.c |  46 ++++-
 drivers/nvme/target/fabrics-cmd.c      |  30 ++-
 drivers/nvme/target/nvmet.h            |  30 ++-
 drivers/nvme/target/tcp.c              |  27 +++
 fs/crypto/hkdf.c                       |  68 +------
 include/crypto/hkdf.h                  |  18 ++
 include/linux/nvme-auth.h              |   5 +
 include/linux/nvme-keyring.h           |   7 +
 include/linux/nvme.h                   |   7 +
 21 files changed, 898 insertions(+), 122 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


