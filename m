Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B8ABAC433FE
	for <linux-nvme@archiver.kernel.org>; Fri, 27 May 2022 08:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=F810qm9cYs4u2MRAMLsRPa8Pl8Atv/jacb63sdljSRE=; b=SPYe9loK+dZOPN6feBhpfwQ4IT
	jiwEclhFiv6/DqqaMOjd0eKYO/SEeI03nTGfHCcZxCm0Xm434VqAqTh4djZ4oTB550LyLossV+SS+
	bUspqZu8lFG3wzI5EerrAw5zFb020g79HoM1IOyN4u1ww+PWkb5nSYqcSSxI0SGdIe2t3ZMcv86o3
	V5xf4hbIBmXIU1d9ac1cXFpxkU5vu2tzIkMi7ya9f8JtrMZaoK2JaBhmuBlqcftCO02A9EytQeI2g
	egtnpvNjbjfHvJjusgipkEbUB/4AX99iFCbK3WMuzWsQwsRn/TIdC9Loh1BFxWaDks8/HtAkj1yJ7
	SS+XbJEg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuUyO-00GwVV-5A; Fri, 27 May 2022 08:05:28 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nuUyB-00GwP1-Di
	for linux-nvme@lists.infradead.org; Fri, 27 May 2022 08:05:17 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
	by smtp-out2.suse.de (Postfix) with ESMTP id 411661F93D;
	Fri, 27 May 2022 08:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
	t=1653638713; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F810qm9cYs4u2MRAMLsRPa8Pl8Atv/jacb63sdljSRE=;
	b=AZmBPGlumB3gfWAf4tYM8TpGXJSpk2j2VTjow8mB2tx5+nKyY+VElgaq8VhQnlLmvACtlV
	c/nwwedwWARIIbmUaW9nnTBz0q2iZSolRUoeZ7BP+lloQD7IjePmbMeyW96ttiogQoJxY+
	BAI0WzUNc1T/sUOwK5dLKO36lXv8bqE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
	s=susede2_ed25519; t=1653638713;
	h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
	 mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
	bh=F810qm9cYs4u2MRAMLsRPa8Pl8Atv/jacb63sdljSRE=;
	b=YjKgXtK9IDU4joXzqnxejHqWrEbGHr3JQNyClJrxDvazDm9o1Z5osc60XEon/8xVvPZEXy
	GNkT9nxdS/pBytAw==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
	by relay2.suse.de (Postfix) with ESMTP id 34E5E2C142;
	Fri, 27 May 2022 08:05:13 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
	id 1F65C5194716; Fri, 27 May 2022 10:05:13 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>,
	Keith Busch <kbusch@kernel.org>,
	linux-nvme@lists.infradead.org,
	Hannes Reinecke <hare@suse.de>
Subject: [PATCHv13 0/9] nvme: In-band authentication support
Date: Fri, 27 May 2022 10:04:48 +0200
Message-Id: <20220527080457.90855-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220527_010515_723595_164F98A6 
X-CRM114-Status: GOOD (  17.68  )
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
branch auth.v13

The patchset is being cut against v5.18.

As usual, comments and reviews are welcome.

Changes to v12:
- Replaces crypto_has_shash() and crypto_has_kpp() helper
  with CONFIG_ checks
- Fixed kbuild robot warning in pr_fmt()

Changes to v11:
- Fixup type for FAILURE2 message (Prashant Nayak)
- Do not sent SUCCESS2 if bi-directional authentication is not
requested
  (Martin George)

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
	    suggested by
	        Sagi
		    - Add nvmet_parse_fabrics_io_cmd() as suggested by
		    hch

Changes to v6:
- Use 'u8' for DH group id and hash id
- Use 'struct nvme_dhchap_key'
- Rename variables to drop 'DHCHAP'
- Include reviews from Chaitanya

Changes to v5:
- Unify nvme_auth_generate_key()
- Unify nvme_auth_extract_key()
- Fixed bug where re-authentication with wrong controller key would
not fail
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

Hannes Reinecke (9):
  lib/base64: RFC4648-compliant base64 encoding
  nvme: add definitions for NVMe In-Band authentication
  nvme-fabrics: decode 'authentication required' connect error
  nvme: Implement In-Band authentication
  nvme-auth: Diffie-Hellman key exchange support
  nvmet: parse fabrics commands on io queues
  nvmet: Implement basic In-Band Authentication
  nvmet-auth: Diffie-Hellman key exchange support
  nvmet-auth: expire authentication sessions

 drivers/nvme/host/Kconfig              |   12 +
 drivers/nvme/host/Makefile             |    1 +
 drivers/nvme/host/auth.c               | 1470 ++++++++++++++++++++++++
 drivers/nvme/host/auth.h               |   40 +
 drivers/nvme/host/core.c               |  141 ++-
 drivers/nvme/host/fabrics.c            |   83 +-
 drivers/nvme/host/fabrics.h            |    7 +
 drivers/nvme/host/nvme.h               |   31 +
 drivers/nvme/host/rdma.c               |    1 +
 drivers/nvme/host/tcp.c                |    1 +
 drivers/nvme/host/trace.c              |   32 +
 drivers/nvme/target/Kconfig            |   13 +
 drivers/nvme/target/Makefile           |    1 +
 drivers/nvme/target/admin-cmd.c        |    4 +-
 drivers/nvme/target/auth.c             |  523 +++++++++
 drivers/nvme/target/configfs.c         |  133 ++-
 drivers/nvme/target/core.c             |   15 +
 drivers/nvme/target/fabrics-cmd-auth.c |  533 +++++++++
 drivers/nvme/target/fabrics-cmd.c      |   55 +-
 drivers/nvme/target/nvmet.h            |   75 +-
 include/linux/base64.h                 |   16 +
 include/linux/nvme.h                   |  204 +++-
 lib/Makefile                           |    2 +-
 lib/base64.c                           |  103 ++
 24 files changed, 3481 insertions(+), 15 deletions(-)
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/host/auth.h
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
 create mode 100644 include/linux/base64.h
 create mode 100644 lib/base64.c

-- 
2.29.2


