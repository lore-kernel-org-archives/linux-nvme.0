Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC6A8C43334
	for <linux-nvme@archiver.kernel.org>; Thu, 23 Jun 2022 06:17:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=pSyhlYZA0IJDXWL9oMaJMnLqpqzGtII/IYqNo3sS87E=; b=yMc8GMLMZlB/AgM80T8ftoBi1u
	BVdezT/EeOE8fgltRQcTQSHcVSoNia3JXCO180XNMkIHwlTHgJuXM6sRRI7Irv3sIv+sbAjU8YjFk
	x9NQAp/aHmn9gVKj56/Ehhe6foCg1iZmZNXYmjuwJmax/uGpXyxAiqt4oS7X6HmvVePbIO0nefKCc
	iV9brN4eNxZByQzAvKB/KmIu2fAic4WDd2oVpWhviovKlsqfYnf2U6E99VbGIF5t9tGaRpijaf5AT
	H1ukFFJ0xAbpuB12sP9ZwkkNruFhjd4VnSg9o717QiAbASSoJzDX3lc70afN6XBb+YQLpV1feXc+w
	TS97q17g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4GA1-00DdSg-T2; Thu, 23 Jun 2022 06:17:49 +0000
Received: from smtp-out1.suse.de ([195.135.220.28])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o4G9t-00DdMl-5Y
	for linux-nvme@lists.infradead.org; Thu, 23 Jun 2022 06:17:43 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out1.suse.de (Postfix) with ESMTP id E96DA21B84;
	Thu, 23 Jun 2022 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1655965055; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pSyhlYZA0IJDXWL9oMaJMnLqpqzGtII/IYqNo3sS87E=;
	b=DlghWBeegjqFzMdtN0NwaEarAoMA/uTtOHa0S6qpvES7lY7Kjvo6357hfh31yW4b35BwEs
	XNQ4BGVr71BCqCuMIin/PXvBlq66BKL2jSD81+6StKU4XQMMonXII/fKx12MkkBGm3HZWo
	PhRlVZV6WQf2RJ1ZfPjh5OX4Ih2BgJ0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1655965055;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=pSyhlYZA0IJDXWL9oMaJMnLqpqzGtII/IYqNo3sS87E=;
	b=DFLwzfzMNtmFCpiDP/731poS8lZ6qNCE0VErzo3oNdHqnxdNlYNiVcp6fjefHl9qNAtB2s
	jKcHMPOSib9S2JCw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id DC7302C143;
	Thu, 23 Jun 2022 06:17:35 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 0A7775194D68; Thu, 23 Jun 2022 08:17:35 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv17 00/11] nvme: In-band authentication support
Date: Thu, 23 Jun 2022 08:17:19 +0200
Message-Id: <20220623061730.51490-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220622_231741_437549_B625C544 
X-CRM114-Status: GOOD (  17.96  )
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
branch auth.v17

The patchset is being cut against nvme-5.20.

As usual, comments and reviews are welcome.

Changes to v16:
- Fixup memory leaks
- Fix crash on invalid controller secret
- Abort connect command on invalid conroller secret

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
 drivers/nvme/common/auth.c             |  482 ++++++++++++
 drivers/nvme/host/Kconfig              |   15 +
 drivers/nvme/host/Makefile             |    1 +
 drivers/nvme/host/auth.c               | 1006 ++++++++++++++++++++++++
 drivers/nvme/host/core.c               |  143 +++-
 drivers/nvme/host/fabrics.c            |   84 +-
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
 33 files changed, 3560 insertions(+), 15 deletions(-)
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


