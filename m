Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0D86C41513
	for <linux-nvme@archiver.kernel.org>; Wed,  8 May 2024 10:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=Nwxs0hDo2mUHuj2nUeJ3s9i5bAuSj8hB4cExDGngIqw=; b=XVZEReNPCd+VBzsoW5M8PvpU+8
	Z7f3lAMybyfSrxiOJtGYSNqVBTidapT7Y9YB8AjZ4lMkzL/wTKQz72Z/fDCAOBPMDTMthAH1NAhNw
	yocF1zLrHosUo5eZb2kc/0seAZW2Zm6b/i4AkiHYKjiemHuqlI5VMjKwsb4MzQRL+n1qO64HQWEhV
	cj9B5UXsyByNXmMzFR5QhO9fslrNJlXSFYZffP5RpOmvymAuaY8BjDACB+YPXZNsWmrcqo3Begejv
	nULlQgv7ThWQwSGc9T98F7yj8ObzQo/dIKQeOgKu8U9lUuMLws5I4kiVyCaJF+JGXhARVh++b7XQT
	4t7jP5Xw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSQ-0000000ExyJ-3ykr;
	Wed, 08 May 2024 10:23:30 +0000
Received: from sin.source.kernel.org ([2604:1380:40e1:4800::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1s4eSN-0000000Exw3-10Yc
	for linux-nvme@lists.infradead.org;
	Wed, 08 May 2024 10:23:29 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sin.source.kernel.org (Postfix) with ESMTP id 987E1CE180D;
	Wed,  8 May 2024 10:23:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89B82C3277B;
	Wed,  8 May 2024 10:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715163802;
	bh=SjlEJPzz2rmEyQ7k1FQ96Wzuv+3HPUUKk3pfIV2wIgM=;
	h=From:To:Cc:Subject:Date:From;
	b=m0Ize/ePTkwXMaYuQc0VOckcgQBFfvYJiT9V9jeKtjylqvL/zohoOTfIlz33GK6zj
	 o2u1AKR4o6cBCRoj0c2EbVNNMMP+sLIQxoxHxqO5CDnG1Up7cJJ3ZSDSUtjMirRLPT
	 rH6+eWMe4Jq92MzU09FGY6fQ1ssjN47uAWQExAir0mwMK7zZhmi3EOz76wXnkjuSa7
	 Ac1eUssWGqSEC9yCaQGGFHukTH0v5dc5HJjaSpGX+psqH77EJtya3Vtd3NM51VCNNg
	 XJbdZxi0WijbeE4NNsNGoRKMglNRuELQY6gt+KYCeXRFTc8ySe5z8TP3l0XZu1KXQ/
	 ePwp/lBsfpM6Q==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@kernel.org>
Subject: [PATCHv4 00/19] nvme: implement secure concatenation
Date: Wed,  8 May 2024 12:22:46 +0200
Message-Id: <20240508102305.108949-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240508_032327_665656_2948438F 
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
before resetting for TLS, as the current implementation of the TCP
driver doesn't allow us to skip I/O queue initialisation.
But the queues are never started, and the namespace scan is skipped,
so the I/O queues are never visible to userspace until TLS has
been enabled.

As usual, comments and reviews are welcome.

Patchset can be found at
git.kernel.org:/pub/scm/linux/kernel/git/hare/nvme.git
branch secure-concat.v4

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

Hannes Reinecke (19):
  nvme-keyring: restrict match length for version '1' identifiers
  crypto,fs: Separate out hkdf_extract() and hkdf_expand()
  nvme: add nvme_auth_generate_psk()
  nvme: add nvme_auth_generate_digest()
  nvme: add nvme_auth_derive_tls_psk()
  nvme-keyring: add nvme_tls_psk_refresh()
  nvme-tcp: sanitize TLS key handling
  nvme-tcp: check for invalidated or revoked key
  nvme: add a newline to the 'tls_key' sysfs attribute
  nvme-sysfs: add 'tls_configured_key' sysfs attribute
  nvme-sysfs: add 'tls_keyring' attribute
  nvme-tcp: request secure channel concatenation
  nvme-fabrics: reset connection for secure concatenation
  nvme-tcp: reset after recovery for secure concatenation
  nvme-tcp: do not start queues when TLS is not enabled for secure
    concatenation
  nvmet-auth: allow to clear DH-HMAC-CHAP keys
  nvme-target: do not check authentication status for admin commands
    twice
  nvme-target: do not check authentication status for I/O commands twice
  nvmet-tcp: support secure channel concatenation

 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 112 +++++++++
 drivers/nvme/common/auth.c             | 303 +++++++++++++++++++++++++
 drivers/nvme/common/keyring.c          | 103 ++++++++-
 drivers/nvme/host/auth.c               | 105 ++++++++-
 drivers/nvme/host/core.c               |   9 +-
 drivers/nvme/host/fabrics.c            |  40 +++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   2 +-
 drivers/nvme/host/sysfs.c              |  37 ++-
 drivers/nvme/host/tcp.c                | 130 +++++++++--
 drivers/nvme/target/admin-cmd.c        |   3 +-
 drivers/nvme/target/auth.c             |  84 ++++++-
 drivers/nvme/target/core.c             |   3 -
 drivers/nvme/target/fabrics-cmd-auth.c |  46 +++-
 drivers/nvme/target/fabrics-cmd.c      |  29 ++-
 drivers/nvme/target/nvmet.h            |  30 ++-
 drivers/nvme/target/tcp.c              |  25 +-
 fs/crypto/hkdf.c                       |  68 +-----
 include/crypto/hkdf.h                  |  18 ++
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |  10 +-
 include/linux/nvme.h                   |   7 +
 23 files changed, 1051 insertions(+), 124 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


