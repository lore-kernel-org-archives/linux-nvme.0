Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23D1C433F5
	for <linux-nvme@archiver.kernel.org>; Mon, 28 Mar 2022 08:09:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	MIME-Version:Message-Id:Date:Subject:Cc:To:From:Reply-To:Content-Type:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=bLu2vADd6RFrXul4kKolwUKg4GvEbA3af9PIwEFCd+g=; b=usodMEyzJATzOUpLpW2uE4Qpy2
	kVPsV3ETQrt9PBcodUXRZWPI/mNSn0OqZK+s2pIIQCCub6l39zSkQfeLxlouyMNcDkaMfC/65pEqK
	InyWr7ETxpLChOLFeSyI6aFp0VscVJEFMtSilHQXKZKKmuvT1MZP9mFoHnSWXINP6pG2V8ReVlsLY
	OThNPWdDgw5yX6REan6T1Q5T19BnpiAtsTrzhy6NMM99z0VnDFhcNNGx1t3/+2OQqNCqyqGoD27Cf
	XPcQVbK7kOVWYGja0QQrStcIh8lrRlGnLZtb0d1Nb/+udi3aqC/mUvKXMnxHSx/xjW9psyCayMKjj
	zqHv88Fw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nYkRY-007jop-6x; Mon, 28 Mar 2022 08:09:40 +0000
Received: from smtp-out2.suse.de ([195.135.220.29])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nYkQn-007jTd-OY
 for linux-nvme@lists.infradead.org; Mon, 28 Mar 2022 08:08:59 +0000
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
 by smtp-out2.suse.de (Postfix) with ESMTP id BC27E1F37E;
 Mon, 28 Mar 2022 08:08:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1648454929; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bLu2vADd6RFrXul4kKolwUKg4GvEbA3af9PIwEFCd+g=;
 b=h2crgll1gc9Zu3ahdHGjqOSJ/W0leWXIdiNKtwUs4sOJ4lj1g0enLchKEob+Oyg9FaXXlD
 NTiUrhHjB9hplrEIEe3Raxi3rUQCSIu800Cd959vXQTOEgWPnv4TXwntiqMA8goiQ+Px4r
 2ByykQvV/sF+mfPQJNUwmBd3RXxqwmA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1648454929;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version: content-transfer-encoding:content-transfer-encoding;
 bh=bLu2vADd6RFrXul4kKolwUKg4GvEbA3af9PIwEFCd+g=;
 b=GyUdwP0TWm+fBR1SthxuDVJJNIlMTkddylwVClyrTOdKFNllpBenRDnaZrzcrVUM5ZlKL4
 7VApMsff57mbGsDA==
Received: from adalid.arch.suse.de (adalid.arch.suse.de [10.161.8.13])
 by relay2.suse.de (Postfix) with ESMTP id B4780A3B9D;
 Mon, 28 Mar 2022 08:08:49 +0000 (UTC)
Received: by adalid.arch.suse.de (Postfix, from userid 16045)
 id A1C535193996; Mon, 28 Mar 2022 10:08:49 +0200 (CEST)
From: Hannes Reinecke <hare@suse.de>
To: Christoph Hellwig <hch@lst.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <kbusch@kernel.org>,
 linux-nvme@lists.infradead.org, Hannes Reinecke <hare@suse.de>
Subject: [PATCHv10 00/11] nvme: In-band authentication support
Date: Mon, 28 Mar 2022 10:08:25 +0200
Message-Id: <20220328080836.72844-1-hare@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220328_010854_097953_0BCC3BC4 
X-CRM114-Status: GOOD (  17.01  )
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
does not provide. This is being worked on with a different patchset,
and subject to discussion at LSF..

The nvme-cli support has already been merged; please use the latest
nvme-cli git repository to build the most recent version.

A copy of this patchset can be found at
git://git.kernel.org/pub/scm/linux/kernel/git/hare/scsi-devel
branch auth.v10

It is being cut against the latest master branch from Linus.

As usual, comments and reviews are welcome.

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
    - Update nvme_auth_generate_key to return the key as suggested by
    Sagi
    - Add nvmet_parse_fabrics_io_cmd() as suggested by hch

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
 drivers/nvme/host/Kconfig              |   12 +
 drivers/nvme/host/Makefile             |    1 +
 drivers/nvme/host/auth.c               | 1457 ++++++++++++++++++++++++
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
 drivers/nvme/target/auth.c             |  525 +++++++++
 drivers/nvme/target/configfs.c         |  138 ++-
 drivers/nvme/target/core.c             |   15 +
 drivers/nvme/target/fabrics-cmd-auth.c |  534 +++++++++
 drivers/nvme/target/fabrics-cmd.c      |   55 +-
 drivers/nvme/target/nvmet.h            |   75 +-
 include/crypto/hash.h                  |    2 +
 include/crypto/kpp.h                   |    2 +
 include/linux/base64.h                 |   16 +
 include/linux/nvme.h                   |  204 +++-
 lib/Makefile                           |    2 +-
 lib/base64.c                           |  103 ++
 28 files changed, 3492 insertions(+), 15 deletions(-)
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/host/auth.h
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
 create mode 100644 include/linux/base64.h
 create mode 100644 lib/base64.c

-- 
2.29.2


