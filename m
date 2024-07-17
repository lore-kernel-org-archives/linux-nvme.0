Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C05FC3DA42
	for <linux-nvme@archiver.kernel.org>; Wed, 17 Jul 2024 09:10:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=4JSPXLkbQjB6jpLngyGuD0osTGvofCj4s+JEm3Q87Ko=; b=fzyVMl16408AS8yFTc6q62qRmQ
	IrvpN94XbSyawlAQxBz6nBt/mzhoqeFmIaFM+eDEKPLhgvkBsfVEdcIEYOmwh01R7awmcvvdbWJC6
	uBK8vjYcmMf8zfkS9qo3Bs2W/7Wgij29L06lUiQ8eyacm6rV5lGo253MJEqOnuvQmpQUhUmXm8REn
	PL3O8iVFH+pwp/ceIwTzYicJqS7It9rn5aArSQhDGvO3DG988dEDImJYeP2BO4RKaP/moOAHmdRm/
	GWTD9PdBT7zklpn4hjayvV8OTk237KMYub8eRsUD7mWthTp/CgGtQXZGw+56OHf6Y+nt+xu6RKtrB
	n4Z+Fs9Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gR-0000000DFlm-0i3e;
	Wed, 17 Jul 2024 09:10:47 +0000
Received: from sin.source.kernel.org ([145.40.73.55])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sU0gO-0000000DFkm-1VKx
	for linux-nvme@lists.infradead.org;
	Wed, 17 Jul 2024 09:10:46 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id F29E7CE12E0;
	Wed, 17 Jul 2024 09:10:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42F2C32782;
	Wed, 17 Jul 2024 09:10:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721207441;
	bh=gmLB5pyqUrJtm+x1yGiDYoKRudaYbWj7HACSyliOeK4=;
	h=From:To:Cc:Subject:Date:From;
	b=Ww3tqfAJIZKX9ooXfKNYd/wbAOvH0PgJZhfR1yjPNdZOr3O4/mESAvY/Z4n3yjVZ9
	 /33o3L3P/2SIoRB2wwWwkzR0XYzA3ZwwLcnELA7/DISm/HVj9XcVw0C9DJsk/HICKT
	 WPbDL4qhMcEoPZd5uQcd6acocEKs+enqiGVT6Mv5qCIE90hGk8Z/uypeOSlY/kaU3P
	 s/LbO7me9RmgprvKeKRNw6wXe+HVz1VI0dsDxdztgIAy8hZjfe1DBSTGDP+wEHANYw
	 bYR41ID5lH+MAqC66pFmMFo22ThkxiYypdEN/wzojJPMe6WDNTXZNqTl5isXxUpQrJ
	 WIVTpvf3qvyPA==
From: Hannes Reinecke <hare@kernel.org>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv5 00/16] nvme: implement secure concatenation
Date: Wed, 17 Jul 2024 11:10:15 +0200
Message-Id: <20240717091031.143188-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240717_021044_782271_41057971 
X-CRM114-Status: GOOD (  18.36  )
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

To implement that Sagi came up with the idea to directly reset the
admin queue once the DH-CHAP negotiation has completed; that way
it will be transparent to the upper layers and we don't have to
worry about exposing queues which should not be used.

As usual, comments and reviews are welcome.

Patchset can be found at
git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
branch secure-concat.v5

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

Hannes Reinecke (16):
  nvme-keyring: restrict match length for version '1' identifiers
  nvme-tcp: sanitize TLS key handling
  nvme-tcp: check for invalidated or revoked key
  nvme: add a newline to the 'tls_key' sysfs attribute
  nvme-sysfs: add 'tls_configured_key' sysfs attribute
  nvme-sysfs: add 'tls_keyring' attribute
  crypto,fs: Separate out hkdf_extract() and hkdf_expand()
  nvme: add nvme_auth_generate_psk()
  nvme: add nvme_auth_generate_digest()
  nvme: add nvme_auth_derive_tls_psk()
  nvme-keyring: add nvme_tls_psk_refresh()
  nvme-tcp: request secure channel concatenation
  nvme-fabrics: reset admin connection for secure concatenation
  nvmet-auth: allow to clear DH-HMAC-CHAP keys
  nvme-target: do not check authentication status for admin commands
    twice
  nvmet-tcp: support secure channel concatenation

 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 112 +++++++++
 drivers/nvme/common/auth.c             | 303 +++++++++++++++++++++++++
 drivers/nvme/common/keyring.c          | 103 ++++++++-
 drivers/nvme/host/auth.c               | 105 ++++++++-
 drivers/nvme/host/core.c               |   1 -
 drivers/nvme/host/fabrics.c            |  36 ++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   2 +-
 drivers/nvme/host/sysfs.c              |  37 ++-
 drivers/nvme/host/tcp.c                | 108 +++++++--
 drivers/nvme/target/admin-cmd.c        |   2 -
 drivers/nvme/target/auth.c             |  84 ++++++-
 drivers/nvme/target/fabrics-cmd-auth.c |  49 +++-
 drivers/nvme/target/fabrics-cmd.c      |  26 ++-
 drivers/nvme/target/nvmet.h            |  30 ++-
 drivers/nvme/target/tcp.c              |  25 +-
 fs/crypto/hkdf.c                       |  68 +-----
 include/crypto/hkdf.h                  |  18 ++
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |  10 +-
 include/linux/nvme.h                   |   7 +
 22 files changed, 1015 insertions(+), 122 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


