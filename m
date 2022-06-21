Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A797DC43334
	for <linux-nvme@archiver.kernel.org>; Tue, 21 Jun 2022 17:25:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=6CCzYuDzLWuba9qFIGl2VRqum9eXD1OOSMqygdl4Xc0=; b=WPlWXi/cV9F8Cy9y0/6eX2n8Ph
	mb1o70OKA3wem73JxquGrq5gYoVImF+zrG3RvLRQbk1YyZmRqhnYCkIhIPlcxWNHOf3+4Pv1q73XL
	9Q3SfNJOFB81LBGp9AHdaZtGF9FTaBcGyHfoDF7S0vbRJXluiAISe6q66fZFHfcM07tEmYqQ2Wxhi
	RBhbxKK0elEkvQekbthWzmGZclV7hMVnWe42OcvOzIzZGoZVePn8BpVwBJWp1qySZ2qZ4iOvKYQ4P
	FuuxXa5GH1M4XfjNdF5cpHsVzVvT8mzZoKhi5Df8WlI9ITGTp3jCjmk4BvmL0FIpJ7I07Ori8XsAv
	r0ngBfzQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3hcV-006XIB-4v; Tue, 21 Jun 2022 17:24:55 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o3hcA-006XC0-Je
	for linux-nvme@lists.infradead.org; Tue, 21 Jun 2022 17:24:37 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id 331FF21C0B;
	Tue, 21 Jun 2022 17:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655832271; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6CCzYuDzLWuba9qFIGl2VRqum9eXD1OOSMqygdl4Xc0=;
	b=K3yqOsf3xDIN5F0Gy0aauLJDxA+7nwikuhZ5ImNQTht4cTMicUhbL7do7DhVastNBaysB+
	NiGNY4TeTtQKgLQgzJhWfNIIXZ8M3MB3DdfVXtp8HI9KkCeODEts11Daj/IWSzOvGXoK24
	JlnqT0rbOs+Yh+Fjp0pusGVJL0EIW1s=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655832271;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=6CCzYuDzLWuba9qFIGl2VRqum9eXD1OOSMqygdl4Xc0=;
	b=pa56z4sGTOMhUdMbAc5qxcTMXymRghqCTnhmSYZiy4xvE8jee/7EgKi1jZmqErApdSy//V
	b0g/J+hXZu6YleCA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 27F252C143;
	Tue, 21 Jun 2022 17:24:30 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 4B8DA5194C76; Tue, 21 Jun 2022 19:24:30 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv16 00/11] nvme: In-band authentication support
Date: Tue, 21 Jun 2022 19:24:03 +0200
Message-Id: <20220621172414.82847-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220621_102434_914370_E8052377 
X-CRM114-Status: GOOD (  17.77  )
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

recent updates to the NVMe spec have added definitions for in-band
authentication, and seeing that it provides some real benefit
especially for NVMe-TCP here's an attempt to implement it.

Thanks to Nicolai Stange the crypto DH framework has been upgraded
to provide us with a FFDHE implementation; I've updated the patchset
to use the ephemeral key generation provided there.

Note that this is just for in-band authentication. Secure
concatenation (ie starting TLS with the negotiated parameters)
requires a TLS handshake, which the in-kernel TLS implementation
does not provide. This is being worked on with a different patchset
which is still WIP.

The nvme-cli support has already been merged; please use the latest
nvme-cli git repository to build the most recent version.

A copy of this patchset can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
branch auth.v15

The patchset is being cut against nvme-5.20.

As usual, comments and reviews are welcome.

Changes to v15:
- Rebase to nvme-5.20

Changes to v14:
- Rebase to nvme-5.19
- Fixup sparse warnings as noted by Christoph
- Fixup Kconfig dependencies
- Add NVME_CONNECT_AUTHREQ definitions

Changes to v13:
- Fixup sysfs attribute visibility (reported by Chaitanya)
- Fixup SUCCESS1 handling
- Re-introduce crypto_has_shash() and crypto_has_kpp() helper
- Unse 'authenticated' flag on failure

Changes to v12:
- Replaces crypto_has_shash() and crypto_has_kpp() helper
  with CONFIG_ checks
- Fixed kbuild robot warning in pr_fmt()

Changes to v11:
- Fixup type for FAILURE2 message (Prashant Nayak)
- Do not sent SUCCESS2 if bi-directional authentication is not
  requested (Martin George)

Changes to v10:
- Fixup error return value when authentication failed

Changes to v9:
- Include review from Chaitanya
- Use sparse array for dhgroup and hash lookup
- Common function for auth_send and auth_receive

Changes to v8:
- Rebased to Nicolais crypto DH rework
- Fixed oops on non-fabrics devices

Changes to v7:
- Space out hash list and dhgroup list in nvme negotiate data
  to be conformant with the spec
- Update sequence number handling to start with a random value and
  ignore '0' as mandated by the spec
- Update nvme_auth_generate_key to return the key as
  suggested by Sagi
- Add nvmet_parse_fabrics_io_cmd() as suggested by hch

Changes to v6:
- Use 'u8' for DH group id and hash id
- Use 'struct nvme_dhchap_key'
- Rename variables to drop 'DHCHAP'
- Include reviews from Chaitanya

Changes to v5:
- Unify nvme_auth_generate_key()
- Unify nvme_auth_extract_key()
- Fixed bug where re-authentication with wrong controller key
  would not fail
- Include reviews from Sagi

Changes to v4:
- Validate against blktest suite
- Fixup base64 decoding
- Transform secret with correct hmac algorithm

Changes to v3:
- Renamed parameter to 'dhchap_ctrl_key'
- Fixed bi-directional authentication
- Included reviews from Sagi
- Fixed base64 algorithm for transport encoding

Changes to v2:
- Dropped non-standard algorithms
- Reworked base64 based on fs/crypto/fname.c
- Fixup crash with no keys

Changes to the original submission:
- Included reviews from Vladislav
- Included reviews from Sagi
- Implemented re-authentication support
- Fixed up key handling

Hannes Reinecke (11):
  crypto: add crypto_has_shash()
  crypto: add crypto_has_kpp()
  lib/base64: RFC4648-compliant base64 encoding
  nvme: add definitions for NVMe In-Band authentication
  nvme-fabrics: decode 'authentication required' connect error
  nvme: Implement In-Band authentication
  nvme-auth: Diffie-Hellman key exchange support
  nvmet: parse fabrics commands on io queues
  nvmet: Implement basic In-Band Authentication
  nvmet-auth: Diffie-Hellman key exchange support
  nvmet-auth: expire authentication sessions

 crypto/kpp.c                           |    6 +
 crypto/shash.c                         |    6 +
 drivers/nvme/Kconfig                   |    1 +
 drivers/nvme/Makefile                  |    1 +
 drivers/nvme/common/Kconfig            |    4 +
 drivers/nvme/common/Makefile           |    7 +
 drivers/nvme/common/auth.c             |  481 ++++++++++++
 drivers/nvme/host/Kconfig              |   15 +
 drivers/nvme/host/Makefile             |    1 +
 drivers/nvme/host/auth.c               | 1000 ++++++++++++++++++++++++
 drivers/nvme/host/core.c               |  143 +++-
 drivers/nvme/host/fabrics.c            |   83 +-
 drivers/nvme/host/fabrics.h            |    7 +
 drivers/nvme/host/nvme.h               |   30 +
 drivers/nvme/host/rdma.c               |    1 +
 drivers/nvme/host/tcp.c                |    1 +
 drivers/nvme/host/trace.c              |   32 +
 drivers/nvme/target/Kconfig            |   15 +
 drivers/nvme/target/Makefile           |    1 +
 drivers/nvme/target/admin-cmd.c        |    4 +-
 drivers/nvme/target/auth.c             |  525 +++++++++++++
 drivers/nvme/target/configfs.c         |  138 +++-
 drivers/nvme/target/core.c             |   15 +
 drivers/nvme/target/fabrics-cmd-auth.c |  545 +++++++++++++
 drivers/nvme/target/fabrics-cmd.c      |   55 +-
 drivers/nvme/target/nvmet.h            |   75 +-
 include/crypto/hash.h                  |    2 +
 include/crypto/kpp.h                   |    2 +
 include/linux/base64.h                 |   16 +
 include/linux/nvme-auth.h              |   41 +
 include/linux/nvme.h                   |  209 ++++-
 lib/Makefile                           |    2 +-
 lib/base64.c                           |  103 +++
 33 files changed, 3552 insertions(+), 15 deletions(-)
 create mode 100644 drivers/nvme/common/Kconfig
 create mode 100644 drivers/nvme/common/Makefile
 create mode 100644 drivers/nvme/common/auth.c
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
 create mode 100644 include/linux/base64.h
 create mode 100644 include/linux/nvme-auth.h
 create mode 100644 lib/base64.c

-- 
2.29.2


