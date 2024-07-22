Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 69D35C3DA7E
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Jul 2024 14:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=dNDQq9VpZIlznQCgzxwahIjMih0OwM0r9nSC/AIc38E=; b=M6WPJslWknjKE2kYkYm4HsB1nE
	mSIh+gZAJmCqib2kYXxwdy6pRgUZSaDqcQElosrigrXtPSu6Ww401hlVwbyISbQZqlocjkk9+SQas
	PP/ifsHOwL0KFtOjIWn3cl6nkdYhkWm97fAXsaZ4ksUSS9n2fV5Uf28uP7ccvhQcOQ08bifuvrUd/
	tQbv26vybPPEYkKORevqQxUJZiC4N0TVHMeQlCaLW6AsBsSeDNJQjiHGaYETPqd1ISwe5R5jvAoB8
	11MBBysYBOmyRMbWyisK8GeKE5Gfdq196cqT3BB5MWw+cgMjNOsJs53AGK32eUqMtOaEWpiSQSeCH
	QpMQy35Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvQ-00000009lBS-3H6N;
	Mon, 22 Jul 2024 14:22:04 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1sVtvO-00000009l9y-0877
	for linux-nvme@lists.infradead.org;
	Mon, 22 Jul 2024 14:22:03 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by dfw.source.kernel.org (Postfix) with ESMTP id 7202260AFB;
	Mon, 22 Jul 2024 14:22:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85A47C116B1;
	Mon, 22 Jul 2024 14:21:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721658121;
	bh=sO48rBfePwJJwOuzkWv9CUXSJWa4aJoG3UxyflX83Ss=;
	h=From:To:Cc:Subject:Date:From;
	b=tWMyjQHbegfVwskT3GBJxlDZclJfEJjSZBivYlo8bqDxSeilqd6YDNt2uhKs6uiL5
	 6AKnYrh5VLi+5uiL0GwaXuraj8iMiaQDqox8197nt2zWa7TtQR+c6iziT3Hv4ypGtT
	 83ywrel3YtZXmMmT8soAKy1wZSCDu/8Jj+CdGP2ExesPyMhW7kHEIO4L4cYHEoj+Gc
	 OsNAkq4XH/+jJY4sh80yYh9ZQpiodhcPAaUBGvzER0tGEq379dRUA/xRN6FTAuDasx
	 /XwVwEFS/brY4WX5sgR4aBsESyGE/59vMAIFrXW7MJ2HtZfYoVd0tSfqhML59sRD76
	 yPg/oLm7TaqMA==
From: Hannes Reinecke <hare@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	Eric Biggers <ebiggers@kernel.org>,
	linux-crypto@vger.kernel.org,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv8 0/9] nvme: implement secure concatenation
Date: Mon, 22 Jul 2024 16:21:13 +0200
Message-Id: <20240722142122.128258-1-hare@kernel.org>
X-Mailer: git-send-email 2.35.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240722_072202_197508_A8EC0358 
X-CRM114-Status: GOOD (  19.33  )
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
branch secure-concat.v8

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

 crypto/Makefile                        |   1 +
 crypto/hkdf.c                          | 112 +++++++++
 drivers/nvme/common/auth.c             | 303 +++++++++++++++++++++++++
 drivers/nvme/common/keyring.c          |  50 ++++
 drivers/nvme/host/auth.c               | 108 ++++++++-
 drivers/nvme/host/fabrics.c            |  34 ++-
 drivers/nvme/host/fabrics.h            |   3 +
 drivers/nvme/host/nvme.h               |   2 +
 drivers/nvme/host/sysfs.c              |   4 +-
 drivers/nvme/host/tcp.c                |  56 ++++-
 drivers/nvme/target/auth.c             |  72 +++++-
 drivers/nvme/target/debugfs.c          |  27 +++
 drivers/nvme/target/fabrics-cmd-auth.c |  49 +++-
 drivers/nvme/target/fabrics-cmd.c      |  33 ++-
 drivers/nvme/target/nvmet.h            |  38 +++-
 drivers/nvme/target/tcp.c              |  23 +-
 fs/crypto/hkdf.c                       |  68 +-----
 include/crypto/hkdf.h                  |  18 ++
 include/linux/nvme-auth.h              |   7 +
 include/linux/nvme-keyring.h           |   7 +
 include/linux/nvme.h                   |   7 +
 21 files changed, 926 insertions(+), 96 deletions(-)
 create mode 100644 crypto/hkdf.c
 create mode 100644 include/crypto/hkdf.h

-- 
2.35.3


